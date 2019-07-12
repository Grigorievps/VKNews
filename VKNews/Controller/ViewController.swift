//
//  ViewController.swift
//  VKNews
//
//  Created by Павел Григорьев on 11/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var authenticationService: AuthenticationService!
    @IBOutlet var authenticationButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //authenticationService = AuthenticationService()
        authenticationService = AppDelegate.shared().authenticationService
    }

    @IBAction func signInTouch() {
    authenticationService.wakeUpSession()
    }
    
    
}

// MARK: - UIButton extension

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}