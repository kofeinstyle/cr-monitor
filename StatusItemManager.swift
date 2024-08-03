import Cocoa
import SwiftUI
import Combine


final class StatusItemManager: ObservableObject {
    // 1
    private var hostingView: NSHostingView<AppStatusItem>?
    private var statusItem: NSStatusItem?

    // 2
    private var sizePassthrough = PassthroughSubject<CGSize, Never>()
    private var sizeCancellable: AnyCancellable?
        
    func createStatusItem() {
        
        let frame: NSRect = NSRect(x: 0, y: 0, width: 0, height: 24);
        //-------------
        
        // 3
        let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let hostingView = NSHostingView(rootView: AppStatusItem(sizePassthrough: sizePassthrough))
        
//        statusItem.button?.action = #selector(handleClick(_:))
//        statusItem.button?.target = self
//        statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
        
        
        
        let menu = AppNSMenu()
        statusItem.menu = menu.make()

        
        hostingView.frame = frame
        statusItem.button?.frame = frame
        statusItem.button?.addSubview(hostingView)
        

        // 4
        self.statusItem = statusItem
        self.hostingView = hostingView


        // 5
        sizeCancellable = sizePassthrough.sink { [weak self] size in
            let frame = NSRect(origin: .zero, size: .init(width: size.width, height: 24))
            self?.hostingView?.frame = frame
            self?.statusItem?.button?.frame = frame
        }
    }
    
//    func  getMenuBarHeight () -> CGFloat ? {
//      guard  let desktopFrame =  NSScreen .main ? .visibleFrame else {
//        return  nil
//       }
//      let screenFrame =  NSScreen .main ? .frame
//      let menuBarHeight = screenFrame ! .height - desktopFrame.height
//      return menuBarHeight
//    }
    
//    @objc func handleClick(_ sender: NSButton) {
//        let event = NSApp.currentEvent!
//        if event.type == NSEvent.EventType.rightMouseUp {
//            // Handle right-click
//        } else {
//            showMainMenu()
//        }
//    }
//    
//    func showMainMenu() {
//        let menu = AppNSMenu()
//        
//        // Set the menu to the status item and trigger a click event
//        self.statusItem?.menu = menu.make()
//        self.statusItem?.button?.performClick(nil)
//        
//        // Clear the menu to ensure it doesn't stay attached
//        self.statusItem?.menu = nil
//    }
}
