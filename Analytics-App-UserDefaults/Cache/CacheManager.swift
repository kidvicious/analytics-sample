//
//  CacheManager.swift
//  Analytics-App-UserDefaults
//
//  Created by Asmin Ghale on 7/7/24.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()

    private init() {}
    
    static let kFileNameLog = "analyticslog.json"

    // Function to save all sessions to a single file
    func saveSessionsToFile(sessions: [Session]) {
        let fileName = CacheManager.kFileNameLog
        let fileManager = FileManager.default
        do {
            let cacheDirectory = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = cacheDirectory.appendingPathComponent(fileName)

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(sessions)

            try jsonData.write(to: fileURL)
            print("Sessions saved to file: \(fileName)")
        } catch {
            print("Error saving sessions to file: \(error)")
        }
    }

    // Function to load all sessions from a single file
    func loadSessionsFromFile() -> [Session]? {
        let fileName = CacheManager.kFileNameLog
        let fileManager = FileManager.default
        do {
            let cacheDirectory = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = cacheDirectory.appendingPathComponent(fileName)

            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let loadedSessions = try decoder.decode([Session].self, from: jsonData)
            return loadedSessions
        } catch {
            print("Error loading sessions from file: \(error)")
            return nil
        }
    }
}
