const mongoose = require('mongoose')

const AnswerSchema = new mongoose.Schema({
  dateAnswer:{
    type: Date,
    default : Date.now()
  },
  contentAnswer:{
    type:String
  },
  idLikesAnswer:{
    type: [mongoose.Schema.Types.ObjectId]
  },
  isAnonymous:{
    type: Boolean,
    default: false
  },
  ownerAnswer:{
    type: mongoose.ObjectId
  },
  tagsAnswer:{
    type: [ mongoose.ObjectId]
  },
  idProp:{
    type: mongoose.ObjectId
  }
});



// le 3eme parametre est le nom de la collection dans la base
const Answer =  mongoose.model('Answer',AnswerSchema,'Answer');
module.exports = Answer;
