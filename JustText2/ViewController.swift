//
//  ViewController.swift
//  JustText2
//
//  Created by Marc D. Nichitiu on 2/23/22.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

