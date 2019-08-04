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
import SwiftSVGKit

public class CallKitKeypadBackDeleteButtonViewNode: ASDisplayNode {
    public let buttonNode:ASButtonNode = ASButtonNode();
    let button_backgroundColor:UIColor
    let contentColor:UIColor
    
    public init( backgroundColor:UIColor, contentColor:UIColor, highlightBackgroundColor:UIColor ) {
        self.button_backgroundColor = backgroundColor;
        self.contentColor = contentColor;
        super.init()
        self.automaticallyManagesSubnodes = true;
        //self.iconImageNode.image = image;
        let svgAsset = NSDataAsset(name: "callkit_backdelete_dialpad_icon", bundle: Bundle(for: CallKitKeypadBackDeleteButtonViewNode.self))
        if svgAsset != nil {
            //svgAsset.data
            if let doc = SVGDocument(data: svgAsset?.data ?? Data()) {
                
                
                
                SWKQueue.mainQueue().async { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    doc.setStyle(Style(strokeColor: nil, fillColor: backgroundColor), for: "box")
                    doc.setStyle(Style(strokeColor: nil, fillColor: contentColor), for: "cross")
                    strongSelf.buttonNode.setImage(doc.image(CGSize(width: 40, height: 40)), for: UIControl.State.normal)
                    
                    doc.setStyle(Style(strokeColor: nil, fillColor: highlightBackgroundColor), for: "box")
                    doc.setStyle(Style(strokeColor: nil, fillColor: contentColor), for: "cross")
                    strongSelf.buttonNode.setImage(doc.image(CGSize(width: 40, height: 40)), for: UIControl.State.highlighted)
                }
            }else{
                LOGE("Unable to load SVGDocument")
            }
        }else{
            LOGE("Unable to load ASSET callkit_backdelete_dialpad_icon")
        }
        
        self.buttonNode.contentMode = .scaleAspectFit
        self.buttonNode.imageNode.contentMode = .scaleAspectFit
        self.buttonNode.style.alignSelf = .center
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASAbsoluteLayoutSpec();
        LOGE("size: \(constrainedSize.max)")
        self.buttonNode.style.preferredLayoutSize = ASLayoutSizeMake(ASDimensionMake(constrainedSize.max.width), ASDimensionMake(constrainedSize.max.height))
        layout.children = [ self.buttonNode]
        return layout;
    }
}
