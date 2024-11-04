const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Data dummy untuk menyimpan item
let items = [
  { id: 1, title: 'Item 1', body: 'Description of item 1' },
  { id: 2, title: 'Item 2', body: 'Description of item 2' },
];

// Endpoint GET untuk mendapatkan semua item
app.get('/items', (req, res) => {
  res.json(items);
});

// Endpoint POST untuk menambahkan item baru
app.post('/items', (req, res) => {
  const newItem = {
    id: items.length + 1,
    title: req.body.title,
    body: req.body.body,
  };
  items.push(newItem);
  res.status(201).json(newItem);
});

// Endpoint PUT untuk mengupdate item
app.put('/items/:id', (req, res) => {
  const itemId = parseInt(req.params.id);
  const itemIndex = items.findIndex((item) => item.id === itemId);
  if (itemIndex !== -1) {
    items[itemIndex].title = req.body.title;
    items[itemIndex].body = req.body.body;
    res.json(items[itemIndex]);
  } else {
    res.status(404).json({ message: 'Item not found' });
  }
});

// Endpoint DELETE untuk menghapus item
app.delete('/items/:id', (req, res) => {
  const itemId = parseInt(req.params.id);
  items = items.filter((item) => item.id !== itemId);
  res.json({ message: 'Item deleted' });
});

// Menjalankan server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
