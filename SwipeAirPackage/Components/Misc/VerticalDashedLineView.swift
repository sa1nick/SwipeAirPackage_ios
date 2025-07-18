//
//  VerticalDashedLineView.swift
//  SwipeAirPackage
//
//  Created by apple on 18/07/25.
//

import UIKit

class VerticalDashedLineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineDashPattern = [4, 4] // Dash length 4, gap length 4
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: 0))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.height))
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the path when the view's bounds change
        if let shapeLayer = layer.sublayers?.first as? CAShapeLayer {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX, y: 0))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.height))
            shapeLayer.path = path.cgPath
        }
    }
}
