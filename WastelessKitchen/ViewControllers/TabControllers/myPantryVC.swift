//
//  PantryVCViewController.swift
//  WastelessKitchen
//
//  Created by God on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class myPantryVC: UIViewController {
    
    private var pantryList = [FoodPantry]() {
          didSet {
              myFoodPantryTableView.reloadData()
          }
      }
    
    
    //MARK:- UI Objects
       
       lazy var myFoodPantryTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(myPantryCell.self, forCellReuseIdentifier: CellIdentifier.myPantryCell.rawValue)
        //tv.dataSource = self
       // tv.delegate = self
           return tv
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupScene()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupScene(){
       self.navigationController?.navigationBar.topItem?.title = "My Food Pantry"
        // navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.xmark"), style: .plain, target: self, action: #selector(logoutButtonPressed))
    // Colors.shared.setGradientBackground(colorTop: .gray, colorBottom: .white, newView: view)
          }
     
       //MARK: -UI Constraints
        
    private func setupTableView() {
    view.addSubview(myFoodPantryTableView)
        myFoodPantryTableView.translatesAutoresizingMaskIntoConstraints = false
        myFoodPantryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myFoodPantryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myFoodPantryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myFoodPantryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }


