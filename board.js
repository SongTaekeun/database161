var express = require('express');
var router = express.Router();
var listController = require('../controllers/listController')
var writeController = require('../controllers/writeController');

router.get('/', require('../controllers/listController').getListFirst);
router.get('/list/:id', listController.getList);

router.get('/write',writeController.writeForm);
router.post('/write', writeController.writeData);

module.exports = router;