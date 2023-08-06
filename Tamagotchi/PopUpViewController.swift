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
    @IBOutlet var lineView: UIView!
    
    var tamaList = TamagotchiList().tamagotchi
    var tamaInfo: TamagotchiInfo!
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
    
    @IBAction func selectButtonClicked(_ sender: UIButton) {
        
        if state == .initial { //초기
            UserDefaults.standard.set(try? PropertyListEncoder().encode(tamaInfo), forKey: tamaInfo.name)
            UserDefaults.standard.set(false, forKey: "isInitial")
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        let nav = UINavigationController(rootViewController: vc)
        UserDefaults.standard.set(tamaInfo.name, forKey: "selectedTama") //내가 선택한 다마고치 이름
        vc.tamaName = tamaInfo.name
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
        
        
       
    }
    

}


//디자인
extension PopUpViewController {
    
    func setDesignView() {
        view.backgroundColor = .clear
        backView.layer.backgroundColor = UIColor.black.cgColor
        backView.layer.opacity = 0.1
        
        lineView.backgroundColor = .lightGray
        
        popUpMainView.backgroundColor = setBackgroundColor()
        popUpMainView.layer.cornerRadius = 5
        
        configurationButton(btnText: "취소", button: cancelButton)
        if state == .initial{
            configurationButton(btnText: "시작하기", button: selectButton) //변경화면 시 텍스트 변경 설정 필요
        } else {
            configurationButton(btnText: "변경하기", button: selectButton)
        }
       
        
        tamaNameLabel.text = tamaInfo.name
        tamaNameLabel.textAlignment = .center
        
        profileLabel.text = tamaInfo.profile
        profileLabel.textAlignment = .center
        
        profileLabel.numberOfLines = 0
        profileLabel.font = .systemFont(ofSize: 13, weight: .light)
        tamaImageView.image = UIImage(named: "\(tamaInfo.imgNum)-6")
        
        
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
