//
//  AppDelegate.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?

    var popOver = NSPopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()

        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: contentView)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let menuButton = statusItem?.button {
            menuButton.image = NSImage(systemSymbolName: "lock.circle.fill", accessibilityDescription: nil)
            menuButton.action = #selector(menuButtonToggle)
        }
    }

    @objc
    func menuButtonToggle() {
        guard let menuButton = statusItem?.button else { return }
        self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
    }
}
