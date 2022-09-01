//
//  PopOver.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 30.8.2022.
//

import Foundation
import AppKit
import SwiftUI
import Popover

class MyPopoverConfiguration: DefaultConfiguration {
  override var backgroundColor: NSColor { NSColor(Color("backdrop")) }
  override var borderColor: NSColor? { nil }
  override var popoverToStatusItemMargin: CGFloat { 4 }
  override var cornerRadius: CGFloat { 10 }
}

class PopoverViewController: NSViewController {

}
