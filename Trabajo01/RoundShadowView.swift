//
//  RoundShadowView.swift
//  cliente
//
//  Created by Valeria Henao on 4/05/22.
//  Copyright © 2022 Sebastian Panesso. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundShadowView: UIView{
    @IBInspectable var radius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }

    @IBInspectable var showShadow: Bool = false{
        didSet{
            self.applyMask()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyMask()
    }
    
    func applyMask()
    {
        clipsToBounds = true
        layer.cornerRadius = radius
        
        if showShadow {
            layer.masksToBounds = false
            layer.shadowOffset = CGSize.init(width: 0, height: 3)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 2.0
            layer.shadowOpacity = 0.35
            
        }
    }
}
