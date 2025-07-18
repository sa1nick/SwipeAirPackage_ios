import UIKit
import SwiftUI

class WelcomeContentViewController: UIViewController {

    var screenData: WelcomeScreen = .mock

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let logoImageView = UIImageView()
    private var titleSubtitleView: TitleSubtitleView!
    private var signInButton: SAPButton!
    private let stackView = UIStackView()
    private let metaImageView = UIImageView()
    private let appleImageView = UIImageView()
    private let googleImageView = UIImageView()
    private let termsTextView = UITextView()
    private let backgroundImageView = UIImageView()

    private let orDividerStack = UIStackView()
    private let orDividerLeftLine = UIView()
    private let orDividerLabel = UILabel()
    private let orDividerRightLine = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }


    private func setupUI() {
        view.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Logo
        logoImageView.image = screenData.logoImage
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImageView)

        // Background
        backgroundImageView.image = screenData.backgroundImage
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)

        // Title
        titleSubtitleView = TitleSubtitleView(title: screenData.titleText, subtitle: screenData.subtitleText)
        contentView.addSubview(titleSubtitleView)


        // Sign-In Button
        signInButton = SAPButton(title: "Sign In / Sign Up") { [weak self] in
            let signupVC = UIHostingController(rootView: SignUpScreenBridgeView())
            signupVC.modalPresentationStyle = .fullScreen
            self?.present(signupVC, animated: true)
        }

        signInButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signInButton)


        // OR Divider
        orDividerLeftLine.backgroundColor = .greyECECEC
        orDividerLeftLine.translatesAutoresizingMaskIntoConstraints = false
        orDividerLeftLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

        orDividerLabel.text = "or"
        orDividerLabel.textAlignment = .center
        orDividerLabel.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-SemiBold", size: 16)!)
        orDividerLabel.textColor = .black
        orDividerLabel.backgroundColor = .white

        orDividerRightLine.backgroundColor = .greyECECEC
        orDividerRightLine.translatesAutoresizingMaskIntoConstraints = false
        orDividerRightLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

        orDividerStack.axis = .horizontal
        orDividerStack.spacing = 8
        orDividerStack.alignment = .center
        orDividerStack.distribution = .fill
        orDividerStack.translatesAutoresizingMaskIntoConstraints = false
        orDividerStack.addArrangedSubview(orDividerLeftLine)
        orDividerStack.addArrangedSubview(orDividerLabel)
        orDividerStack.addArrangedSubview(orDividerRightLine)
        contentView.addSubview(orDividerStack)

        orDividerLeftLine.widthAnchor.constraint(equalTo: orDividerRightLine.widthAnchor).isActive = true

        // Social Icons
        metaImageView.image = screenData.metaIcon
        appleImageView.image = screenData.appleIcon
        googleImageView.image = screenData.googleIcon
        [metaImageView, appleImageView, googleImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(metaImageView)
        stackView.addArrangedSubview(appleImageView)
        stackView.addArrangedSubview(googleImageView)
        contentView.addSubview(stackView)

        // Terms with Links
        let termsText = "By Continuing, you agree to our Terms of Service and acknowledge our Privacy Notice."
        let attributedText = NSMutableAttributedString(string: termsText)
        let fullRange = NSRange(location: 0, length: termsText.count)

        // Paragraph style for center alignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        // Base font
        let baseFont = UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-Regular", size: 14)!)

        // Apply base attributes
        attributedText.addAttributes([
            .foregroundColor: UIColor.grey909090,
            .font: baseFont,
            .paragraphStyle: paragraphStyle
        ], range: fullRange)

        // "Terms of Service"
        if let termsRange = (termsText as NSString).range(of: "Terms of Service") as NSRange? {
            attributedText.addAttributes([
                .font: UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-SemiBold", size: 14)!),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .link: URL(string: "https://yourdomain.com/terms")!
            ], range: termsRange)
        }

        // "Privacy Notice"
        if let privacyRange = (termsText as NSString).range(of: "Privacy Notice") as NSRange? {
            attributedText.addAttributes([
                .font: UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-SemiBold", size: 14)!),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .link: URL(string: "https://yourdomain.com/privacy")!
            ], range: privacyRange)
        }

        // Assign to UITextView
        termsTextView.attributedText = attributedText
        termsTextView.textAlignment = .center // optional, already handled by paragraphStyle


        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.attributedText = attributedText
        termsTextView.isEditable = false
        termsTextView.isScrollEnabled = false
        termsTextView.textAlignment = .center
        termsTextView.backgroundColor = .clear
        termsTextView.dataDetectorTypes = [.link]
        termsTextView.linkTextAttributes = [.foregroundColor: UIColor.black]
        contentView.addSubview(termsTextView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 218),
            logoImageView.heightAnchor.constraint(equalToConstant: 42),

            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 220.29),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -64.37),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 530.82),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 360.71),

            titleSubtitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 180),
            titleSubtitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleSubtitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signInButton.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 16),
            signInButton.heightAnchor.constraint(equalToConstant: 60),

            // Optional: cap maximum width to 382pt
            signInButton.widthAnchor.constraint(lessThanOrEqualToConstant: 382),

            orDividerStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            orDividerStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            orDividerStack.widthAnchor.constraint(equalToConstant: 413.89),
            orDividerStack.heightAnchor.constraint(equalToConstant: 20),

            stackView.topAnchor.constraint(equalTo: orDividerStack.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 65),

            metaImageView.widthAnchor.constraint(equalToConstant: 65),
            appleImageView.widthAnchor.constraint(equalToConstant: 65),
            googleImageView.widthAnchor.constraint(equalToConstant: 65),

            termsTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 17),
            termsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            termsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            termsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
