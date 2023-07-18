const { builtinModules } = require('module')
const router = require('express').Router()
const Person = require('../models/Person')

// Create - criação de dados
router.post('/', async (req, res) => {
  // req.body
  const { name, salary, approved } = req.body

  if (!name) {
    res.status(422).json({ error: 'Nome obrigatório!' })
    return
  }
  const person = { name, salary, approved }

  try {
    await Person.create(person)
    res.status(201).json({ message: 'Cadastro efetuado com sucesso!' })
  } catch (error) {
    res.status(500).json({ error: error })
  }
})

// Read - Leitura de dados
router.get('/', async (req, res) => {
  //  console.log(req)
  try {
    const people = await Person.find()
    res.status(200).json(people)
  } catch (error) {
    res.status(500).json({ error: error })
  }
})

router.get('/:id', async (req, res) => {
  // console.log(req)
  // extrair o dado da requisição
  const id = req.params.id

  try {
    const person = await Person.findOne({ _id: id })
    if (!person) {
      res.status(422).json({ message: 'Usurio não localizado no BD!' })
      return
    }
    res.status(200).json(person)
  } catch (error) {
    res.status(500).json({ error: error })
  }
})

// Update - Atualização de dados (PUT, PATCH)

router.patch('/:id', async (req, res) => {
  // console.log(req)

  const id = req.params.id
  const { name, salary, approved } = req.body
  const person = { name, salary, approved }

  try {
    const updatePerson = await Person.updateOne({ _id: id }, person)
    if (updatePerson.matchedCount === 0) {
      res.status(422).json({ message: 'Usurio não localizado no BD!' })
      return
    }
    res.status(200).json(person)
  } catch (error) {
    res.status(500).json({ error: error })
  }
})

router.delete('/:id', async (req, res) => {
  // console.log(req)

  const id = req.params.id
  const person = await Person.findOne({ _id: id })

  if (!person) {
    res.status(422).json({ message: 'Usurio não localizado no BD!' })
    return
  }

  try {
    await Person.deleteOne({ _id: id })
    res.status(200).json({ message: 'Usurio removido com sucesso!' })
  } catch (error) {
    res.status(500).json({ error: error })
  }

})


module.exports = router