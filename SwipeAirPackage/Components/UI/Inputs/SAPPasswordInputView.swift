//
//  SAPPasswordInputView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 03/07/25.
//

import UIKit

class SAPPasswordInputView: UIView {

    private let containerView = UIView()
    private let textField = UITextField()
    private let toggleButton = UIButton(type: .system)

    private var isPasswordVisible = false

    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear

        // 🔲 Container setup
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        containerView.layer.cornerRadius = 24
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true

        // 🔒 TextField setup
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter Password"
        textField.font = UIFont.jost(JostFontWeight.regular, size: 16, scaled: true)
        textField.textColor = .black // Set input text color to black
        // Set placeholder text color to grey7B7B7B
        if let placeholderText = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [.foregroundColor: UIColor.grey7B7B7B]
            )
        }
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        // 👁 Toggle Button (eye icon)
        toggleButton.setImage(UIImage(named: "eye-slash"), for: .normal)
        toggleButton.tintColor = .black
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false

        // 📦 Add subviews
        containerView.addSubview(textField)
        containerView.addSubview(toggleButton)
        addSubview(containerView)

        // 📐 Constraints
        NSLayoutConstraint.activate([
            // Container
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // TextField
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor, constant: -8),

            // Toggle Button
            toggleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            toggleButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            toggleButton.widthAnchor.constraint(equalToConstant: 24),
            toggleButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func togglePasswordVisibility() {
            isPasswordVisible.toggle()
            textField.isSecureTextEntry = !isPasswordVisible
            let imageName = isPasswordVisible ? "eye" : "eye-slash"
            toggleButton.setImage(UIImage(named: imageName), for: .normal)
        }
}

