//
//  CallKitKeypadDigitButtonViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 5/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public class CallKitKeypadDigitButtonViewNode:ASButtonNode {
    @objc public var onTouchUpInside:((_ sender:CallKitKeypadDigitButtonViewNode) -> ())?
    let largeTextNode:ASTextNode2 = ASTextNode2()
    let smallTextNode:ASTextNode2 = ASTextNode2()
    let iconImageNode:ASImageNode = ASImageNode()
    let image:UIImage?
    let normalBackgroundColor:UIColor
    let highlightBackgroundColor:UIColor
    public var digitCode:Int
    
    
    public init(digit:Int, iconImage:UIImage? = nil, largeAttributedText:NSAttributedString? = nil, smallAttributedText:NSAttributedString? = nil, backgroundColor:UIColor, highlightBackgroundColor:UIColor) {
        self.normalBackgroundColor = backgroundColor
        self.highlightBackgroundColor = highlightBackgroundColor
        self.image = iconImage
        self.digitCode = digit
        super.init()
        self.automaticallyManagesSubnodes = true
        
        self.backgroundColor = backgroundColor
        self.largeTextNode.attributedText = largeAttributedText
        self.smallTextNode.attributedText = smallAttributedText
        
        self.largeTextNode.style.alignSelf = .center
        self.smallTextNode.style.alignSelf = .center
        
        self.iconImageNode.image = self.image
        self.iconImageNode.contentMode = .scaleAspectFit
        self.iconImageNode.forceUpscaling = true
        
        self.addTarget(self, action: #selector(onTouchUpInsidePrivate), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    @objc private func onTouchUpInsidePrivate( _ sender:CallKitKeypadDigitButtonViewNode){
        self.onTouchUpInside?(self);
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.vertical()
        layout.justifyContent = .center
        layout.alignContent = .center
        layout.spacing = -5
        layout.style.flexShrink = 1
        
        if let _ = image {
            layout.child = self.iconImageNode
        }else{
            layout.children = [self.largeTextNode, self.smallTextNode]
        }
        self.cornerRadius = constrainedSize.max.width/2
        return layout
    }
    
    
    public override var isEnabled:Bool{
        didSet{
            self.alpha = self.isEnabled ? 1 : 0.6
            if !self.isEnabled {
                self.m_isHighlighted = false
            }
        }
    }
    
    public override var isHighlighted: Bool {
        didSet{
            if oldValue != isHighlighted {
                m_isHighlighted = isHighlighted
            }
        }
    }
    
    private var m_isHighlighted:Bool = false {
        didSet{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                let originalColor: UIColor? =  strongSelf.backgroundColor
                var newColor:UIColor? = strongSelf.normalBackgroundColor;
                if strongSelf.m_isHighlighted {
                    newColor = strongSelf.highlightBackgroundColor
                }
                /// CABasicAnimation prevents lag of UIView.animation
                strongSelf.backgroundColor = newColor
                let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
                colorAnimation.fromValue = originalColor?.cgColor
                colorAnimation.duration = 0.3
                colorAnimation.autoreverses = false
                colorAnimation.repeatCount = 0
                colorAnimation.isRemovedOnCompletion = true
                self?.view.layer.add(colorAnimation, forKey: "ColorPulse")
 
            }
        }
    }
    
    /*
    private func isInsideSelf(touches:Set<UITouch>, event:UIEvent?) -> Bool{
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if self.bounds.contains(location) { return true }
        }
        return false
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = true
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchInInside?(self)
        }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
         if !self.isEnabled { return }
        if self.isInsideSelf(touches: touches, event: event) {
            m_isHighlighted = true
        }else{
            m_isHighlighted = false
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
         if !self.isEnabled { return }
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchUpInside?(self)
        }
        m_isHighlighted = false
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
    }
    */
    
}
