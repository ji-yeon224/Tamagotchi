//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

enum Setting: CaseIterable {
    case name, change, reset
}

class SettingViewController: UIViewController {
    
    static let identifier = "SettingViewController"
    
    var tamaList:[Tamagotchi] = []
    
    
    @IBOutlet var settingTableView: UITableView!
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let setting = Setting.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = setBackgroundColor()
        settingTableView.backgroundColor = setBackgroundColor()
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        settingTableView.layer.backgroundColor = setBackgroundColor().cgColor
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.backgroundColor = setBackgroundColor()
        title = "설정"
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        cell.subLabel.text = UserDefaults.standard.string(forKey: "userName")
        settingTableView.reloadData()
    }
    

    
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        cell.backgroundColor = .clear
        
        switch setting[indexPath.row] {
        case .name:
            cell.configureCell(img: "pencil", title: "내 이름 설정하기", sub: UserDefaults.standard.string(forKey: "userName")!)
        case .change:
            cell.configureCell(img: "moon.fill", title: "다마고치 변경하기", sub: "")
        case .reset:
            cell.configureCell(img: "goforward", title: "데이터 초기화", sub: "")
            
            
        }
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch setting[indexPath.row] {
        case .name:
            let vc = sb.instantiateViewController(identifier: NameChangeViewController.identifier) as! NameChangeViewController
            navigationController?.pushViewController(vc, animated: true)
            
        case .change:
            changeTamagotchi()
        case .reset:
            resetAlert()
        }
    }
    
    //다마고치 변경하기
    func changeTamagotchi() {
        
        let vc = sb.instantiateViewController(identifier: SelectViewController.identifier) as! SelectViewController
    
        vc.state = .change
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //초기화 경고창
    func resetAlert() {
        let alert = UIAlertController(title: nil, message: "정말로 초기화 하시겠어요?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "네!", style: .default) {
            (action) in self.resetData()
        }
        let cancel = UIAlertAction(title: "아니요ㅠ", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    
    //리셋 화면 전환
    func resetData() {

        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = sb.instantiateViewController(identifier: SelectViewController.identifier) as! SelectViewController
        let nav = UINavigationController(rootViewController: vc)
        
        vc.state = .initial
        UserDefaults.standard.set(false, forKey: "isLaunched")
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
        
        
    }
    
}
