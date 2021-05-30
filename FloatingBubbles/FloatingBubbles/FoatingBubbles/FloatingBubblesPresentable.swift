//
//  FloatingBubblesPresenable.swift
//  FloatingBubbles
//
//  Created by Chandan Sharda on 30/05/21.
//  Copyright © 2021 Chandan Sharda. All rights reserved.
//


import Foundation
import UIKit

public protocol FloatingBubblesPresenable: NSObject {
    var floatingViews: Int { get}
    var fps: Double { get }
    var speed: CGFloat { get }
    var heightWidth: CGFloat { get }
    func viewForBubbleAt(withIndex index: Int) -> UIView?
}

extension FloatingBubblesPresenable {
    
    var floatingViews: Int {
        get {
            return 0
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
