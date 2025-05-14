//
//  PushLogger.swift
//  Beacon
//
//  Created by Kuba on 5/14/25.
//

@MainActor
public protocol PushLogger {
    func trackEvent(event: PushLogEvent)
    func addUserProperties(dict: [String: Any], isHighPriority: Bool)
}

public protocol PushLogEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var type: PushLogType { get }
}

public enum PushLogType: Int, CaseIterable, Sendable {
    case info // 0
    case analytic // 1
    case warning // 2
    case severe // 3

    var emoji: String {
        switch self {
        case .info:
            return "👋"
        case .analytic:
            return "📈"
        case .warning:
            return "⚠️"
        case .severe:
            return "🚨"
        }
    }

    var asString: String {
        switch self {
        case .info: return "info"
        case .analytic: return "analytic"
        case .warning: return "warning"
        case .severe: return "severe"
        }
    }
}
