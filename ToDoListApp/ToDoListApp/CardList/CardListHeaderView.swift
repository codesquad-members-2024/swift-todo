//
//  CardListHeaderView.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/8/24.
//

import UIKit

class CardListHeaderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var badgeLabel: UILabel = {
        let badgeLabel = UILabel()
        badgeLabel.layer.cornerRadius = 15
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = UIColor.black.cgColor
        badgeLabel.backgroundColor = .systemGray5
        badgeLabel.textColor = .black
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.text = "0"
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        return badgeLabel
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(CardListHeaderView.self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        configureLayout()
    }
    
    private func setupView() {
        self.backgroundColor = .systemGray5
        [ titleLabel, badgeLabel, addButton ].forEach { self.addSubview($0) }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            badgeLabel.heightAnchor.constraint(equalToConstant: 30),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualTo: badgeLabel.heightAnchor),
            
            addButton.centerYAnchor.constraint(equalTo: badgeLabel.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -20)
        ])
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        print("헤더 add버튼 탭")
    }
}
