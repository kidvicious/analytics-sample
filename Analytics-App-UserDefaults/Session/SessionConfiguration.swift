//
//  SessionConfiguration.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/6/24.
//

import Foundation

public struct SessionConfiguration: Codable {
    
    ///Timeout duration in seconds:
    var timeoutDuration: Double = 100
    ///Method swizzling is used to log view lifecycle events for viewDidAppear and viewDidDisappear. You can disable it by setting this value to false.
    var trackLifecycleEvents: Bool = true
}
