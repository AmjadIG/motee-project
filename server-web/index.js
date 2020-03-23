const express = require('express')
const app = express()
const cors = require('cors')
const users = require('./router/users')
const propositions = require('./router/propositions')
const answers = require('./router/answers')
const tags = require('./router/tags')
const database = require('./database')
const dotenv = require('dotenv')
dotenv.config();

const port = process.env.PORT

const logInfo = (req, res, next) => {
    console.log('[INFO]', '(' + new Date().toLocaleString() +')', req.method, req.url, 'from', req.hostname)
    next()
}

app.use(cors())
app.use(express.json())
app.use(logInfo)
app.use('/users',users)
app.use('/propositions',propositions)
app.use('/answers',answers)
app.use('/tags',tags)
app.listen(port, () => console.log(`App listening on port ${port}`))
