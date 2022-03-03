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
    switch environment {
    case "production":
      self.appState = AppState()
      self.menuBarPopOver = NSPopover()
      super.init()
    default:
      let testingStore = TestingStore()
      self.appState = AppState(
        passphraseGeneratorService: PassphraseGeneratorService(
          wordService: environment == "test" ? TestingWordService() : KotusWordService()
        ),
        defaultsStore: testingStore
      )

      self.menuBarPopOver = NSPopover()
      super.init()
    }
  }

  func applicationDidFinishLaunching(_ notification: Notification) {
    appState.openAboutWindow = openAboutWindow

    menuBarPopOver.behavior = .transient
    menuBarPopOver.animates = true
    menuBarPopOver.contentViewController = NSViewController()
    menuBarPopOver.contentViewController?.view = NSHostingView(rootView: PopOverContent(appState: appState))
    menuBarPopOver.contentViewController?.view.setAccessibilityIdentifier("PopOver")

    menuBarIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    if let menuButton = menuBarIcon?.button {
      menuButton.image = NSImage(systemSymbolName: "key.fill", accessibilityDescription: nil)
      menuButton.action = #selector(menuButtonToggle)
      menuButton.setAccessibilityEnabled(true)
    }

    openAboutWindow()
    var accessibilityChildren = NSApp.accessibilityChildren() ?? [Any]()
    accessibilityChildren.append(menuBarPopOver.contentViewController?.view as Any)
    NSApp.setAccessibilityChildren(accessibilityChildren)
  }

  private func openAboutWindow() {
    if let aboutWindow = aboutWindow {
      if aboutWindow.isVisible && aboutWindow.isOnActiveSpace {
        return
      }
      if aboutWindow.isVisible { aboutWindow.close() }
    }

    aboutWindow = aboutWindowSpecs
    NSApp.activate(ignoringOtherApps: true)
  }

  @objc
  private func menuButtonToggle() {
    guard let menuButton = menuBarIcon?.button else { return }
    appState.generateNewPassphrase()
    menuBarPopOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
    menuBarPopOver.contentViewController?.view.window?.makeKey()
    NSApp.activate(ignoringOtherApps: true)
  }

}

extension AppDelegate {

  private var aboutWindowSpecs: NSWindow {
    let windowToReturn = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 600),
      styleMask: [.miniaturizable, .closable, .titled],
      backing: .buffered,
      defer: false
    )
    windowToReturn.center()
    windowToReturn.title = NSLocalizedString("aboutWindowTitle", comment: "")
    windowToReturn.contentView = NSHostingView(rootView: AboutView(appState: appState))

    windowToReturn.titleVisibility = .hidden
    windowToReturn.styleMask.insert(.fullSizeContentView)
    windowToReturn.titlebarAppearsTransparent = true
    windowToReturn.contentView?.wantsLayer = true
    windowToReturn.backgroundColor = NSColor(Color("about-background"))

    windowToReturn.makeKeyAndOrderFront(nil)
    windowToReturn.isReleasedWhenClosed = false
    windowToReturn.setAccessibilityIdentifier("aboutWindow")
    return windowToReturn
  }

}

private var environment: String {
  guard let env = ProcessInfo.processInfo.environment["env"] else { return "production" }
  return env
}
