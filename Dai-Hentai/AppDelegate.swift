//
//  AppDelegate.swift
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2018/11/20.
//  Copyright © 2018 DaidoujiChen. All rights reserved.
//

import Foundation
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Property
    
    var window: UIWindow?
    lazy var effectView = { () -> UIVisualEffectView in
        var effect = UIBlurEffect.init(style: .light)
        var effectView = UIVisualEffectView.init(effect: effect)
        effectView.alpha = 0
        effectView.frame = UIScreen.main.bounds
        return effectView
    }()
    private var allowOnce: Bool?
    
    // MARK: - App Life Cycle
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 如果是一個有上鎖的設定, 就讓 window 在最一開始的時候就是隱藏的
        window?.isHidden = DBUserPreference.isLockThisApp
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.removeLaunchScreenCacheIfNeeded()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // 进入后台
        self.addEffectView()
        
        // 如果需要上鎖, 在進入背景前將 window hidden, 避免重新開啟時會看到露出的畫面
        if DBUserPreference.info()?.isLockThisApp.boolValue ?? false {
            window?.isHidden = true
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 回到前台
        self.removeEffectView()
        
        // 一次解開設定, 可以解開或是踢出去
        if let allowOnce = allowOnce {
            if allowOnce {
                self.allowOnce = nil
                AuthHelper.refresh()
                window?.makeKeyAndVisible()
                return
            }
            
            window?.isHidden = true
            exit(0)
        }
        
        // 如果不需要上鎖, window 則是 visible 的
        if !DBUserPreference.isLockThisApp {
            window?.makeKeyAndVisible()
            return
        }
        
        // 需要上鎖的話, window 則是 hidden 的
        window?.isHidden = true
        AuthHelper.check(for: "使用這個 App 需要先解鎖呦") { [weak self] (pass) in
            guard let self = self else {
                return
            }
            
            self.allowOnce = pass
        }
    }
    
    func addEffectView() {
        window?.addSubview(effectView)
        UIView.animate(withDuration: 0.5) {
            self.effectView.alpha = 1
        }
    }
    
    func removeEffectView() {
//        UIView.animate(withDuration: 0.5) {
//        }
        UIView.animate(withDuration: 0.5) {
            self.effectView.alpha = 0
        } completion: { Bool in
            self.effectView.removeFromSuperview()
        }

    }
    
    func removeLaunchScreenCacheIfNeeded() {
        let filePath = NSHomeDirectory() + "/Library/SplashBoard"
        if FileManager.default.fileExists(atPath: filePath) {
            try! FileManager.default.removeItem(atPath: filePath)
        }
    }
}

extension DBUserPreference {
    
    fileprivate static var isLockThisApp: Bool {
        return self.info()?.isLockThisApp.boolValue ?? false
    }
    
}
