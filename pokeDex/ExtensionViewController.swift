//
//  ExtensionViewController.swift
//  pokeDex
//
//  Created by akiracaio on 08/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
