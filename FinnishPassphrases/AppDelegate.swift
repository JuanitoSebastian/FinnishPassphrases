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

  /// Initialize the AppDelegate. Here it is determined if the app is running in either
  /// production / testing / dev environment.
  ///
  /// If app is running in production AppState is initiated with the default
  /// constructor parameters meaning that a persistent store is used for saving the users preferences
  /// and the actual word list is loaded.
  ///
  /// If app is running in dev environment a mock store is used (settings are not saved)
  /// and the actual word list is loaded.
  ///
  /// If app is running in testing environment a mock store is used (settings are not saved)
  /// and a shorter test word list is loaded.
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

  /// Create the menu bar icon and prepare the popover. Displayes the about window.
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

    // This is needed for EndToEnd tests to access the PopOver elements.
    var accessibilityChildren = NSApp.accessibilityChildren() ?? [Any]()
    accessibilityChildren.append(menuBarPopOver.contentViewController?.view as Any)
    NSApp.setAccessibilityChildren(accessibilityChildren)
  }

  /// Displayes the About window. If the About window is already open in the same
  /// space (where the user currently is) nothing is done. If the window is open  in
  /// another space, the window is closed and re-opened in the current space.
  /// This function is passed to the AppState so that it can be called
  /// from the popover.
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

  /// The popover is displayed and activate is called. Calling activate
  /// makes sure that the keyboard shortcuts work.
  /// This function is called when the menu bar icon is clicked.
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
