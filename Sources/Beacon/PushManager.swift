//
//  PushManager.swift
//  Beacon
//
//  Created by Kuba on 5/14/25.
//

import Foundation
import FirebaseMessaging

@MainActor
@Observable
class PushManager {
    
    private let logManager: PushLogger?
    
    init(logManager: PushLogger? = nil) {
        self.logManager = logManager
    }
    
    func requestAuthorization() async throws -> Bool {
        let isAuthorized = try await LocalNotifications.requestAuthorization()
        logManager?.addUserProperties(dict: ["push_is_authorized": isAuthorized], isHighPriority: true)
        return isAuthorized
    }
    
    func canRequestAuthorization() async -> Bool {
        await LocalNotifications.canRequestAuthorization()
    }
        
    private func scheduleNotification(title: String, subtitle: String, triggerDate: Date) async throws {
        let content = AnyNotificationContent(title: title, body: subtitle)
        let trigger = NotificationTriggerOption.date(date: triggerDate, repeats: false)
        try await LocalNotifications.scheduleNotification(content: content, trigger: trigger)
    }
    
    enum Event: PushLogEvent {
        case sample

        var eventName: String {
            switch self {
            case .sample:          return "PushMan_SampleEvent"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            default:
                return nil
            }
        }
        
        var type: PushLogType {
            switch self {
            default:
                return .analytic
            }
        }
    }
}
