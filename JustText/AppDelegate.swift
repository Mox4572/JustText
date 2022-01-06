//
//  AppDelegate.swift
//  UI Test
//
//  Created by Dante Vaughn on 12/19/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	@IBOutlet var window: NSWindow!
	
    func applicationDidFinishLaunching(_ aNotification: Notification) { }
	
    func applicationWillTerminate(_ aNotification: Notification) { }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool { return true }
	
	@IBAction func openMarkdownTool(_ sender: NSMenuItem) {
		if FileManager.default.fileExists(atPath: "/Applications/Markdown Tool.app") {
			let url = NSURL(fileURLWithPath: "/Applications/Markdown Tool.app", isDirectory: true) as URL
			NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration())
		} else {
			let alert = NSAlert()
			alert.alertStyle = .warning
			alert.messageText = "You don't have Markdown Tool installed"
			let okButton = alert.addButton(withTitle: "OK")
			let moreInformationButton = alert.addButton(withTitle: "More Information")
			okButton.tag = NSApplication.ModalResponse.OK.rawValue
			moreInformationButton.tag = NSApplication.ModalResponse.continue.rawValue
			let response = alert.runModal()
			if response == .continue {
				NSWorkspace.shared.open(URL(string: "https://github.com/Squid4572/MarkdownTool/releases")!)
			}
		}
	}
}
