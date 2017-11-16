//
//  RoundedView.swift
//  final
//
//  Created by Govind Cacciatore on 21/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
