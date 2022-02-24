//
//  AppDelegate.swift
//  JustText2
//
//  Created by MDNich on 2/23/22.
//

import Cocoa
import Foundation

@main
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminate(_ sender: NSApplication)-> NSApplication.TerminateReply {
        return .terminateNow
    }
    @IBAction func printDocument(_ sender: Any?)
    {
        if let localViewCtrl = NSApplication.shared.mainWindow?.contentViewController as! ViewController? {
            localViewCtrl.printDocument(sender)
        }
    }
    



}

