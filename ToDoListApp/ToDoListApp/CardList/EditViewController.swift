//
//  EditViewController.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/13/24.
//

import UIKit

class EditViewController: UIViewController {
    var editView: EditView!
    var cardStatus: CardStatus
    var cardManager: CardManager
    
    init(cardManager: CardManager, cardStatus: CardStatus) {
        self.cardManager = cardManager
        self.cardStatus = cardStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.cardManager = CardManager()
        self.cardStatus = .toDO
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        
        if let viewFromXib = Bundle.main.loadNibNamed("EditView", owner: self)?.first as? EditView {
            self.editView = viewFromXib
            self.view.addSubview(editView)
            configureLayout()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandlers()
    }
    
    private func configureLayout() {
        editView.layer.cornerRadius = 10
        editView.layer.borderWidth = 1
        editView.layer.borderColor = UIColor.black.cgColor
        
        editView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            editView.widthAnchor.constraint(equalToConstant: 428),
            editView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

    private func setupHandlers() {
        self.editView.onOkTapped = { [weak self] title, content in
            self?.addNewCard(title: title, content: content)
        }

        self.editView.onCancelTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    private func addNewCard(title: String, content: String) {
        let newCard = ToDoCard(title: title, description: content, platform: "iOS", status: self.cardStatus)
        cardManager.addCard(newCard)
        dismiss(animated: true, completion: nil)
    }
}
