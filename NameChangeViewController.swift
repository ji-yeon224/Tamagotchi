//
//  NameChangeViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

class NameChangeViewController: UIViewController {
    
    static let identifier = "NameChangeViewController"
    
    
    @IBOutlet var nameChangeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "대장님 이름 변경하기"
        nameChangeTextField.text = UserDefaults.standard.string(forKey: "userName")
        nameChangeTextField.placeholder = "대장님 이름을 알려주세요!"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(changeUserName))
        navigationController?.navigationBar.tintColor = .darkGray
        
        

    }
    
    //모든 뷰 설정 완료 후
    override func viewDidLayoutSubviews() {
        nameChangeTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: nameChangeTextField.frame.size.height-1, width: nameChangeTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        nameChangeTextField.layer.addSublayer((border))
    }
    
    @objc func changeUserName() {
        
        
        if nameChangeTextField.text == nil || nameChangeTextField.text!.count < 2 || nameChangeTextField.text!.count > 6 {
            showAlert("2글자 이상 6글자 이하로 작성해주세요!")
        } else {
            UserDefaults.standard.set(nameChangeTextField.text, forKey: "userName")
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    

   

}
