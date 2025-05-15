//
//  deepLinkTestApp.swift
//  deepLinkTest
//
//  Created by Vasileios Diamantidis on 15.05.25.
//

import SwiftUI

@main
struct deepLinkTestApp: App {
    var body: some Scene {
        WindowGroup {
            QRCodeView(url: "www.bettermile.com")
        }
    }
}
