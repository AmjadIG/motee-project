const express = require('express');
const router = express.Router();
const propositionModel = require('../models/proposition')
const userModel = require('../models/user')
const tagModel = require('../models/tag')
const answerModel = require('../models/answer')
const database = require('../database')
const jwt = require('jsonwebtoken');
var bcrypt = require('bcryptjs');
const dotenv = require('dotenv')
dotenv.config();

// delete a tag / called from a proposition or answer
router.post('/delete', (req,res) =>{
  // get the token
  var authorizationHeader = req.headers.authorization;
  if (!authorizationHeader) return res.status(401).send({ errors: 'Authentication error. Token required' });
  var token  = authorizationHeader.split(' ')[1];

  // check token
  jwt.verify(token, process.env.JWT_KEY , function(err, decoded) {
    if (err){
      console.log(err)
      return res.status(500).send({ errors: 'Failed to authenticate token.' });
    }


    tagModel.findById(req.body.id_tag, function(err,tag){
      if (err){
        return res.status(500).send(err);
      }

      console.log(tag)
      // check if a tag is in proposition or answer
      var toDelete = req.body.id_toDelete;
      var prop = tag.idProps.includes(toDelete);

      // if appear more than 1 time
      if(tag.nbOccurence > 1){
        //if is in a proposition
        if(prop){
          // delete the id in idProps field and decrement nbOccurence
          var content = tag.idProps.filter(id => id != toDelete);
          var update = {"idProps" : content,
                        $inc : { "nbOccurence" : -1}}
          tagModel.findOneAndUpdate({"_id" : tag._id},update,{new: true}, function(err,tag1){
            if(err){
              console.log(err);
              return res.status(500).json(err);
            }
            console.log("field idProps in tag model modified");

            // update id tag in proposition model
            propositionModel.findById({_id : toDelete},function(err1,prop1){
              if(err1){
                console.log(err1);
                return res.status(500).json(err);
              }
              console.log("here 1")
              contentProp = prop1.tagsProp.filter(id => id != tag._id);
              propositionModel.findOneAndUpdate({_id : toDelete},contentProp,function(err2,prop2){
                if(err2){
                  console.log(err2);
                  return res.status(500).json(err);
                }
                console.log("here 2")
                console.log("field tagsProps in proposition model modified")
                return res.status(204);
              });
            });

          });
        }
        // if is in a answer
        else{
          // delete the id in idAnswers field and decrement nbOccurence
          var content = tag.idAnswers.filter(id => id != toDelete);
          var update = {"idAnswers" : content,
                        $inc : { "nbOccurence" : -1}}
          tagModel.findOneAndUpdate({"_id" : tag._id},update,{new: true}, function(err,tag1){
            if(err){
              console.log(err);
              return res.status(500).json(err);
            }
            console.log("field idAnswers in tag modified");
          });

          // update id tag in answer model
          answerModel.findById({_id : toDelete},function(err,prop1){
            if(err){
              console.log(err);
              return res.status(500).json(err);
            }
            contentProp = prop1.tagsAnswer.filter(id => id != tag._id);
            answerModel.findOneAndUpdate({_id : toDelete},contentProp,function(err,prop2){
              if(err){
                console.log(err);
                return res.status(500).json(err);
              }
              console.log("field tagsAnswer in Answer model modified")
            });
          });
        }

      // delete the tag
      }else{
        tagModel.findByIdAndRemove(req.body.id_tag,function(err,deleted){
          if(err){
            console.log(err);
            return res.status(500).json(err);
          }
          console.log("tag deleted");
        })
      }
    });
  })
})

module.exports = router
