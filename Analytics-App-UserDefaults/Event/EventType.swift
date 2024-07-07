//
//  EventType.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/6/24.
//

import Foundation

public protocol EventType {
    var caption: String { get }
    var eventDescription: String? { get }
}

public enum AppEvent: EventType {
    case app(String?)
    case journey(String?)
    case session(String?)
    
    public var caption: String {
        switch self {
        case .app:
            return "App"
        case .journey:
            return "Journey"
        case .session:
            return "Session"
        }
    }
    
    public var eventDescription: String? {
        switch self {
        case .app(let string), .journey(let string), .session(let string):
            return string
        }
    }
}


//MARK: CUSTOM EVENT ENUMS. CREATE AS NECESSARY

public enum UIElementEvent: EventType {
    
    case buttonTap(String?)
    case viewTap(String?)
    
    public var caption: String {
        switch self {
        case .buttonTap:
            return "Button Tap"
        case .viewTap:
            return "View Tap"
        }
    }
    
    public var eventDescription: String? {
        switch self {
        case .buttonTap(let string), .viewTap(let string):
            return string
        }
    }
    
}
