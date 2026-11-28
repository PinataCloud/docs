function reo() {
	var e, t, n;
	e = "3ca5238beb530cd";
	t = () => {
		Reo.init({ clientID: "3ca5238beb530cd" });
	};
	n = document.createElement("script");
	n.src = `https://static.reo.dev/${e}/reo.js`;
	n.defer = true;
	n.onload = t;
	document.head.appendChild(n);
}

reo();
