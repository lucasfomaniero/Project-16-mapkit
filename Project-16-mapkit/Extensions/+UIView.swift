//
//  +UIView.swift
//  Project-16-mapkit
//
//  Created by Lucas Maniero on 27/03/22.
//

import UIKit

extension UIView {
    
    enum AnchorType: CaseIterable {
                
        case leading
        case top
        case trailing
        case bottom
        case left
        case right
    }
    func fillSuperView(withMargin margin: CGFloat = 0.0, shouldRespectSafeArea respectSafeArea: Bool = false) {
        guard let superview = self.superview else {return}
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: margin * -1),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margin * -1)
        ])
    }
    
    func anchorTo(_ anchors: AnchorType..., withMargin margin: CGFloat = 0.0) {
        guard let superview = superview else {return}
        anchors.forEach { anchor in
            switch anchor {
            case .top:
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: margin).isActive = true
            case .leading:
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin).isActive = true
            case .trailing:
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: margin * -1).isActive = true
            case .bottom:
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margin * -1).isActive = true
            case .left:
                self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margin).isActive = true
            case .right:
                self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: margin * -1).isActive = true
            }
        }
    }
    
    
}
