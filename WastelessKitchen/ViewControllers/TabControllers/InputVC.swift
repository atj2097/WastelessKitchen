//
//  InputVC.swift
//  WastelessKitchen
//
//  Created by God on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit


class InputVC: UIViewController {
    //Views
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
   var pictureArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        constraints()
    }
    
    private func constraints() {
        [datePicker,collectionView].forEach({self.view.addSubview($0)})
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        [datePicker.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50), datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)].forEach({$0.isActive = true})
        
        [collectionView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)].forEach({$0.isActive = true})
    }

}
extension InputVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
        
        return cell
    }
    
    
}



