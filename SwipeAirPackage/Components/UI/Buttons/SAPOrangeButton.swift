//
//  SAPOrangeButton.swift
//  SwipeAirPackage
//
//  Created by apple on 18/07/25.
//

import UIKit

class SAPOrangeButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(title: "")
    }

    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.jost(.medium, size: 18)
        backgroundColor = UIColor(hex: "#FF6D09")
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        contentEdgeInsets = UIEdgeInsets(top: 17, left: 83, bottom: 17, right: 83)
    }
}
