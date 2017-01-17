//
//  AppDelegate.swift
//  FullScreenTest
//
//  Created by Dan Moore on 1/16/17.
//  Copyright © 2017 DCM Test. All rights reserved.
//

import Cocoa

func coregraphicsReconfiguration(display:CGDirectDisplayID, flags:CGDisplayChangeSummaryFlags, userInfo:UnsafeMutableRawPointer?) -> Void
{
    print("Core Graphics Reconfiguration")
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var theView: NSView!
    
    lazy var screens = NSScreen.screens()
    var screen: NSScreen? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        // Register with Core Graphics for reconfiguration callbacks
        CGDisplayRegisterReconfigurationCallback(coregraphicsReconfiguration, nil)

        // Register with Notification Center to get screen parameter change notices
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationcenterDidChangeScreenParameters(_:)), name: NSNotification.Name.NSApplicationDidChangeScreenParameters, object: nil)
    }

    // Registered for this one with Notification Center above.
    func notificationcenterDidChangeScreenParameters(_ notification: Notification) {
        print("Notification Center Did Change Screen Parameters: \(notification.name.rawValue)")
        
        updateScreens()
    }

    // Normal app delegate method.  No registration required.
    func applicationDidChangeScreenParameters(_ notification: Notification) {
        print("Application Did Change Screen Parameters: \(notification.name.rawValue)")
        
        updateScreens()
    }

    // Exit full screen mode and update screen list.
    func updateScreens()
    {
        screens = NSScreen.screens()
        
        let stillThere = (screen != nil) && (screens?.contains(screen!))!

        print("Is display still there? \(stillThere)")
        
        if (!stillThere && theView.isInFullScreenMode) {
            theView.exitFullScreenMode(options: nil)
        }
    }
    
    @IBAction func enterFull(_ sender: NSButton) {
        if ((screens?.count)! > 1) {
            screen = screens?[1]
            let fullScreenOptions = [NSFullScreenModeAllScreens: false as NSNumber]
            
            theView.enterFullScreenMode(screen!, withOptions: fullScreenOptions)
        }
    }

    @IBAction func exitFull(_ sender: NSButton) {
        if (theView.isInFullScreenMode) {
            theView.exitFullScreenMode()
        }
        
        screen = nil
    }
    
    @IBAction func releaseDisplays(_ sender: NSButton) {
        CGReleaseAllDisplays()
    }

    @IBAction func pollDisplays(_ sender: NSButton) {
        if (screen != nil) {
            let did = screen!.deviceDescription["NSScreenNumber"] as! CGDirectDisplayID

            CGDisplayRelease(did)
            
            // FIXME:  When re-capturing, the display gets painted black so...  Not a good option.
            CGDisplayCapture(did)
        }
    }
}

