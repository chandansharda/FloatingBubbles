//
//  FloatingBubblesPresenable.swift
//  FloatingBubbles
//
//  Created by Chandan Sharda on 30/05/21.
//  Copyright © 2021 Chandan Sharda. All rights reserved.
//


import Foundation
import UIKit

public enum FloatingBubblesAnimationType {
    case bubbleRubber
}

public protocol FloatingBubblesPresenable: NSObject {
    var floatingViews: Int { get}
    var fps: Double { get }
    var speed: CGFloat { get }
    var heightWidth: CGFloat { get }
    func viewForBubbleAt(withIndex index: Int) -> UIView?
    func heightForViewAt(atIndex index: Int) -> CGSize?
    var animationType: FloatingBubblesAnimationType? { get }
}

extension FloatingBubblesPresenable {
    
    var floatingViews: Int {
        get {
            return 0
        }
    }
    
    var animationType: FloatingBubblesAnimationType? {
        get {
            return nil
        }
    }
    
    var speed: CGFloat {
        get {
            return 20
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
