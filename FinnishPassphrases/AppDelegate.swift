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

  private let appState: AppState
  private let menuBarPopOver: NSPopover
  private var menuBarIcon: NSStatusItem?
  private var aboutWindow: NSWindow?

  override init() {
    let kotusWordService = KotusWordService()
    kotusWordService.readFileToMemory()
    self.appState = AppState(
      passphraseGeneratorService: PassphraseGeneratorService(
        kotusWordService: kotusWordService
      )
    )

    self.menuBarPopOver = NSPopover()

    super.init()
  }

  func applicationDidFinishLaunching(_ notification: Notification) {
    appState.openAboutWindow = openAboutWindow

    menuBarPopOver.behavior = .transient
    menuBarPopOver.animates = true
    menuBarPopOver.contentViewController = NSViewController()
    menuBarPopOver.contentViewController?.view = NSHostingView(rootView: PopOverContent(appState: appState))

    menuBarIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    if let menuButton = menuBarIcon?.button {
      menuButton.image = NSImage(systemSymbolName: "key.fill", accessibilityDescription: nil)
      menuButton.action = #selector(menuButtonToggle)
    }

    if !appState.doNotShowAboutWindowOnStart {
      openAboutWindow()
    }
  }

  private func openAboutWindow() {
    aboutWindow = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: cAboutWindowWidth, height: cAboutWindowHeight),
      styleMask: [.miniaturizable, .closable, .titled],
      backing: .buffered,
      defer: false
    )
    aboutWindow?.center()
    aboutWindow?.title = NSLocalizedString("appNameTitle", comment: "")
    aboutWindow?.contentView = NSHostingView(rootView: AboutView(appState: appState))

    aboutWindow?.titleVisibility = .hidden
    aboutWindow?.styleMask.insert(.fullSizeContentView)
    aboutWindow?.titlebarAppearsTransparent = true
    aboutWindow?.contentView?.wantsLayer = true
    aboutWindow?.backgroundColor = .white

    aboutWindow?.makeKeyAndOrderFront(nil)
    aboutWindow?.isReleasedWhenClosed = false
    NSApp.activate(ignoringOtherApps: true)
  }

  @objc
  private func menuButtonToggle() {
    guard let menuButton = menuBarIcon?.button else { return }
    appState.generateNewPassphrase()
    self.menuBarPopOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
    NSApp.activate(ignoringOtherApps: true)
  }
}
