import UIKit

protocol TabButtonGroupViewDelegate: AnyObject {
    func didSelectTab(_ tab: TabButtonGroupView.TabType)
}

class TabButtonGroupView: UIView {
    weak var delegate: TabButtonGroupViewDelegate?
    var onTabChanged: ((TabType) -> Void)?

    enum TabType {
        case bookRide
        case sendPackage
    }

    private let buttonContainer = UIView()
    private let bookRideButton = UIButton(type: .custom)
    private let sendPackageButton = UIButton(type: .custom)
    private let spacerView = UIView()
    private var currentActiveTab: TabType = .bookRide

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupActions()
        updateTabAppearance() // Set initial appearance without async delay
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupActions()
        updateTabAppearance() // Set initial appearance without async delay
    }

    private func setupUI() {
        backgroundColor = .clear
        buttonContainer.backgroundColor = UIColor(hex: "F8AFFF")
        buttonContainer.layer.cornerRadius = 8
        buttonContainer.layer.masksToBounds = true

        setupButton(bookRideButton, title: "Book a Ride", imageName: "car")
        setupButton(sendPackageButton, title: "Send Package", imageName: "box")

        spacerView.backgroundColor = .white
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(buttonContainer)
        buttonContainer.addSubview(bookRideButton)
        buttonContainer.addSubview(spacerView)
        buttonContainer.addSubview(sendPackageButton)

        [buttonContainer, bookRideButton, sendPackageButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupButton(_ button: UIButton, title: String, imageName: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.jost(.semiBold, size: 16)
        button.backgroundColor = .clear

        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonContainer.topAnchor.constraint(equalTo: topAnchor),
            buttonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonContainer.heightAnchor.constraint(equalToConstant: 69),

            bookRideButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            bookRideButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            bookRideButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            bookRideButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.5, constant: -0.5), // Half width minus spacer

            spacerView.leadingAnchor.constraint(equalTo: bookRideButton.trailingAnchor),
            spacerView.widthAnchor.constraint(equalToConstant: 1),
            spacerView.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            spacerView.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),

            sendPackageButton.leadingAnchor.constraint(equalTo: spacerView.trailingAnchor),
            sendPackageButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            sendPackageButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
            sendPackageButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor)
        ])
    }

    private func setupActions() {
        bookRideButton.addTarget(self, action: #selector(bookRideButtonTapped), for: .touchUpInside)
        sendPackageButton.addTarget(self, action: #selector(sendPackageButtonTapped), for: .touchUpInside)
    }

    @objc private func bookRideButtonTapped() {
        currentActiveTab = .bookRide
        updateTabAppearance()
        onTabChanged?(.bookRide)
    }

    @objc private func sendPackageButtonTapped() {
        currentActiveTab = .sendPackage
        updateTabAppearance()
        onTabChanged?(.sendPackage)
    }

    private func updateTabAppearance() {
        [bookRideButton, sendPackageButton].forEach { $0.layer.sublayers?.removeAll(where: { $0.name == "bottomBorder" }) }
        let activeButton = currentActiveTab == .bookRide ? bookRideButton : sendPackageButton
        let border = CALayer()
        border.name = "bottomBorder"
        border.backgroundColor = UIColor(hex: "680172").cgColor
        border.frame = CGRect(x: 0, y: activeButton.bounds.height - 3, width: activeButton.bounds.width, height: 3)
        activeButton.layer.addSublayer(border)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateTabAppearance()
    }
}
