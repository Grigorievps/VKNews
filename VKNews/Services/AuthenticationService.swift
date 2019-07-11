//
//  AuthenticationService.swift
//  VKNews
//
//  Created by Павел Григорьев on 11/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation
import VKSdkFramework

final class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7052520"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthenticationServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        // Checking last session with capture list for deligate
        VKSdk.wakeUpSession(scope) { [delegate]
            (state, error) in
            if state == VKAuthorizationState.authorized {
                delegate?.authenticationServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
            } else {
                print("authentication problem \(state) error \(String(describing: error))")
                delegate?.authenticationServiceDidSignInFail()
            }
        }
    
    }
    
    // MARK: VKSDKDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authenticationServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        
    }
    
    // MARK: VKSDKUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authenticationServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

    // MARK: SignIn protocol
protocol AuthenticationServiceDelegate: class {
    func authenticationServiceShouldShow(_ viewController: UIViewController)
    func authenticationServiceSignIn()
    func authenticationServiceDidSignInFail()
}
