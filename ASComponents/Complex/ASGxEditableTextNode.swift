//
//  ASGxEditableTextNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 7/23/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public protocol ASGxEditableTextNodeProtocol {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
}

public class ASGxEditableTextNode: ASDisplayNode, ASEditableTextNodeDelegate {
    public var delegate: ASGxEditableTextNodeProtocol?
    /// Default is 0 or unlimited
    public var maxTextLength: Int = 0;
    public var textViewInset: UIEdgeInsets = .zero
    public let textNode:ASEditableTextNode = ASEditableTextNode()
    public override init(){
        super.init()
        self.automaticallyManagesSubnodes = true
        self.isUserInteractionEnabled = true
        self.textNode.delegate = self;
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.vertical()
        //layout.style.flexGrow = 1;
        layout.style.minHeight = self.style.minHeight
        layout.justifyContent = .center
        layout.children = [ASInsetLayoutSpec(insets: self.textViewInset, child: self.textNode)]
        return layout
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touchPoint = touches.first?.location(in: self.view) else { return }
        guard self.bounds.contains(touchPoint) else { return }
        self.textNode.becomeFirstResponder()
    }
    
    
    public func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.maxTextLength > 0 {
            if (text.rangeOfCharacter(from: CharacterSet.alphanumerics) != nil || text.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil) {
                if editableTextNode.attributedText?.string.count ?? 0 > self.maxTextLength {
                    return false
                }
            }
        }
        return self.delegate?.editableTextNode(editableTextNode, shouldChangeTextIn: range, replacementText: text) ?? true
    }
}
