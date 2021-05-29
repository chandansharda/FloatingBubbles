//
//  File.swift
//
//
//  Created by Chandan Sharda on 29/05/21.
//
import Foundation
import UIKit

public protocol BouncyFloatingPresenable: NSObject {
    var floatingViews: Int { get}
    var fps: Double { get }
    var heightWidth: CGFloat { get }
    func viewForBubbleAt(withIndex index: Int) -> UIView?
}

extension BouncyFloatingPresenable {
    
    var floatingViews: Int {
        get {
            return 0
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
