const express = require('express');
const router = express.Router();
const database = require('../database')
const jwt = require('jsonwebtoken');
var bcrypt = require('bcryptjs');
const dotenv = require('dotenv');
const answerModel = require('../models/answer')
const propositionModel = require('../models/proposition')
const userModel = require('../models/user')
const tagModel = require('../models/tag')
dotenv.config();


// return all answers
router.get('/', (req,res) =>{
  answerModel.find({}, function(err,query){
    if (err){
      return res.status(500).send(err);
    }

     // format the query
    result = {};
    for (var i = 0; i < query.length; i++) {
      result[query[i]._id] = query[i];
    }
    res.status(200).json(result);
  })
});

// return answer by id
router.get('/:id_answer', async (req,res) =>{
  answerModel.findOne({ _id : req.params.id_answer}, function(err,query){
    if (err){
      return res.status(500).send(err);
    }

    console.log(query.length)
    // no proposition found
    if(query.length === 0) {
      res.status(204).send({errors : "No answers found"});
    }
     // format the query
     result = {};
     result[query._id] = query;
     res.status(200).json(result);
  })
});

router.post('/newAnswer', (req, res) => {

  // get the token
  var authorizationHeader = req.headers.authorization;
  if (!authorizationHeader) return res.status(401).send({ errors: 'Authentication error. Token required' });
  var token  = authorizationHeader.split(' ')[1];

  jwt.verify(token, process.env.JWT_KEY , function(err, decoded) {
    if (err){
      console.log(err)
      return res.status(500).send({ errors: 'Failed to authenticate token.' });
    }

    // check if field is filled
    if(!req.body.contentAnswer){
      console.log(" fields are not filled !")
      return res.status(422).json({errors: " fields are not filled !"});
    }

    // save field in model
    var answer = new answerModel();
    answer.contentAnswer = req.body.contentAnswer;
    answer.isAnonymous = req.body.isAnonymous;
    answer.ownerAnswer = decoded.user._id;
    answer.idProp = req.body.idProp;

    // prepare tag for insert
    var tagsReq = req.body.tagsAnswer;
    var tagsArray = tagsReq.split(' ');

    //save proposition in database collection
    answer.save(function (err, answer1) {
      if(err){
        console.log(err);
        return res.status(500).json(err);
      }

      console.log("answer saved");

      // insert answer in user Array
      userModel.findOneAndUpdate({"_id": decoded.user._id},{$push : {"idAnswers" : answer1._id}},{new: true}, function(err,user){
        if(err){
          console.log(err);
          return res.status(500).json(err);
        }
        console.log("user answer Array updated");
      });

      // insert answer in user
      propositionModel.findOneAndUpdate({"_id": answer.idProp},{$push : { "idAnswers" : answer1._id}},{new: true}, function(err,user){
        if(err){
          console.log(err);
          return res.status(500).json(err);
        }
        console.log("user answer id update in proposition");
      })
      
      // counter for tag
      var counter = 0;

      // insert each tags or update if exist
      for (var i = 0; i < tagsArray.length; i++) {
        var query = {"label" : tagsArray[i]},
        update = { "label": tagsArray[i],
                    $inc : { "nbOccurence" : 1},
                    $push : { "idAnswers" : answer._id}},
        options = { upsert: true, new: true, setDefaultsOnInsert: true };

        //insert tag in database
        tagModel.findOneAndUpdate(query,update,options, function(err,tagRes){
          if(err){
            console.log(err);
            return res.status(500).json(err);
          }

          console.log("tags insered !");

          // update tag array in answer collection
          answerModel.findOneAndUpdate({ _id : answer1.id},{$push : { "tagsAnswer" : tagRes._id}},{new: true}, function(err,propU){
            if(err){
              console.log(err);
              return res.status(500).json(err);
            }

            console.log("Array of tag ID updated in answer collection")
            counter++;

            // return the added proposition at the end of the loop
            if(counter == tagsArray.length){
              result = {};
              result[propU._id] = propU;
              return res.status(201).json(result);
            }
          });
        })
      }
    });
  })
});

module.exports = router
