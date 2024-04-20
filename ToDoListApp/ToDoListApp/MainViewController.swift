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
    private var tableViewControllers: [UITableView: CardListViewController] = [:]
    
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
        let statuses: [(name: String, status: CardStatus)] = [(name: "해야할 일", status: .toDO),
                                                              (name: "하고 있는 일", status: .inProgress),
                                                              (name: "완료한 일", status: .done)]
        
        statuses.enumerated().forEach { index, status in
            let cardListVC = CardListViewController(headerTitle: status.name, cardManager: cardManager, cardStatus: status.status)
            addChild(cardListVC)
            stackView.addArrangedSubview(cardListVC.view)
            cardListVC.didMove(toParent: self)
            
            cardListVC.tableView.dragDelegate = self
            cardListVC.tableView.dropDelegate = self
            tableViewControllers[cardListVC.tableView] = cardListVC
        }
    }
}

extension MainViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if let cardListVC = tableViewControllers[tableView],
           let card = cardListVC.cardManager.card(for: cardListVC.cardStatus, at: indexPath.row) {
            let itemProvider = NSItemProvider(object: card)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = card
            return [dragItem]
        }
        return []
    }
}

extension MainViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        guard session.items.count == 1 else {
            return UITableViewDropProposal(operation: .cancel)
        }
        
        if session.localDragSession != nil {
            if tableView.hasActiveDrag {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            } else {
                return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: 0, section: 0)
        
        for item in coordinator.items {
            guard let dragItem = item.dragItem.localObject as? ToDoCard else { continue }
            coordinator.session.loadObjects(ofClass: ToDoCard.self) { [weak self] items in
                guard let self = self, let card = items.first as? ToDoCard else { return }
                guard let destinationVC = self.tableViewControllers[tableView] else { return }
                
                DispatchQueue.main.async {
                    let sourceVC = self.tableViewControllers.first { $1.cardManager.containsCard(with: card.id) }?.value
                    
                    if let sourceVC = sourceVC, sourceVC === destinationVC {
                        let numRows = destinationVC.tableView.numberOfRows(inSection: destinationIndexPath.section)
                        if destinationIndexPath.row < numRows {
                            sourceVC.cardManager.moveCard(from: destinationIndexPath.row, to: destinationIndexPath.row, within: destinationVC.cardStatus)
                            tableView.moveRow(at: destinationIndexPath, to: destinationIndexPath)
                        } else {
                            print("인덱스 벗어남.")
                        }
                    } else if let sourceVC = sourceVC {
                        sourceVC.cardManager.removeCard(by: card.id)
                        destinationVC.cardManager.addCard(card, with: destinationVC.cardStatus)
                        
                        sourceVC.tableView.reloadData()
                        destinationVC.tableView.reloadData()
                    }
                }
            }
        }
    }
}
