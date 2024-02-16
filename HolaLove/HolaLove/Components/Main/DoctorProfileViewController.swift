//
//  DoctorProfile.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//

import Foundation
import UIKit

class DoctorProfileViewController : UIViewController {
    
    private var doctorRates = [DoctorRate]()
    var user_id = Core.shared.getCurrentUserID()
    
    @IBOutlet weak var DoctorRatesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        db.collection("doctorRates").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.doctorRates = documents.compactMap { (QueryDocumentSnapshot) -> DoctorRate? in
                do {
                            let medicalReport = try QueryDocumentSnapshot.data(as: DoctorRate.self)
                            return medicalReport
                        } catch {
                            print("Error decoding MedicalReport: \(error)")
                            return nil
                        }
            }
            
            self.doctorRates = self.doctorRates.filter { medicalReport in
                return medicalReport.doctor_id == self.user_id
            }
        
            self.DoctorRatesTableView.reloadData()
        }
        
    }
    
    @IBAction func backAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DoctorProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = doctorRates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserRateViewCell", for: indexPath) as! UserRateViewCell
        
        //binding data here
        cell.nameLabel.text = model.user_id
        cell.commentLabel.text = model.comment
        //cell.timeLabel.text =  getTimeFromDate(model.latestMessage.date)
        
        
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.width / 2
        cell.avatarImage.clipsToBounds = true
        
//        db.collection("medicalReports").whereField("user_id", isEqualTo: Core.shared.getCurrentUserID()).getDocuments{ (document, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    if let document = document, document.exists {
//                        let data = document.data()//                    }
//                }
//            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let dest = self.storyboard?.instantiateViewController(withIdentifier: "MedicalReportDetailViewController") as! MedicalReportDetailViewController
//
//        let index = indexPath.row
//        let doctorRate = doctorRates[index]
//        dest.medicalReport = medicalReport
//
//        let navController = UINavigationController(rootViewController: dest)
//        self.present(navController, animated: true)
    }
    
    func getTimeFromDate(_ date: String) -> String {
        
        let dateFormatter: DateFormatter = {
            let formattre = DateFormatter()
            formattre.dateStyle = .medium
            formattre.timeStyle = .long
            formattre.locale = .current
            return formattre
        }()
        
        let yourDate = dateFormatter.date(from: date)
        print(yourDate!)
        
        dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.string(from: yourDate!)
        
        print(result)
        return result
    }
    
}
