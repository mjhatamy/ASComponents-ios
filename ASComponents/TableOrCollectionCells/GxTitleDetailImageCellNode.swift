//
//  GxTitleDetailImageCellNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 9/11/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public class GxTitleDetailImageCellNode: ASCellNode {
    
    public enum ViewType {
        case LeftDetail
        case RightDetail
        case Subtitle
    }
    
    public var imageNode:ASImageNode = ASImageNode()
    public var textNode:ASTextNode = ASTextNode()
    public var detailTextNode:ASTextNode = ASTextNode()
    public var preferredLayoutSize:ASLayoutSize;
    private let viewType:ViewType
    
    private let highlightedBackgroundColor:UIColor?
    private let imageLayoutSize:ASLayoutSize;
    public init( backgroundColor:UIColor?, highlightedBackgroundColor:UIColor?,
        preferredLayoutSize:ASLayoutSize = ASLayoutSizeMake(ASDimensionMake("100%"), ASDimensionMake(44)), viewType:ViewType = ViewType.LeftDetail,
        imageLayoutSize:ASLayoutSize = ASLayoutSizeMake(ASDimensionMake(29), ASDimensionMake(29))) {
        self.preferredLayoutSize = preferredLayoutSize;
        self.imageLayoutSize = imageLayoutSize;
        self.viewType = viewType;
        self.highlightedBackgroundColor = highlightedBackgroundColor;
        super.init()
        self.automaticallyManagesSubnodes = true
        self.imageNode.clipsToBounds = true
        self.imageNode.contentMode = .scaleAspectFit
        
        self.backgroundColor = backgroundColor;
    }
    
    override public var selectedBackgroundView: UIView?{
        get{
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = self.highlightedBackgroundColor
            return selectedBackgroundView
        }
        set{ }
    }
    
    override public func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let horizantalLaout = ASStackLayoutSpec.horizontal()
        horizantalLaout.style.flexGrow = 1
        horizantalLaout.justifyContent = .start
        horizantalLaout.alignContent = .center
        horizantalLaout.style.preferredLayoutSize = self.preferredLayoutSize;
        
        self.textNode.style.alignSelf = .center;
        self.textNode.style.spacingBefore = 0;
        
        self.imageNode.style.alignSelf = .center
        self.imageNode.style.spacingBefore = 15
        self.imageNode.style.preferredLayoutSize = self.imageLayoutSize;
        
        let detailsTextLayout = ASStackLayoutSpec.horizontal()
        detailsTextLayout.style.alignSelf = .center;
        detailsTextLayout.style.flexGrow = 1
        detailsTextLayout.alignContent = .center
        detailsTextLayout.style.spacingBefore = 15
        
        switch self.viewType {
        case .LeftDetail:
            detailsTextLayout.justifyContent = .start
            break;
        case .RightDetail:
            detailsTextLayout.justifyContent = .spaceBetween
            break;
        case .Subtitle:
            detailsTextLayout.direction = .vertical;
            detailsTextLayout.justifyContent = .start
            break;
        }
        detailsTextLayout.children = [self.textNode, self.detailTextNode]
        
        var children = [ASLayoutElement]()
        if let _ = self.imageNode.image {
            children.append(self.imageNode)
        }
        //children.append(self.textNode)
        children.append(detailsTextLayout)
        
        horizantalLaout.children = children
        return horizantalLaout
    }
}
