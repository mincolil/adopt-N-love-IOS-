//
//  Model.swift
//  HolaLove
//
//  Created by Apple on 18/12/2023.
//

import Foundation
import Firebase
import BCrypt
import FirebaseFirestoreSwift

let db = Firestore.firestore()

struct MyUser: Identifiable, Codable {
    @DocumentID var id : String?
    var UID : String = ""
    var address : String = ""
    var dateOfBirth : String = ""
    var email : String = ""
    var fullname : String = ""
    var gender : String = ""
    var password : String = ""
    var phone : String = ""
    var token : String = ""
    var username : String = ""
    var avatar : String = ""
    var favorites = [String]()
    var following = [String]()
    var followers = [String]()
    var role : String = ""
}
