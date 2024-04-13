//
//  MainViewController.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/8/24.
//

import UIKit

class MainViewController: UIViewController {
    private let stackView = UIStackView()
    private var cardManager = CardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupStackView()
        addCardListControllers()
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -300),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addCardListControllers() {
        let statuses: [(String, CardStatus)] = [("해야할 일", .toDO), ("하고 있는 일", .inProgress), ("완료한 일", .done)]
        
        for (title, status) in statuses {
            let cardListVC = CardListViewController(headerTitle: title, cardManager: cardManager, cardStatus: status)
            addChild(cardListVC)
            stackView.addArrangedSubview(cardListVC.view)
            cardListVC.didMove(toParent: self)
        }
    }
}

