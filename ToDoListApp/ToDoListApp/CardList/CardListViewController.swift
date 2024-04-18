//
//  CardListViewController.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/8/24.
//

import UIKit

class CardListViewController: UIViewController {
    var tableView: UITableView!
    var stackView: UIStackView!
    var cardManager: CardManaging
    var headerView: CardListHeaderView!
    let headerTitle: String
    let cardStatus: CardStatus
    
    init(headerTitle: String, cardManager: CardManaging, cardStatus: CardStatus) {
        self.headerTitle = headerTitle
        self.cardManager = cardManager
        self.cardStatus = cardStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.headerTitle = ""
        self.cardManager = CardManager()
        self.cardStatus = .toDO
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNewCardAdded),
                                               name: CardManager.Notifications.NewCardAdded,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleCardMoved),
                                               name: CardManager.Notifications.CardMoved,
                                               object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: CardManager.Notifications.NewCardAdded, object: nil)
        NotificationCenter.default.removeObserver(self, name: CardManager.Notifications.CardMoved, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupTableView()
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        headerView = CardListHeaderView()
        headerView.titleLabel.text = headerTitle
        updateHeaderBadge()
        headerView.addButtonAction = { [weak self] in
            self?.addNewCard()
        }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(headerView)
        
        headerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func updateHeaderBadge() {
        headerView.badgeLabel.text = "\(cardManager.count(for: cardStatus))"
    }
    
    private func addNewCard() {
        let editVC = EditViewController(cardManager: cardManager as! CardManager, cardStatus: self.cardStatus)
        editVC.modalPresentationStyle = .overFullScreen
        
        self.present(editVC, animated: true)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "CardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CardTableViewCell")
    }
    
    // MARK: - Notification Handlers
    @objc private func handleNewCardAdded(notification: Notification) {
        updateHeaderBadge()
        self.tableView.reloadData()
    }
    
    @objc private func handleCardMoved(notification: Notification) {
        guard let userInfo = notification.userInfo,
                  let cardId = userInfo["cardId"] as? UUID,
                  let card = cardManager.card(for: cardStatus, with: cardId),
                  let newIndex = cardManager.index(of: card, in: cardStatus) else { return }
        
        if let oldIndex = tableView.indexPathsForVisibleRows?.first(where: { indexPath in
            guard let visibleCard = cardManager.card(for: cardStatus, at: indexPath.row) else { return false }
            return visibleCard.id == cardId
        }) {
            tableView.moveRow(at: oldIndex, to: IndexPath(row: newIndex, section: 0))
        }
        self.tableView.reloadData()
    }
}

extension CardListViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardManager.count(for: cardStatus)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        if let card = cardManager.card(for: cardStatus, at: indexPath.row) {
            cell.configure(with: card)
        }
        
        return cell
    }
    
    // MARK: - delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(headerTitle): \(indexPath.row)")
    }
}
