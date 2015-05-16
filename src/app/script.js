var openInRegJump = function(selectedText) {
  chrome.runtime.sendNativeMessage('com.hmemcpy.chrome.regjump', { text: selectedText.trim() }, function(response) {
    console.log("Received " + response);
  });
}

chrome.contextMenus.create({
  title: "Open %s in Regedit",
  contexts:["selection"],
  onclick: function(info, tab) {
     openInRegJump(info.selectionText);
  }
 });
