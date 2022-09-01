//
//  AppDelegate.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation
import AppKit
import SwiftUI
import Popover

class AppDelegate: NSObject, NSApplicationDelegate {

  private let appState: AppState
  private let menuBarPopOver: NSPopover
  private var menuBarIcon: NSStatusItem?
  private var aboutWindow: NSWindow?
  var popover: Popover!

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
    let popoverViewController = PopoverViewController()
    popoverViewController.view = NSHostingView(rootView: PopOverContent(appState: appState))
    popoverViewController.view.setFrameSize(NSSize(width: cPopOverWidth, height: cPopOverHeight))
    popoverViewController.view.setAccessibilityIdentifier("PopOver")

    popover = Popover(with: MyPopoverConfiguration())

    popover.prepare(
      with: NSImage(systemSymbolName: "key.fill", accessibilityDescription: nil)!,
      contentViewController: popoverViewController
    )

    openAboutWindow()

    // This is needed for EndToEnd tests to access the PopOver elements.
    var accessibilityChildren = NSApp.accessibilityChildren() ?? [Any]()
    accessibilityChildren.append(popoverViewController.view as Any)
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

    aboutWindow = getAboutWindow
    NSApp.activate(ignoringOtherApps: true)
  }
}

extension AppDelegate {

  /// A NSWindow styled correctly for the About Window
  private var getAboutWindow: NSWindow {
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

private var screenWidth: CGFloat? {
  NSScreen.main?.frame.maxX
}
