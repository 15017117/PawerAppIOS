//
//  ViewController.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 17/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit
import Alamofire
import QuartzCore

class ViewController: UIViewController {
    
    let URL_USER_LOGIN = "http://www.ehostingcentre.com/pawer/loginuser.php";
   
    //let defaultValues:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var emailTextField: DesignableTextField!
    
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          let defaultValues = UserDefaults.standard
        
        
        
        LoginButton.layer.cornerRadius = 15.0;
        
        if defaultValues.string(forKey: "user_username") != nil{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
           
        
        }
       
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginButton(_ sender: UIButton) {
        let defaultValues = UserDefaults.standard
        //getting the username and password
        let parameters: Parameters = [
            "user_email": emailTextField.text!,
            "user_pwd":passwordTextField.text!,
            
            ]
        //making a post request
        Alamofire.request(URL_USER_LOGIN,method: .post,parameters: parameters).responseJSON{
            response in
            //printing response
            print(response)
            
            //getting the JSON value from the server
            
            let convertResponse =  response.result.value as!NSDictionary
            let getStatus = convertResponse.value(forKey: "status")! as! Int
          
            
          if(getStatus == 200){
            let user = convertResponse.value(forKey: "users")! as!
            NSArray
            
            print(user)
            let user_username = user.value(forKey: "user_username")as! [String]
           // print(user_username[0])
                let user_firstname = user.value(forKey: "user_firstname")as! [String]
                let user_lastname = user.value(forKey: "user_lastname")as!
                    [String]
                let user_email = user.value(forKey: "user_email")as![String]
           // print(user_email)
            
            
            defaultValues.set(user_username[0], forKey: "user_username")
         
            defaultValues.set(user_firstname[0], forKey: "user_firstname")
            defaultValues.set(user_lastname[0], forKey:"user_lastname")
            defaultValues.set(user_email[0], forKey: "user_email")
            
          

//                    switching the screen
            
//    let WelcomeViewController = self.storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
//    self.navigationController?.pushViewController(WelcomeViewController, animated: true)
        //self.dismiss(animated: false, completion: nil)
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
    
          } else if(getStatus == 201){
            let defaultValues = UserDefaults.standard
            let alert = UIAlertController(title: "Alert!!!", message: "Waiting for Approval from parent", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
           
            self.present(alert, animated: true, completion: nil)
            
            let user = convertResponse.value(forKey: "users")! as!
            NSArray
            
            //print(user)
            let user_username = user.value(forKey: "user_username")as! [String]
            // print(user_username[0])
            let user_firstname = user.value(forKey: "user_firstname")as! [String]
            let user_lastname = user.value(forKey: "user_lastname")as!
                [String]
            
            defaultValues.set(user_username[0], forKey: "user_username")
            
            defaultValues.set(user_firstname[0], forKey: "user_firstname")
            defaultValues.set(user_lastname[0], forKey:"user_lastname")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
            
          } else if(getStatus == 202){
            let alert = UIAlertController(title: "Alert!!!", message: "Sorry, Your Application is rejected. Please Contact Admin", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
          }
            
          
          
          
          else if(getStatus == 401){
            let alert = UIAlertController(title: "Alert!!!", message: "Wrong email or password!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Re-Enter Username and Password", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
          }
          
          
          else if(getStatus ==  404){
                    let alert = UIAlertController(title: "Alert!!!", message: "You have not registered for PAWER 15 yet!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Please Register!", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            
            }
        }
    }
    
    


