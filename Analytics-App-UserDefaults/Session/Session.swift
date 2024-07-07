//
//  Session.swift
//  Analytics-tracker
//
//  Created by Asmin Ghale on 7/3/24.
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSObject, Codable {

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sessionId = try container.decode(String.self, forKey: .sessionId)
        self.startedAt = try container.decode(Date.self, forKey: .startedAt)
        self.endedAt = try container.decodeIfPresent(Date.self, forKey: .endedAt)
        self.events = try container.decode([Event].self, forKey: .events)
    }
    
    enum CodingKeys: CodingKey {
        case sessionId
        case startedAt
        case endedAt
        case events
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.sessionId, forKey: .sessionId)
        try container.encode(self.startedAt, forKey: .startedAt)
        try container.encodeIfPresent(self.endedAt, forKey: .endedAt)
        try container.encode(self.events, forKey: .events)
    }
    
    public var sessionId: String
    public var startedAt: Date
    public var endedAt: Date?
    public var events: [Event] = []
    
    init(sessionId: String, startedAt: Date = Date()) {
        self.sessionId = sessionId
        self.startedAt = startedAt
    }
    
    var isExpired: Bool {
        let expireDate = endedAt ?? startedAt.addingTimeInterval(Analytics.shared.configuration.timeoutDuration)
        return Date() > expireDate
    }
    
    func addEvent(event: EventType) -> Event {
        let event = Event(sessionId: sessionId, eventType: event)
        events.append(event)
        return event
    }
    
}

class SessionLog: Codable {
    
    init(sessions: [Session]) {
        self.sessions = sessions
    }
    
    var sessions: [Session] = []
}
