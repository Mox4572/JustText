//
//  ViewController.swift
//  JustText2
//
//  Created by Marc D. Nichitiu on 2/23/22.
//

import Cocoa

class WelcomeViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override var representedObject: Any? {
        didSet {
        }
    }
    override func viewWillDisappear() {
    }
    
    @IBAction func CreateNewDocAction(_ sender: Any) {
        let docCtrl = NSDocumentController()
        docCtrl.newDocument(docCtrl)
        self.view.window?.close()
    }
    @IBAction func openDocAction(_ sender: Any) {
        let docCtrl = NSDocumentController()
        docCtrl.openDocument(sender)
        self.view.window?.close()
    }
    @IBAction func openPrefsAction(_ sender: Any) {
        self.view.window?.close()
    }
}



class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

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

