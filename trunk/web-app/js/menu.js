YAHOO.example.onMenuReady = function(p_oEvent) {

  var oMenu = new YAHOO.widget.Menu("menuwithgroups", { fixedcenter: true });
  oMenu.render();
  oMenu.show();

  function onMenuToggleMouseDown(p_oEvent) {
    YAHOO.util.Event.stopPropagation(p_oEvent);
    oMenu.show();
  }

  YAHOO.util.Event.addListener("menutoggle", "mousedown", onMenuToggleMouseDown);
}
