//
//  SAPButton.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 03/07/25.
//
import UIKit

class SAPButton: UIButton {

    private var actionHandler: (() -> Void)?
    private var originalTitle: String?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Public Loading State
    var isLoading: Bool = false {
        didSet {
            updateLoadingState()
        }
    }

    // MARK: - Initializer
    init(title: String,
         height: CGFloat = 60,
         action: @escaping () -> Void) {

        super.init(frame: .zero)
        self.actionHandler = action
        self.originalTitle = title
        setupUI(title: title, height: height)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UI Setup
    private func setupUI(title: String, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.title = title
        config.titleTextAttributesTransformer = .init { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.jost(.medium, size: 16)
            return outgoing
        }
        config.baseBackgroundColor = .purple680172
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

        self.configuration = config
        self.layer.cornerRadius = 12
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // Activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white // ✅ Force white color
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Button Action
    @objc private func buttonTapped() {
        if !isLoading {
            actionHandler?()
        }
    }

    // MARK: - Loading State Management
    private func updateLoadingState() {
        isUserInteractionEnabled = !isLoading

        if isLoading {
            originalTitle = self.configuration?.title

            // Remove title to make space
            var newConfig = self.configuration
            newConfig?.title = ""
            self.configuration = newConfig

            activityIndicator.startAnimating()
        } else {
            // Restore title
            var newConfig = self.configuration
            newConfig?.title = originalTitle
            self.configuration = newConfig

            activityIndicator.stopAnimating()
        }
    }

}
