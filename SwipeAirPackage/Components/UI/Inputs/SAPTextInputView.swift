//
//  SAPTextInputView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//
import UIKit

class SAPTextInputView: UIView {

    private let containerView = UIView()
    private let textField = UITextField()

    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
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

        // Container setup
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        containerView.layer.cornerRadius = 24
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true

        // TextField setup
        textField.borderStyle = .none
        textField.font = UIFont.jost(JostFontWeight.medium, size: 16, scaled: true)
        textField.textColor = .black // Set input text color to black
        // Set placeholder color to grey7B7B7B and font to Jost Regular
        var placeholder: String? {
            get { textField.placeholder }
            set {
                textField.placeholder = newValue // Required for `textField.placeholder` binding
                if let placeholderText = newValue {
                    textField.attributedPlaceholder = NSAttributedString(
                        string: placeholderText,
                        attributes: [
                            .foregroundColor: UIColor.grey7B7B7B,
                            .font: UIFont.jost(JostFontWeight.regular, size: 16, scaled: true)
                        ]
                    )
                }
            }
        }
        textField.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        containerView.addSubview(textField)
        addSubview(containerView)

        // Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
