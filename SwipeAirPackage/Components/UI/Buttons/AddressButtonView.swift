//
//  AddressButtonView.swift
//  SwipeAirPackage
//
//  Created by apple on 17/07/25.
//

import UIKit

class AddressButtonView: UIView {
    
    var tapAction: (() -> Void)?
    
    private let addressIconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F5F5F5")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        return view
    }()
    
    private let addressIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.jost(.semiBold, size: 18, scaled: true)
        label.textColor = .black
        return label
    }()
    
    private let addressDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.jost(.regular, size: 16, scaled: true)
        label.textColor = .grey7B7B7B
        label.numberOfLines = 0
        return label
    }()
    
    private let addressTextStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addressContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 13.75
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(title: String, detail: String, icon: UIImage?, tapAction: (() -> Void)? = nil) {
            super.init(frame: .zero)
            self.tapAction = tapAction
            translatesAutoresizingMaskIntoConstraints = false
            layer.borderWidth = 0.5
            layer.borderColor = UIColor(hex: "#BFBFBF").cgColor
            layer.cornerRadius = 10
            backgroundColor = .white
            
            addressIcon.image = icon
            addressTitleLabel.text = title
            addressDetailLabel.text = detail
            
            setupView()
            applyConstraints()
            setupTapGesture()
        }
    
    private func setupTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapGesture)
        }

        @objc private func handleTap() {
            tapAction?()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    private func setupView() {
        addressIconContainer.addSubview(addressIcon)
        addressTextStack.addArrangedSubview(addressTitleLabel)
        addressTextStack.addArrangedSubview(addressDetailLabel)
        addressContentStack.addArrangedSubview(addressIconContainer)
        addressContentStack.addArrangedSubview(addressTextStack)
        addSubview(addressContentStack)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            addressIconContainer.widthAnchor.constraint(equalToConstant: 36),
            addressIconContainer.heightAnchor.constraint(equalToConstant: 36),
            
            addressIcon.leadingAnchor.constraint(equalTo: addressIconContainer.leadingAnchor),
            addressIcon.trailingAnchor.constraint(equalTo: addressIconContainer.trailingAnchor),
            addressIcon.topAnchor.constraint(equalTo: addressIconContainer.topAnchor),
            addressIcon.bottomAnchor.constraint(equalTo: addressIconContainer.bottomAnchor),
            
            addressContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            addressContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            addressContentStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            addressContentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
}
