//
//  Event + Protocol.swift
//  AnalyticsApp
//
//  Created by Asmin Ghale on 7/6/24.
//

import Foundation

protocol AnalyticEvent: AnyObject {
    var id: UUID { get }
    var date: Date { get set }
    var eventType: EventType { get set }
    var detectedEvent: String { get set }
    var description: String { get }
}
