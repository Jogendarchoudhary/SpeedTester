//
//  DBManager.swift
//  SpeedTester
//
//  Created by Ranosys on 17/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    /* This is the table Value or we can say one key which is primary key*/
    let speedOfVehicle = "speed"
    
    /* this is shared instance of DBManager which is sigelton and will be only create once*/
    static let shared:DBManager = DBManager()
    
    /* These are the Database Variables  which goes like databasefile name, path of the database, and FMDatabe Object*/
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    
    /* the Init method to create the directory of the Database or the path of database*/
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    /*  This the method which is used to create the databse at first, it will be called only once when app runs*/
    func createDataBase() -> Bool {
        if !FileManager.default.fileExists(atPath: pathToDatabase) {             // To check if the path already exits if NO then create one
            database = FMDatabase(path: pathToDatabase!)                         // we are createing the database
            
            if database != nil {                                                  // if it is not nil then we are opening the database
                if database.open() {
                    
                    let createSpeedQuery = "create table SpeedData (\(speedOfVehicle) float primary key not null)" // Executing the Query to create te table SppedData with one key SppedVehicle
                    
                    do {
                        try database.executeUpdate(createSpeedQuery, values: nil)  // If everything goes correct create the table in the databse and return True
                        return true
                    }
                    catch {
                        print("error to create db")              // else return false and catch the error and Do the needful
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()                                                // this step is very important once everything goes right close the databse after all operation done
                } else {
                    print("error to open db")                            // If somehow we cannot open databse we can print the error here
                    return false
                }
                
            }
        } else {
            database = FMDatabase(path: pathToDatabase!)
            return true                          // return wheather the database have created or not
        }
        return false
    }
    
    
    /*    this is the Simple method to open Database */
    func openDataBase() -> Bool {
        _ = createDataBase()
        if database == nil {
            if !FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path : pathToDatabase)
            }
        } else {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    func insertDataIntoTable(speedValue : String) -> Bool {
        if openDataBase() {
            
            let query = "insert into SpeedData (\(speedOfVehicle)) values (\(speedValue));"
            if !self.database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(self.database.lastError(), self.database.lastErrorMessage())
                self.database.close()
                return false
            } else {
                print("Database created")
                self.database.close()
                return true
            }
        }
        return false
    }
    
}
