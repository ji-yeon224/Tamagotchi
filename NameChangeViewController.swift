//
//  NameChangeViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import UIKit

class NameChangeViewController: UIViewController {
    
    static let identifier = "NameChangeViewController"
    
    @IBOutlet var underLineView: UIView!
    @IBOutlet var nameChangeTextField: UITextField!
    let maxLength = 6
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "대장님 이름 변경하기"
        nameChangeTextField.text = UserDefaults.standard.string(forKey: "userName")
        nameChangeTextField.placeholder = "대장님 이름을 알려주세요!"
        
        view.backgroundColor = setBackgroundColor()
        underLineView.backgroundColor = .darkGray
        nameChangeTextField.backgroundColor = .clear
        nameChangeTextField.borderStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(changeUserName))
        navigationController?.navigationBar.tintColor = .darkGray
        
        

    }
    
    @IBAction func returnKeyClicked(_ sender: UITextField) {
        view.endEditing(true)
        changeUserName()
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
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
