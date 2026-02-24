using { sap.capire.incidents as my } from '../db/schema';

//for support
service ProcessorService {
    //to create incidents
    entity Incidents as projection on my.Incidents;
    //read only
    entity Customers as projection on my.Customers;
} 

//for admin
service AdminService {

    entity Incidents as projection on my.Incidents;
    entity Customers as projection on my.Customers;

}
