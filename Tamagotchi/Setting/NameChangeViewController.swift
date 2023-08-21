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
        
        guard let text = nameChangeTextField.text else {
            showAlert("이름을 입력해주세요!")
            return
        }
        
      
        //앞 뒤 공백 제거
        let removeWhiteSpaceText = text.trimmingCharacters(in: .whitespaces)
        do {
            let result = try validateNicknameInput(text: removeWhiteSpaceText)
        } catch {
            print("error")
            return
        }
        
        UserDefaults.standard.set(removeWhiteSpaceText, forKey: "userName")
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func validateNicknameInput(text: String) throws -> Bool {
        
        guard !(text.isEmpty) else {
            showAlert("이름을 입력해주세요!")
            throw ValidationError.emptyInput
        }
        
        guard text.count >= 2 else {
            showAlert("2글자 이상 6글자 이하로 작성해주세요!")
            throw ValidationError.isMinInput
        }
        
        guard text.count <= 6 else {
            showAlert("2글자 이상 6글자 이하로 작성해주세요!")
            throw ValidationError.isMaxInput
        }
        
        return true
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }

}
