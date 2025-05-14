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
public class PushManager {
    
    private let logManager: PushLogger?
    
    public init(logManager: PushLogger? = nil) {
        self.logManager = logManager
    }
    
    public func requestAuthorization() async throws -> Bool {
        let isAuthorized = try await LocalNotifications.requestAuthorization()
        logManager?.addUserProperties(dict: ["push_is_authorized": isAuthorized], isHighPriority: true)
        return isAuthorized
    }
    
    public func canRequestAuthorization() async -> Bool {
        await LocalNotifications.canRequestAuthorization()
    }
        
    public func scheduleNotification(title: String, subtitle: String, triggerDate: Date) async throws {
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
