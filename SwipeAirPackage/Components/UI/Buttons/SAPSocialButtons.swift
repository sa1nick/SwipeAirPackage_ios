//
//  SAPSocialButtons.swift
//  SwipeAirPackage
//
//  Created by Nikhil on 03/07/25.
//

import UIKit

class SAPSocialButtons: UIStackView {

    var onMetaTap: (() -> Void)?
    var onAppleTap: (() -> Void)?
    var onGoogleTap: (() -> Void)?

    private let metaImageView = UIImageView()
    private let appleImageView = UIImageView()
    private let googleImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        axis = .horizontal
        spacing = 24
        alignment = .center
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false

        setupIcon(metaImageView, imageName: "metaIcon", selector: #selector(metaTapped))
        setupIcon(appleImageView, imageName: "appleIcon", selector: #selector(appleTapped))
        setupIcon(googleImageView, imageName: "googleIcon", selector: #selector(googleTapped))
    }

    private func setupIcon(_ imageView: UIImageView, imageName: String, selector: Selector) {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 65).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        imageView.addGestureRecognizer(tapGesture)
        addArrangedSubview(imageView)
    }

    @objc private func metaTapped() {
        onMetaTap?()
    }

    @objc private func appleTapped() {
        onAppleTap?()
    }

    @objc private func googleTapped() {
        onGoogleTap?()
    }
}
