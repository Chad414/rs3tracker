//
//  CustomizableAlertController.swift
//  RS3-Toolkit
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

typealias StringAttribute = NSAttributedString.StringAttribute

final class DarkAlertController: CustomizableAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.visualEffectView?.effect = UIBlurEffect(style: .dark)
        
        self.tintColor = UIColor(red: 0.4, green: 0.5, blue: 1.0, alpha: 1.0)
        
        //self.contentView?.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
        self.contentView?.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        
        let whiteStringAttribute = StringAttribute(key: .foregroundColor, value: UIColor.white)
        self.titleAttributes = [whiteStringAttribute]
        self.messageAttributes = [whiteStringAttribute]
    }
}

open class CustomizableAlertController: UIAlertController {
    
    open lazy var visualEffectView: UIVisualEffectView? = {
        return self.view.visualEffectView
    }()
    
    open lazy var lazyContentView: UIView? = {
        return self.contentView
    }()
    
    open lazy var tintColor: UIColor? = {
        return self.view.tintColor
    }()
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.tintColor = self.tintColor
    }
    
    func addParallaxEffect(x: Int = 20, y: Int = 20) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -x
        horizontal.maximumRelativeValue = x
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -y
        vertical.maximumRelativeValue = y
        
        let motionEffectsGroup = UIMotionEffectGroup()
        motionEffectsGroup.motionEffects = [horizontal, vertical]
        
        self.view.addMotionEffect(motionEffectsGroup)
    }
}

//
extension UIAlertController {
    
    private var visualEffectView: UIVisualEffectView? {
        return self.view.visualEffectView
    }
    
    var contentView: UIView? {
        return self.view.subviews.first?.subviews.first?.subviews.first
    }
    
    var titleAttributes: [StringAttribute] {
        get { return self.attributedTitle_?.attributes ?? [] }
        set { self.attributedTitle_ = newValue.suitableAttributedText(forText: self.title) }
    }
    
    var messageAttributes: [StringAttribute] {
        get { return self.attributedMessage_?.attributes ?? [] }
        set { self.attributedMessage_ = newValue.suitableAttributedText(forText: self.message) }
    }
}

extension NSAttributedString {
    
    struct StringAttribute {
        
        let key: NSAttributedString.Key
        let value: Any
        var range: NSRange? = nil
        
        init(key: NSAttributedString.Key, value: Any, range: NSRange? = nil) {
            self.key = key
            self.value = value
            self.range = range
        }
    }
    
    var attributes: [StringAttribute] {
        
        var savedAttributes: [StringAttribute] = []
        
        let rawAttributes = self.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: self.length))
        
        for rawAttribute in rawAttributes {
            savedAttributes.append(StringAttribute(key: rawAttribute.key, value: rawAttribute.value))
        }
        return savedAttributes
    }
    convenience init(string: String?, attributes: [StringAttribute]) {
        
        guard let validString = string else { self.init(string: "", attributes: [:]); return }
        
        var attributesDict: [NSAttributedString.Key: Any] = [:]
        for attribute in attributes {
            attributesDict[attribute.key] = attribute.value
        }
        self.init(string: validString, attributes: attributesDict)
    }
}

private extension UIView {
    var visualEffectView: UIVisualEffectView? {
        
        if self is UIVisualEffectView {
            return self as? UIVisualEffectView
        }
        
        for subview in self.subviews {
            if let validView = subview.visualEffectView {
                return validView
            }
        }
        return nil
    }
}

private extension UIAlertController {
    
    private var attributedTitle_: NSAttributedString? {
        get {
            return self.value(forKey: "attributedTitle") as? NSAttributedString
        } set {
            self.setValue(newValue, forKey: "attributedTitle")
        }
    }
    
    private var attributedMessage_: NSAttributedString? {
        get {
            return self.value(forKey: "attributedMessage") as? NSAttributedString
        } set {
            self.setValue(newValue, forKey: "attributedMessage")
        }
    }
}

extension NSMutableAttributedString {
    var mutableAttributes: [StringAttribute] {
        get { return self.attributes }
        set {
            let defaultRange = NSRange(location: 0, length: self.length)
            for attribute in newValue {
                self.addAttribute(attribute.key, value: attribute.value, range: attribute.range ?? defaultRange)
            }
        }
    }
    convenience init(string: String?, mutableAttributes: [StringAttribute]) {
        guard let text = string else { self.init(string: ""); return }
        self.init(string: text)
        self.mutableAttributes = mutableAttributes
    }
}

extension Array where Element == StringAttribute {
    func suitableAttributedText(forText text: String?) -> NSAttributedString {
        if self.compactMap({ $0.range }).isEmpty {
            return NSAttributedString(string: text, attributes: self)
        }
        return NSMutableAttributedString(string: text, mutableAttributes: self)
    }
}

