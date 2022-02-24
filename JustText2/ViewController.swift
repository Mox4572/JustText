//
//  ViewController.swift
//  JustText2
//
//  Created by MDNich on 2/23/22.
//

import Cocoa

class WelcomeViewController: NSViewController {
    static var isBeingShown: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
       // let docCtrl = NSDocumentController.shared
//        docCtrl.closeAllDocuments(withDelegate: self, didCloseAllSelector: nil, contextInfo: nil)
        WelcomeViewController.isBeingShown = true
        
        // Do any additional setup after loading the view.
    }
    override var representedObject: Any? {
        didSet {
        }
    }
    override func viewWillDisappear() {
        WelcomeViewController.isBeingShown = false
    }
    
    @IBAction func CreateNewDocAction(_ sender: Any) {
        let docCtrl = NSDocumentController.shared
        self.view.window?.close()
        docCtrl.newDocument(docCtrl)
    }
    @IBAction func openDocAction(_ sender: Any) {
        let docCtrl = NSDocumentController.shared
        self.view.window?.close()
        docCtrl.openDocument(sender)
    }
    @IBAction func openPrefsAction(_ sender: Any) {
        self.view.window?.close()
        // TODO Impl
    }
}



class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(WelcomeViewController.isBeingShown) {
            self.view.window?.close() // dont exist if the other one is there
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func checkUpdates(_ sender: Any) {
        // TODO
        print("Not yet impl")
        let alert = NSAlert()
        alert.messageText = "Cannot Check for Updates"
        alert.informativeText = "Please update manually from Github. Autoupdate has not yet been implemented."
        alert.addButton(withTitle: "OK")
        alert.runModal()

    }
    @IBAction func OpenGithub(_ sender: Any) {
        let url = URL(string: "https://github.com/Squid4572/JustText")!
        if NSWorkspace.shared.open(url) {
            print("Browser Successfully opened")
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Pass down the represented object to all of the child view controllers.
            for child in children {
                child.representedObject = representedObject
                
            }
        }
    }
    
    weak var document: Document? {
        if let docRepresentedObject = representedObject as? Document {
            return docRepresentedObject
        }
        return nil
    }
    func textDidBeginEditing(_ notification: Notification) {
        document?.objectDidBeginEditing(self)
    }

    func textDidEndEditing(_ notification: Notification) {
        document?.objectDidEndEditing(self)
    }


}

