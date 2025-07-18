//
//  FloatingPlaceholderTextField.swift
//  SwipeAirPackage
//
//  Created by apple on 18/07/25.
//
import UIKit
class FloatingPlaceholderTextField: UIView {

    private let textField = UITextField()
    private let floatingLabel = UILabel()
    private var isFloating = false

    var font: UIFont? {
        get { return textField.font }
        set { textField.font = newValue }
    }

    init(placeholder: String) {
        super.init(frame: .zero)
        floatingLabel.text = placeholder
        textField.placeholder = placeholder
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        floatingLabel.font = UIFont.jost(.medium, size: 14)
        floatingLabel.textColor = .gray
        floatingLabel.alpha = 0
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        addSubview(floatingLabel)
        addSubview(textField)

        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            floatingLabel.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.topAnchor.constraint(equalTo: floatingLabel.bottomAnchor, constant: 2)
        ])
    }

    @objc private func textDidChange() {
        let shouldFloat = !(textField.text?.isEmpty ?? true)
        animateFloatingLabel(shouldFloat)
    }

    private func animateFloatingLabel(_ float: Bool) {
        guard float != isFloating else { return }
        isFloating = float
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = float ? 1 : 0
            self.floatingLabel.transform = float ? CGAffineTransform(translationX: 0, y: -20) : .identity
        }
    }
}
