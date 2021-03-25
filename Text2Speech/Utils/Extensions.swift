//
//  Extensions.swift
//  Text2Speech
//
//  Created by Carlos Cardona on 24/03/21.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}

extension UIView {
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}
