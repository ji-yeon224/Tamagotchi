//
//  PopUpViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/04.
//

import UIKit

class PopUpViewController: UIViewController {
    
    static let identifier = "PopUpViewController"
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet var popUpMainView: UIView!
    @IBOutlet var tamaImageView: UIImageView!
    @IBOutlet var tamaNameLabel: UILabel!
    @IBOutlet var profileLabel: UILabel!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var tama: TamagotchiInfo!
    var state: State = .initial
    var tamaEnum = Tamagotchi.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setDesignView()
        setNameLabel(label: tamaNameLabel)
        

    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
//    @IBAction func selectButtonClicked(_ sender: UIButton) {
//        print("start")
//        //UserDefaults 값 설정 후 화면 전환
//        switch state {
//        case .initial:
//            UserDefaults.standard.set(, forKey: <#T##String#>)
//
//        //case .change:
//    }
    

}


//디자인
extension PopUpViewController {
    
    func setDesignView() {
        view.backgroundColor = .clear
        backView.layer.backgroundColor = UIColor.black.cgColor
        backView.layer.opacity = 0.1
        
        popUpMainView.backgroundColor = setBackgroundColor()
        popUpMainView.layer.cornerRadius = 5
        
        configurationButton(btnText: "취소", button: cancelButton)
        configurationButton(btnText: "시작하기", button: selectButton) //변경화면 시 텍스트 변경 설정 필요
        
        tamaNameLabel.text = tama.name
        tamaNameLabel.textAlignment = .center
        
        profileLabel.text = tama.profile
        profileLabel.textAlignment = .center
        profileLabel.numberOfLines = 0
        profileLabel.font = .systemFont(ofSize: 13, weight: .light)
        tamaImageView.image = UIImage(named: "\(tama.imgNum)-6")
        
        
    }
    
    func configurationButton(btnText: String, button: UIButton) {
        
        var config = UIButton.Configuration.plain()
        config.title = btnText
        config.baseForegroundColor = .darkGray
        config.baseBackgroundColor = setBackgroundColor()
        config.titleAlignment = .center
        
        button.configuration = config
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        
    }
    
}
