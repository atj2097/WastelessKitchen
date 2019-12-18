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
        let layout = UICollectionViewFlowLayout.init()
               let cv = UICollectionView(frame:.zero , collectionViewLayout: layout)
               layout.scrollDirection = .horizontal
               layout.itemSize = CGSize(width: 250, height: 250)
               cv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
               cv.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
               cv.dataSource = self
               cv.delegate = self
        return cv
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(createGroc), for: .touchUpInside)
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
   var pictureArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        constraints()
    }
    
    private func constraints() {
        [datePicker,collectionView,createButton].forEach({self.view.addSubview($0)})
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        [datePicker.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50), datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)].forEach({$0.isActive = true})
        
        [collectionView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)].forEach({$0.isActive = true})
        
        [createButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    @objc func createGroc() {
        //Add Firebase
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



