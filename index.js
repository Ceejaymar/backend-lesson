const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const port = 3002;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use((err, req, res) => {
  res.status(400).json({ error: err.toString() });
});

app.listen(port, () => {
  console.log(`App is running on port: ${port}`);
});
