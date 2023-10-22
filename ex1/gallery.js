// Масив з назвами файлів зображень
const imageNames = [
    "FS30_4",
    "FS30_5",
    "FS30_4",
    "FS30_5"
    // Додайте інші назви файлів, якщо потрібно
];

// Функція для створення тегів <img> на основі масиву назв файлів
/* function createImageGallery() {
    const galleryContainer = document.getElementById("imageGallery");

    // Проходимось по масиву назв файлів та створюємо <img> елементи
    for (const imageName of imageNames) {
        const img = document.createElement("img");
        img.src = "img/" + imageName;
        img.alt = imageName;
        img.width = "500";
        galleryContainer.appendChild(img);
    }
}
*/
function createImageGallery() {
    const galleryContainer = document.getElementById("imageGallery");

    // Проходимось по масиву назв файлів та створюємо <img> елементи
    for (const imageName of imageNames) {
        const img = document.createElement("div");
        //img.src = "img/" + imageName;
        //img.alt = imageName;
        //img.width = "500";
        img.innerHTML = '<div class="post"><div class="post_title"><h2><a href="ind/'+imageName+'.ex4">'+imageName+'</a></h2></div>	<div class="image-frame"><img src="img/'+imageName+'.png" width="420px" height="215px" alt="'+imageName+'" onclick="enlargeImage(this)"></div><img id="enlarged-image" class="enlarged-image" onclick="closeEnlargedImage()"><div class="post_meta"><a href="ind/'+imageName+'.ex4">'+imageName+'.ex4</a> |  <a href="ind/'+imageName+'.mq4">'+imageName+'.mq4</a></div></div>';
        galleryContainer.appendChild(img);
    }
}

// Викликаємо функцію для створення галереї після завантаження сторінки
window.addEventListener("load", createImageGallery);
