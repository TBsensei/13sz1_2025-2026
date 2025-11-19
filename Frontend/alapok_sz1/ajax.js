// Get keres
function getData(url){
    return new Promise((resolve, reject) => {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.onreadystatechange = () =>{
            if (xhr.readyState === 4){
                if (xhr.status === 200){
                    resolve(JSON.parse(xhr.responseText));
                }else {
                    let errorData;
                    try{
                        errorData = JSON.parse(xhr.responseText);
                    }catch (e){
                        errorData = {
                            status : xhr.status,
                        };
                    }
                    reject(errorData);
                }
            }
        }
        xhr.send();
    });
}
// JSON vs XML egy nagyon rovid pelda
// POST
// PUT
// DELETE