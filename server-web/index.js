const express = require('express')
const app = express()
const cors = require('cors')
const users = require('./router/users')
const propositions = require('./router/propositions')
const database = require('./database')
const dotenv = require('dotenv')
dotenv.config();

const port = "3001"//process.env.PORT

const logInfo = (req, res, next) => {
    console.log('[INFO]', '(' + new Date().toLocaleString() +')', req.method, req.url, 'from', req.hostname)
    next()
}

app.use(cors())
app.use(express.json())
app.use(logInfo)
app.use('/users',users)
app.use('/propositions',propositions)
app.listen(port, () => console.log(`App listening on port ${port}`))


const db = {
    users : [
        { id : 1, pseudo : 'michel', mdp : 'michelmdp', mail : 'michel@gmail.com' },
        { id : 2, pseudo : 'lucas', mdp : 'lucasmdp', mail : 'lucas@gmail.com' },
        { id : 3, pseudo : 'amjad', mdp : 'amjadmdp', mail : 'amjad@gmail.com'}
    ]
}
