let mongoose = require('mongoose');
const dotenv = require('dotenv')
dotenv.config();

const uri = "mongodb+srv://" + process.env.USER +":"+ process.env.PASSWORD + "@awios-zkpmr.mongodb.net/"+ process.env.DATABASE + "?retryWrites=true&w=majority"

class Database {
  constructor() {
    this._connect()
  }

_connect() {
     mongoose.connect(uri,{ useNewUrlParser: true })
       .then(() => {
         console.log('Database connection successful')
       })
       .catch(err => {
         console.error('Database connection error')
         console.log(err)
       })
  }
}

module.exports = new Database()
