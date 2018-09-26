//
//  BorderedView.swift
//
//  Created by Hernan Paez on 9/6/15.
//  Copyright © 2015 Infinixsoft. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedView: UIView {
    
    @IBInspectable var bottomLeftCornerRadius:CGFloat = 0.0
    @IBInspectable var bottomRightCornerRadius:CGFloat = 0.0
    @IBInspectable var topLeftCornerRadius:CGFloat = 0.0
    @IBInspectable var topRightCornerRadius:CGFloat = 0.0
    @IBInspectable var borderColor:UIColor? = nil
    @IBInspectable var borderWidth:CGFloat = 0.0

    private var borderView:UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBorder()
    }
    
    func setupBorder() {
        let rect = self.bounds
        let path = UIBezierPath()
        
        if bottomLeftCornerRadius != 0 {
            path.move(to: CGPoint(x: bottomLeftCornerRadius, y: rect.size.height))
            path.addArc(withCenter: CGPoint(x: bottomLeftCornerRadius, y: rect.size.height - bottomLeftCornerRadius), radius: bottomLeftCornerRadius, startAngle: -270 * CGFloat.pi/180, endAngle: -180 * CGFloat.pi/180, clockwise: true)
        }
        else {
            path.move(to: CGPoint(x: 0, y: rect.size.height))
        }
        
        if topLeftCornerRadius != 0 {
            path.addLine(to: CGPoint(x: 0, y: topLeftCornerRadius))
            path.addArc(withCenter: CGPoint(x: topLeftCornerRadius, y: topLeftCornerRadius), radius: topLeftCornerRadius, startAngle: -180 * CGFloat.pi/180, endAngle: -90 * CGFloat.pi/180, clockwise: true)
        }
        else {
            path.addLine(to: CGPoint.zero)
        }
        
        if topRightCornerRadius != 0 {
            path.addLine(to: CGPoint(x: rect.size.width - topRightCornerRadius, y: 0))
            path.addArc(withCenter: CGPoint(x: rect.size.width - topRightCornerRadius, y: topRightCornerRadius), radius: topRightCornerRadius, startAngle: -90 * CGFloat.pi/180, endAngle: 0 * CGFloat.pi/180, clockwise: true)
        }
        else {
            path.addLine(to: CGPoint(x: rect.size.width, y:0))
        }
        
        if bottomRightCornerRadius != 0 {
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height - bottomRightCornerRadius))
            path.addArc(withCenter: CGPoint(x: rect.size.width - bottomRightCornerRadius, y: rect.size.height - bottomRightCornerRadius), radius: bottomRightCornerRadius, startAngle: 0 * CGFloat.pi/180, endAngle: 90 * CGFloat.pi/180, clockwise: true)
        }
        else {
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        }
        
        if bottomLeftCornerRadius != 0 {
            path.addLine(to: CGPoint(x: bottomLeftCornerRadius, y: rect.size.height))
        }
        else {
            path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        }
        
        let cornerMaskLayer = CAShapeLayer()
        cornerMaskLayer.path = path.cgPath
        self.layer.mask = cornerMaskLayer
        
        let borderMask = CAShapeLayer()
        borderMask.path = path.cgPath
        borderMask.fillColor = UIColor.clear.cgColor
        borderMask.strokeColor = borderColor?.cgColor
        borderMask.lineWidth = borderWidth
        
        borderView?.removeFromSuperview()
        borderView = UIView(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        borderView?.isUserInteractionEnabled = false
        borderView?.layer.addSublayer(borderMask)
        self.addSubview(borderView!)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupBorder()
    }    

}
