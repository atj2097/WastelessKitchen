//
//  FoodCell.swift
//  WastelessKitchen
//
//  Created by God on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class FoodCell: UICollectionViewCell {
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
