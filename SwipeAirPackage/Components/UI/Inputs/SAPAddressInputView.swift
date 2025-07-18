import UIKit

class SAPAddressInputView: UIView, UITextFieldDelegate {
    
    private let placeholderLabel = UILabel()
    private let textField = UITextField()
    private var placeholderCenterYConstraint: NSLayoutConstraint!
    private var placeholderTopConstraint: NSLayoutConstraint!
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 22
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        placeholderLabel.font = UIFont.jost(.regular, size: 16, scaled: true)
        placeholderLabel.textColor = UIColor.grey7B7B7B
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.jost(.medium, size: 16, scaled: true)
        textField.textColor = .black
        textField.tintColor = UIColor.purple680172
        textField.borderStyle = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderLabel)
        addSubview(textField)
    }

    private func setupConstraints() {
        // Placeholder constraints: centerY for default, top for floated
        placeholderCenterYConstraint = placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        placeholderTopConstraint = placeholderLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -2) // 2-point gap when floated
        
        // Activate centerY constraint by default
        placeholderCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // Placeholder horizontal constraints
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            placeholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            // TextField constraints
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2) // 2-point bottom margin
        ])
    }

    // MARK: - Floating Placeholder Logic
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animatePlaceholder(up: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animatePlaceholder(up: false) // Always return to centered position
    }

    private func animatePlaceholder(up: Bool) {
        // Toggle between centerY and top constraints
        placeholderCenterYConstraint.isActive = !up
        placeholderTopConstraint.isActive = up
        
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.font = up ? UIFont.jost(.regular, size: 14, scaled: true) : UIFont.jost(.regular, size: 16, scaled: true)
            self.layoutIfNeeded()
        }
    }
    
    func getText() -> String? {
        return textField.text
    }
    
    func setText(_ text: String) {
        textField.text = text
        animatePlaceholder(up: !text.isEmpty) // Float if text is present on set
    }
}
