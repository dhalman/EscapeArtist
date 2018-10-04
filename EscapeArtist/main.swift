import Cocoa

// MARK: Constants
let CTRLMOD = 262401
let LCTRL : UInt16 = 59
let ESC : UInt16 = 53

// MARK: Runtime flags
var shouldEsc = false

// MARK: Startup
class ApplicationDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        listenForEvents()
    }
}

// MARK: Event Monitor
func listenForEvents() {
    NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: keyDown)
    NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged, handler: modifierChanged)
}


// MARK: Key Input from EventHandler
func keyDown(event: (NSEvent)) -> Void {
    shouldEsc = false
}

func modifierChanged(event: (NSEvent)) -> Void {
    switch event.keyCode {
    case LCTRL : // L-CTRL
        if event.modifierFlags.rawValue == CTRLMOD {
            // CTRL on
            shouldEsc = true
            
        } else {
            // CTRL off
            if shouldEsc {
                shouldEsc = false
                
                fireKey(keyCode: ESC)
            }
        }
        break
    default:
        shouldEsc = false
    }
}

// MARK: Key Replacement
func fireKey(keyCode : UInt16) {
    let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
    let loc = CGEventTapLocation.cghidEventTap
    
    CGEvent(keyboardEventSource: src, virtualKey: keyCode, keyDown: true)?.post(tap:loc)
    CGEvent(keyboardEventSource: src, virtualKey: keyCode, keyDown: false)?.post(tap:loc)
}

// MARK: Main
let application = NSApplication.shared
let applicationDelegate = ApplicationDelegate()
application.delegate = applicationDelegate
application.activate(ignoringOtherApps: false)
application.run()
