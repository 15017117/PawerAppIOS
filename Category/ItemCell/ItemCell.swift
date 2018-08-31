//
//  ItemCell.swift
//  PawerApp
//
//  Created by Ivan Lipotan on 16/8/18.
//  Copyright © 2018 Etechnology. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setaData(text: String){
        self.textLabel.text = text
    }
}
