//
//  EditView.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/11/24.
//

import UIKit

class EditView: UIView {
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var onOkTapped: ((String, String) -> Void)?
    var onCancelTapped: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        content.delegate = self
        okButton.isEnabled = false
        
        content.layer.cornerRadius = 8
        content.layer.borderWidth = 1.0
        content.layer.borderColor = UIColor.systemGray5.cgColor
        
        okButton.layer.cornerRadius = 10
        okButton.layer.borderWidth = 1.0
        okButton.layer.borderColor = UIColor.black.cgColor
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.black.cgColor
        
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(didTapOK), for: .touchUpInside)
    }
    
    @objc private func didTapCancel() {
        onCancelTapped?()
    }
    
    @objc private func didTapOK() {
        if let title = title.text,
           let content = content.text {
            onOkTapped?(title, content)
        }
    }
}

extension EditView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)

        return updateText.count <= 500
    }
    
    func textViewDidChange(_ textView: UITextView) {
        okButton.isEnabled = textView.text.count <= 500 && !(textView.text.isEmpty) && !(title.text?.isEmpty ?? true)
    }
}
