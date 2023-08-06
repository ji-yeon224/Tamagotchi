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
        print("start")
        UserDefaults.standard.set("대장", forKey: "userName") //초기화 시에만 설정
        
        //구초체 객체 저장
        //UserDefaults.standard.set(try? PropertyListEncoder().encode(self.tamaInfo), forKey: tamaInfo.name)
        
        //UserDefaults.standard.set()
        //UserDefaults.standard.set(tamaList, forKey: "tamaList")
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(tamaInfo), forKey: tamaInfo.name)
        
        UserDefaults.standard.set(true, forKey: "isSelected") //시작 뷰 바꾸기
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        let nav = UINavigationController(rootViewController: vc)
        
        vc.tamaName = tamaInfo.name
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
        //UserDefaults 값 설정 후 화면 전환
//        switch state {
//        case .initial:
//            UserDefaults.standard.set(, forKey: <#T##String#>)

        //case .change:
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
        configurationButton(btnText: "시작하기", button: selectButton) //변경화면 시 텍스트 변경 설정 필요
        
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
