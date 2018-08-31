//
//  DesignableTextField.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 17/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit
@IBDesignable class DesignableTextField: UITextField {
  
    
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
            designTextField()
        }
        
    }
    func updateView(){
        if let image = leftImage{
            leftViewMode = .always
            let imageView =  UIImageView(frame: CGRect(x:4,y:0,width: 20,height:20))
        
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
            view.addSubview(imageView)
            
            leftView = view
        } else{
            //image is null
             leftViewMode = .never
        }
    }
    func designTextField(){
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 0
            , height: 0)
        self.layer.shadowColor = UIColor.black
            .cgColor
    
       
        
        
        
    }
}
