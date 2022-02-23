/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model object representing the content of the Document.
*/

import Foundation
import Cocoa

class Content: NSObject {
    @objc dynamic var contentString = ""
    
    public init(contentString: String) {
        self.contentString = contentString
    }
    func update(contentNew: String)
    {
        self.contentString = contentNew
    }

    
}

extension Content {
    
    func read(from data: Data) {
        print("reading")
        contentString = String(bytes: data, encoding: .utf8)!
        print(contentString)
    }
    
    func data() -> Data? {
        print("givedata")
        print(contentString)
        var dat = contentString.data(using: .utf8)
        print(dat)
        return dat
    }
    
}
