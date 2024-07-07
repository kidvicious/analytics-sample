//
//  Swizzler.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/3/24.
//

import UIKit

extension UIViewController {
    static let swizzleViewDidAppear: Void = {
        let originalSelector = #selector(UIViewController.viewDidAppear)
        let swizzledSelector = #selector(UIViewController.swizzled_viewDidAppear)

        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)

        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    
    static let swizzleViewDidDisappear: Void = {
        let originalSelector = #selector(UIViewController.viewDidDisappear)
        let swizzledSelector = #selector(UIViewController.swizzled_viewDidDisappear)

        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)

        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    
    @objc func swizzled_viewDidAppear() {
        self.swizzled_viewDidAppear()
        
        guard let session = Analytics.shared.currentSession else {return}
        
        //DELAYED LOGGING: IN CASES WHERE A NEW SCREEN APPEARS, THE LOGGING FOR DISAPPEAR HAPPENS BEFORE LOGGING NEW SCREEN EVENT.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Analytics.shared.trackEvent(event: AppEvent.journey("appeared viewcontroller: \(String(describing: self))"))
        }
    }
    
    @objc func swizzled_viewDidDisappear() {
        self.swizzled_viewDidDisappear()
        
        guard let session = Analytics.shared.currentSession else {return}
        Analytics.shared.trackEvent(event: AppEvent.journey("disappeared viewcontroller: \(String(describing: self))"))
    }
}
