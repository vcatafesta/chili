// config inicial
require('dotenv').config()
const express = require('express')
//const mongoose = require('mongoose')
const { default: mongoose } = require('mongoose')
const { restart } = require('nodemon')
const app = express()

// forma de ler JSON / middlewares
app.use(
  express.urlencoded({
    extended: true
  })
)
app.use(express.json())

// rotas da API
const personRoutes = require('./routes/personRouter')
app.use('/person', personRoutes)

// rota inicial /endpoint
app.get('/', (req, res) => {
  // mostrar req
  res.json({ message: 'Oi express!' })
})

// entregar uma porta
const DB_USER = process.env.DB_USER
const DB_PASSWORD = encodeURIComponent(process.env.DB_PASSWORD)

mongoose
  .connect(`mongodb+srv://${DB_USER}:${DB_PASSWORD}@cluster0.gmtvpks.mongodb.net/?retryWrites=true&w=majority`)
  .then(() => {
    console.log("Conectado ao MongoDB")
    app.listen(5000)
  })
  .catch((err) => console.log(err))
