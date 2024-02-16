//
//  MedicalReportModel.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct MedicalReport : Identifiable, Codable{
    @DocumentID var id : String?
    var user_id : String = ""
    var mr_id : String = ""
    var name : String = ""
    var age : Int = 0
    var address : String = ""
    var description : String = ""
    //var avatar : String = ""
    var gender : Bool = true
    var type : Int = 0
    var images = [String]()
    var posted_date = Date()
    var is_active : Int = 1
}
