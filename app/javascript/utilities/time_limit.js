document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.time-limit')
  if (control) {
    // Get time in minutes
    time_left = parseInt(control.dataset.timeLeft)

    // Execute now
    updateShowTime()
    // And after each second
    var timerId = setInterval(updateShowTime, 1000)
  }
})

function endTestIfTimedOut(time_left) {
  if (time_left <= 0) {
    document.querySelector('form').submit()
  }
}

function updateShowTime() {
  var control = document.querySelector('.time-limit')

  time_left = parseInt(control.dataset.timeLeft) - 1

  control.dataset.timeLeft = time_left

  minutes = Math.floor(time_left / 60);
  seconds = time_left - (minutes * 60);

  timeString = minutes.toString().padStart(2, '0') + ':' + 
               seconds.toString().padStart(2, '0');

  control.textContent = timeString

  endTestIfTimedOut(time_left)
}
