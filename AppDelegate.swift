import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
func applicationDidFinishLaunching(_ notification: Notification) {
let a = NSApp.windows
if( a.count > 1 ) {
let window : NSWindow = a[1]
window.close()
}
}
}
