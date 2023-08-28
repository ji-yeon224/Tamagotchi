//
//  ReusableProtocol.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/21.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
    
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

