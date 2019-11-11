document.addEventListener('turbolinks:load', function() {
    var control = document.querySelector('.progress-bar')
    if (control) { handleProgressBar(control) }
})

function handleProgressBar(control) {
    var currentQuestion = control.dataset.currentQuestion
    var overallQuestions = control.dataset.overallQuestions
    var progressBarValue = control.querySelector('.progress-bar-value')

    var percentage = (currentQuestion * 100.0) / overallQuestions

    // Change inner text of progress bar
    progressBarValue.innerText = percentage + '%'
    // Fill progress bar
    control.style.width = percentage + "%"
}
