//
//  UIView+Extensions.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import UIKit

enum ConstraintType {
    case top, left, right, bottom, horizontal, centerX, centerY, vertical, height, width
}

extension UIView {
    func pinEdgesToView(_ view: UIView, edges: UIEdgeInsets = .zero, except dir: [ConstraintType] = []) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        if !dir.contains(.top) {
            topAnchor.constraint(equalTo: view.topAnchor, constant: edges.top).isActive = true
        }
        if !dir.contains(.left) {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edges.left).isActive = true
        }
        if !dir.contains(.right) {
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edges.right).isActive = true
        }
        if !dir.contains(.bottom) {
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edges.bottom).isActive = true
        }
    }
    
    func pinCenterToView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @discardableResult func add(constarint: ConstraintType, view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch constarint {
        case .top:
            constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        case .left:
            constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        case .right:
            constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        case .bottom:
            constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        case .centerX:
            constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        case .centerY:
            constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        case .height:
            if multiplier != 0 {
                constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
                constraint.isActive = true
                return constraint
            }
            constraint = heightAnchor.constraint(equalTo: view.heightAnchor, constant: constant)
        case .width:
            if multiplier != 0 {
                constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
                constraint.isActive = true
                return constraint
            }
            constraint = widthAnchor.constraint(equalTo: view.widthAnchor, constant: constant)
        case .horizontal:
            constraint = leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        case .vertical:
            constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        }
        constraint.isActive = true
        return constraint
    }
}
