function limitInputLength(input, maxLength) {
    console.log("yer5")
    if (input.value.length > maxLength) {
        input.value = input.value.slice(0, maxLength);
    }
}