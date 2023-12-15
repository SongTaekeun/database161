var express = require('express');
var router = express.Router();
var model = require('../models');

/* GET home page. */
module.exports = async(req,res)=>{
	let result = await model.boards.findAll({}).catch((err)=>console.log(err));
	console.log(result);
	res.render('index',{title: 'test', rows: result});
};

