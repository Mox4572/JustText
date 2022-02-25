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

class EditorWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        print("awake")
        if(WelcomeViewController.isBeingShown) {
            self.close() // dont exist if the other one is there
            print("closed")
        }
        if(WelcomeViewController.isBeingShown) {
            self.close() // dont exist if the other one is there
            print("closed2")
        }
    }
}

class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet var textView: NSTextView!
    
    static func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    override func viewDidAppear() {
        // Fill the text view with the document's contents.
        let document = self.view.window?.windowController?.document as! Document
        if(document.isRTF) {
            textView.textStorage?.setAttributedString(document.text)}
        else {
            textView.string = document.content.contentString // plain text impl
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("awake")
        if(WelcomeViewController.isBeingShown) {
            self.view.window?.close() // dont exist if the other one is there
            print("closed")
        }
        if(WelcomeViewController.isBeingShown) {
            self.view.window?.close() // dont exist if the other one is there
            print("closed2")
        }
        
        ViewController.documentStatic = document ?? Document()
        if(!ViewController.documentStatic.isEqual(to: document)) {
            ViewController.documentStatic.content.contentString = textView.string
            print("updated")
        }
        
        
        textView.font = NSFont(name: "Menlo", size: CGFloat(12.0))
        ViewController.textViewStatic = textView
        
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
    @IBAction func printDocument(_ sender: Any)
    {
       textView.appearance = NSAppearance(named: .aqua)
       textView.printView(sender)
       textView.appearance = NSAppearance(named: .darkAqua)
    }
    

    
    override var representedObject: Any? {
        didSet {
            // Pass down the represented object to all of the child view controllers.
            for child in children {
                child.representedObject = representedObject
                
            }
        }
    }
    
    var printInfo = NSPrintInfo()
    
    weak var document: Document? {
        if let docRepresentedObject = representedObject as? Document {
            return docRepresentedObject
        }
        return nil
    }
    static var documentStatic = Document()
    static var textViewStatic: NSTextView? = nil

    func textDidBeginEditing(_ notification: Notification) {
        document?.objectDidBeginEditing(self)
        ViewController.documentStatic.content.contentString = textView.string

    }
    func textDidChange(_ notification: Notification) {
        document?.objectDidBeginEditing(self)
        ViewController.documentStatic.content.contentString = textView.string

    }

    func textDidEndEditing(_ notification: Notification) {
        document?.objectDidEndEditing(self)
        ViewController.documentStatic.content.contentString = textView.string

    }


}

