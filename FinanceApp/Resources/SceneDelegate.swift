//
//  SceneDelegate.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 20/05/2023.
//

import UIKit

let appColor: UIColor = .systemBlue

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var hasOnboard = false
    
    let loginVC = LoginVC()
    let onboardingContainerVC = OnboardingContainerVC()
    let mainVC = MainVC()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        
        loginVC.delegate = self
        onboardingContainerVC.delegate = self
        window?.makeKeyAndVisible()
        
        displayLogin()
    }
    
    
    private func displayLogin() {
        setRootViewController(loginVC)
    }
    
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            setRootViewController(mainVC)
        } else {
            setRootViewController(onboardingContainerVC)
        }
    }
}


extension SceneDelegate: LoginVCDelegate {
    func didLogin() {
        displayNextScreen()
        
    }
}


extension SceneDelegate: OnboardingContainerVCDelegate {
    func didFinishOnBoarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainVC)
    }
}


extension SceneDelegate: DummyVCDelegate {
    func didLogout() {
        setRootViewController(loginVC)
    }
}


extension SceneDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil)
    }
}
