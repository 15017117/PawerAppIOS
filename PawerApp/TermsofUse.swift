//
//  TermsofUse.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 4/9/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit

class TermofUse: UIViewController{
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var viewtemplate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDone.layer.cornerRadius = 15.0
    viewtemplate.layer.shadowOpacity = 0.2
        viewtemplate.layer.shadowRadius = 4.0
        viewtemplate.layer.shadowOffset = CGSize(width: 0
            , height: 0)
        viewtemplate.layer.shadowColor = UIColor.black
            .cgColor
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    
    }
}
