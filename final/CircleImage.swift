//
//  CircleImage.swift
//  final
//
//  Created by Govind Cacciatore on 21/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true 
    }

}
