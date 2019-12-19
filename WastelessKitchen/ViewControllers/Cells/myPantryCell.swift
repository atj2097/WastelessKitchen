//
//  myPantryCell.swift
//  WastelessKitchen
//
//  Created by Krystal Campbell on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class myPantryCell: UITableViewCell {

   lazy var foodImage: UIImageView = {
      let iv = UIImageView()
      iv.clipsToBounds = true
      iv.contentMode = .scaleToFill
      iv.backgroundColor = .systemIndigo
       return iv
      }()
      
    lazy var foodLabel:UILabel = {
      let label = UILabel()
          label.textAlignment = .center
          label.font = UIFont(name: "Marker Felt", size: 26.0)
          label.font = label.font.withSize(26)
          label.textColor = .black
          label.numberOfLines = 0
          label.textAlignment = .center
          label.adjustsFontSizeToFitWidth = true
          label.layer.cornerRadius = 20
          label.backgroundColor = .clear
      return label
      }()
      
    lazy var expirationLabel:UILabel = {
      let label = UILabel()
          label.textAlignment = .center
          label.numberOfLines = 0
          label.font = UIFont(name: "Marker Felt", size: 26.0)
          label.font = label.font.withSize(26)
          label.textColor = .black
          label.textAlignment = .center
          label.adjustsFontSizeToFitWidth = true
          label.layer.cornerRadius = 20
          label.backgroundColor = .clear
      return label
      }()
      
}
