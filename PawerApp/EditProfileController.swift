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
    
    
    
    @IBOutlet weak var firstName: DesignableTextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var username: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     let defaultValues = UserDefaults.standard
        print(defaultValues)
        if let getusername = defaultValues.string(forKey: "username"){
            username.text = getusername
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
}
