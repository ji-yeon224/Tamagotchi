//
//  EatButton.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/21.
//

import UIKit

@IBDesignable
class EatButton: UIButton {
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
        
        
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            return layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.backgroundColor = newValue.cgColor
        }
    }
    
   
    
    
    
    
}
