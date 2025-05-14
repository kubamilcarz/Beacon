//
//  AnyNotificationContent.swift
//  Beacon
//
//  Created by Kuba on 5/14/25.
//

import SwiftUI

public struct AnyNotificationContent {
    let id: String
    let title: String
    let body: String?
    let sound: Bool
    let badge: Int?

    public init(
        id: String = UUID().uuidString,
        title: String,
        body: String? = nil,
        sound: Bool = true,
        badge: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.sound = sound
        self.badge = badge
    }
}
