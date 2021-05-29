//
//  File.swift
//
//
//  Created by Chandan Sharda on 29/05/21.
//

import Foundation
import UIKit

public protocol BouncyFloatingPresenable: NSObject {
    var floatingViews: [UIView] { get}
    var fps: Double { get }
    var heightWidth: CGFloat { get }
}

extension BouncyFloatingPresenable {
    
    var floatingViews: [UIView] {
        get {
            return [UIView(), UIView()]
        }
    }
    
    var fps: Double {
        get {
            return 16.0
        }
    }
    
    var heightWidth: Double {
        get {
            return 40
        }
    }
}
