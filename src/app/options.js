function verify() {
  var status = document.getElementById('status');
  status.textContent = '';
  chrome.runtime.sendNativeMessage('com.hmemcpy.chromes.regjump', { "status": "validate" }, function(response) {
    if (response == undefined) {
      status.textContent = "Unable to communicate with RegJump. Make sure you've installed it correctly";
    }
  });
}

document.getElementById('verify').addEventListener('click', verify);
