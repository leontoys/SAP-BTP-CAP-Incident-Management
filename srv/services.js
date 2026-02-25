const cds = require('@sap/cds')
const { SELECT } = require('@sap/cds/lib/ql/cds-ql')

class ProcessorService extends cds.ApplicationService {
    //register custom event handlers
    init(){
        this.before("CREATE","Incidents",(req)=>this.changeUrgencyDueToSubject(req.data))
        this.before("UPDATE","Incidents", (req)=> this.onUpdate(req))

        return super.init()
    }

    changeUrgencyDueToSubject(data){
        let urgent = data.title?.match(/urgent/i) //if incident has urgency in title mark it as high
        if(urgent) {
            data.urgency_code = 'H'
        }
    }

    //check if incident is closed
    async onUpdate(req){
        console.log('---lsv---',req.subject)
    let closed = await SELECT.one(1) .from (req.subject) .where `status.code = 'C'` //wtf?
        if(closed) {
            req.reject `Can't modify a closed incident`
        }
    }


}

module.exports = {ProcessorService}