const mongoose = require('mongoose')

const UserSchema = new mongoose.Schema({
  pseudo:{
    type: String,
    required: true,
    unique: true
  },
  mail:{
    type: String,
    required: true,
    unique: true,
    match : /\S+@\S+\.\S+/
  },
  password:{
    type: String,
    required: true
  },
  city:{
    type: String
  },
  isAdmin:{
    type: Boolean,
    default: false
  },
  isConnected:{
    type:Boolean,
    default: false
  },
  isBanned:{
    type:Boolean,
    default : false
  },
  idPropositions:{
    type: [mongoose.Schema.Types.ObjectId]
  },
  idAnswers:{
    type: [mongoose.Schema.Types.ObjectId]
  }
});


// le 3eme parametre est la collection
const User =  mongoose.model('User',UserSchema,'User');
module.exports = User;
