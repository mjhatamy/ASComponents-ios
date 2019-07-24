//
//  ASGxEditableTextNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 7/23/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public class ASGxEditableTextNode: ASTextNode {
    public var textViewInset: UIEdgeInsets = .zero
    public let textNode:ASEditableTextNode = ASEditableTextNode()
    public override init(){
        super.init()
        self.automaticallyManagesSubnodes = true
        self.isUserInteractionEnabled = true
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.vertical()
        //layout.style.flexGrow = 1;
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
}
