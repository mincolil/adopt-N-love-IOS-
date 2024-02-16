//
//  MedicalReport.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//

import Foundation
import UIKit

class MedicalReportViewController : UIViewController {
    
    private var medicalReports = [MedicalReport]()
    var user_id = Core.shared.getCurrentUserID()
    
    @IBOutlet weak var MedicalReportTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init()
        fetchData()
    }
    
    func fetchData() {
        db.collection("medicalReports").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.medicalReports = documents.compactMap { (QueryDocumentSnapshot) -> MedicalReport? in
                do {
                            let medicalReport = try QueryDocumentSnapshot.data(as: MedicalReport.self)
                            return medicalReport
                        } catch {
                            print("Error decoding MedicalReport: \(error)")
                            return nil
                        }
            }
            
            if(Core.shared.getCurrentUserRole() == "User"){
                self.medicalReports = self.medicalReports.filter { medicalReport in
                    return medicalReport.user_id == self.user_id
                }
                
                self.medicalReports = self.medicalReports.filter { medicalReport in
                    return medicalReport.is_active == 1 || medicalReport.is_active == 2
                }
            } else {
                self.medicalReports = self.medicalReports.filter { medicalReport in
                    return medicalReport.is_active == 1
                }
            }
        
            self.MedicalReportTableView.reloadData()
        }
        
    }
    
    @IBAction func CreateReportAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateMedicalReportViewController") as! CreateMedicalReportViewController
        
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true)
    }
    
}

extension MedicalReportViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalReports.count
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let model = medicalReports[indexPath.row]
//
//            ChatDatabaseManager.shared.deleteConversation(conversationId: model.id, completion: {  result in
//                if result {
//                    print("delelted")
//                    self.chatTableView?.reloadData()
//                }
//                })
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = medicalReports[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalReportCell", for: indexPath) as! MedicalReportCell
        
        //binding data here
        cell.PetName.text = model.name
        cell.Description.text = model.description
        //cell.timeLabel.text =  getTimeFromDate(model.latestMessage.date)
        
        
        cell.PetImage.layer.cornerRadius = cell.PetImage.frame.width / 2
        cell.PetImage.clipsToBounds = true
        
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
        tableView.deselectRow(at: indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "MedicalReportDetailViewController") as! MedicalReportDetailViewController
        
        let index = indexPath.row
        let medicalReport = medicalReports[index]
        dest.medicalReport = medicalReport
        
        let navController = UINavigationController(rootViewController: dest)
        self.present(navController, animated: true)
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
