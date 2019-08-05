//
//  ASWKWebView.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 8/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import WebKit

public class ASWKWebView: ASDisplayNode {
    public var webView: WKWebView { return view as! WKWebView }
    public override init() {
        super.init()
        setViewBlock { () -> UIView in
            return WKWebView()
        }
    }
}
