document.addEventListener('turbolinks:load', function() {
  var control = document.getElementById('badge_rule')
  if (control) {
    // Add event on selection box element select
    control.addEventListener('change', loadValues)
  }
})

function loadValues(event) {
  // Our rule selection box
  var rule_control = event.target
  // Our value selection box
  var value_control = document.getElementById('badge_value')
  // New value selection box
  var new_value_control = document.createElement('select')

  // Preserve id and name attributes of the
  // original select box. This is needed for Rails
  // to correctly parse and save submitted data to DB
  new_value_control.id = 'badge_value'
  new_value_control.name = value_control.name

  // If we want to load categories
  if (rule_control.value == 'passed_all_tests_by_category?') {
    showValueSelectionParagraph() //                        Parse data attribute as JSON array
    populateValueSelectionWithTestCategories(new_value_control, JSON.parse(rule_control.dataset.categories))

    // Replace old value selection box with new one
    var parent_node = value_control.parentNode
    parent_node.replaceChild(new_value_control, value_control)
  }

  // If we want to load avaliable test levels
  if (rule_control.value == 'passed_all_lvl_tests?') {
    showValueSelectionParagraph() //                        Parse data attribute as JSON array
    populateValueSelectionWithTestLevels(new_value_control, JSON.parse(rule_control.dataset.levels))

    // Replace old value selection box with new one
    var parent_node = value_control.parentNode
    parent_node.replaceChild(new_value_control, value_control)
  }

  // If we want to remove value selection
  // because passed_test_first_try? implies no value
  if (rule_control.value == 'passed_test_first_try?') {
    // Empty it because we don't wanna any info laying there
    emptyValueSelection(value_control)
    hideValueSelectionParagraph()
  }

}

function populateValueSelectionWithTestCategories(value_control, categories) {
  for (var i = 0; i < categories.length; i++) {
    var opt = document.createElement('option')
    opt.setAttribute('value', categories[i])
    opt.text = categories[i]
    value_control.appendChild(opt)
  }
}

function populateValueSelectionWithTestLevels(value_control, levels) {
  for (var i = 0; i < levels.length; i++) {
    var opt = document.createElement('option')
    opt.setAttribute('value', levels[i])
    opt.text = levels[i]
    value_control.appendChild(opt)
  }
}

function emptyValueSelection(value_selection) {
  for (var i = 0; i < value_selection.length; i++) {
    value_selection.remove(i)
  }
}

function showValueSelectionParagraph() {
  var paragraph_control = document.getElementById('value_prompt')
  if (paragraph_control.classList.contains('hide')) {
    paragraph_control.classList.remove('hide')
  }
}

function hideValueSelectionParagraph() {
  var paragraph_control = document.getElementById('value_prompt')
  if (!paragraph_control.classList.contains('hide')) {
    paragraph_control.classList.add('hide')
  }
}
