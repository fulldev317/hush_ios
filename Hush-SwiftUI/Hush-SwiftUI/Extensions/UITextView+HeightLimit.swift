//
//  UITextView+HeightLimit.swift
//  Inskreen
//
//  Created by Alex Kovalov on 4/13/18.
//  Copyright © 2018 Requestum. All rights reserved.
//

import UIKit

extension UITextView {
    
    public enum Limit {
        case numberOfLines(Int)
        case maximumHeight(CGFloat)
    }
    
    public func layoutTextView(_ constraint: NSLayoutConstraint, minHeight: CGFloat, limit: Limit) {
        
        let sizeThatFitsTextView: CGSize = sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        let textViewHeight: CGFloat = sizeThatFitsTextView.height
        
        switch limit {
        case .numberOfLines(let number):
            
            guard let lineHeight = font?.lineHeight, textViewHeight > minHeight else {
                constraint.constant = minHeight
                isScrollEnabled = false
                return
            }
            
            let numberOfLines: Int = Int(textViewHeight / lineHeight)
            
            isScrollEnabled = numberOfLines > number
            
            let topAndBottomInsets: CGFloat = contentInset.top + contentInset.bottom + textContainerInset.top + textContainerInset.bottom
            
            constraint.constant = isScrollEnabled ? ceil(CGFloat(number) * lineHeight + topAndBottomInsets) : textViewHeight
            
        case .maximumHeight(let maxHeight):
            
            if textViewHeight < maxHeight && textViewHeight > minHeight {
                constraint.constant = textViewHeight
            } else if textViewHeight < minHeight {
                constraint.constant = minHeight
            } else {
                constraint.constant = maxHeight
            }
            
            isScrollEnabled = textViewHeight > maxHeight
        }
    }
}
