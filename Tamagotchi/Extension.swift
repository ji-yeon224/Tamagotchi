//
//  ExtensionColor.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/04.
//

import UIKit
extension UIViewController {
    
    func setBackgroundColor() -> UIColor {
        return UIColor(red: 232 / 255, green: 251 / 255, blue: 252 / 255, alpha: 1)
    }
    
    //다마고치 이름 레이블 공통 디자인
    func setNameLabel(label: UILabel) {
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
    }
    
}


