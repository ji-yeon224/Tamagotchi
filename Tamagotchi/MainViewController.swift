//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

struct Limit {
    static let maximumOnetimeWater = 50
    static let maximumOnetimeMeal = 100
}

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    
    
    @IBOutlet var textImageView: UIImageView!
    
    @IBOutlet var backVIew: UIView!
    @IBOutlet var tamaImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var mealTextField: UITextField!
    @IBOutlet var mealButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var underLineViews: [UIView]!
    
    
    var level = 1
    var tamaName = ""
    var tamaInfo:TamagotchiInfo! {
        didSet{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(tamaInfo), forKey: tamaInfo.name)
        }
    }
    var userName = ""
    let messageList = Message()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tamaInfo = getTamaInfo()
        tamaName = UserDefaults.standard.string(forKey: "selectedTama") ?? "empty"
        title = "\(userName)님의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(showSettingView))
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        setProperties()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        userName = UserDefaults.standard.string(forKey: "userName")!
        title = "\(userName)님의 다마고치"
        
        changeTamaInfo() //이미지 정보 메세지 변경
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func getTamaInfo() -> TamagotchiInfo {
        guard let tamaInfo = UserDefaults.standard.value(forKey: tamaName) as? Data,
              let data = try? PropertyListDecoder().decode(TamagotchiInfo.self, from: tamaInfo) else {return TamagotchiInfo(name: "", profile: "", imgNum: -1)}
        
        return data
    }
    
    
    @IBAction func mealButtonClicked(_ sender: UIButton) {
        
        do {
            let result = try validateUserInputError(num: mealTextField.text ?? "0", max: Limit.maximumOnetimeMeal)
        } catch{
            return
        }
        
        if mealTextField.text!.count == 0 {
            tamaInfo.meal += 1
            changeTamaInfo()
        } else {
            tamaInfo.meal += Int(mealTextField.text!) ?? 0
            mealTextField.text = ""
            changeTamaInfo()
        }
        view.endEditing(true)
        
        
        
    }
    
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
        do {
            let result = try validateUserInputError(num: waterTextField.text ?? "0", max: Limit.maximumOnetimeWater)
        } catch{
            return
        }
        
        if waterTextField.text!.count == 0 {
            tamaInfo.water += 1
            changeTamaInfo()
        } else {
            tamaInfo.water += Int(waterTextField!.text!) ?? 0
            waterTextField.text = ""
            changeTamaInfo()
        }
        view.endEditing(true)
       

    }
    
    func validateUserInputError(num: String, max: Int) throws -> Bool {
        guard Int(num) != nil else {
            throw ValidationError.isNotInt
        }
        
        guard Int(num)! < max else {
            changeMessage(messageList.overEatMessage.randomElement()!)
            throw ValidationError.isMaxInput
        }
        
        return true
        
    }

    
    
    @objc func showSettingView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: SettingViewController.identifier) as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    

}

//디자인 및 설정
extension MainViewController {
    
    //메세지, 정보, 이미지 변경
    func changeTamaInfo() {
        infoLabel.text = "LV\(tamaInfo.level()) | 밥알 \(tamaInfo.meal)개 | 물방울 \(tamaInfo.water)개"
        var imgNum = tamaInfo.level()
        if imgNum > 9 {
            imgNum = 9
        }
        
        tamaImageView.image = UIImage(named: "\(tamaInfo.imgNum)-\(imgNum)")
        
        var msg = ""
        if tamaInfo.meal == 0 && tamaInfo.water == 0 {
            msg = "반가워요, nickname님!!"
        } else if level != tamaInfo.level() {
            msg = messageList.levelUPMessage.randomElement()!
        }else if level == 10 {
            msg = messageList.maxMessage.randomElement()!
        } else{
            msg = messageList.growMessage.randomElement()!
        }
        changeMessage(msg)
        
    }
    
    func changeMessage(_ string: String) {
        var msg = string
        if string.contains("nickname") {
            msg = string.replacingOccurrences(of: "nickname", with: userName) //닉네임 붙여서 메세지 멘트 가져오기
        }
        messageLabel.text = msg
        
    }

    
    //레이블 버튼 등등 디자인
    func setProperties() {
        
        view.backgroundColor = setBackgroundColor()
        backVIew.backgroundColor = setBackgroundColor()
        nameLabel.text = " \(tamaInfo.name) "
        setNameLabel(label: nameLabel)
        
        
        tamaImageView.contentMode = .scaleAspectFill
        textImageView.image = UIImage(named: "bubble")
        textImageView.contentMode = .scaleToFill
        
        infoLabel.textColor = .darkGray
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textAlignment = .center
        infoLabel.textColor = setFontColor()
        
        messageLabel.font = .systemFont(ofSize: 13)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = setFontColor()
        
        mealTextField.keyboardType = .numberPad
        mealTextField.backgroundColor = .clear
        mealTextField.borderStyle = .none
        mealTextField.placeholder = "밥주세용"
        mealTextField.textAlignment = .center
        
        waterTextField.keyboardType = .numberPad
        waterTextField.backgroundColor = .clear
        waterTextField.borderStyle = .none
        waterTextField.placeholder = "물주세용"
        waterTextField.textAlignment = .center
        
        for v in underLineViews {
            v.backgroundColor = setFontColor()
            
        }
        
        
        designButton(button: waterButton, image: "drop.circle", title: "물먹기")
        designButton(button: mealButton, image: "leaf.circle", title: "밥먹기")
        
       
    }

    
  
    
    func designButton(button: UIButton, image: String, title: String) {

        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = UIImage(systemName: image)
        config.baseForegroundColor = setFontColor()
        config.buttonSize = .small
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.titleAlignment = .center
        config.cornerStyle = .capsule

        button.configuration = config

    }
    
    
}

//텍스트필드 누를 시 키보드만큼 화면 올라감
extension MainViewController {
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        if view.frame.origin.y >= 0 {
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                self.view.frame.origin.y -= keyboardHeight
            }
        }
        
            
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight
        }
    }
    

                                            
    
}
