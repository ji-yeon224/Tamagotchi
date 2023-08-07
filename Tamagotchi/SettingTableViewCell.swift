//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"

    @IBOutlet var imgLabel: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!

    
    
    func configureCell(img: String, title: String, sub: String) {
        titleLabel.font = .boldSystemFont(ofSize: 14)
        subLabel.font = .systemFont(ofSize: 14)
        subLabel.textColor = .lightGray
        
        imgLabel.image = UIImage(systemName: img)
        imgLabel.tintColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        titleLabel.text = title
        subLabel.text = sub
        
        
    }
    
    
    
}
