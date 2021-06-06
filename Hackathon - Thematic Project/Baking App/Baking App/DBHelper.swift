//
//  DBHelper.swift
//  Banking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import Foundation
import SQLite3
import Darwin

class DBHelper {
    static let shared = DBHelper()
    
    var db: OpaquePointer?
    var path: String = "Bank.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("There is error in creating DB")
            return nil
        } else {
            print("Database has been created with path \(path) or \(filePath.absoluteURL)")
            return db
        }
        
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS Users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT, balance TEXT);"
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK{
            if sqlite3_step(createTable) == SQLITE_DONE{
                print("Table created")
            } else{
                print("Table failed to create")
            }
        } else{
            print("Preparation fail")
        }
    }

    func insertIntoDBForm(username:String, email:String, password:String){
        
        /**
          - Parameters:
            - username: The username people have entered
            - email: The email people have entered
            - password: The password people have entered
         */
        
        let query = "INSERT INTO Users (username, email, password, balance) VALUES (?,?,?,?);"
        
        var statement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
//            sqlite3_bind_int(statement, 1, 2)
            sqlite3_bind_text(statement, 1, NSString(string: username).utf8String, -1, nil) // Username
            sqlite3_bind_text(statement, 2, NSString(string: email).utf8String, -1, nil)    // Email
            sqlite3_bind_text(statement, 3, NSString(string: password).utf8String, -1, nil)    // Password
            sqlite3_bind_text(statement, 4, NSString(string: "0").utf8String, -1, nil)    // Balance
            
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data inserted successfully")
            } else{
                print("Data is not inserted into the table")
            }
            
        }
        else {
            print("Query does not fit requirement/failed preparing")
        }
        sqlite3_finalize(statement)
    }
    func insertIntoDBBalance(balance:String){ // Enter in subtracted Result
        
        /**
          - Parameters:
            - username: The username people have entered
            - email: The email people have entered
            - password: The password people have entered
         */
        
        let query = "INSERT INTO Users (username, email, password, balance) VALUES (?,?,?,?);"
        
        var statement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 4, NSString(string: balance).utf8String, -1, nil)    // Balance
            
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data inserted successfully")
            } else{
                print("Data is not inserted into the table")
            }
            
        }
        else {
            print("Query does not fit requirement/failed preparing")
        }
        sqlite3_finalize(statement)
    }
        
    func readFromDB() -> [Int:Array<String>]{
            
        let query = "SELECT * FROM Users;"
        var statement:OpaquePointer? = nil
        var idList:Array<Int> = []
        var usernameList:Array<String> = []
        var emailList:Array<String> = []
        var passwordList:Array<String> = []
        var balanceList: Array<String>? = []
        var userBio:[Int:Array<String>] = [:]
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let id = Int(sqlite3_column_int(statement, 0))
                    let username = String(cString:sqlite3_column_text(statement, 1))
                    let email = String(cString:sqlite3_column_text(statement, 2))
                    let password = String(cString: sqlite3_column_text(statement, 3))
                    let balance = String(cString: sqlite3_column_text(statement, 4))
                    
//                    var isInteger = (id as! Double).truncatingRemainder(dividingBy: 1) == 0
//                    if isInteger != false{
//                        //uh oh
//                    }
                    
                    idList.append(id)
                    usernameList.append(username)
                    emailList.append(email)
                    passwordList.append(password)
                    balanceList?.append(balance)
                    
                    userBio[id] = [email, username, balance, password]
                    print(userBio)
                    
                    
                    
                 }
                sqlite3_finalize(statement)
                print("FINAL USER BIO = \(userBio)")
                return userBio
            }
        return [0:["", "", "", ""]]
        }
    
    
    
}




