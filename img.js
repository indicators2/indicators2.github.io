function enlargeImage(image) {
    var enlargedImage = document.getElementById("enlarged-image");
    enlargedImage.src = image.src;
    enlargedImage.style.display = "block";
}
function closeEnlargedImage() {
    var enlargedImage = document.getElementById("enlarged-image");
    enlargedImage.style.display = "none";
}
