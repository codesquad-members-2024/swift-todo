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
    let headerTitle: String
    var cards: [ToDoCard]
    
    init(headerTitle: String, cards: [ToDoCard] = []) {
        self.headerTitle = headerTitle
        self.cards = cards
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupTableView()
    }
    
    func setupStackView() {
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
        
        let headerView = CardListHeaderView()
        headerView.titleLabel.text = headerTitle
        headerView.badgeLabel.text = "\(cards.count)"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(headerView)
        
        headerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupTableView() {
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
}

extension CardListViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        let card = cards[indexPath.row]
        cell.configure(with: card)
        return cell
    }
    
    // MARK: - delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(headerTitle): \(indexPath.row)")
    }
}


