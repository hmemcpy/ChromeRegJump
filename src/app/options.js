function verify() {
  var status = document.getElementById('status');
  status.textContent = '';
  chrome.runtime.sendNativeMessage('com.hmemcpy.chrome.regjump', { "status": "validate" }, function(response) {
    if (response == undefined) {
      status.textContent = "Unable to communicate with RegJump. Make sure you've installed it correctly";
    } else if (response.message == 'regjump') {
      status.textContent = 'Unable to locate Microsoft RegJump. Please download it and extract it to: ' + response.regJumpPath;
    } else if (response.message == 'ok') {
      status.textContent = 'All good!';
    }
  });
}

document.getElementById('verify').addEventListener('click', verify);
