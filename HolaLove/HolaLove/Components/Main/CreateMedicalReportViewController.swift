//
//  CreateMedicalReportViewController.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//

import Foundation
import UIKit
import MaterialComponents
import UIFloatLabelTextView
import BottomPopUpView
import Photos
import ALCameraViewController
import FirebaseStorage
import SCLAlertView
import ProgressHUD

class CreateMedicalReportViewController : ViewController {
    
    @IBOutlet weak var petNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var petAgeTextField: MDCOutlinedTextField!
    @IBOutlet weak var petGenderTextField: MDCOutlinedTextField!
    @IBOutlet weak var petAddressTextField: MDCOutlinedTextField!
    @IBOutlet weak var petDescriptionBorder: UIButton!
    @IBOutlet weak var petDescriptionLabelBg: UIButton!
    @IBOutlet weak var petDescriptionDummy: MDCOutlinedTextField!
    @IBOutlet weak var petDescriptionTextView: UITextView!
    @IBOutlet weak var petTypeTextField: MDCOutlinedTextField!
    
    
    @IBOutlet weak var avatarPickerButton: UIButton!
    @IBOutlet weak var petImage1Button: UIButton!
    @IBOutlet weak var petImage2Button: UIButton!
    @IBOutlet weak var petImage3Button: UIButton!
    @IBOutlet weak var addPetButton: MDCButton!
    
    
    
    var genderPickerView: UIPickerView!
    var typePickerView: UIPickerView!
    var bottomPopUpView: BottomPopUpView!
    
    let genderPickerViewDelegate = GenderPickerViewDelegate()
    let typePickerViewDelegate = PetTypePickerViewDelegate()
    
    override func viewDidLoad() {
        //init()
    }
    
    @IBAction func pickImage1Act(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "Where would you like to attach a photo from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in

          let cameraViewController = CameraViewController { [weak self] image, asset in
              // Do something with your image here.
              self?.dismiss(animated: true, completion: nil)
          }

          self?.present(cameraViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in

          let imagePickerViewController = PhotoLibraryViewController()
          imagePickerViewController.onSelectionComplete = { asset in

                  // The asset could be nil if the user doesn't select anything
                  guard let asset = asset else {
                      return
                  }

              // Provides a PHAsset object
                  // Retrieve a UIImage from a PHAsset using
                  let options = PHImageRequestOptions()
              options.deliveryMode = .highQualityFormat
              options.isNetworkAccessAllowed = true

                  PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { image, _ in
                  if let image = image {
                     
                    self!.petImage1Button.setImage(image, for: .normal)
                    self!.petImage1Button.tag = 1
                    self!.petImage1Button.imageView?.layer.cornerRadius = 13.0
                      
                      imagePickerViewController.dismiss(animated: false, completion: nil)
                      
                  }
              }
          }

          self?.present(imagePickerViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(actionSheet, animated: true)
    }
    
    @IBAction func pickImage2Act(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "Where would you like to attach a photo from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in

          let cameraViewController = CameraViewController { [weak self] image, asset in
              // Do something with your image here.
              self?.dismiss(animated: true, completion: nil)
          }

          self?.present(cameraViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in

          let imagePickerViewController = PhotoLibraryViewController()
          imagePickerViewController.onSelectionComplete = { asset in

                  // The asset could be nil if the user doesn't select anything
                  guard let asset = asset else {
                      return
                  }

              // Provides a PHAsset object
                  // Retrieve a UIImage from a PHAsset using
                  let options = PHImageRequestOptions()
              options.deliveryMode = .highQualityFormat
              options.isNetworkAccessAllowed = true

                  PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { image, _ in
                  if let image = image {
                     
                    self!.petImage2Button.setImage(image, for: .normal)
                    self!.petImage2Button.tag = 1
                    self!.petImage2Button.imageView?.layer.cornerRadius = 13.0
                      
                      imagePickerViewController.dismiss(animated: false, completion: nil)
                      
                  }
              }
          }

          self?.present(imagePickerViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(actionSheet, animated: true)
    }
    
    @IBAction func pickImage3Act(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "Where would you like to attach a photo from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in

          let cameraViewController = CameraViewController { [weak self] image, asset in
              // Do something with your image here.
              self?.dismiss(animated: true, completion: nil)
          }

          self?.present(cameraViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in

          let imagePickerViewController = PhotoLibraryViewController()
          imagePickerViewController.onSelectionComplete = { asset in

                  // The asset could be nil if the user doesn't select anything
                  guard let asset = asset else {
                      return
                  }

              // Provides a PHAsset object
                  // Retrieve a UIImage from a PHAsset using
                  let options = PHImageRequestOptions()
              options.deliveryMode = .highQualityFormat
              options.isNetworkAccessAllowed = true

                  PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { image, _ in
                  if let image = image {
                     
                    self!.petImage3Button.setImage(image, for: .normal)
                    self!.petImage3Button.tag = 1
                    self!.petImage3Button.imageView?.layer.cornerRadius = 13.0
                      
                      imagePickerViewController.dismiss(animated: false, completion: nil)
                      
                  }
              }
          }

          self?.present(imagePickerViewController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(actionSheet, animated: true)
    }
    
    @IBAction func AddMedicalReportAct(_ sender: Any) {
        var newMR = MedicalReport()
        
        newMR.name = petNameTextField.text ?? ""
        if (newMR.name == "") {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "your pet's name must be filled")
            print("1")
            return
        }

        newMR.age = Int(petAgeTextField.text ?? "0") ?? 0
        if (newMR.age == 0) {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "your pet's age must be filled")
            print("2")
            return
        }

        newMR.address = petAddressTextField.text ?? ""
        if (newMR.address == "") {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "your pet's address must be filled")
            print("3")
            return
        }

        newMR.description = petDescriptionTextView.text ?? ""
        if (newMR.description == "") {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "your pet's description must be filled")
            print("4")
            return
        }
        
        let genderText = petGenderTextField.text ?? ""
        if (genderText == "") {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "your pet's gender must be selected")
            print("5")
            return
        }
        newMR.gender = genderText == "Male"
        
        let typeText = petTypeTextField.text ?? "" //Bien text cua gender
        if (typeText == "") {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "Is he/she a dog, a cat or other?")
            print("10")
            return
        }
        
        newMR.type = typeText == "Dog" ? 1 : (typeText == "Cat" ? 2 : 3)
        
//        let avatarImage = avatarPickerButton.image(for: .normal)
//        if (avatarPickerButton.tag == 0) {
//            let appearance = SCLAlertView.SCLAppearance(
//                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
//                showCloseButton: false, showCircularIcon: false
//            )
//
//            let alertView = SCLAlertView(appearance: appearance)
//
//            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
//                alertView.dismiss(animated: true, completion: nil)
//            })
//
//            alertView.showWarning("Warning", subTitle: "pick an avatar picture for your pet")
//            print("6")
//            return
//        }
        
        let image1 = petImage1Button.image(for: .normal)
        if (petImage1Button.tag == 0) {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "pick 3 picture for your pet")
            print("7")
            return
        }
        
        let image2 = petImage2Button.image(for: .normal)
        if (petImage2Button.tag == 0) {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "he/she needs 2 more pictures")
            print("8")
            return
        }
        
        let image3 = petImage3Button.image(for: .normal)
        if (petImage2Button.tag == 0) {
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: "he/she needs 1 more picture")
            print("9")
            return
        }
        
        newMR.user_id = Core.shared.getCurrentUserID()
        newMR.mr_id = UUID().uuidString
        
        ProgressHUD.animate()
        //upload Avatar
//        StorageManager.shared.uploadImage(with: avatarImage!.pngData()!, fileName: "avatar.png", folder: "Pet", subFolder: newMR.pet_id, completion: {  result in
//                switch result {
//                case .success(let urlString):
//                    // Ready to send message
//                    print("Uploaded avatar Photo: \(urlString)")
//                    newMR.avatar = urlString
//                case .failure(let error):
//                    print("message photo upload error: \(error)")
//
//                    return
//                }
            //Image1
            StorageManager.shared.uploadImage(with: image1!.pngData()!, fileName: "1.png", folder: "MedicalReport", subFolder: newMR.mr_id, completion: { result in
                    switch result {
                    case .success(let urlString):
                        // Ready to send message
                        print("Uploaded image 1 Photo: \(urlString)")
                        newMR.images.append(urlString)
                    case .failure(let error):
                        print("message photo upload error: \(error)")
                        
                        return
                    }
                //Image2
                StorageManager.shared.uploadImage(with: image2!.pngData()!, fileName: "2.png", folder: "MedicalReport", subFolder: newMR.mr_id, completion: { result in
                    
                        switch result {
                        case .success(let urlString):
                            // Ready to send message
                            print("Uploaded image 2 Photo: \(urlString)")
                            newMR.images.append(urlString)
                        case .failure(let error):
                            print("message photo upload error: \(error)")
                            
                            return
                        }
                    //Image3
                    StorageManager.shared.uploadImage(with: image3!.pngData()!, fileName: "3.png", folder: "MedicalReport", subFolder: newMR.mr_id, completion: { result in
                            switch result {
                            case .success(let urlString):
                                // Ready to send message
                                print("Uploaded image 3 Photo: \(urlString)")
                                newMR.images.append(urlString)
                            case .failure(let error):
                                print("message photo upload error: \(error)")
                                
                                return
                            }
                        print(newMR)
                        
                        self.db.collection("medicalReports").document(newMR.mr_id).setData([
                            "address": newMR.address,
                            "age": newMR.age,
//                            "avatar" : newMR.avatar,
                            "description" : newMR.description,
                            "images" : newMR.images,
                            "gender" : newMR.gender,
                            "is_active" : 1,
                            "name": newMR.name,
                            "mr_id" : newMR.mr_id,
                            "posted_date" : Date(),
                            "type" : newMR.type,
                            "user_id" : newMR.user_id
                        ], merge: true)
                        
                        //Alert thanh cong
                        ProgressHUD.dismiss()
                        let appearance = SCLAlertView.SCLAppearance(
                            kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                            showCloseButton: false, showCircularIcon: false
                        )
                        
                        let alertView = SCLAlertView(appearance: appearance)
                        alertView.addButton("OK", action: {
                            alertView.dismiss(animated: true, completion: nil)
                        })
                        alertView.showSuccess("Congratulation", subTitle: "Your pet has been added successfully")
                        
                        self.resetAct((Any).self)
                        }
                    )
                    }
                )
                }
            )
//            }
//        )
    }
    
    @IBAction func resetAct(_ sender: Any) {
        petNameTextField.text = ""
        petAgeTextField.text = ""
        petGenderTextField.text = ""
        petAddressTextField.text = ""
        petDescriptionTextView.text = ""
        petTypeTextField.text = ""
        
        avatarPickerButton.setImage(UIImage(named: "ic-md-blue-imgpicker"), for: .normal)
        petImage1Button.setImage(UIImage(named: "ic-md-blue-imgpicker"), for: .normal)
        petImage2Button.setImage(UIImage(named: "ic-md-blue-imgpicker"), for: .normal)
        petImage3Button.setImage(UIImage(named: "ic-md-blue-imgpicker"), for: .normal)
        
        avatarPickerButton.imageView?.layer.cornerRadius = 0
        petImage1Button.imageView?.layer.cornerRadius = 0
        petImage2Button.imageView?.layer.cornerRadius = 0
        petImage3Button.imageView?.layer.cornerRadius = 0
        
        avatarPickerButton.tag = 0;
        petImage1Button.tag = 0;
        petImage2Button.tag = 0;
        petImage3Button.tag = 0;
    }

    
}
