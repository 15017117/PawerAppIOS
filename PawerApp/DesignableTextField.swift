//
//  DesignableTextField.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 17/7/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit
@IBDesignable class DesignableTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
       
        
    }
    
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
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
}
