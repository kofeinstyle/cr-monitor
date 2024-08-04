import SwiftUI

class AppNSMenu: NSMenu {
    private lazy var applicationName = ProcessInfo.processInfo.processName
    
    required override init(title: String) {
        super.init(title: title)
        self.autoenablesItems = false
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func make () -> Self {
        
        let item = NSMenuItem(title: "Matcha", action: #selector(handleClick(_:)), keyEquivalent: "")
        item.target = self

        self.addItem(item)
        self.addItem(NSMenuItem.separator())

        self.addItem(NSMenuItem(title: "About \(applicationName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""))
        self.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        return self;
    }

    
    @objc func handleClick(_ sender: NSMenuItem) {
        if (sender.title == "Matcha") {
            if let url = URL(string: "https://matcha.xyz/tokens/arbitrum/eth") {
                NSWorkspace.shared.open(url)
            }
        }
    }
    
}
