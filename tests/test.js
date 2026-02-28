const cds = require('@sap/cds')
const { SELECT } = require('@sap/cds/lib/ql/cds-ql')
const { default : axios} = require('axios')
const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname+'../../', '--with-mocks')

axios.defaults.auth = {username:'alice'}

jest.setTimeout(111111)

describe('Test the GET endpoints',()=>{
    it('Should check Processor Service',async()=>{
        const processorService = await cds.connect.to('ProcessorService')
        const {Incidents} = processorService.entities
        expect(await SELECT.from(Incidents)).to.have.length(4) //4 entries in csv
    })
})

//add more tests later