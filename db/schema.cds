using { cuid , managed, sap.common.CodeList} from '@sap/cds/common';
namespace sap.capire.incidents;

//creating entities
//incidents created by customers
entity Incidents : cuid, managed {
    customer : Association to Customers;
    title : String @title : 'Title';
    urgency : Association to Urgency default 'M';
    status : Association to  Status default 'N';
    conversation : Composition of many {
        key ID : UUID;
        timestamp : type of managed:createdAt;
        author    : type of managed:createdBy;
        message : String;
    } 
}
//customers create incidents
entity Customers : managed {
    key ID : String;
    firstName : String;
    lastName : String;
    name : String = trim (firstName || '' || lastName); //calculated elements
    email : EMailAddress;
    phone : PhoneNumber;
    incidents : Association to many Incidents on incidents.customer = $self;
    creditCardNo : String(16) @assert.format : '^[1-9]\d{15}$';
    addresses : Composition of many Address on addresses.customer = $self;  
}

//address
entity Address : cuid, managed {
    customer : Association to Customers;
    city : String;
    postcode : String;
    streetAddress : String;
}

//codelist
entity Status : CodeList {
    key code : String enum {
        new = 'N';
        assigned = 'A';
        in_process = 'I';
        on_hold = 'O';
        resolved = 'R';
        closed = 'C';
    };
    criticality : Integer;
}
//urgency
entity Urgency : CodeList {
    key code : String enum {
        high = 'H';
        medium = 'M';
        low = 'L';
    }
}

type EMailAddress : String;
type PhoneNumber : String;

