//
//  GenderPickerViewDelegate.swift
//  HolaLove
//
//  Created by Apple on 27/12/2023.
//

import Foundation
import UIKit

class GenderPickerViewDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var genders: [String] = ["All", "Male", "Female"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    
}

