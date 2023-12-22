const BREWERIES = {};

const handleResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement('tr');
  tr.classList.add('tablerow');
  const name = tr.appendChild(document.createElement('td'));
  name.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement('td'));
  year.innerHTML = brewery.year;
  const beer_count = tr.appendChild(document.createElement('td'));
  beer_count.innerHTML = brewery.beer_count;
  const status = tr.appendChild(document.createElement('td'));
  status.innerHTML = brewery.active ? 'active' : 'retired';
  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll('.tablerow').forEach((el) => el.remove());
  const table = document.getElementById('brewerytable');
  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => a.year - b.year);
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => a.beer_count - b.beer_count);
};

const breweries = () => {
  document.getElementById('name').addEventListener('click', (e) => {
    e.preventDefault();
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById('year').addEventListener('click', (e) => {
    e.preventDefault();
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById('beer_count').addEventListener('click', (e) => {
    e.preventDefault();
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });

  fetch('breweries.json')
    .then((response) => response.json())
    .then(handleResponse);
};

export { breweries };
