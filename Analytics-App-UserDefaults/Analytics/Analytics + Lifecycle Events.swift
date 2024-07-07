//
//  Analytics + Lifecycle Events.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/6/24.
//

import UIKit

extension Analytics {
    
    fileprivate func setupNotificationForAppEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    fileprivate func removeNotificationsForAppEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func swizzleViews() {
        UIViewController.swizzleViewDidAppear
        UIViewController.swizzleViewDidDisappear
    }
    
    @objc private func appBecomeActive() {
        guard currentSession != nil else {return}
        Analytics.shared.trackEvent(event: AppEvent.app("app became active."))
    }
    
    @objc private func appEnteredBackground() {
        guard currentSession != nil else {return}
        Analytics.shared.trackEvent(event: AppEvent.app("app entered background."))
    }
    
    @objc private func appWillTerminate() {
        guard currentSession != nil else {return}
        Analytics.shared.trackEvent(event: AppEvent.app("app will terminate."))
    }
    
    func activateUITracking() {
        setupNotificationForAppEvents()
        swizzleViews()
    }
    
}
