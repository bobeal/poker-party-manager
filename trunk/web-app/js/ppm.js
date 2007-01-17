function switchKindFields() {
  	Element.toggle(document.getElementById('cashgame'));
	if (Element.visible(document.getElementById('cashgame'))) {
		Element.setStyle(document.getElementById('cashgame'), {display:'inline'});
		Element.addClassName(document.getElementById('buyinLabel'), 'required');
	}
  	Element.toggle(document.getElementById('sitandgo'));
	if (Element.visible(document.getElementById('sitandgo'))) {
		Element.setStyle(document.getElementById('sitandgo'), {display:'inline'});
		Element.removeClassName(document.getElementById('buyinLabel'), 'required');
	}
}

function setChampionshipTab(tabId) {
	expandtab('maintab', 3);
	Element.show(tabId);
}

function simulateClick(objectId) {
	var evt = document.createEvent("MouseEvents");
  	evt.initMouseEvent("click", true, true, window,
    	0, 0, 0, 0, 0, false, false, false, false, 0, null);
  	var cb = document.getElementById(objectId); 
  	cb.dispatchEvent(evt);
  	/*
  	var canceled = !cb.dispatchEvent(evt);
  	if(canceled) {
    	// A handler called preventDefault
    	alert("canceled");
  	} else {
    	// None of the handlers called preventDefault
    	alert("not canceled");
  	}
  	*/
}