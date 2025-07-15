//
//  SAPOTPInputView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import UIKit

class SAPOTPInputView: UIStackView {

    private var textFields: [UITextField] = []
    var onOTPEntered: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        spacing = 8
        alignment = .center
        distribution = .fillProportionally

        for i in 0..<4 {
            let tf = createOTPField(tag: i)
            textFields.append(tf)
            addArrangedSubview(tf)

            if i == 1 {
                let dashLabel = UILabel()
                dashLabel.text = "-"
                dashLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                dashLabel.textColor = UIColor.gray
                dashLabel.textAlignment = .center
                dashLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
                addArrangedSubview(dashLabel)
            }
        }

        textFields.first?.becomeFirstResponder()
    }

    private func createOTPField(tag: Int) -> UITextField {
        let tf = UITextField()
        tf.tag = tag
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = .jost(.medium, size: 16)
        tf.layer.cornerRadius = 25
        tf.clipsToBounds = true
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tf.tintColor = UIColor.purple680172  // 👈 Cursor color
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.delegate = self

        tf.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        tf.addTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)

        return tf
    }
    
    

    func getOTP() -> String {
        return textFields.compactMap { $0.text }.joined()
    }

    func clearOTP() {
        textFields.forEach { $0.text = "" }
        textFields.first?.becomeFirstResponder()
    }

    @objc private func textChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }

        sender.text = String(text.prefix(1))

        let nextTag = sender.tag + 1
        if nextTag < textFields.count {
            textFields[nextTag].becomeFirstResponder()
        } else {
            sender.resignFirstResponder()
            onOTPEntered?(getOTP())
        }
    }

    @objc private func editingDidBegin(_ sender: UITextField) {
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.purple680172.cgColor
    }

    @objc private func editingDidEnd(_ sender: UITextField) {
        sender.layer.borderWidth = 0
    }
}

// MARK: - UITextFieldDelegate
extension SAPOTPInputView: UITextFieldDelegate {
    
    func shake(duration: CFTimeInterval = 0.4, pathLength: CGFloat = 8) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-pathLength, pathLength, -pathLength * 0.7, pathLength * 0.7, -pathLength * 0.4, pathLength * 0.4, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func shake() {
            self.shake(duration: 0.4, pathLength: 8)
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 1 { return false }

        if string.isEmpty {
            textField.text = ""
            if range.location == 0,
               let previous = viewWithTag(textField.tag - 1) as? UITextField {
                previous.becomeFirstResponder()
            }
            return false
        }


        textField.text = string
        textChanged(textField)
        return false
    }
}
