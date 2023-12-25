const DATA = {};

const handleResponse = (rows) => {
  DATA.list = rows;
  DATA.show();
};

const getColumns = () => {
  const colNodes = document.querySelectorAll('#datatable > thead > tr > th');
  return [...colNodes];
};

const createTableRow = (row) => {
  const tr = document.createElement('tr');
  tr.classList.add('tablerow');
  for (const column of getColumns()) {
    const col = tr.appendChild(document.createElement('td'));
    col.innerHTML = row[column.dataset['name']];
  }
  return tr;
};

DATA.show = () => {
  document.querySelectorAll('.tablerow').forEach((el) => el.remove());
  const table = document.getElementById('datatable');
  DATA.list.forEach((row) => {
    const tr = createTableRow(row);
    table.appendChild(tr);
  });
};

DATA.sortByStringColumn = (col) => {
  DATA.list.sort((a, b) => {
    return a[col]
      .toString()
      .toUpperCase()
      .localeCompare(b[col].toString().toUpperCase());
  });
};

DATA.sortByNumberColumn = (col) => {
  DATA.list.sort((a, b) => a[col] - b[col]);
};

DATA.sortByColumn = (col) => {
  if (DATA.list.length > 0) {
    const col_name = col.dataset['name'];
    switch (typeof DATA.list[0][col_name]) {
      case 'number':
        DATA.sortByNumberColumn(col.dataset.name);
        break;
      default:
        DATA.sortByStringColumn(col.dataset.name);
    }
  }
};

const tablerows = () => {
  for (const col of getColumns()) {
    col.addEventListener('click', (e) => {
      e.preventDefault();
      DATA.sortByColumn(col);
      DATA.show();
    });
  }

  const table = document.getElementById('datatable');

  fetch(`${table.dataset.json}.json`)
    .then((response) => response.json())
    .then(handleResponse);
};

export { tablerows };
