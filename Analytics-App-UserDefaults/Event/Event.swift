//
//  Event.swift
//  Analytics-tracker
//
//  Created by Asmin Ghale on 7/3/24.
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSObject, Codable {
    
    var id: UUID
    var date: Date
    public var eventType: String
    var detectedEvent: String
    var userInfo: [String: String]?
    var sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case id, date, eventType, detectedEvent, userInfo, sessionId
    }
    
    var eventDescription: String {
        "[\(Date.timeIntervalSinceReferenceDate)]: \(eventType) - \(detectedEvent). Userinfo: \(String(describing: userInfo))"
    }
    
    init(sessionId: String, date: Date = Date(), eventType: EventType, userInfo: [String: String]? = nil) {
        self.id = UUID()
        self.sessionId = sessionId
        self.date = date
        self.eventType = eventType.caption
        self.detectedEvent = eventType.eventDescription ?? ""
        self.userInfo = userInfo
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.eventType = try container.decode(String.self, forKey: .eventType)
        self.detectedEvent = try container.decode(String.self, forKey: .detectedEvent)
        self.userInfo = try container.decodeIfPresent([String: String].self, forKey: .userInfo)
        self.sessionId = try container.decode(String.self, forKey: .sessionId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(detectedEvent, forKey: .detectedEvent)
        try container.encode(userInfo, forKey: .userInfo)
        try container.encode(sessionId, forKey: .sessionId)
    }
    
}
