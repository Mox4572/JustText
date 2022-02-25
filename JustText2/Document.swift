//
//  Document.swift
//  JustText2
//
//  Created by MDNich on 2/23/22.
//
/*
Abstract:
The NSDocument subclass for reading and writing plain text files.
*/

import Cocoa

class Document: NSDocument {
    
    @objc var content = Content(contentString: "")
    var contentViewController: ViewController!
    var isRTF: Bool = false
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidMiniaturize(aNotification:)), name: NSWindow.didMiniaturizeNotification, object: nil)
        // Add your subclass-specific initialization here.
    }
    
    // MARK: - Enablers
    
    // This enables auto save.
    override class var autosavesInPlace: Bool {
        return true
    }
    
    // This enables asynchronous-writing.
    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
        return true
    }
    
    // This enables asynchronous reading.
    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {
        return ofType == "public.plain-text"
    }
    
    // MARK: - User Interface
    
    /// - Tag: makeWindowControllersExample
    override func makeWindowControllers() {
            // Returns the Storyboard that contains your Document window.
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
            self.addWindowController(windowController)
        }
    
    
    var text = NSAttributedString()
    
    var viewController: ViewController? {
        return windowControllers[0].contentViewController as? ViewController
    }
    
    // MARK: - Reading and Writing
    
    /// - Tag: readExample
    override func read(from data: Data, ofType typeName: String) throws {
        if(typeName == "public.plain-text") {
            isRTF = false
            content.read(from: data)
        }
        if(typeName == "public.rtf") {
            isRTF = true
            if let contents = NSAttributedString(rtf: data, documentAttributes: nil) {
                text = contents
            }
        }
    }
    
    /// - Tag: writeExample
    override func data(ofType typeName: String) throws -> Data {
        if(typeName == "public.plain-text") {
            if let textView = viewController?.textView {
                content.contentString = textView.string
                return content.data()!
            }
        }
        if(typeName == "public.rtf") {
            if let textView = viewController?.textView {
                let rangeLength = textView.string.count
                
                textView.breakUndoCoalescing()
                let textRange = NSRange(location: 0, length: rangeLength)
                if let contents = textView.rtf(from: textRange) {
                    return contents
                }
            }
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    
    @objc func windowDidMiniaturize(aNotification: Notification) {
        saveText()
    }
    
    func saveText() {
        if let textView = viewController?.textView {
            text = textView.attributedString()
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Printing
    
    func thePrintInfo() -> NSPrintInfo {
        let thePrintInfo = NSPrintInfo()
        thePrintInfo.horizontalPagination = .fit
        thePrintInfo.isHorizontallyCentered = false
        thePrintInfo.isVerticallyCentered = false
        
        // One inch margin all the way around.
        thePrintInfo.leftMargin = 72.0
        thePrintInfo.rightMargin = 72.0
        thePrintInfo.topMargin = 72.0
        thePrintInfo.bottomMargin = 72.0
        
        printInfo.dictionary().setObject(NSNumber(value: true),
                                         forKey: NSPrintInfo.AttributeKey.headerAndFooter as NSCopying)
        
        return thePrintInfo
    }
    
    @objc
    func printOperationDidRun(
        _ printOperation: NSPrintOperation, success: Bool, contextInfo: UnsafeMutableRawPointer?) {
        // Printing finished...
    }
    
    @IBAction override func printDocument(_ sender: Any?) {
        // Print the NSTextView.
        // Create a copy to manipulate for printing.
        let pageSize = NSSize(width: (printInfo.paperSize.width), height: (printInfo.paperSize.height))
        let textView = NSTextView(frame: NSRect(x: 0.0, y: 0.0, width: pageSize.width, height: pageSize.height))
        
        // Make sure we print on a white background.
        textView.appearance = NSAppearance(named: .aqua)
        
        // Copy the attributed string.
        textView.textStorage?.append(NSAttributedString(string: content.contentString))
        
        let printOperation = NSPrintOperation(view: textView)
        printOperation.runModal(
            for: windowControllers[0].window!,
            delegate: self,
            didRun: #selector(printOperationDidRun(_:success:contextInfo:)), contextInfo: nil)
    }
    
}
