function drawStaticFigures() {
    context.beginPath();
    context.moveTo(0, centerY);
    context.lineTo(canvas.width, centerY);
    context.strokeStyle = 'black';
    context.stroke();

    for (let i = -100; i <= 100; i += 50) {
        context.beginPath();
        context.arc(centerX + i, centerY, 3, 0, Math.PI * 2);
        context.fillStyle = 'black';
        context.fill();
        context.strokeStyle = 'black';
        context.stroke();
    }

// Draw y-axis
    context.beginPath();
    context.moveTo(centerX, 0);
    context.lineTo(centerX, canvas.height);
    context.strokeStyle = 'black';
    context.stroke();

    for (let i = -100; i <= 100; i += 50) {
        context.beginPath();
        context.arc(centerX, centerY - i, 3, 0, Math.PI * 2);
        context.fillStyle = 'black';
        context.fill();
        context.strokeStyle = 'black';
        context.stroke();
    }
// Draw quarter circle
    const canvasRadius = 50;
    context.beginPath();
    context.moveTo(centerX, centerY);
    context.arc(centerX, centerY, canvasRadius*2, Math.PI* 1.5, 0);
    context.closePath();
    context.fillStyle = 'rgba(0, 128, 255, 0.3)';
    context.fill();
    context.strokeStyle = 'blue';
    context.stroke();
// Draw rectangle
    const rectWidth = 100;
    const rectHeight = 50;
    context.beginPath();
    context.rect(centerX - rectHeight, centerY-rectHeight*2, rectHeight, rectWidth);
    context.fillStyle = 'rgba(255, 0, 0, 0.3)';
    context.fill();
    context.strokeStyle = 'red';
    context.stroke();
// Draw triangle
    const triangleHeight = 50;
    context.beginPath();
    context.moveTo(centerX, centerY + triangleHeight*2);
    context.lineTo(centerX + rectWidth / 2, centerY);
    context.lineTo(centerX, centerY);
    context.closePath();
    context.fillStyle = 'rgba(0, 255, 0, 0.3)';
    context.fill();
    context.strokeStyle = 'green';
    context.stroke();
// Labels
    context.font = '12px Arial';
    context.fillStyle = 'black';
    context.fillText('R', centerX + 100, centerY + 20);
    context.fillText('R/2', centerX + 50, centerY + 20);
    context.fillText('-R', centerX - 100, centerY + 20);
    context.fillText('-R/2', centerX - 50, centerY + 20);

    context.textAlign = 'right';
    context.fillText('R', centerX - 10, centerY - 100);
    context.fillText('R/2', centerX - 10, centerY - 50);
    context.fillText('-R', centerX - 10, centerY + 100);
    context.fillText('-R/2', centerX - 10, centerY + 50);
    context.textAlign = 'left';
}

function drawPoint(x, y, R) {
    const canvasWidth =210; // Width of your canvas
    const canvasHeight = 200; // Height of your canvas
    const scalex = canvasWidth / (2 * R);
    const scaley = canvasHeight / (2 * R);// Adjust this scale factor as needed for your canvas
    const scaledX = centerX + x * scalex;
    const scaledY = centerY - y * scaley;

    context.beginPath();
    context.arc(scaledX, scaledY, 3, 0, Math.PI * 2);
    context.fillStyle = 'red';
    context.fill();
    context.strokeStyle = 'black';
    context.stroke();
}

function updateCanvas() {

    const newR = parseFloat(getCheckedValue('R'));
    drawStaticFigures(newR);

    const selectedX = parseFloat(getCheckedValue('x'));
    const selectedY = parseFloat(document.getElementById('y').value);

    drawPoint(selectedX, selectedY, newR);
}

function getCheckedValue(name) {
    const radioButtons = document.getElementsByName(name);
    for (const radioButton of radioButtons) {
        if (radioButton.checked) {
            return radioButton.value;
        }
    }
    return null;
}
