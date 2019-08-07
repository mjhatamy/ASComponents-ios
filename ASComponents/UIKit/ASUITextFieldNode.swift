//
//  ASUITextFieldNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 8/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SWKSwiftSignalKit

public class ASUITextFieldNode:ASDisplayNode {
    public var textField: UITextField { return view as! UITextField }
    public override init() {
        super.init()
        setViewBlock { () -> UIView in
            return UITextField()
        }
        
        //self.textField.text
    }
    
    public var text: String? {
        get{
            var m_Val: String?
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.text;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.text = newValue
            }
        }
    }
    
    public var returnKeyType: UIReturnKeyType {
        get{
            var m_Val: UIReturnKeyType = UIReturnKeyType.default
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.returnKeyType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.returnKeyType = newValue
            }
        }
    }
    
    public var keyboardAppearance: UIKeyboardAppearance {
        get{
            var m_Val: UIKeyboardAppearance = UIKeyboardAppearance.default
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.keyboardAppearance;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.keyboardAppearance = newValue
            }
        }
    }
    
    public var autocapitalizationType: UITextAutocapitalizationType {
        get{
            var m_Val: UITextAutocapitalizationType = UITextAutocapitalizationType.none
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.autocapitalizationType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.autocapitalizationType = newValue
            }
        }
    }
    
    public var autocorrectionType: UITextAutocorrectionType {
        get{
            var m_Val: UITextAutocorrectionType = UITextAutocorrectionType.default
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.autocorrectionType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.autocorrectionType = newValue
            }
        }
    }
    
    public var keyboardType: UIKeyboardType  {
        get{
            var m_Val: UIKeyboardType = UIKeyboardType.default
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.keyboardType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.keyboardType = newValue
            }
        }
    }
    
    public var textContentType: UITextContentType  {
        get{
            var m_Val: UITextContentType = UITextContentType.name
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.textContentType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.textContentType = newValue
            }
        }
    }
    
    
    public var isSecureTextEntry: Bool  {
        get{
            var m_Val: Bool = false
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.isSecureTextEntry;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.isSecureTextEntry = newValue
            }
        }
    }
    
    
    public var spellCheckingType: UITextSpellCheckingType {
        get{
            var m_Val: UITextSpellCheckingType = UITextSpellCheckingType.default
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                m_Val = strongSelf.textField.spellCheckingType;
            }
            return m_Val;
        }
        set{
            SWKQueue.mainQueue().sync { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.textField.spellCheckingType = newValue
            }
        }
    }
}
