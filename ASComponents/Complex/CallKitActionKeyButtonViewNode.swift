//
//  CallKitActionKeyButtonViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 5/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public final class CallKitActionKeyButtonViewNode:ASDisplayNode {
    public var type:String
    
    public final class CallKitButtonIconContainerNode:ASDisplayNode {
        var isSelected:Bool = false {
            didSet{ self.updateImage() }
        }
        
        public var isEnabled:Bool = true {
            didSet{ self.updateImage() }
        }
        
        let imageNode:ASImageNode = ASImageNode()

        var iconImage:UIImage?
        var iconImageSelected:UIImage?
        var iconImageDisabled:UIImage?
        
        public init(_ iconImage:UIImage?,
                    _ iconImageSelected:UIImage?,
                    _ iconImageDisabled:UIImage?) {
            self.iconImage = iconImage
            self.iconImageSelected = iconImageSelected
            self.iconImageDisabled = iconImageDisabled
            super.init()
            self.automaticallyManagesSubnodes = true
            
            self.imageNode.style.alignSelf = .center
            self.imageNode.image = iconImage
            //self.imageNode.forceUpscaling = true
            self.imageNode.contentMode = .center
            
            
            self.updateImage()
        }
        
        fileprivate func updateImage(){
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                let newImage = strongSelf.isEnabled ?
                    (strongSelf.isSelected ? (strongSelf.iconImageSelected ?? strongSelf.iconImage) : strongSelf.iconImage)
                    :  (strongSelf.iconImageDisabled ?? strongSelf.iconImage)
                
                strongSelf.imageNode.image = newImage
            }
        }
        
        public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
            let layout = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: [], child: self.imageNode)
            layout.style.preferredSize = constrainedSize.max
            self.imageNode.style.preferredSize = CGSize(width: constrainedSize.max.width/2, height: constrainedSize.max.height/2)
            return layout
        }
        
        func setValues(_ iconImage:UIImage?,
                       _ iconImageSelected:UIImage?,
                       _ iconImageDisabled:UIImage?) {
            self.iconImage = iconImage
            self.iconImageSelected = iconImageSelected
            self.iconImageDisabled = iconImageDisabled
            self.updateImage()
        }
    }
    
    
    public var onTouchUpInside:((_ sender:CallKitActionKeyButtonViewNode) -> ())?
    
    let iconContainerNode:CallKitButtonIconContainerNode
    let labelNode:ASTextNode2 = ASTextNode2()
    let normalBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.2)
    let highlightBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.5)
    let selectedBackgroundColor:UIColor = UIColor(white: 1, alpha: 1.0)
    
    var titleAttributedStringSelected:NSAttributedString?
    var titleAttributedStringDisabled:NSAttributedString?
    var titleAttributedString:NSAttributedString?
    
    public init(_ iconImage:UIImage?,
                _ iconImageSelected:UIImage?,
                _ iconImageDisabled:UIImage?,
                _ titleAttributedString:NSAttributedString?,
                _ titleAttributedStringSelected:NSAttributedString? = nil,
                _ titleAttributedStringDisabled:NSAttributedString? = nil, type:String = "default") {
        self.titleAttributedString = titleAttributedString
        self.titleAttributedStringSelected = titleAttributedStringSelected
        self.titleAttributedStringDisabled = titleAttributedStringDisabled
        self.iconContainerNode = CallKitButtonIconContainerNode(iconImage, iconImageSelected, iconImageDisabled)
        self.type = type
        super.init()
        self.automaticallyManagesSubnodes = true
        self.labelNode.attributedText = titleAttributedString
        self.iconContainerNode.backgroundColor = self.normalBackgroundColor
        
        self.updateText()
    }
    
    
    public func setValues(_ iconImage:UIImage?,
                _ iconImageSelected:UIImage?,
                _ iconImageDisabled:UIImage?,
                _ titleAttributedString:NSAttributedString,
                _ titleAttributedStringSelected:NSAttributedString? = nil,
                _ titleAttributedStringDisabled:NSAttributedString? = nil, type:String = "default" ){
        self.titleAttributedString = titleAttributedString
        self.titleAttributedStringSelected = titleAttributedStringSelected
        self.titleAttributedStringDisabled = titleAttributedStringDisabled
        
        self.iconContainerNode.setValues(iconImage, iconImageSelected, iconImageDisabled)
        self.type = type
        
        self.updateBackgoundColor()
        
        self.updateText()
        
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.iconContainerNode.invalidateCalculatedLayout()
        }
    }
    
    fileprivate func updateText(){
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.labelNode.attributedText = strongSelf.isEnabled ? ( strongSelf.isSelected ? (strongSelf.titleAttributedStringSelected ?? strongSelf.titleAttributedString) : strongSelf.titleAttributedString ) :
                (strongSelf.titleAttributedStringDisabled ?? strongSelf.titleAttributedString )
        }
        
    }
    
    fileprivate func updateBackgoundColor(){
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.iconContainerNode.backgroundColor = strongSelf.isEnabled ?
                (strongSelf.isSelected ? strongSelf.selectedBackgroundColor : strongSelf.normalBackgroundColor) : strongSelf.normalBackgroundColor
        }
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width:CGFloat = min(constrainedSize.max.width, constrainedSize.max.height)
        let verticalLayout = ASStackLayoutSpec.vertical()
        verticalLayout.justifyContent = .start
        verticalLayout.alignContent = .center
        self.labelNode.style.alignSelf = .center
        
        self.iconContainerNode.style.preferredSize = CGSize(width: width, height: width)
        self.iconContainerNode.cornerRadius = width/2
        
        verticalLayout.spacing = 6
        verticalLayout.children = [self.iconContainerNode, self.labelNode]
        
        return verticalLayout
    }
    
    public var isSelected:Bool = false {
        didSet {
            if self.isSelected == oldValue { return }
            self.iconContainerNode.isSelected = self.isSelected
            self.updateBackgoundColor()
            self.updateText()
        }
    }
    
    public var isEnabled:Bool =  true {
        didSet{
            if self.isEnabled == oldValue { return }
            self.iconContainerNode.isEnabled = self.isEnabled
            self.updateBackgoundColor()
            self.updateText()
        }
    }
    
    private var m_isHighlighted:Bool = false {
        didSet{
            if self.m_isHighlighted == oldValue { return }
            if self.isSelected || !self.isEnabled { return }
            SWKQueue.mainQueue().async { [weak self] in
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    if self?.m_isHighlighted ?? false {
                        self?.iconContainerNode.backgroundColor = self?.highlightBackgroundColor
                    }else{
                        self?.iconContainerNode.backgroundColor = self?.normalBackgroundColor
                    }
                })
            }
        }
    }
    
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
        m_isHighlighted = false
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchUpInside?( self )
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
    }
}



