//
//  Extension+UIViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullNavigation
        case push
    }

    func transitionView<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    func setBorder<T: UIView>(view: T) {
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        view.layer.cornerRadius = 5
    }
    
}

