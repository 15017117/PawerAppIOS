
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








