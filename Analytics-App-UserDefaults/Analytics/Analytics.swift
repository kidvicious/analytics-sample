//
//  Analytics.swift
//  Analytics-tracker
//
//  Created by Asmin Ghale on 7/3/24.
//

import Foundation
import UIKit

@objc
public class Analytics: NSObject {
    
    public static let shared = Analytics()
    
    private var cache = CacheManager.shared
    
    weak var delegate: AnalyticsDelegate?
    
    private override init() {
        super.init()
        self.sessions = cache.loadSessionsFromFile() ?? []
    }
    
    
    //SESSION CONFIGURATION VALUES. Passed as a value on startSession. Cannot be modified.
    public var configuration: SessionConfiguration {
        get {
            if let configuration: SessionConfiguration = Defaults.value(structForKey: .configuration) {
                return configuration
            }else{
                let configuration = SessionConfiguration()
                Defaults.store(value: configuration, key: .configuration)
                return configuration
            }
        }
    }
    
    ///Currently active session.
    public var currentSession: Session? {
        sessions.first(where: {$0.isExpired == false})
    }
    
    ///List of logged sessions.
    public var sessions: [Session] = []

    //to check if user has stopped session manually. set `true` on startSession() and `false` on stopSession()
    private var isEnabled: Bool = false
    
    public var enabled: Bool { isEnabled }
    
    ///Check if session is active/expired. Create new session if needed.
    private func startNewSessionIfNeeded() {
        
        guard isEnabled else {return}
        
        if currentSession == nil {
            createNewSession()
        } else if let session = currentSession, session.isExpired {
            //Save session to storage and create new session
            saveCurrentSession()
            createNewSession()
        }
    }
    
    private func createNewSession() {
        
        let newSession = Session(sessionId: UUID().uuidString)
        
        //Logging Event for new session started.
        newSession.addEvent(event: AppEvent.session("session started"))
        sessions.append(newSession)
        
        //save to storage
        saveToCache()
    }
    
    private func saveCurrentSession() {
        guard let currentSession = currentSession else { return }
    
        //Log event for session ended.
        currentSession.addEvent(event: AppEvent.session("session ended"))
        currentSession.endedAt = Date()
        
        //TODO: save to storage
        saveToCache()
    }
    
    private func saveToCache() {
        CacheManager.shared.saveSessionsToFile(sessions: sessions)
    }
    
}



//PUBLIC METHODS

extension Analytics: Trackable {
    
    public func trackEvent(event: EventType) {
        startNewSessionIfNeeded()
        guard let currentSession = currentSession else {return}
        let event = currentSession.addEvent(event: event)
        saveToCache()
        
        delegate?.didLogEvent(session: currentSession, event: event)
    }
    
    public func start(with configuration: SessionConfiguration? = nil) {
        //save configuration to userdefaults
        Defaults.store(value: configuration ?? SessionConfiguration(), key: .configuration)
        
        isEnabled = true
        
        if currentSession != nil {
            stopSession()
        }
        
        startNewSessionIfNeeded()
        
        if Analytics.shared.configuration.trackLifecycleEvents == true {
            activateUITracking()
        }
    }
    
    public func stopSession() {
        guard let session = currentSession else { return }
        isEnabled = false
        saveCurrentSession()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func logAllData() {
        
        for each in sessions {
            
            print("\n\nSESSION: \(each.startedAt), expired: \(each.isExpired)\n")
            
            for event in each.events {
                    print(event.eventDescription)
                }
            }
    }
    
    func saveToFile() -> Bool {
        return true
    }
    
}
