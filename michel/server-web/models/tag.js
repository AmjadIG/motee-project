const mongoose = require('mongoose')

const TagSchema = new mongoose.Schema({
  label:{
    type: String,
    unique : true,
    required : true
  },
  nbOccurence:{
    type:Number,
    default : 1
  },
  idProps:{
    type: [mongoose.ObjectId]
  },
  idAnswers:{
    type: [mongoose.ObjectId]
  }
});

// le 3eme parametre est la collection
const Tag =  mongoose.model('Tag',TagSchema,'Tag');
module.exports = Tag;
