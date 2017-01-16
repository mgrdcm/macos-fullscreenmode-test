# macos-fullscreenmode-test

## Problem

It appears that when views are in full screen mode, that the application does not receive notifications from macOS that screens have been changed.

I've tried all three methods I know of:
- NSApplicationDelegate's applicationDidChangeScreenParameters method: https://developer.apple.com/reference/appkit/nsapplicationdelegate/1428424-applicationdidchangescreenparame
- Registering with NotificationCenter for NSApplicationDidChangeScreenParameters notifications: https://developer.apple.com/reference/foundation/nsnotification.name/1428749-nsapplicationdidchangescreenpara
- The Core Graphics CGDisplayRegisterReconfigurationCallback function: https://developer.apple.com/reference/coregraphics/1455336-cgdisplayregisterreconfiguration?language=objc

And none of them seem to get notifications.

## Testing

Run the included application with at least one external screen.

Click the "Enter" button to start full screen mode.

