<?php
session_start();

class Database {
    private $host = "localhost";
    private $username = "root";
    private $password = "";
    private $database = "test";
    private $conn;
    
    public function __construct() {
        $this->conn = new mysqli($this->host, $this->username, $this->password, $this->database);
        
        if ($this->conn->connect_error) {
            die("Kapcsolódási hiba: " . $this->conn->connect_error);
        }
        
        $this->conn->set_charset("utf8");
    }
    
    public function query($sql) {
        $result = $this->conn->query($sql);
        
        if (!$result) {
            die("Lekérdezési hiba: " . $this->conn->error);
        }
        
        return $result;
    }
    
    public function fetchAll($result) {
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        return $data;
    }
    
    public function close() {
        $this->conn->close();
    }
}

class TravelAgency {
    private $db;
    private $tasks;
    
    public function __construct() {
        $this->db = new Database();
        $this->initTasks();
    }
    
    private function initTasks() {
        $this->tasks = array(
            '9.1' => array(
                'title' => '9.1 Országonként városok száma',
                'sql' => "SELECT orszag, COUNT(varos) AS varosok_szama
                         FROM utazas
                         GROUP BY orszag
                         ORDER BY varosok_szama DESC"
            ),
            '9.2' => array(
                'title' => '9.2 Első tíz legtávolabbi úticél',
                'sql' => "SELECT orszag, varos, tavolsag
                         FROM utazas
                         ORDER BY tavolsag DESC
                         LIMIT 10"
            ),
            '9.3' => array(
                'title' => '9.3 Úticélok 120.000 Ft alatt',
                'sql' => "SELECT orszag, varos, alapar
                         FROM utazas
                         WHERE alapar < 120000
                         ORDER BY alapar"
            ),
            '9.4' => array(
                'title' => '9.4 Felhasználónként megrendelt utak száma',
                'sql' => "SELECT f.nev, f.felhasznalonev, COUNT(u.turnus_id) AS megrendelt_utak_szama
                         FROM felhasznalo f
                         LEFT JOIN utazik u ON f.id = u.felh_ID
                         GROUP BY f.id, f.nev, f.felhasznalonev
                         ORDER BY megrendelt_utak_szama DESC"
            ),
            '9.5' => array(
                'title' => '9.5 Felhasználók, akik több útra is elmentek',
                'sql' => "SELECT f.nev, f.felhasznalonev, COUNT(u.turnus_id) AS utak_szama
                         FROM felhasznalo f
                         INNER JOIN utazik u ON f.id = u.felh_ID
                         GROUP BY f.id, f.nev, f.felhasznalonev
                         HAVING COUNT(u.turnus_id) > 1
                         ORDER BY utak_szama DESC"
            ),
            '9.6' => array(
                'title' => '9.6 Top 3 felhasználó költések alapján',
                'sql' => "SELECT f.nev, f.felhasznalonev, 
                         SUM(ut.alapar + um.ar + um.jarulekos_koltseg) AS osszkoltseg
                         FROM felhasznalo f
                         INNER JOIN utazik u ON f.id = u.felh_ID
                         INNER JOIN turnus t ON u.turnus_id = t.id
                         INNER JOIN utazas ut ON t.utazas_id = ut.id
                         INNER JOIN utazasi_mod um ON t.mod_id = um.id
                         WHERE u.fizetve = 1
                         GROUP BY f.id, f.nev, f.felhasznalonev
                         ORDER BY osszkoltseg DESC
                         LIMIT 3"
            ),
            '9.7' => array(
                'title' => '9.7 Legnépszerűbb úticél(ok)',
                'sql' => "SELECT ut.orszag, ut.varos, COUNT(u.felh_ID) AS utazok_szama
                         FROM utazas ut
                         INNER JOIN turnus t ON ut.id = t.utazas_id
                         INNER JOIN utazik u ON t.id = u.turnus_id
                         GROUP BY ut.id, ut.orszag, ut.varos
                         HAVING COUNT(u.felh_ID) = (
                             SELECT MAX(utazo_szam) 
                             FROM (
                                 SELECT COUNT(u2.felh_ID) AS utazo_szam
                                 FROM utazas ut2
                                 INNER JOIN turnus t2 ON ut2.id = t2.utazas_id
                                 INNER JOIN utazik u2 ON t2.id = u2.turnus_id
                                 GROUP BY ut2.id
                             ) AS max_utazok
                         )"
            ),
            '9.8' => array(
                'title' => '9.8 Legnépszerűbb indulási időpont',
                'sql' => "SELECT t.indulasi_ido, COUNT(u.felh_ID) AS utazok_szama
                         FROM turnus t
                         INNER JOIN utazik u ON t.id = u.turnus_id
                         GROUP BY t.indulasi_ido
                         ORDER BY utazok_szama DESC
                         LIMIT 1"
            ),
            '9.9' => array(
                'title' => '9.9 Utak, amelyekből nem indulnak turnusok',
                'sql' => "SELECT ut.orszag, ut.varos, ut.alapar
                         FROM utazas ut
                         LEFT JOIN turnus t ON ut.id = t.utazas_id
                         WHERE t.utazas_id IS NULL
                         ORDER BY ut.orszag ASC, ut.varos ASC, ut.alapar DESC"
            ),
            '9.10' => array(
                'title' => '9.10 2014 augusztusi turnusok utazásonként',
                'sql' => "SELECT ut.orszag, ut.varos, COUNT(t.id) AS turnusok_szama
                         FROM utazas ut
                         INNER JOIN turnus t ON ut.id = t.utazas_id
                         WHERE YEAR(t.indulasi_ido) = 2014 AND MONTH(t.indulasi_ido) = 8
                         GROUP BY ut.id, ut.orszag, ut.varos
                         ORDER BY turnusok_szama DESC"
            )
        );
    }
    
    public function getTasks() {
        return $this->tasks;
    }
    
    public function executeTask($taskId) {
        if (!isset($this->tasks[$taskId])) {
            return null;
        }
        
        $result = $this->db->query($this->tasks[$taskId]['sql']);
        return $this->db->fetchAll($result);
    }
    
    public function getTaskTitle($taskId) {
        return isset($this->tasks[$taskId]) ? $this->tasks[$taskId]['title'] : '';
    }
    
    public function __destruct() {
        $this->db->close();
    }
}

$travelAgency = new TravelAgency();
$selectedTask = isset($_POST['task']) ? $_POST['task'] : '';
$results = null;

if ($selectedTask) {
    $_SESSION['selected_task'] = $selectedTask;
    $results = $travelAgency->executeTask($selectedTask);
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Utazási Iroda Rendszer</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Utazási Iroda Adatbázis Kezelő</h1>
        </header>
        
        <div class="content">
            <form method="POST" action="">
                <div class="form-group">
                    <label for="task">Válassz feladatot:</label>
                    <select name="task" id="task" onchange="this.form.submit()">
                        <option value="">-- Válassz --</option>
                        <?php foreach ($travelAgency->getTasks() as $key => $task): ?>
                            <option value="<?php echo $key; ?>" <?php echo ($selectedTask === $key) ? 'selected' : ''; ?>>
    <?php echo $task['title']; ?>
</option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </form>
            
            <div>
    <strong>Aktuális választás: <?php echo htmlspecialchars($selectedTask); ?></strong>
</div>
            
            <?php if ($selectedTask && $results !== null): ?>
                <div class="task-info">
                    <h2><?php echo $travelAgency->getTaskTitle($selectedTask); ?></h2>
                </div>
                
                <div class="results">
                    <?php if (count($results) > 0): ?>
                        <table>
                            <thead>
                                <tr>
                                    <?php foreach (array_keys($results[0]) as $column): ?>
                                        <th><?php echo htmlspecialchars($column); ?></th>
                                    <?php endforeach; ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($results as $row): ?>
                                    <tr>
                                        <?php foreach ($row as $value): ?>
                                            <td><?php echo htmlspecialchars($value); ?></td>
                                        <?php endforeach; ?>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                        <p class="result-count">Találatok száma: <?php echo count($results); ?></p>
                    <?php else: ?>
                        <p class="no-results">Nincs megjeleníthető eredmény.</p>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
        
        <footer>
            <p>&copy; 2024 Utazási Iroda Rendszer</p>
        </footer>
    </div>
</body>
</html>