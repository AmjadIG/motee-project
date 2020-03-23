const express = require('express');
const router = express.Router();
const userModel = require('../models/user')
const database = require('../database')
const jwt = require('jsonwebtoken');
var bcrypt = require('bcryptjs');
const dotenv = require('dotenv')
dotenv.config();

// get all user
router.get('/', (req,res) =>{
  userModel.find({}, function(err,query){
    if (err){
      return res.status(500).send(err);
    }
     // format the query
    result = {};
    for (var i = 0; i < query.length; i++) {
      query[i].password = null;
      result[query[i]._id] = query[i];
    }
    res.status(200).json(result);
  })
});

// get user by id
router.get('/:id_user', async (req,res) =>{
  userModel.findById(req.params.id_user, function(err,query){
    if (err){
      return res.status(500).send(err);
    }
    // no proposition found
    if(query) {
      // format the query
      query.password = null;
      result = {};
      result[query._id] = query;
      res.status(200).json(result);
    }else{
      res.status(204).send({errors : "No user found"});
    }
  })
});

// Login
// return a token with user info inside
router.post('/authenticate', (req, res) => {
  const pseudo = req.body.pseudo
  const password = req.body.password

  if(!pseudo || !password){
    return res.status(422).json({errors: "pseudo or password is required !"});
  }

  userModel.findOne({"pseudo" : pseudo}, function(err,user){
    if (err){
      console.log(err)
      return res.status(500).send({ errors: 'Internal error' });
    }

    if(user){
      // check poassword
      console.log(user)
      bcrypt.compare(password, user.password, function(err, result) {
        if (err){
          console.log(err)
          return res.status(500).send({ errors: 'Internal error' });
        }
        // if password is correct
        if(result){
          // update state in user
          userModel.findOneAndUpdate({"_id": user.id},{"isConnected" : true},{new: true}, function(err){
            if(err){
              console.log(err);
              return res.status(500).json(err);
            }
            console.log("user update");
          });

          // format user and create token
          user.password = null;
          user.isConnected = true;
          var token = jwt.sign({user}, process.env.JWT_KEY, {expiresIn: 86400});
          res.status(200).json({token: token});
        }else{
          return res.status(400).json({errors: "password is invalid !"});
        }
      })
    }else{
      return res.status(400).json({errors: "pseudo is invalid !"});
    }
  });
});

// register a new user
router.post('/register', (req, res) => {

  const pseudo = req.body.pseudo;
  const password = req.body.password;
  const mail = req.body.mail;

  if(!pseudo || !password || !mail){
    return res.status(422).json({errors: " fields are not filled !"});
  }

  // find if a user with the same pseudo and email exist
  userModel.findOne({$or: [{"pseudo": pseudo},{"mail": mail}]},function(err,user1){
    if(err){
      console.log(err);
      return res.status(500).json(err);
    }

    // case of is exist
    if(user1){
      console.log("pseudo or mail already exist");
      return res.status(400).json({ errors: "pseudo or mail already exist" });
    }

    // create user with model
    var user = new userModel();
    user.pseudo = pseudo;
    user.password = bcrypt.hashSync(password, bcrypt.genSaltSync(10));
    user.mail = mail;

    //save user in database
    user.save(function(err){
      if(err){
        console.log(err);
        return res.status(500).json(err);
      }

      console.log("user created");
      return res.status(201).json("user created");
    });
  });
});

// logout
router.put('/logout', (req, res) => {

  // get the token
  var authorizationHeader = req.headers.authorization;
  if (!authorizationHeader) return res.status(401).send({ errors: "Error. No connected" });
  var token  = authorizationHeader.split(' ')[1];

  // check token
  jwt.verify(token, process.env.JWT_KEY , function(err, decoded) {
    if (err){
      console.log(err)
      return res.status(500).send({ errors: 'Failed to authenticate token.' });
    }

    // update state user
    userModel.findOneAndUpdate({"_id": decoded._id},{"isConnected" : false},{new: true}, function(err){
      if(err){
        console.log(err);
        return res.status(500).json(err);
      }
      console.log("user update and logout");
      res.status(200).send({ token: null });
    });

  });
})


// fonction inachevé
router.get('/userinfo', async (req,res) =>{
  var authorizationHeader = req.headers.authorization;
  if (!authorizationHeader) return res.status(401).send({ errors: 'Authentication error. Token required' });

  var token  = authorizationHeader.split(' ')[1];
  console.log(token);
  jwt.verify(token, process.env.JWT_KEY , function(err, decoded) {
    if (err){
      return res.status(500).send({ errors: 'Failed to authenticate token.' });
    }

    console.log(decoded);

    res.status(200).send(decoded);
  });


});

module.exports = router
