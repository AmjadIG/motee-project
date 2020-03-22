const mongoose = require('mongoose')

const PropositionSchema = new mongoose.Schema({
  dateProp:{
    type: Date,
    default : Date.now
  },
  contentProp:{
    type:String,
    required: true
  },
  idLikesProp:{
    type: [mongoose.Schema.Types.ObjectId]
  },
  isAnonymous:{
    type: Boolean,
    default: false
  },
  ownerProp:{
    type: mongoose.Schema.Types.ObjectId,
    required: true
  },
  tagsProp:{
    type: [mongoose.Schema.Types.ObjectId]
  },
  idAnswers:{
    type: [mongoose.Schema.Types.ObjectId]
  }
});

// le 3eme parametre est le nom de la collection dans la base
const Proposition = mongoose.model('Proposition',PropositionSchema,'Proposition');
module.exports = Proposition;
