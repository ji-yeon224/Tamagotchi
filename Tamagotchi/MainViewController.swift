//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    
    @IBOutlet var textImageView: UIImageView!
    
    @IBOutlet var tamaImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var mealTextField: UITextField!
    @IBOutlet var mealButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterButton: UIButton!
    
    var tamaName = ""
    var tamaInfo:TamagotchiInfo! {
        didSet{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(tamaInfo), forKey: tamaInfo.name)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tamaList = UserDefaults.standard.array(forKey: "tamaList") as? [TamagotchiInfo] ?? [TamagotchiInfo]()
//        print(tamaList[0])
        
        
        
        tamaInfo = getTamaInfo()
        let userName = UserDefaults.standard.string(forKey: "userName")!
        title = "\(userName)님의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(showSettingView))
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        setProperties()
        
    }
    
    @IBAction func mealButtonClicked(_ sender: UIButton) {
        
        if mealTextField.text!.count == 0 {
            tamaInfo.meal += 1
        } else {
            tamaInfo.meal += Int(mealTextField!.text!) ?? 0
            mealTextField.text = ""
        }
        
        changeTamaInfo()
        
    }
    
    
    
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
        if waterTextField.text!.count == 0 {
            tamaInfo.water += 1
        } else {
            tamaInfo.water += Int(waterTextField!.text!) ?? 0
            waterTextField.text = ""
        }
        
        changeTamaInfo()

    }
    
    func changeTamaInfo() {
        infoLabel.text = "LV\(tamaInfo.level()) | 밥알 \(tamaInfo.meal)개 | 물방울 \(tamaInfo.water)개"
        tamaImageView.image = UIImage(named: "\(tamaInfo.imgNum)-\(tamaInfo.level())")
        //print(tamaInfo.level())
    }
    
    //레이블 버튼 등등 디자인
    func setProperties() {
        nameLabel.text = tamaInfo?.name
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .darkGray
        
        tamaImageView.image = UIImage(named: "\(tamaInfo.imgNum)-1")
        tamaImageView.contentMode = .scaleAspectFill
        textImageView.image = UIImage(named: "bubble")
        textImageView.contentMode = .scaleToFill
        
        mealTextField.keyboardType = .decimalPad
        waterTextField.keyboardType = .decimalPad
        
        infoLabel.text = "LV\(tamaInfo.level()) | 밥알 \(tamaInfo.meal)개 | 물방울 \(tamaInfo.water)개"
        infoLabel.textColor = .darkGray
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textAlignment = .center
        
        designButton(button: waterButton, image: "leaf.circle", title: "물먹기")
        designButton(button: mealButton, image: "drop.circle", title: "밥먹기")
        
       
    }
    
    //모든 뷰 설정 완료 후
    override func viewDidLayoutSubviews() {
        mealTextField.borderStyle = .none
        waterTextField.borderStyle = .none
        var border = CALayer()
        border.frame = CGRect(x: 0, y: mealTextField.frame.size.height-1, width: mealTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        mealTextField.layer.addSublayer((border))
        
        border = CALayer()
        border.frame = CGRect(x: 0, y: waterTextField.frame.size.height-1, width: waterTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        waterTextField.layer.addSublayer((border))
    }
    
    func designButton(button: UIButton, image: String, title: String) {
        
        var config = UIButton.Configuration.filled()  //기본 시스템 버튼
        config.title = title
        config.image = UIImage(systemName: image) //기본으로 애플에 등록된 이미지
        config.buttonSize = .small
        config.baseForegroundColor = .darkGray
        config.baseBackgroundColor = .clear
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.titleAlignment = .center
        
        config.cornerStyle = .capsule
        
        button.configuration = config //outlet에 설정 붙이기
        
    }
    
    
    func getTamaInfo() -> TamagotchiInfo {
        guard let tamaInfo = UserDefaults.standard.value(forKey: tamaName) as? Data,
              let data = try? PropertyListDecoder().decode(TamagotchiInfo.self, from: tamaInfo) else {return TamagotchiInfo(name: "", profile: "", imgNum: -1)}
        return data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print(#function)
        let userName = UserDefaults.standard.string(forKey: "userName")
        title = "\(userName!)님의 다마고치"
    }
    
    @objc func showSettingView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: SettingViewController.identifier) as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    

}
