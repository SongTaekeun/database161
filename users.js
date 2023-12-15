var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('joinForm.js check');
});
router.post('/register', function(req, res, next) {
  const { id, password } = req.body;
  const responseData = { id, password };
  res.json(responseData);
});

module.exports = router;
