export function formatDate(date = new Date()) {
    return Intl.DateTimeFormat('hu-HU', {
        timeZone: 'Europe/Budapest',
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        weekday: 'long',
        hour: '2-digit',
        minute: "2-digit"
    }).format(date)
}