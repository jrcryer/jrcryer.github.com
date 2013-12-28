/* Use this script if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-tree' : '&#x64;',
			'icon-mobile' : '&#x6d;',
			'icon-google-plus' : '&#x67;',
			'icon-github' : '&#x68;',
			'icon-android' : '&#x61;',
			'icon-linkedin' : '&#x6c;',
			'icon-html5' : '&#x70;',
			'icon-file-xml' : '&#x63;',
			'icon-layers' : '&#x62;',
			'icon-monitor' : '&#x69;',
			'icon-cogs' : '&#x65;',
			'icon-database' : '&#x73;',
			'icon-rocket' : '&#x72;',
			'icon-cloud-upload' : '&#x75;',
			'icon-cloud' : '&#x79;',
			'icon-twitter' : '&#x77;',
			'icon-facebook' : '&#x6f;',
			'icon-google-plus-2' : '&#x6a;',
			'icon-apple' : '&#x76;',
			'icon-css3' : '&#x21;',
			'icon-wordpress' : '&#x22;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, html, c, el;
	for (i = 0; i < els.length; i += 1) {
		el = els[i];
		attr = el.getAttribute('data-icon');
		if (attr) {
			addIcon(el, attr);
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};