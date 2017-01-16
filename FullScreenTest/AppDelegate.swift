//
//  AppDelegate.swift
//  FullScreenTest
//
//  Created by Dan Moore on 1/16/17.
//  Copyright © 2017 DCM Test. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var theView: NSView!
    
    lazy var screens = NSScreen.screens()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        // Try registering with Notification Center to get screen parameter change notices
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationcenterDidChangeScreenParameters(_:)), name: NSNotification.Name.NSApplicationDidChangeScreenParameters, object: nil)
    }

    // Registered for this one with Notification Center above.
    func notificationcenterDidChangeScreenParameters(_ notification: Notification) {
        print("Notification Center Did Change Screen Parameters: \(notification.name)")
        
        updateScreens()
    }

    // Normal app delegate method.  No configuration required.
    func applicationDidChangeScreenParameters(_ notification: Notification) {
        print("Application Did Change Screen Parameters: \(notification.name)")
        
        updateScreens()
    }

    // Exit full screen mode and update screen list.
    func updateScreens()
    {
        if (theView.isInFullScreenMode) {
            theView.exitFullScreenMode(options: nil)
        }
        
        screens = NSScreen.screens()
    }
    
    @IBAction func enterFull(_ sender: NSButton) {
        if ((screens?.count)! > 1) {
            let screen = screens?[1]
            let fullScreenOptions = [NSFullScreenModeAllScreens: false as NSNumber]
            
            theView.enterFullScreenMode(screen!, withOptions: fullScreenOptions)
        }
    }

    @IBAction func exitFull(_ sender: NSButton) {
        if (theView.isInFullScreenMode) {
            theView.exitFullScreenMode()
        }
    }
}

