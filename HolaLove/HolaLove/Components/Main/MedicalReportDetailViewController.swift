//
//  MedicalReportDetail.swift
//  HolaLove
//
//  Created by Apple on 07/01/2024.
//

import UIKit
import MaterialComponents
import ImageSlideshow
import AlamofireImage
import Alamofire
import Nuke
import SCLAlertView
import Firebase
import FirebaseStorage

class MedicalReportDetailViewController : UIViewController {
    
    @IBOutlet weak var petImageSlideShow: ImageSlideshow!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petAddressLabel: UILabel!
    @IBOutlet weak var petDescriptionLabel: UILabel!
    @IBOutlet weak var userAvatar: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var endTreatButton: UIButton!
    @IBOutlet weak var messageBUtton: UIButton!
    @IBOutlet weak var adoptMeButton: MDCButton!
    @IBOutlet weak var imageSSIndicator: UIPageControl!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    var rp_id : String = ""
    var medicalReport = MedicalReport()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       initView()
    }
    
    func initView() {
        adoptMeButton.layer.cornerRadius = 12.0
        userAvatar.layer.cornerRadius = 30.0
        endTreatButton.isHidden = true
        configImageSlideShow()
        
        petNameLabel.text = medicalReport.name
        petAgeLabel.text = "\(medicalReport.age) month"
        petGenderLabel.text = medicalReport.gender ? "Male" : "Female"
        petAddressLabel.text = medicalReport.address
        petDescriptionLabel.text = medicalReport.description
        
        db.collection("users").document(medicalReport.user_id).getDocument { (document, error) in
            let data = document?.data()
            
            self.userNameLabel.text = (data?["fullname"] as! String)
            self.userEmailLabel.text = (data?["email"] as! String)
            
            let urlStr = URL(string: (data?["avatar"] as! String))
            let urlReq = URLRequest(url: urlStr!)
            
            let options = ImageLoadingOptions(
              placeholder: UIImage(named: "user_avatar"),
              transition: .fadeIn(duration: 0.5)
            )
            
            Nuke.loadImage(with: urlReq, options: options, into: self.userAvatarImageView)

            self.userAvatarImageView.layer.cornerRadius = 30.0
        }
        
        db.collection("users").document(Core.shared.getCurrentUserID()).getDocument { (document, error) in
            let data = document?.data()
            
            let favorites = data!["favorites"] as! [String]
            
            let index = favorites.firstIndex(of: self.medicalReport.mr_id)
            

        }
    }
    
    func configImageSlideShow() {
        //test data
        let afNetworkingSource = [ AlamofireSource(urlString: medicalReport.images[0])!, AlamofireSource(urlString: medicalReport.images[1])!, AlamofireSource(urlString: medicalReport.images[2])!]
        
        petImageSlideShow.slideshowInterval = 5.0
        petImageSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        petImageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill

        petImageSlideShow.activityIndicator = DefaultActivityIndicator()
        petImageSlideShow.delegate = self

        petImageSlideShow.setImageInputs(afNetworkingSource)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageSlideShowTap))
        petImageSlideShow.addGestureRecognizer(recognizer)
    }
    
    @objc func imageSlideShowTap() {
        let fullScreenController = petImageSlideShow.presentFullScreenController(from: self)
            
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
    }
    
    @IBAction func viewProfileAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtherUserProfileViewController") as! OtherUserProfileViewController
        
        vc.user_id = medicalReport.user_id
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func confirmTreatAct(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmMedicalViewCOntroller") as! ConfirmMedicalViewCOntroller
        let uiController = UINavigationController(rootViewController: vc)
        self.present(uiController, animated: true, completion: nil)
    }
    
    @IBAction func messageAct(_ sender: Any) {
        db.collection("users").document(medicalReport.user_id).getDocument { (document, error) in
            let data = document?.data()
            
            //Day nha bro
            let name = (data?["fullname"] as! String)
            var email = (data?["email"] as! String)
            
            if email == Core.shared.getCurrentUserEmail() {
                let appearance = SCLAlertView.SCLAppearance(
                    kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                    showCloseButton: false, showCircularIcon: false
                )
                
                let alertView = SCLAlertView(appearance: appearance)
               
                alertView.addButton("OK", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                    alertView.dismiss(animated: true, completion: nil)
                })
                
                    
                alertView.showWarning("Warning", subTitle: "You can not chat with your self")
                
            } else {
            
            email = ChatDatabaseManager.safeEmail(emailAddress: email)
            
            print(name)
            print(email)
            
            ChatDatabaseManager.shared.conversationExists(with: email, completion: { [weak self] result in
                    guard let strongSelf = self else {
                        return
                    }
                    switch result {
                    case .success(let conversationId):
                        print("success to load exists")

                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
                        vc.isNewConversation = false
                        vc.otherUserEmail = email
                        vc.conversationId = conversationId
                        vc.titleChat = name
                        
                        vc.modalPresentationStyle = .fullScreen
                        
                        strongSelf.present(vc, animated: true, completion: nil)
                    case .failure(_):
                        print("create new")

                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
                        vc.isNewConversation = true
                        vc.otherUserEmail = email
                        vc.conversationId = nil
                        vc.titleChat = name
                        
                        vc.modalPresentationStyle = .fullScreen
                        
                        strongSelf.present(vc, animated: true, completion: nil)
                       
                        
                    }
                })
            
            }
                 
        }
    }
    

    @IBAction func treatAct(_ sender: Any) {
        DispatchQueue.global().async {
            db.collection("medicalReports").document(self.medicalReport.mr_id).updateData(["is_active" : 2]) { error in
                if let error = error {
                    print("Error updating field: \(error.localizedDescription)")
                } else {
                    print("Field updated successfully")
                }
            }
        }
        
        self.adoptMeButton.isHidden = true
        self.messageBUtton.isHidden = true
        self.endTreatButton.isHidden = false
    }
    
    @IBAction func endTreatAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RatingViewController" ) as! RatingViewController
        let UIControl = UINavigationController(rootViewController: vc)
        self.present(UIControl, animated: true)
    }
    
    
    @IBAction func backAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MedicalReportDetailViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        imageSSIndicator.currentPage = page
    }
}

