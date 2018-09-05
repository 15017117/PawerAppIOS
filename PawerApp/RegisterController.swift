//
//  File.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 18/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//


import UIKit
import Alamofire
import KeyboardLayoutHelper
import UnderKeyboard



class RegisterController: UIViewController,UITextFieldDelegate {
    
    let URL_USER_REGISTER = "http://www.ehostingcentre.com/pawer/pawer_Registration.php";
    let underKeyboardLayoutConstraint = UnderKeyboardLayoutConstraint()
   
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
    
    var unchecked = false
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
            //getting the JSON value from the server
            let defaultValues = UserDefaults.standard
            let convertResponse  = response.result.value as!NSDictionary
            let getStatus = convertResponse.value(forKey: "status")! as! Int
                var a  = false
                var b = false
                if self.unchecked == true{
                    if self.password.text == self.confirmpassword.text{
                        print(self.password.text == self.confirmpassword.text)
                    a = true
                    if(getStatus == 200){
                    
                    let user = convertResponse.value(forKey: "users")! as!NSArray
                    
                    print(user)
                    
                    let user_username = user.value(forKey: "user_username") as! [String]
                    
                    let user_firstname = user.value(forKey: "user_firstname")as! [String]
                    
                    let user_lastname = user.value(forKeyPath: "user_lastname")as! [String]
                    let user_email = user.value(forKey: "user_email")as! [String]
                    
                    defaultValues.set(user_username[0], forKey: "user_username")
                    
                    defaultValues.set(user_firstname[0], forKey: "user_firstname")
                    defaultValues.set(user_lastname[0], forKey:"user_lastname")
                    defaultValues.set(user_email[0], forKey: "user_email")
                   
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
                    self.show(vc, sender: self)
                } else{
                        
                        let alert = UIAlertController(title: "Almost There!", message: "You have already registered for PAWER under this email!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Re-Enter", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    
                    }
                } else{
                        
                    
                        let alert = UIAlertController(title: "Alert!!!", message: "Password & Confirm Password Doesn't Match", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Re-enter Password", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
         
                    
            } else {
                    let alert = UIAlertController(title: "Alert!!!", message: "Need to checked the Term of Use and Privacy Policy", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        
        }
        
    }

    
    let keyboardObserver = UnderKeyboardObserver()
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardObserver.start()
        
       // NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        
        firstName.delegate = self
         lastName.delegate = self
         email.delegate = self
         userName.delegate = self
         password.delegate = self
        confirmpassword.delegate = self
        parentAddress.delegate = self
        parentContact.delegate = self
        nameParent.delegate = self
       
        firstName.tag = 0
        lastName.tag = 0
        email.tag = 0
        userName.tag = 0
        password.tag = 0
        confirmpassword.tag = 0
        parentAddress.tag = 0
        parentContact.tag = 0
        nameParent.tag = 0
        
       
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow,object: nil)
          NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow,object: nil)
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
            parentContact.isHidden = true
             parentAddress.isHidden = true
             nameParent.isHidden = true
        } else{
            parentContact.isHidden = false
            parentAddress.isHidden = false
            nameParent.isHidden = false
        }
        
      
    
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstName {
            lastName.becomeFirstResponder()
        } else if textField == lastName {
            email.becomeFirstResponder()
        } else if textField == email {
            userName.becomeFirstResponder()
        }else if textField == userName {
            DateofBirth.becomeFirstResponder()
        }else if textField == DateofBirth {
            password.becomeFirstResponder()
        } else if textField == password {
            confirmpassword.becomeFirstResponder()
           

        }else if textField == confirmpassword{
            parentContact.becomeFirstResponder()
            
        }
        else if textField == parentContact {
            parentAddress.becomeFirstResponder()
        }
        else if textField == parentAddress {
            nameParent.becomeFirstResponder()
        } else if textField == nameParent{
            
            nameParent.resignFirstResponder()
        }
      return true
    }

    func myFunction() {
        print("Keyboard height: \(String(describing: keyboardObserver.currentKeyboardHeight))")
    }
 @objc func keyboardWillShow(notification: NSNotification) {
       view.frame.origin.y = -100
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
}
}

