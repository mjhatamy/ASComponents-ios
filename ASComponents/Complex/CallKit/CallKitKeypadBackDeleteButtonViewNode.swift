//
//  CallKitKeypadBackDeleteButtonViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 8/1/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import GXUIKitExtensions
import AsyncDisplayKit

public class CallKitKeypadBackDeleteButtonViewNode: ASDisplayNode {
    let iconImageNode:ASImageNode = ASImageNode()
    let textNode:ASTextNode2 = ASTextNode2();
    let imageColor:UIColor
    let contentInset:UIEdgeInsets
    
    public init( image: UIImage?,  textFont:UIFont, textColor:UIColor, imageColor: UIColor,  imageSize: CGSize, contentInset:UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)) {
        self.imageColor = imageColor;
        self.contentInset = contentInset;
        super.init()
        self.automaticallyManagesSubnodes = true;
        self.iconImageNode.image = image;
        
        self.textNode.attributedText = "X".attributedString(textColor, font: textFont, alignment: .center, backgroundColor: nil);
        
        self.iconImageNode.style.alignSelf = .center
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASAbsoluteLayoutSpec();
        
        var imageSizeRaw = CGSize(width: constrainedSize.max.width, height: ((constrainedSize.max.width * 75)/102))
        imageSizeRaw.width -= self.contentInset.left + self.contentInset.right
        imageSizeRaw.height -= self.contentInset.top + self.contentInset.bottom
        
        LOGD("constrainedSize::> \(constrainedSize.max)  width:\(imageSizeRaw.width)  height:\(imageSizeRaw.height)")
        
        let xPointCenter = (constrainedSize.max.width - (imageSizeRaw.width))/2
        let yPointCenter = (constrainedSize.max.height - (imageSizeRaw.height))/2
        
        self.iconImageNode.style.layoutPosition = CGPoint(x: xPointCenter, y: yPointCenter)
        self.textNode.style.layoutPosition = CGPoint(x: xPointCenter + 14, y: yPointCenter + 6)
        self.iconImageNode.style.preferredLayoutSize = ASLayoutSizeMake(ASDimensionMake(imageSizeRaw.width), ASDimensionMake(imageSizeRaw.height))
        
        layout.children = [ self.iconImageNode, self.textNode ]
        return layout;
    }
}
