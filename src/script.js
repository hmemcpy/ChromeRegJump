var openInRegJump = function(selectedText) {
  chrome.runtime.sendNativeMessage('com.hmemcpy.chrome.regjump', { text: selectedText.trim() }, function(response) {
    console.log("Received " + response);
  });
}

chrome.contextMenus.create({
  title: "Open %s in Registry Editor",
  contexts:["selection"],
  onclick: function(info, tab) {
     openInRegJump(info.selectionText);
  }
});


chrome.runtime.onInstalled.addListener(function(details){
  if(details.reason == "install"){
    var optionsUrl = chrome.extension.getURL('options.html');

    chrome.tabs.query({url: optionsUrl}, function(tabs) {
       if (tabs.length) {
           chrome.tabs.update(tabs[0].id, {active: true});
       } else {
           chrome.tabs.create({url: optionsUrl});
       }
    });
  }
});
