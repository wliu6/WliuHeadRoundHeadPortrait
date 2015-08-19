//
//  WliuHeadPortraitImageView.swift
//  RoundHeadPortrait_swift
//
//  Created by 66 on 15/8/17.
//  Copyright (c) 2015年 w66. All rights reserved.
//

import UIKit
/// mask view's default background color
let W6_MaskViewDefaultBackgroundColor: UIColor = UIColor.clearColor()
/// mask view's default alpha
let W6_MaskViewDefaultAlpha: CGFloat = 0.0
let W6_CARendering_MinPoint: CGFloat = 2
struct WliuSquare : Equatable {
    var origin: CGPoint
    var lengthOfSide: CGFloat
    init(originArg: CGPoint ,lengthOfSideArg: CGFloat){
        origin = originArg
        lengthOfSide = lengthOfSideArg
    }
}
func ==(firstObj: WliuSquare, secondObj: WliuSquare) -> Bool {
    return (firstObj.origin == secondObj.origin) && (firstObj.lengthOfSide == secondObj.lengthOfSide)
}

@objc protocol WliuHeadPortraitViewDelegate: class {
    optional func isClicked()
}
@IBDesignable
class WliuHeadPortraitImageView: UIImageView {
    // MARK: private properties 
    internal var selfMaskView: UIView = UIView(frame: CGRectMake(0, 0, 0, 0))
    private let isLoadNib: Bool
//    private let cornerRadiusIsChanged: Bool
    private var isCustomCornerRadius: Bool
    private var selfCornerRadius: CGFloat = 0
    // MARK: public properties 
    @IBOutlet var delegate: WliuHeadPortraitViewDelegate!
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius < 0 {
                cornerRadius = 0
            }
            self.layer.cornerRadius = cornerRadius
            selfMaskView.layer.cornerRadius = cornerRadius
            isCustomCornerRadius = true;
        }
    }
    // MARK: -- default
    /// The color of the WliuHeadPortraitImageView's border
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    /// The width of the WliuHeadPortraitImageView's border.
    @IBInspectable var borderWidth: CGFloat  = 0 {
        didSet {
            if borderWidth < W6_CARendering_MinPoint {
                borderWidth = W6_CARendering_MinPoint
            }
            self.layer.borderWidth = borderWidth
        }
    }
    /// The alpha of WliuHeadPortraitImageView's mask view, you can used it when night theme...
    @IBInspectable var maskAlpha: CGFloat = 0 {
        didSet {
            if maskAlpha < 0 {
                maskAlpha = 0
            }
            if maskAlpha > 1 {
                maskAlpha = 1
            }
            selfMaskView.alpha = maskAlpha
        }
    }
    /// The background color of WliuHeadPortraitImageView's mask view, you can used it when night theme...
    @IBInspectable var maskBGColor: UIColor = UIColor.clearColor() {
        didSet {
            selfMaskView.backgroundColor = maskBGColor
        }
    }
    // MARK: -- highlight
    /// The width of the WliuHeadPortraitImageView's border in highlight status.
    @IBInspectable var highlightBorderWidth: CGFloat = 0 {
        didSet {
            if highlightBorderWidth < W6_CARendering_MinPoint {
                highlightBorderWidth = W6_CARendering_MinPoint
            }
        }
    }
    @IBInspectable var highlightBorderColor: UIColor = UIColor.clearColor()
    @IBInspectable var highlightMaskViewBGColor: UIColor = UIColor.clearColor()
    @IBInspectable var highlightMaskViewAlpha: CGFloat = 0 {
        didSet {
            if maskAlpha < 0 {
                maskAlpha = 0
            }
            if maskAlpha > 1 {
                maskAlpha = 1
            }
        }
    }
    // MARK: super class properties reset
    override var frame: CGRect {
        didSet {
            let reallyFrame:WliuSquare = self.reallyFrameAtBuild(frame)
            selfMaskView.frame = CGRectMake(0, 0, reallyFrame.lengthOfSide, reallyFrame.lengthOfSide)
            super.frame = CGRectMake(frame.minX, frame.minY, reallyFrame.lengthOfSide, reallyFrame.lengthOfSide)
            selfCornerRadius = reallyFrame.lengthOfSide / 2
            if !isCustomCornerRadius {
                self.layer.cornerRadius = selfCornerRadius
                selfMaskView.layer.cornerRadius = selfCornerRadius
            }
        }
    }
    // MARK: super class properties reset
    override func layoutSubviews() {
        super.layoutSubviews()
        if isLoadNib {
            let currentFrame: CGRect = self.frame
            self.frame = currentFrame
        }
    }
    // MARK: init
    required init(coder aDecoder: NSCoder) {
        isLoadNib = true
//        cornerRadiusIsChanged = false
        isCustomCornerRadius = false
        super.init(coder: aDecoder);
        self.layer.masksToBounds = true
        self.addSubview(selfMaskView)
        self.userInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        isLoadNib = false
//        cornerRadiusIsChanged = false
        isCustomCornerRadius = false
        super.init(frame: frame);
        self.layer.masksToBounds = true
        self.addSubview(selfMaskView)
        self.userInteractionEnabled = true
    }
    
    override init(image: UIImage!) {
        isLoadNib = false
//        cornerRadiusIsChanged = false
        isCustomCornerRadius = false
        super.init(image: image)
        self.addSubview(selfMaskView)
        self.layer.masksToBounds = true
        self.userInteractionEnabled = true
    }
    
    convenience init(frame: CGRect, boardWidth: CGFloat, boardColor: UIColor) {
        self.init(frame: frame)
        self.borderWidth = boardWidth
        self.borderColor = boardColor
        self.layer.borderWidth = boardWidth
        self.layer.borderColor = boardColor.CGColor
    }
    
    // MARK: touch observer method of 'UIResponder'  reset
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        let point: CGPoint = self.touchPoint(touches)
        if self.checkPointInRound(point, roundRadius: selfCornerRadius) {
            self.w6_configureHighlight()
        }
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        let point: CGPoint = self.touchPoint(touches)
        if self.checkPointInRound(point, roundRadius: selfCornerRadius) {
            self.w6_configureHighlight()
        }else {
            self.touchesCancelled(touches, withEvent: event)
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.w6_configureDefault()
        let point: CGPoint = self.touchPoint(touches)
        if self.checkPointInRound(point, roundRadius: selfCornerRadius) {
            delegate?.isClicked!()
        }
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        self.w6_configureDefault()
    }
    // MARK: own private methods
    private func reallyFrameAtBuild(frame : CGRect) ->WliuSquare {
        let lengthOfSide: CGFloat = frame.width >= frame.height ? frame.height : frame.width
        let point: CGPoint = CGPointMake((frame.minX + frame.maxX - lengthOfSide) / 2, (frame.minY + frame.maxY - lengthOfSide) / 2)
        let square: WliuSquare = WliuSquare(originArg: point, lengthOfSideArg: lengthOfSide)
        return square
    }
    private func checkPointInRound(point: CGPoint, roundRadius: CGFloat) -> Bool {
        var result: Bool = false
        let abstractCenter: CGPoint = CGPointMake(roundRadius, roundRadius)
        let diff_x: CGFloat = point.x - abstractCenter.x
        let diff_y: CGFloat = point.y - abstractCenter.y
        if isCustomCornerRadius {
            let diagonalRadius: CGFloat = roundRadius - self.cornerRadius
            result = (hypot(diagonalRadius, diagonalRadius) + self.cornerRadius >= hypot(diff_x, diff_y)) && (fabs(diff_x) > 0 || fabs(diff_x) > 0)
        }else {
            result = (roundRadius >= hypot(diff_x, diff_y))
        }
        return result
    }
    private func w6_configureDefault() {
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.borderWidth = self.borderWidth
        selfMaskView.alpha = self.maskAlpha
        selfMaskView.backgroundColor = self.maskBGColor
    }
    private func w6_configureHighlight() {
        self.layer.borderColor = self.highlightBorderColor.CGColor
        self.layer.borderWidth = self.highlightBorderWidth
        selfMaskView.alpha = self.highlightMaskViewAlpha
        selfMaskView.backgroundColor = self.highlightMaskViewBGColor
    }
    private func touchPoint(touches: Set<NSObject>) -> CGPoint {
        let touch: UITouch = touches.first as! UITouch
        let point: CGPoint = touch.locationInView(self)
        return point
    }
}

//extension WliuHeadPortraitImageView {
//    var wwwwww: CGFloat {
//        set (newWwwwww) {
//            println("\(newWwwwww)")
//        }
//        get {
//            return 222222
//        }
//    }
//}