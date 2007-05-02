/**
 * Switch HTML form elements to display according to specified party kind 
 * (currently, Cash Game or Sit and Go)
 */
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


var tryingDeleteElementId = '';

function confirmDelete(confirmDlg, yesDlg, noDlg, elementId, postUrl) {
    var yesSubmitUrl = postUrl + "/" + elementId;
    tryingDeleteElementId = elementId;
    var commands = document.getElementById('commands-' + elementId);
    var post = commands.parentNode;
    commands.style.display = 'none';
    var confirmDeleteMethod = 'new Ajax.Updater(\'\',\'' + yesSubmitUrl + '\',{asynchronous:true,evalScripts:true,onSuccess:successDelete});return false;';
    var newDiv = Builder.node('div', {className:'commands', id:'commands-askdelete-' + elementId}, [
        Builder.node('span', {className:'important'}, ' ' + confirmDlg + ' '),
        Builder.node('a', {onclick:confirmDeleteMethod, href:'javascript:void(0);'}, yesDlg),
        ' / ',
        Builder.node('a', {onclick:'javascript:cancelDelete();', href:'javascript:void(0);'}, noDlg),
    ]);
    post.appendChild(newDiv);
}

function cancelDelete() {
    Element.remove(document.getElementById('commands-askdelete-' + tryingDeleteElementId));
    Element.toggle(document.getElementById('commands-' + tryingDeleteElementId));
    tryingDeleteElementId = '';
}

function successDelete(t) {
	var deleteResponse = eval('(' + t.responseText + ')');
    if (deleteResponse.status == "success") {
       document.getElementById('delete-result-status').innerHTML = 
       		"<div class=\"message_embed\">" + deleteResponse.msg + "</div>";
       Effect.Fade(document.getElementById('row-' + tryingDeleteElementId));
       Element.remove(document.getElementById('row-' + tryingDeleteElementId));
    } else {
       document.getElementById('delete-result-status').innerHTML = 
       		"<div class=\"errors_embed\">" + deleteResponse.msg + "</div>";
    }
    Effect.Appear('delete-result-status', {duration: 3.0 });
    new Effect.Highlight('delete-result-status', {duration: 2.0});
    Effect.Fade('delete-result-status');
    cancelDelete();
}

function onDefaultSubmitButtonsMarkupReady() {
	var oSubmitButton1 = new YAHOO.widget.Button('wrappedSubmit', { id:'submit' });
}

function onSubmitButtonsMarkupReady(origId, destId) {
	var oSubmitButton1 = new YAHOO.widget.Button(origId, { id:destId });
}
