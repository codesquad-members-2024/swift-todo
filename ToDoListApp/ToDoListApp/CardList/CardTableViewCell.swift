//
//  CardTableViewCell.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/8/24.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView() {
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        cardBackgroundView.layer.cornerRadius = 10
        cardBackgroundView.clipsToBounds = true
        
    }
    
    func configure(with card: ToDoCard) {
        titleLabel.text = card.title
        descriptionLabel.text = card.description
        platformLabel.text = "author by \(card.platform)"
    }
}
