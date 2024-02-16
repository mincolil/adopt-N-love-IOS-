//
//  DoctorRateModel.swift
//  HolaLove
//
//  Created by Apple on 07/01/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct DoctorRate : Identifiable, Codable{
    @DocumentID var id : String?
    var rate_id : String = ""
    var user_id : String = ""
    var mr_id : String = ""
    var doctor_id : String = ""
    var comment : String = ""
    var type : String = ""
    var posted_date = Date()
}

