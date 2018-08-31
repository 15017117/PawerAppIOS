
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
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.removeObject(forKey: "userId")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier:"LoginController")as! ViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
        
    }
    var movieplayer:MPMoviePlayerController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let path  = Bundle.main.path(forResource: "pawer_app_video", ofType: "mp4")
        let url = NSURL(fileURLWithPath: path!)
        self.movieplayer = MPMoviePlayerController(contentURL: url as URL!)
        self.movieplayer!.view.frame = CGRect(x: 0, y: 200, width:400, height: 250)
        self.movieplayer!.prepareToPlay()
        self.view.addSubview(self.movieplayer!.view)
    }
    
}








