import Cocoa

// MARK: Constants
let LCTRLMOD = 262401
let RCTRLMOD = 270592
let LCTRL : UInt16 = 59
let RCTRL : UInt16 = 62
let ESC : UInt16 = 53

// MARK: Runtime flags
var shouldEsc = false

// MARK: Startup
class ApplicationDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let os = ProcessInfo().operatingSystemVersion
        if os.majorVersion == 10 && os.minorVersion >= 14 {
            if !acquirePrivileges() {
                print("You need to enable EscapeArtist in the System Preferences")
            }
        }
        
        listenForEvents()
    }
}

// MARK: Acquire Privleges
func acquirePrivileges() -> Bool {
    let attrs = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as
    CFDictionary
    return AXIsProcessTrustedWithOptions(attrs)
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
    case RCTRL :
        handleCtrl(flags:event.modifierFlags.rawValue)
        break
    case LCTRL:
        handleCtrl(flags:event.modifierFlags.rawValue)
        break
    default:
        shouldEsc = false
    }
}

func handleCtrl(flags : UInt) {
    if flags == LCTRLMOD || flags == RCTRLMOD {
        // CTRL on
        shouldEsc = true
        
    } else {
        // CTRL off
        if shouldEsc {
            shouldEsc = false
            
            fireKey(keyCode: ESC)
        }
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
