/**
 * Initial timer duration in milliseconds (2 minutes)
 * @constant {number}
 */
const INITIAL_MS = 2 * 60 * 1000;

/**
 * Extension duration in milliseconds (30 seconds)
 * @constant {number}
 */
const EXTEND_MS = 30 * 1000;

/**
 * Tick interval for timer updates in milliseconds
 * @constant {number}
 */
const TICK_MS = 250;

/**
 * Toast notification display duration in milliseconds
 * @constant {number}
 */
const TOAST_MS = 2.5 * 1000;

/**
 * Timer display element
 * @type {HTMLElement}
 */
const timerEl = document.querySelector("#timer");

/**
 * Status message element
 * @type {HTMLElement}
 */
const statusEl = document.querySelector("#status");

/**
 * Extend button element
 * @type {HTMLButtonElement}
 */
const extendBtn = document.querySelector("#extendBtn");

/**
 * Cancel button element
 * @type {HTMLButtonElement}
 */
const cancelBtn = document.querySelector("#cancelBtn");

/**
 * Toast notification element
 * @type {HTMLElement}
 */
const toastEl = document.querySelector("#toast");

/**
 * Deadline timestamp in milliseconds
 * @type {number}
 */
let deadline = Date.now() + INITIAL_MS;

/**
 * Timeout ID for the tick interval
 * @type {number|null}
 */
let tickTimeoutId = null;

/**
 * Timeout ID for the expiration timer
 * @type {number|null}
 */
let expireTimoutId = null;

/**
 * Flag indicating whether the timer has expired
 * @type {boolean}
 */
let expired = false;

/**
 * Pads a number with leading zeros to ensure 2 digits
 * @param {number} n - The number to pad
 * @returns {string} The padded string representation
 */
const pad = (n) => n.toString().padStart(2, "0");

/**
 * Converts milliseconds to MM:SS format
 * @param {number} ms - Time in milliseconds
 * @returns {string} Time formatted as MM:SS
 */
function msToMMSS(ms) {
  const sec = Math.max(0, Math.ceil(ms / 1000));
  const m = Math.floor(sec / 60);
  const s = sec % 60;
  return `${pad(m)}:${pad(s)}`;
}

/**
 * Renders the current remaining time to the timer element
 * @returns {void}
 */
function renderTime() {
  const remaining = deadline - Date.now();
  timerEl.textContent = msToMMSS(remaining);
}

/**
 * Schedules the next tick to update the timer display
 * @returns {void}
 */
function scheduleTick() {
  tickTimeoutId = setTimeout(() => {
    renderTime();
    if (!expired) scheduleTick();
  }, TICK_MS);
}

/**
 * Schedules the expiration callback based on the remaining time
 * @returns {void}
 */
function scheduleExpire() {
  const remaining = Math.max(0, deadline - Date.now());
  expireTimoutId = setTimeout(onExpire, remaining);
}

/**
 * Clears all active timers
 * @returns {void}
 */
function clearTimers() {
  if (tickTimeoutId) {
    clearTimeout(tickTimeoutId);
    tickTimeoutId = null;
  }
  if (expireTimoutId) {
    clearTimeout(expireTimoutId);
    expireTimoutId = null;
  }
}

/**
 * Disables the extend and cancel buttons
 */
function disableActions() {
  extendBtn.disabled = true;
  cancelBtn.disabled = true;
}

/**
 * Handles timer expiration
 */
function onExpire() {
  if (expired) return;
  expired = true;
  clearTimers();
  statusEl.textContent = "Lejárt az idő. A foglalás felszabadult.";
  timerEl.textContent = "00:00";
  disableActions();
}

/**
 * Handles timer extension by adding 30 seconds
 */
function onExtend() {
  if (expired) return;
  deadline += EXTEND_MS;
  statusEl.textContent = "Hosszabbítva +30 mp.";
  if (expireTimoutId) {
    clearTimeout(expireTimoutId);
    scheduleExpire();
  }
  renderTime();
}

/**
 * Handles reservation cancellation
 */
function onCancel() {
  if (expired) return;
  expired = true;
  clearTimers();
  statusEl.textContent = "A foglalást lemondtad.";
  timerEl.textContent = "00:00";
  disableActions();
}

/**
 * Shows a toast notification once (if not already shown)
 */
function showToastOnec() {
  if (toastEl.dataset.shown === "1") return;
  toastEl.dataset.shown = "1";
  toastEl.classList.add("show");
  setTimeout(() => {
    toastEl.classList.remove("show");
  }, TOAST_MS);
}

// Event listeners
extendBtn.addEventListener("click", onExtend);
cancelBtn.addEventListener("click", onCancel);

/**
 * Shows toast notification when tab becomes hidden
 */
document.addEventListener("visibilitychange", () => {
  if (document.hidden && !expired) showToastOnec();
});

/**
 * Handles keyboard shortcuts
 * E key - extends the timer
 * Escape key - cancels the reservation
 */
document.addEventListener("keydown", (e) => {
  if (e.key.toLocaleLowerCase() === "e") onExtend();
  if (e.key === "Escape") onCancel();
});

// Initialize the timer
renderTime();
scheduleTick();
scheduleExpire();