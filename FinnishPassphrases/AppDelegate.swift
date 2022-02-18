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

    let appState: AppState

    var statusItem: NSStatusItem?

    var popOver = NSPopover()

    var window: NSWindow?

    override init() {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        self.appState = AppState(
            passphraseGeneratorService: PassphraseGeneratorService(
                kotusWordService: kotusWordService
            )
        )

        super.init()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        appState.openAboutWindow = openAboutWindow

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

        if !appState.doNotShowAboutWindowOnStart {
            openAboutWindow()
        }
    }

    func openAboutWindow() {
        window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: cAboutWindowWidth, height: cAboutWindowHeight),
                styleMask: [.miniaturizable, .closable, .titled],
                backing: .buffered, defer: false)
        window?.center()
        window?.title = NSLocalizedString("appNameTitle", comment: "")
        window?.contentView = NSHostingView(rootView: AboutView(appState: appState))

        window?.titleVisibility = .hidden
        window?.styleMask.insert(.fullSizeContentView)
        window?.titlebarAppearsTransparent = true
        window?.contentView?.wantsLayer = true
        window?.backgroundColor = .white

        window?.makeKeyAndOrderFront(nil)
        window?.isReleasedWhenClosed = false
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc
    func menuButtonToggle() {
        guard let menuButton = statusItem?.button else { return }
        self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
        NSApp.activate(ignoringOtherApps: true)
    }
}
