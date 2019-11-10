document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.sort-by-title')
  if (control) { control.addEventListener('click', sortRowsByTitle) }
})

function sortRowsByTitle() {
  var table = document.querySelector('table')

  // rows is NodeList
  var rows = table.querySelectorAll('tr')
  var sortedRows = []

  // select all table rows except first (header)
  for (var i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i])
  }

  // direction of sorting based on arrow visibility
  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc)
    this.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.querySelector('.octicon-arrow-down').classList.add('hide')
  } else {
    sortedRows.sort(compareRowsDesc)
    this.querySelector('.octicon-arrow-up').classList.add('hide')
    this.querySelector('.octicon-arrow-down').classList.remove('hide')
  }

  var sortedTable = document.createElement('table')
  sortedTable.classList.add('table') // add CSS class 'table'
  sortedTable.appendChild(rows[0]) // Add table header

  for(var i = 0; i < sortedRows.length; i++) {
    sortedTable.appendChild(sortedRows[i])
  }

  // replace original table in the document with sorted table
  table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
  var tesTitle1 = row1.querySelector('td').textContent
  var tesTitle2 = row2.querySelector('td').textContent

  if (tesTitle1 < tesTitle2) { return -1 }
  if (tesTitle1 > tesTitle2) { return 1 }
  return 0
}

function compareRowsDesc(row1, row2) {
  var tesTitle1 = row1.querySelector('td').textContent
  var tesTitle2 = row2.querySelector('td').textContent

  if (tesTitle1 < tesTitle2) { return 1 }
  if (tesTitle1 > tesTitle2) { return -1 }
  return 0
}
