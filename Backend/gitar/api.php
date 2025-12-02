<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, DELETE, PUT");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = isset($_GET['action']) ? $_GET['action'] : '';

$data = json_decode(file_get_contents("php://input"));

switch($action) {
    
    case 'delete_swing':
        if($method == 'DELETE' || $method == 'POST') {
            $stilusNev = isset($data->stilusNev) ? $data->stilusNev : 'swing';
            
            $query = "DELETE FROM stilus WHERE stilusNev = :stilusNev";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(":stilusNev", $stilusNev);
            
            if($stmt->execute()) {
                http_response_code(200);
                echo json_encode(array("message" => "Stílus törölve: " . $stilusNev));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Stílus törlése sikertelen"));
            }
        }
        break;
        
    case 'create_muvesz':
        if($method == 'POST') {
            if(!empty($data->muveszNev) && !empty($data->stilusID) && !empty($data->nemzetiseg)) {
                
                $queryMaxId = "SELECT MAX(id) as max_id FROM muvesz";
                $stmtMaxId = $conn->prepare($queryMaxId);
                $stmtMaxId->execute();
                $rowMaxId = $stmtMaxId->fetch(PDO::FETCH_ASSOC);
                $newId = $rowMaxId['max_id'] + 1;
                
                $query = "INSERT INTO muvesz (id, muveszNev, stilusID, nemzetiseg) 
                          VALUES (:id, :muveszNev, :stilusID, :nemzetiseg)";
                $stmt = $conn->prepare($query);
                
                $muveszNev = htmlspecialchars(strip_tags($data->muveszNev));
                $stilusID = htmlspecialchars(strip_tags($data->stilusID));
                $nemzetiseg = htmlspecialchars(strip_tags($data->nemzetiseg));
                
                $stmt->bindParam(":id", $newId);
                $stmt->bindParam(":muveszNev", $muveszNev);
                $stmt->bindParam(":stilusID", $stilusID);
                $stmt->bindParam(":nemzetiseg", $nemzetiseg);
                
                if($stmt->execute()) {
                    http_response_code(201);
                    echo json_encode(array(
                        "message" => "Művész létrehozva",
                        "id" => $newId,
                        "muveszNev" => $muveszNev
                    ));
                } else {
                    http_response_code(503);
                    echo json_encode(array("message" => "Művész létrehozása sikertelen"));
                }
            } else {
                http_response_code(400);
                echo json_encode(array("message" => "Hiányos adatok"));
            }
        }
        break;
        
    case 'count_zenekar':
        if($method == 'GET') {
            $query = "SELECT COUNT(*) as total FROM zenekar";
            $stmt = $conn->prepare($query);
            $stmt->execute();
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            
            http_response_code(200);
            echo json_encode(array(
                "message" => "Zenekarok száma",
                "osszes_zenekar" => $row['total']
            ));
        }
        break;
        
    case 'stats_by_stilus':
        if($method == 'GET') {
            $query = "SELECT 
                        s.stilusNev AS stilus,
                        COUNT(m.id) AS muveszek_szama
                      FROM stilus s
                      LEFT JOIN muvesz m ON s.id = m.stilusID
                      GROUP BY s.id, s.stilusNev
                      ORDER BY muveszek_szama ASC";
            $stmt = $conn->prepare($query);
            $stmt->execute();
            
            $stats_arr = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $stats_arr[] = array(
                    "stilus" => $row['stilus'],
                    "muveszek_szama" => $row['muveszek_szama']
                );
            }
            
            http_response_code(200);
            echo json_encode(array("records" => $stats_arr));
        }
        break;
        
    case 'list_muvesz':
        if($method == 'GET') {
            $query = "SELECT m.*, s.stilusNev 
                      FROM muvesz m
                      LEFT JOIN stilus s ON m.stilusID = s.id
                      ORDER BY m.id";
            $stmt = $conn->prepare($query);
            $stmt->execute();
            
            $muvesz_arr = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $muvesz_arr[] = array(
                    "id" => $row['id'],
                    "muveszNev" => $row['muveszNev'],
                    "stilusID" => $row['stilusID'],
                    "nemzetiseg" => $row['nemzetiseg'],
                    "stilusNev" => $row['stilusNev']
                );
            }
            
            http_response_code(200);
            echo json_encode(array("records" => $muvesz_arr, "count" => count($muvesz_arr)));
        }
        break;
        
    default:
        http_response_code(404);
        echo json_encode(array(
            "message" => "Endpoint nem található",
            "available_endpoints" => array(
                "DELETE/POST" => "api.php?action=delete_swing",
                "POST" => "api.php?action=create_muvesz",
                "GET" => "api.php?action=count_zenekar",
                "GET" => "api.php?action=stats_by_stilus",
                "GET" => "api.php?action=list_muvesz"
            )
        ));
        break;
}
?>