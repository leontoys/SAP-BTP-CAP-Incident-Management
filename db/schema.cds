using { cuid , managed, sap.common.CodeList} from '@sap/cds/common';
namespace sap.capire.incidents;

//creating entities
//incidents created by customers
entity Incidents : cuid, managed {
    customer : Association to Customers;
    title : String;
    //urgency
    //status
    conversation : Composition of many {
        key ID : UUID;
        timestamp : type of managed.createdAt;
        author : type of managed.createdBy;
        message : String;
    } 
}
//customers create incidents
entity Customers : managed {
    key ID : String;
    firstName : String;
    lastName : String;
    name : String = trim (firstName || '' || lastName);
    email : EMailAddress;
    phone : PhoneNumber;
    incidents : Association to many Incidents on incidents.customer = $self;
    creditCardNo : String(16) @assert.format : '^[1-9]\d{15}$';
    //address 
}

