//
//  CategoryController.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 16/8/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//
import UIKit
import Alamofire


class CategoryController: UIViewController{
    let URL_USER_Profile = "http://www.ehostingcentre.com/pawer/updateprofile.php"
    
    @IBOutlet weak var txtfieldfirst: DesignableTextField!
    
    @IBOutlet weak var txtfieldlast: UITextField!
    @IBOutlet weak var txtfieldusername: DesignableTextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters: Parameters = [
            "user_firstname": txtfieldfirst.text!,
            "user_lastname": txtfieldlast.text!,
            
            "user_username": txtfieldusername.text!,
           
            
            ]
        
        
        

       
    }
    
 
    
}
