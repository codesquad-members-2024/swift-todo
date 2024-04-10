//
//  ContainerViewController.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/9/24.
//

import UIKit

class ContainerViewController: UIViewController {
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupStackView()
        addTempCardListControllers()
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addTempCardListControllers() {
        let titles = ["해야할 일", "하고 있는 일", "완료한 일"]
        let tempData = [ToDoCard(title: "안녕하세요", description: "안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요", platform: "iOS", status: .done),
                        ToDoCard(title: "안녕하세요", description: "안녕하세요", platform: "iOS", status: .done)]
        titles.forEach { title in
            let cardListVC = CardListViewController(headerTitle: title, cards: tempData)
            addChild(cardListVC)
            stackView.addArrangedSubview(cardListVC.view)
            cardListVC.didMove(toParent: self)
            
            cardListVC.view.translatesAutoresizingMaskIntoConstraints = false
            cardListVC.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -20/3).isActive = true
        }
    }
}
