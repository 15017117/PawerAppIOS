//
//  ViewController.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 17/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let URL_USER_LOGIN = "http://www.ehostingcentre.com/pawer/loginuser.php";

    @IBOutlet weak var emailTextField: DesignableTextField!
    
    @IBOutlet weak var passwordTextField: DesignableTextField!
   
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.borderStyle = UITextBorderStyle.roundedRect
        
 
      
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginButton(_ sender: UIButton) {
        
        let parameters: Parameters = [
            "user_email": emailTextField.text!,
            "user_pwd":passwordTextField.text!,
            
            ]
        Alamofire.request(URL_USER_LOGIN,method: .get,parameters: parameters).responseJSON{
            response in
            print(response)
            
            if let result = response.result.value{
                let jsonData = result as! NSDictionary
                
                self.labelMessage.text = jsonData.value(forKey: "message")as! String?
            }
        }
        
    }


}

