//
//  Extensions.swift
//  Set
//
//  Created by Filip Cecelja on 9/17/22.
//

import Foundation
import UIKit

extension UIColor {
    convenience init (_ r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.numberOfLines = 0
    self.view.addSubview(toastLabel)
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    toastLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    toastLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    toastLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
}
