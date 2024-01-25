function validateForm() {
    const xInput = document.querySelector('input[name="x"]:checked');
    const yInput = document.getElementById("y");
    const rInput = document.querySelector('input[name="R"]:checked');
    document.getElementById('selectedR').value = rInput;
    const notification = document.getElementById("errorMessage");
    function showMessage(messageArea, message) {
        messageArea.textContent = message;
        messageArea.style.display = "block";
        setTimeout(function () {
            messageArea.style.display = "none"
        }, 3000);
    }
    if (!xInput || !rInput) {
        showMessage(notification,"Please select values for X and R.");
        return false;
    }

    if (!isNumeric(yInput.value)) {
        showMessage(notification,"Please enter a valid numeric value for Y.");
        return false;
    }

    notification.textContent = "";
    return true;
}

function isNumeric(value) {
    return !isNaN(parseFloat(value)) && isFinite(value);
}