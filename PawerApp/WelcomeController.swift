
//
//  File.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 15/8/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//


import UIKit
import Alamofire
import AVKit
import AVFoundation
import MediaPlayer

class WelcomeController: UIViewController{
    
    
    
    @IBAction func btnlogout(_ sender: UIButton) {
        
        print("Click logout button");
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        self.movieplayer!.stop()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! ViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)

       
        self.dismiss(animated: false, completion: nil)
        
    }
    var movieplayer:MPMoviePlayerController?
    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         btnLogOut.layer.cornerRadius = 15.0
        btnEditProfile.layer.cornerRadius = 15.0
        
        let path  = Bundle.main.path(forResource: "pawer_app_video", ofType: "mp4")
        let url = NSURL(fileURLWithPath: path!)
        self.movieplayer = MPMoviePlayerController(contentURL: url as URL!)
        self.movieplayer!.view.frame = CGRect(x: 0, y: 200, width:400, height: 250)
        self.movieplayer!.prepareToPlay()
        self.view.addSubview(self.movieplayer!.view)
    }
    
    @IBAction func btnEditProfile(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileController") as! EditProfileController
        self.show(vc, sender: self)
        self.movieplayer!.stop()
        
        
    }
    
    
    
}








