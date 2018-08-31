//
//  File.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 18/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//


import UIKit
import Alamofire


class RegisterController: UIViewController {
    
    let URL_USER_REGISTER = "http://www.ehostingcentre.com/pawer/pawer_Registration.php";
    
    @IBOutlet weak var firstName: DesignableTextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: DesignableTextField!
    @IBOutlet weak var userName: DesignableTextField!
    @IBOutlet weak var DateofBirth: DesignableTextField!
    
    @IBOutlet weak var password: DesignableTextField!
    
    @IBOutlet weak var confirmpassword: DesignableTextField!
    @IBOutlet weak var parentContact: DesignableTextField!
    
    @IBOutlet weak var parentAddress: DesignableTextField!
    @IBOutlet weak var nameParent: DesignableTextField!
    
   
    @IBOutlet weak var btnRegister: UIButton!
    
    var unchecked = true
    @IBAction func tick(_ sender: UIButton) {
    
        if unchecked{
            sender.setImage(UIImage(named: "untick.png"), for: .normal)
            unchecked = false
        } else{
              sender.setImage(UIImage(named: "tick.png"), for: .normal)
            unchecked = true
        }
    }
    
    
    @IBAction func buttonRegister(_ sender: UIButton) {
        
        let parameters: Parameters = [
            "user_firstname": firstName.text!,
            "user_lastname": lastName.text!,
            "user_email": email.text!,
            "user_username": userName.text!,
            "user_dob":DateofBirth.text!,
            "user_pwd":password.text!,
            "parent_name":nameParent.text!,
             "parent_contact": parentContact.text!,
            "parent_address":parentAddress.text!,
        
        ]
        
        
        Alamofire.request(URL_USER_REGISTER,method: .post,parameters: parameters).responseJSON{
            response in
            print(response)
            
            if let result = response.result.value{
                let jsonData = result as! NSDictionary
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
                self.show(vc, sender: self)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                
            }
        }
        
        var a  = false
        var b = false
        if password.text == confirmpassword.text{
            a = true
        }
        else{
            let alert = UIAlertController(title: "Alert!!!", message: "Password & Confirm Password Doesn't Match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Re-enter Password", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 15.0;
        
        
        lastName.layer.cornerRadius = 15.0
        lastName.clipsToBounds = true
        lastName.layer.masksToBounds = false
        lastName.layer.shadowOpacity = 0.2
        lastName.layer.shadowRadius = 4.0
        lastName.layer.shadowOffset = CGSize(width: 0
            , height: 0)
        lastName.layer.shadowColor = UIColor.black
            .cgColor
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
       
        datePicker.addTarget(self, action: #selector(RegisterController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        DateofBirth.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x:0,y:0,width: self.view.frame.size.width, height:40))
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(RegisterController.donePressed(sender:)))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.yellow
        label.textAlignment = NSTextAlignment.center
        label.text = "Select a Date"
        let labelButton = UIBarButtonItem(customView: label)
        toolbar.setItems([flexButton,labelButton,flexButton,doneButton], animated: true)
        
        DateofBirth.inputAccessoryView = toolbar

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func donePressed(sender: UIBarButtonItem){
    DateofBirth.resignFirstResponder()
        
    }
   
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
       let d = formatter.string(from: sender.date)
          DateofBirth.text = d
        
        let onlyYear = DateFormatter()
        onlyYear.dateFormat = "yyyy"
        let year : String = onlyYear.string(from:sender.date)
        
        let intyear = Int(year)
        
        if(intyear! <= 2000){
            parentContact.isUserInteractionEnabled = false
             parentAddress.isUserInteractionEnabled = false
             nameParent.isUserInteractionEnabled = false
        }
        
      
    
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

