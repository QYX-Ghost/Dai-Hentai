//
//  TabBarController.swift
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2018/11/27.
//  Copyright © 2018 DaidoujiChen. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        var titles = [ "列表", "历史", "下载", "设置" ]
        let selector = Selector(("setText:"))
        for view in tabBar.subviews {
            if
                let tabBarButton = NSClassFromString("UITabBarButton"),
                view.isKind(of: tabBarButton),
                view.subviews.count == 2 {
                
                for subview in view.subviews {
                    if
                        let tabBarButtonLabel = NSClassFromString("UITabBarButtonLabel"),
                        subview.isKind(of: tabBarButtonLabel),
                        subview.responds(to: selector) {
                        
                        subview.perform(selector, with: titles.first ?? "")
                        subview.sizeToFit()
                        titles.remove(at: 0)
                        break
                    }
                }
            }
        }
    }
    
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if
            let navigationController = viewController as? UINavigationController,
            let settingViewController = navigationController.topViewController as? SettingViewController {
            DBUserPreference.setInfo(settingViewController.info)
        }
    }
    
}
