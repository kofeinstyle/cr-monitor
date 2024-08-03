// https://developer.apple.com/design/human-interface-guidelines/sf-symbols
//https://gaitatzis.medium.com/building-a-macos-menu-bar-app-with-swift-d6e293cd48eb
//https://macmenubar.com/

import SwiftUI


@main
struct CryptoMonitorApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var manager = StatusItemManager()

    var body: some Scene {

        let _ = NSApplication.shared.setActivationPolicy(.accessory)
        manager.createStatusItem()
        
        let gr = WindowGroup {
            return ContentView().frame(minWidth: 100, maxWidth: 400, minHeight: 300, maxHeight: 400)
        }
        //.windowResizability(.contentSize)
        

        
        return gr

    }
}


//struct AppMenu: View {
//    func action1() {}
//    func action2() {}
//    func action3() {}
//
//    var body: some View {
//        
//        Button(action: action1, label: { Text("Action 1") })
//        Button(action: action2, label: { Text("Action 2") })
//        
//        Divider()
//
//        Button(action: action3, label: { Text("Action 3") })
//        
//        Divider()
//        
//        Button("Quit") { NSApplication.shared.terminate(nil) }
//    }
//}
//
