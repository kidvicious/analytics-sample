//
//  Analytics + Protocol.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/6/24.
//

import Foundation

protocol AnalyticsDelegate: AnyObject {
    func didLogEvent(session: Session, event: Event)
}

protocol Trackable {
    func trackEvent(event: EventType)
    func start(with configuration: SessionConfiguration?)
    func stopSession()
    func logAllData()
    func saveToFile() -> Bool
}
