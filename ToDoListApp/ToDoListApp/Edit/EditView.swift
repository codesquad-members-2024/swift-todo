//
//  EditView.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/11/24.
//

import UIKit

class EditView: UIView {
    enum Mode {
        case add
        case edit(ToDoCard)
    }
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var onOkTapped: ((String, String) -> Void)?
    var onCancelTapped: (() -> Void)?
    
    let placeholderText = "상세 내용을 입력해주세요"
    var mode: Mode = .add
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func configure(with mode: Mode) {
        self.mode = mode
        setupMode()
    }
    
    private func setupMode() {
        switch mode {
        case .add:
            aboutLabel.text = "새 카드 추가하세용"
            title.text = ""
            content.text = placeholderText
        case .edit(let card):
            aboutLabel.text = "카드 수정하기"
            title.text = card.title
            content.text = card.descriptionText
            content.textColor = .black
        }
        updateButtonStyle()
    }
    
    private func setupView() {
        content.delegate = self
        okButton.isEnabled = false
        
        content.text = placeholderText
        content.textColor = .lightGray
        content.layer.cornerRadius = 8
        content.layer.borderWidth = 1.0
        content.layer.borderColor = UIColor.systemGray5.cgColor
        
        okButton.layer.cornerRadius = 10
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.black.cgColor
        
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(didTapOK), for: .touchUpInside)
    }
    
    private func updateButtonStyle() {
        let isEnabled = !(content.text.isEmpty || content.text == placeholderText) && !(title.text?.isEmpty ?? true)
        okButton.isEnabled = isEnabled
        okButton.backgroundColor = isEnabled ? .black : .systemGray3
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let isEnabled = textView.text.count <= 500 && !(textView.text.isEmpty) && !(title.text?.isEmpty ?? true)
        okButton.isEnabled = isEnabled
        updateButtonStyle()
    }
}
