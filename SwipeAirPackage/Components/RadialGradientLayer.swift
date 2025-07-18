//
//  RadialGradientLayer.swift
//  SwipeAirPackage
//
//  Created by apple on 15/07/25.
//

import UIKit

class RadialGradientLayer: CALayer {
    var colors: [CGColor] = []
    var startCenter: CGPoint = .zero
    var startRadius: CGFloat = 0
    var endRadius: CGFloat = 200

    override func draw(in ctx: CGContext) {
        guard let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors as CFArray,
            locations: [0, 1]
        ) else {
            return
        }

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        ctx.drawRadialGradient(
            gradient,
            startCenter: center,
            startRadius: startRadius,
            endCenter: center,
            endRadius: endRadius,
            options: .drawsAfterEndLocation
        )
    }
}
