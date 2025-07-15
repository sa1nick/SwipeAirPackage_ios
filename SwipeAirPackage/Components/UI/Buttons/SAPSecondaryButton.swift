//
//  SAPSecondaryButton.swift
//  SwipeAirPackage
//
//  Created by apple on 08/07/25.
//

import UIKit

class SAPSecondaryButton: UIButton {

    private var onTap: (() -> Void)?

    init(
        title: String,
        backgroundColor: UIColor = UIColor(hex: "#FFF2E9"),
        titleColor: UIColor = UIColor.orangeFF6D09,
        height: CGFloat = 60,
        width: CGFloat? = nil,
        cornerRadius: CGFloat = 12,
        onTap: @escaping () -> Void
    ) {
        super.init(frame: .zero)

        self.onTap = onTap

        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.orangeFF6D09.cgColor
        self.titleLabel?.font = .jost(.medium, size: 16, scaled: true)

        translatesAutoresizingMaskIntoConstraints = false

        // Don't activate layout constraints inside the component — let the parent do it.
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onTap?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
