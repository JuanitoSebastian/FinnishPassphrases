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

    var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        let appState = AppState(
            passphraseGeneratorService: PassphraseGeneratorService(
                kotusWordService: kotusWordService
            )
        )

        let contentView = ContentView(appState: appState)

        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: contentView)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let menuButton = statusItem?.button {
            menuButton.image = NSImage(systemSymbolName: "lock.circle.fill", accessibilityDescription: nil)
            menuButton.action = #selector(menuButtonToggle)
        }

        if !appState.doNotShowInstructions {
            openAboutWindow()
        }
    }

    func openAboutWindow() {
        window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: cAboutWindowWidth, height: cAboutWindowHeight),
                styleMask: [.miniaturizable, .closable, .titled],
                backing: .buffered, defer: false)
        window?.center()
        window?.title = "Finnish Passphrases 🇫🇮"
        window?.contentView = NSHostingView(rootView: AboutView())
        window?.makeKeyAndOrderFront(nil)
    }

    @objc
    func menuButtonToggle() {
        guard let menuButton = statusItem?.button else { return }
        self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
    }
}
