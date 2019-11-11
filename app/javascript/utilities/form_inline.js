document.addEventListener('turbolinks:load', function() {
  // Select all 'Edit' links
  var controls = document.querySelectorAll('.form-inline-link')

  if (controls.length) {
    for( var i = 0; i < controls.length; i++ ) {
      controls[i].addEventListener('click', formInlineLinkHandler)
    }
  } else {
      return
  }

  // If there are errors on the page
  var errors = document.querySelector('.resource-errors')
  if (errors) {
    // Then show the edit form for the resocurce with errors
    // no click on 'Edit' needed
    var resourceId = errors.dataset.resourceId
    formInlineHandler(resourceId)
  }

})

function formInlineLinkHandler(event) {
  // Override default link handling when clicking on 'Edit'
  event.preventDefault()
  var testId = this.dataset.testId
  formInlineHandler(testId)
}

function formInlineHandler(testId) {
  var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
  var testTitle = document.querySelector('.test-title[data-test-id="' + testId + '"]')
  var formInline = document.querySelector('.form-inline[data-test-id="' + testId + '"]')

  if (formInline.classList.contains('hide')) {
    testTitle.classList.add('hide')
    formInline.classList.remove('hide')
    link.textContent = 'Cancel'
  } else {
    testTitle.classList.remove('hide')
    formInline.classList.add('hide')
    link.textContent = 'Edit'
  }
}
