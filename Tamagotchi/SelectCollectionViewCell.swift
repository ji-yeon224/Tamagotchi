//
//  SelectCollectionViewCell.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/04.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SelectCollectionViewCell"
    
    let tamagotchi = Tamagotchi.allCases

    @IBOutlet var selectImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 13, weight: .light)
        nameLabel.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.lightGray.cgColor
        nameLabel.layer.cornerRadius = 5
        
        
    }
    
   
    
    func configureCell(idx: Int) {
        
        
        if idx < tamagotchi.count {
            let tmg = tamagotchi[idx]
            switch tmg{
            case .따끔따끔:
                nameLabel.text = " 따끔따끔 다마고치 "
                selectImageView.image = UIImage(named: "\(tmg.rawValue)-6")
            case .반짝반짝:
                nameLabel.text = " 반짝반짝 다마고치 "
                selectImageView.image = UIImage(named: "\(tmg.rawValue)-6")
            case .방실방실:
                nameLabel.text = " 방실방실 다마고치 "
                selectImageView.image = UIImage(named: "\(tmg.rawValue)-6")
            }
        }else { 
            nameLabel.text = " 준비중이에요 "
            selectImageView.image = UIImage(named: "noImage")
        }
        
        
    }
    

}
