import UIKit
import CountryPickerView

class SAPPhoneInputView: UIView {

    private let containerView = UIView()
    private let flagImageView = UIImageView()
    private let verticalSeparator = UIView()
    private let countryCodeLabel = UILabel()
    private let phoneTextField = UITextField()
    private let cpv = CountryPickerView()
    private let mainStackView = UIStackView()
    private let countryStack = UIStackView()
    private let countryContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        cpv.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        cpv.delegate = self
    }

    public var placeholder: String? {
        get { phoneTextField.placeholder }
        set { phoneTextField.placeholder = newValue }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50)
    }

    private func setupUI() {
        backgroundColor = .clear

        // Container styling
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        containerView.layer.cornerRadius = 24
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Flag
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true

        // Separator
        verticalSeparator.backgroundColor = .lightGray
        verticalSeparator.translatesAutoresizingMaskIntoConstraints = false
        verticalSeparator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalSeparator.heightAnchor.constraint(equalToConstant: 17).isActive = true

        // Country code
        countryCodeLabel.font = UIFont.jost(JostFontWeight.medium, size: 13, scaled: true)
        countryCodeLabel.textColor = .black
        countryCodeLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryCodeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        // Country Stack (Flag + Code + Separator)
        countryStack.axis = .horizontal
        countryStack.spacing = 5
        countryStack.alignment = .center
        countryStack.translatesAutoresizingMaskIntoConstraints = false
        countryStack.addArrangedSubview(flagImageView)
        countryStack.addArrangedSubview(countryCodeLabel)
        countryStack.addArrangedSubview(verticalSeparator)

        // Country Container
        countryContainer.addSubview(countryStack)
        countryContainer.isUserInteractionEnabled = true
        countryContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCountryPicker)))
        countryContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryStack.leadingAnchor.constraint(equalTo: countryContainer.leadingAnchor),
            countryStack.trailingAnchor.constraint(equalTo: countryContainer.trailingAnchor),
            countryStack.topAnchor.constraint(equalTo: countryContainer.topAnchor),
            countryStack.bottomAnchor.constraint(equalTo: countryContainer.bottomAnchor)
        ])

        // Phone TextField
        phoneTextField.placeholder = "Enter Phone Number"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.font = UIFont.jost(JostFontWeight.medium, size: 16, scaled: true)
        phoneTextField.textColor = .black // Set input text color to black
        // Set placeholder color to grey7B7B7B and font to Jost Regular
        if let placeholderText = phoneTextField.placeholder {
            phoneTextField.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [
                    .foregroundColor: UIColor.grey7B7B7B,
                    .font: UIFont.jost(JostFontWeight.regular, size: 16, scaled: true)
                ]
            )
        }
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false

        // Main Stack
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 17.5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(countryContainer)
        mainStackView.addArrangedSubview(phoneTextField)

        containerView.addSubview(mainStackView)
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        updateCountryUI(country: cpv.getCountryByCode("US"))
    }

    @objc private func showCountryPicker() {
        if let topVC = UIApplication.shared.topMostViewController() {
            cpv.showCountriesList(from: topVC)
        }
    }

    private func updateCountryUI(country: CPVCountry?) {
        guard let country = country else { return }
        flagImageView.image = country.flag
        countryCodeLabel.text = country.phoneCode
    }

    public func getFullPhoneNumber() -> String {
        return "\(countryCodeLabel.text ?? "") \(phoneTextField.text ?? "")"
    }
}

extension SAPPhoneInputView: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: CPVCountry) {
        updateCountryUI(country: country)
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return nil
        }

        var topController = rootViewController
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
