//
//  ExtensionUiView.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 31/10/22.
//

import UIKit

extension UIView {
    
    func roundCorners(cornerRadiuns:CGFloat, typeCorners:CACornerMask) {
        
        self.layer.cornerRadius = cornerRadiuns
        self.layer.maskedCorners = typeCorners
        self.clipsToBounds = true
    }
    
}

extension CACornerMask {
    
    static public let downRight: CACornerMask = .layerMaxXMaxYCorner
    static public let downLeft: CACornerMask = .layerMinXMaxYCorner
    static public let upperRight: CACornerMask = .layerMaxXMinYCorner
    static public let upperLeft: CACornerMask = .layerMinXMinYCorner
}
