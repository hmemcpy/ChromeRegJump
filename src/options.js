function verify() {
  var status = document.getElementById('status');
  status.textContent = '';
  chrome.runtime.sendNativeMessage('com.hmemcpy.chrome.regjump', { "status": "validate" }, function(response) {
    if (response == undefined) {
      status.setAttribute('class', 'alert alert-danger');
      status.textContent = "Unable to communicate with RegJump. Please make sure you follow the installation instructions above.";
    } else if (response.message == 'regjump') {
      status.setAttribute('class', 'alert alert-warning')
      status.innerHTML = 'Unable to locate Microsoft RegJump. Please download it and extract it to: ' + '<strong>' + response.regJumpPath + '</strong>';
    } else if (response.message == 'ok') {
      status.setAttribute('class', 'alert alert-info')
      status.textContent = 'All good!';
    }
  });
}

function setExtensionId() {
  var elements = document.getElementsByClassName('extension_id');
  for (var i = 0; i < elements.length; i++) {
    elements[i].textContent = chrome.runtime.id;
  }
  elements = document.getElementsByClassName('version');
  for (var i = 0; i < elements.length; i++) {
    elements[i].textContent = chrome.runtime.getManifest().version;
  }

  var author = document.getElementById('author');
  author.textContent = chrome.runtime.getManifest().author;
  var version = document.getElementById('version');
  version.textContent = "v" + chrome.runtime.getManifest().version;
  var homepage_url = document.getElementById('homepage_url');
  homepage_url.href = chrome.runtime.getManifest().homepage_url;
}

document.addEventListener('DOMContentLoaded', setExtensionId);
document.getElementById('verify').addEventListener('click', verify);
