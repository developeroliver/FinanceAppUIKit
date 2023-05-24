//
//  MainVC.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 22/05/2023.
//

import UIKit

class MainVC : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        tabBar.tintColor = appColor
        
        let summaryVC   = AccountSummaryVC()
        let moneyVC     = MoveMoneyVC()
        let moreVC      = MoreVC()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Résumé")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Transfert")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "Plus")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
    }
}
