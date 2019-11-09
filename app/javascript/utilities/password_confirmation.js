document.addEventListener('turbolinks:load', function() {
  var control = document.getElementById('user_password_confirmation')
  if (control) { control.addEventListener('input', checkPasswordConfirmation) }
})

function checkPasswordConfirmation() {
    var password = document.getElementById('user_password').value
    var password_confirmation = this.value

    // If there is no user input in password_confirmation field
    // remove all isons
    if (password_confirmation.length == 0) {
        document.querySelector('.octicon-check').classList.add('hide')
        document.querySelector('.octicon-x').classList.add('hide')
        return
    }

    // Compare substrings
    if (password_confirmation == password) {
        document.querySelector('.octicon-check').classList.remove('hide')
        document.querySelector('.octicon-x').classList.add('hide')
    } else {
        document.querySelector('.octicon-check').classList.add('hide')
        document.querySelector('.octicon-x').classList.remove('hide')
    }
}
