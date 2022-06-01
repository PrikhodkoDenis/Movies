//
//  GradientView.swift
//  Movies
//
//  Created by Denis on 19.05.2022.
//

import Foundation
import UIKit

extension GradientView {
    
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing
        
        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
}

class GradientView: UIView {
    
    private var startColor: UIColor? {
        didSet {
            setupGradientColors(startColor: startColor, endColor: endColor)
        }
    }
    
    private var endColor: UIColor? {
        didSet {
            setupGradientColors(startColor: startColor, endColor: endColor)
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    convenience init(from: Point, to: Point, inColor: UIColor?, toColor: UIColor?) {
        self.init()
        setupGradient(from: from, to: to, inColor: inColor, toColor: toColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient(from: .leading, to: .trailing, inColor: startColor, toColor: endColor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

private extension GradientView {
    
    func setupGradient(from: Point, to: Point, inColor: UIColor?, toColor: UIColor?) {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors(startColor: inColor, endColor: toColor)
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = to.point
    }
    
    func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}
