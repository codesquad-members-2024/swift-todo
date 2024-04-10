//
//  MainViewController.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/8/24.
//

import UIKit

class MainViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        displayContainerViewController()
    }
    
    private func displayContainerViewController() {
        let containerVC = ContainerViewController()
        addChild(containerVC)
        view.addSubview(containerVC.view)
        containerVC.didMove(toParent: self)
        
        containerVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -300),
            containerVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

}

