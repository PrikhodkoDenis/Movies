//
//  TextAttributes.swift
//  Movies
//
//  Created by Denis on 19.05.2022.
//

import Foundation
import UIKit

enum Text {
    
    static var attributes: [NSAttributedString.Key: NSObject] {
        let descriptor = UIFontDescriptor(name: "Avenir-BlackOblique", size: 18)
        let font = UIFont(descriptor: descriptor, size: 18)
        
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.black
        textShadow.shadowOffset = .init(width: 3, height: 3)
        
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.shadow: textShadow
        ]
        
        return attributes
    }
}
