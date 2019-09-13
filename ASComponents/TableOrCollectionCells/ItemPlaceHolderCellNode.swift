//
//  PlaceHolderCellNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 9/11/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public class ItemPlaceHolderCellNode:ASCellNode {
    public enum ViewType {
        case ImageTop
        case ImageLeft
        case ImageRight
    }
    
    public var lottieAnimNode: ASLottieAnimationViewNode?
    public var imageNode:ASImageNode = ASImageNode();
    public var titletNode:ASTextNode = ASTextNode()
    
    let preferredLayoutSize:ASLayoutSize;
    let imageLayoutSize:ASLayoutSize?
    let lottieAnimLayoutSize:ASLayoutSize?
    let viewType:ViewType;
    public init(backgroundColor:UIColor?, highlightedBackgroundColor:UIColor?, preferredLayoutSize:ASLayoutSize = ASLayoutSizeMake(ASDimensionMake("100%"), ASDimensionMake(44)),
                imageLayoutSize:ASLayoutSize? = nil, lottieAnimLayoutSize:ASLayoutSize? = nil, viewType:ViewType = ViewType.ImageTop) {
        self.preferredLayoutSize = preferredLayoutSize;
        self.imageLayoutSize = imageLayoutSize;
        self.lottieAnimLayoutSize = lottieAnimLayoutSize;
        self.viewType = viewType;
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true;
        self.titletNode.style.alignSelf = .center;
        self.titletNode.style.spacingBefore = 24
        self.titletNode.style.spacingAfter = 24
    }
    
    override public func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalLayout = ASStackLayoutSpec.horizontal()
        verticalLayout.justifyContent = .center
        verticalLayout.style.preferredLayoutSize = self.preferredLayoutSize;
        verticalLayout.children = [self.titletNode];
        return verticalLayout
    }
    
    deinit {
    }
}
