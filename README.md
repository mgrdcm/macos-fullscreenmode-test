# macos-fullscreenmode-test

## Goal

To be able to react when a screen has been disconnected while an application's view is in [full screen mode](https://developer.apple.com/reference/appkit/nsview/1483780-enterfullscreenmode).

## Problem

It appears that when a view is in full screen mode, there's no way to get a notification from macOS.

I've tried all three methods I know of:
- [NSApplicationDelegate's applicationDidChangeScreenParameters] (https://developer.apple.com/reference/appkit/nsapplicationdelegate/1428424-applicationdidchangescreenparame)
- Registering with NotificationCenter for [NSApplicationDidChangeScreenParameters] (https://developer.apple.com/reference/foundation/nsnotification.name/1428749-nsapplicationdidchangescreenpara)
- Core Graphics [CGDisplayRegisterReconfigurationCallback] (https://developer.apple.com/reference/coregraphics/1455336-cgdisplayregisterreconfiguration?language=objc)

And none of them seem to get notifications when a screen disconnects when in full screen mode.

This is probably related to the fact that macOS's System Preferences > Displays cannot change the resolution of any display while a view is in full screen mode.

## Testing

Run the included application with at least one external screen.

Click the "Enter" button to start full screen mode.

Disconnect a display.  Note:  If you get a black screen, just hit command-Q to quit the application.

