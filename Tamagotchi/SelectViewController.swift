//
//  SelectViewController.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/04.
//

import UIKit

class SelectViewController: UIViewController {
    

    @IBOutlet var collectionView: UICollectionView!
    
    //let bgColor = UIColor(red: 232 / 255, green: 251 / 255, blue: 252 / 255, alpha: 1)
    
    var tamaList = TamagotchiList()
    var state: State = .initial
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = setBackgroundColor()
        collectionView.backgroundColor = setBackgroundColor()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if state == .initial{
            UserDefaults.standard.set("대장", forKey: "userName")
            title = "다마고치 선택하기"
        } else if state == .change {
            title = "다마고치 변경하기"
        }
        
        
        let nib = UINib(nibName: SelectCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
        collectionLayout()
        
        
    }
    
    func collectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        
        
    }
 

}


//collectionView
extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as! SelectCollectionViewCell
        cell.tag = indexPath.row
        cell.configureCell(idx: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: PopUpViewController.identifier) as! PopUpViewController
//        vc.modalPresentationStyle = .overFullScreen
        
        if indexPath.row >= tamaList.tamagotchi.count { //준비 셀 클릭 시
            showAlert("아직 준비중입니다!!")
            
        }else { // 다마고치 셀 클릭 시
            let tamaInfo = tamaList.tamagotchi[indexPath.row]
            vc.tamaInfo = tamaInfo
            vc.state = state
            print(UserDefaults.standard.string(forKey: "userName")!)
            
            present(vc, animated: true)
            //transitionView(viewController: PopUpViewController.self, storyboard: "Main", style: .presentFullNavigation)
        }
        
        
        
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
    
}
