

function addToTable(x, y, r) {
    const table = document.querySelector('table');
    const newRow = table.insertRow(1);
    const cellX = newRow.insertCell(0);
    const cellY = newRow.insertCell(1);
    const cellR = newRow.insertCell(2);
    const cellResult = newRow.insertCell(3);
    const cellTimestamp = newRow.insertCell(4);
    const cellExecutionTime = newRow.insertCell(5);
    cellX.textContent = x.toFixed(2);
    cellY.textContent = y.toFixed(2);
    cellR.textContent = r.toFixed(2);
    let startTime = performance.now()
    let x1 = parseFloat(x);
    let y1 = parseFloat(y);
    let r1 = parseFloat(r);
        checkPointOnServer(x1, y1, r1)
            .then(isInside => {
                cellResult.textContent = isInside ? "Внутри" : "Вне";
                console.log(isInside)
                const quarterCircle = (x >= 0 && y >= 0 && (x * x + y * y <= r * r));
                const rectangle = (x <= 0 && x >= -r / 2 && y <= 0 && y >= -r);
                const triangle = (x >= 0 && x <= r / 2 && y >= 0 && y <= (r / 2) - x);
                if(quarterCircle || rectangle || triangle){cellResult.textContent = "Внутри";}
                else {cellResult.textContent = "Вне";}

            })
            .catch(error => {
                console.error('Error:', error);
            });

        function checkPointOnServer(x, y, r) {
            return new Promise((resolve, reject) => {
                fetch('/demo3-1.0-SNAPSHOT/controller?x=' + x + '&y=' + y + '&R=' + r)
                    .then(response => response.text())
                    .then(result => {
                        resolve(result === 'true');
                    })
                    .catch(error => {
                        reject(error);
                    });
            });
        }
    const options = { timeZone: 'Europe/Moscow', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
    const timestamp = new Date();
    cellTimestamp.textContent = new Intl.DateTimeFormat('ru-RU', options).format(timestamp);
    let endTime=performance.now()
    const runTime =(endTime-startTime).toFixed(5)
    cellExecutionTime.textContent = runTime/1000 + " секунд";
}
