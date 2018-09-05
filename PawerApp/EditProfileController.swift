//
//  EditProfileController.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 16/8/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileController : UIViewController{
    let URL_USER_Profile = "http://www.ehostingcentre.com/pawer/updateprofile.php"
    
    
    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var firstName: DesignableTextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var username: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEditProfile.layer.cornerRadius = 15.0
     let defaultValues = UserDefaults.standard
        print(defaultValues)
        if let getusername = defaultValues.string(forKey: "user_username"){
            username.text = getusername
            
          
            
    }
        if let getfirstname = defaultValues.string(forKey: "user_firstname"){
            firstName.text = getfirstname
            
            
        }
        if let getlastname = defaultValues.string(forKey: "user_lastname"){
            lastName.text = getlastname
            
            
        }
        
        lastName.layer.cornerRadius = 15.0
        lastName.clipsToBounds = true
        lastName.layer.masksToBounds = false
        lastName.layer.shadowOpacity = 0.2
        lastName.layer.shadowRadius = 4.0
        lastName.layer.shadowOffset = CGSize(width: 0
            , height: 0)
        lastName.layer.shadowColor = UIColor.black
            .cgColor
        
    }
    
  
    
    @IBAction func btnEditProfile(_ sender: UIButton) {
        let defaultValues = UserDefaults.standard
        let getuseremail  = defaultValues.string(forKey: "user_email")
        let parameters:Parameters=[
            "username": username.text!,
            "firstname": firstName.text!,
            "lastname":lastName.text!,
            "email": getuseremail!
        ]
        print(parameters)
        
        Alamofire.request(URL_USER_Profile,method: .post,parameters: parameters).responseJSON{
            response in
            print(response)
            
            if let result = response.result.value{
                let jsonData = result as!NSDictionary
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
        
        
    }
    
}
