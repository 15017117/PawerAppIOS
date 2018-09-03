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
    //let defaultValues = UserDefaults.standard
    let defaultValues:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var emailTextField: DesignableTextField!
    
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
            var getStatus = convertResponse.value(forKey: "status")! as! Int
          
            
          if(getStatus == 200){
                let user = convertResponse.value(forKey: "users")as! NSArray
            
            print(user)
            
            
            let user_username = user.value(forKey: "user_username")

            
            print(user_username);
                let user_firstname = user.value(forKey: "user_firstname")
                let user_lastname = user.value(forKey: "user_lastname")
            
            self.defaultValues.set(user_username, forKey: "user_username")
                self.defaultValues.set(user_firstname, forKey: "user_firstname")
                self.defaultValues.set(user_lastname, forKey:"user_lastname")
            
            print("User Default  NAME :: \(String(describing: UserDefaults.standard.string(forKey: "user_username" )))")

//                    switching the screen
            
//    let WelcomeViewController = self.storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
//    self.navigationController?.pushViewController(WelcomeViewController, animated: true)
        //self.dismiss(animated: false, completion: nil)
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
    
          } else if(getStatus == 201){
            let alert = UIAlertController(title: "Alert!!!", message: "Waiting for Approval from parent", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
           
            self.present(alert, animated: true, completion: nil)
            
            let user = convertResponse.value(forKey: "users")as! NSArray
            let user_username = user.value(forKey: "user_username")
            let user_firstname = user.value(forKey: "user_firstname")
            let user_lastname = user.value(forKey: "user_lastname")
            
            self.defaultValues.set(user_username, forKey: "username")
            self.defaultValues.set(user_firstname, forKey: "user_firstname")
            self.defaultValues.set(user_lastname, forKey:"user_lastname")
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
            
          } else if(getStatus == 202){
            let alert = UIAlertController(title: "Alert!!!", message: "Sorry, Your Application is rejected. Please Contact Admin", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.show(vc, sender: self)
            
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
    
    


