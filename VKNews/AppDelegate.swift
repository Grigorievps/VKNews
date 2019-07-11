//
//  AppDelegate.swift
//  VKNews
//
//  Created by Павел Григорьев on 11/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    var authenticationService: AuthenticationService!
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.authenticationService = AuthenticationService()
        authenticationService.delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }


}
    // MARK: AuthenticationServiceDelegate protocol implementation
extension AppDelegate: AuthenticationServiceDelegate {
    func authenticationServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authenticationServiceSignIn() {
        print(#function)
        let newsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "News") as? NewsViewController
        let navigationVC = UINavigationController(rootViewController: newsVC!)
        window?.rootViewController = navigationVC
    }
    
    func authenticationServiceDidSignInFail() {
        print(#function)
    }
}
