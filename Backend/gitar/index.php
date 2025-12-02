<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gitárművészek REST API</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        h1 { 
            color: #333; 
            margin-bottom: 10px;
            font-size: 2em;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        .endpoint {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .method {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-weight: bold;
            font-size: 0.85em;
            margin-right: 10px;
        }
        .get { background: #28a745; color: white; }
        .post { background: #007bff; color: white; }
        .delete { background: #dc3545; color: white; }
        .url {
            color: #495057;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
        }
        .description {
            color: #666;
            margin-top: 8px;
            font-size: 0.9em;
        }
        .json-example {
            background: #2d2d2d;
            color: #f8f8f2;
            padding: 10px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            font-size: 0.85em;
            margin-top: 8px;
            overflow-x: auto;
        }
        .section {
            margin-bottom: 30px;
        }
        .section-title {
            color: #667eea;
            font-size: 1.3em;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎸 Gitárművészek REST API</h1>
        <p class="subtitle">PHP REST API a gitárművészek adatbázis kezeléséhez</p>
        
        <div class="section">
            <h2 class="section-title">📋 Elérhető Endpointok</h2>
            
            <div class="endpoint">
                <span class="method delete">DELETE/POST</span>
                <span class="url">api.php?action=delete_swing</span>
                <div class="description">Swing stílus törlése az adatbázisból</div>
                <div class="json-example">{"stilusNev": "swing"}</div>
            </div>
            
            <div class="endpoint">
                <span class="method post">POST</span>
                <span class="url">api.php?action=create_muvesz</span>
                <div class="description">Új művész hozzáadása (pl. Joe Bonamassa)</div>
                <div class="json-example">{"muveszNev": "Joe Bonamassa", "stilusID": 1, "nemzetiseg": "amerikai"}</div>
            </div>
            
            <div class="endpoint">
                <span class="method get">GET</span>
                <span class="url">api.php?action=count_zenekar</span>
                <div class="description">Összes zenekar számának lekérdezése</div>
            </div>
            
            <div class="endpoint">
                <span class="method get">GET</span>
                <span class="url">api.php?action=stats_by_stilus</span>
                <div class="description">Művészek száma stílusonként (növekvő sorrendben)</div>
            </div>
            
            <div class="endpoint">
                <span class="method get">GET</span>
                <span class="url">api.php?action=list_muvesz</span>
                <div class="description">Összes művész listázása stílus információval</div>
            </div>
        </div>
        
        <div class="section">
            <h2 class="section-title">🚀 Gyors Start</h2>
            <div class="endpoint">
                <strong>1.</strong> Hozza létre a gitarmuveszek adatbázist UTF-8 kódolással<br>
                <strong>2.</strong> Importálja az adatbazis.sql fájlt<br>
                <strong>3.</strong> Állítsa be a config.php fájlban az adatbázis kapcsolatot<br>
                <strong>4.</strong> Tesztelje a Postman-nel vagy böngészőből
            </div>
        </div>
    </div>
</body>
</html>