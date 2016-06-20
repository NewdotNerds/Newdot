function delightBackground() {
		var images = ["img/bike.jpg", "img/bicycle.jpg", "img/road.jpg", "img/place.jpg", "img/court.jpg", "img/way.jpg", "img/centre.jpg"];
		var n = Math.floor(Math.random()*images.length);
		var theImage = 'url(' + images[n] + ')';

		document.getElementsByTagName("html")[0].style.backgroundImage = theImage;
	}