//
//  FloatinbBubblesService.swift
//  FloatingBubbles
//
//  Created by Chandan Sharda on 30/05/21.
//  Copyright © 2021 Chandan Sharda. All rights reserved.
//

import Foundation
import UIKit

class FloatingBubblesService {
    
    var xValues = [CGFloat]()
    var yValues = [CGFloat]()
    var views = [UIView]()
    
    func makeBubblesOn(view: UIView, delegate: FloatingBubblesPresenable) {
        
        xValues = []
        yValues = []
        views = []
        
        for i in 0 ..< delegate.floatingViews {
            let width = delegate.heightForViewAt(atIndex: i)?.width ?? delegate.heightWidth
            let height = delegate.heightForViewAt(atIndex: i)?.height ?? delegate.heightWidth
            
            let ball = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            ball.layer.cornerRadius = height / 2
            ball.backgroundColor = .green
            ball.clipsToBounds = true
            while true {
                ball.frame.origin = CGPoint(x: .random(in: 0 ... view.frame.width - width),
                                            y: .random(in: 0 ... view.frame.height - height))
                if views.allSatisfy({ !doesCollide($0, ball) }) { break }
            }
            
            view.addSubview(ball)
            views.append(ball)
            
            let theta = CGFloat.random(in: -.pi ..< .pi)
            let speed: CGFloat = delegate.speed
            xValues.append(cos(theta) * speed)
            yValues.append(sin(theta) * speed)
        }
    }
    
    
    func doesCollide(_ a: UIView, _ b: UIView) -> Bool {
        let radius = a.frame.width / 2
        let distance = sqrt(pow(a.center.x - b.center.x, 2) + pow(a.center.y - b.center.y, 2))
        
        let radius2 = b.frame.width / 2
        return distance <= radius + radius2
    }
    
    func move(ball i: Int, withFps fps: CGFloat) {
        views[i].frame = views[i].frame.offsetBy(dx: self.xValues[i] / fps, dy: self.yValues[i] / fps)
    }
    
    func reflect(ball: Int, nx: CGFloat, ny: CGFloat) {
        
        let normalMagnitude = sqrt(nx * nx + ny * ny)
        let nx = nx / normalMagnitude
        let ny = ny / normalMagnitude
        let dot = xValues[ball] * nx + yValues[ball] * ny
        let rx = -(2 * dot * nx - xValues[ball])
        let ry = -(2 * dot * ny - yValues[ball])
        
        if xValues[ball] * nx + yValues[ball] * ny >= 0 {
            xValues[ball] = rx
            yValues[ball] = ry
        }
    }
    
    func performTimer(withFps fps: CGFloat, onView view: UIView) {
        for i in 0 ..< self.views.count {
            self.move(ball: i, withFps: fps)
        }
        
        for i in 0 ..< self.views.count {
            for j in 0 ..< self.views.count {
                if i != j && self.doesCollide(views[i], views[j]) {
                    
                    let nx = self.views[j].center.x - views[i].center.x
                    let ny = self.views[j].center.y - views[i].center.y
                    
                    self.reflect(ball: i, nx: nx, ny: ny)
                    self.reflect(ball: j, nx: -nx, ny: -ny)
                    
                    self.move(ball: i, withFps: fps)
                    self.move(ball: j, withFps: fps)
                }
            }
        }
        // Check for boundary collision
        for (i, ball) in self.views.enumerated() {
            if ball.frame.minX < 0 { self.views[i].frame.origin.x = 0; self.xValues[i] *= -1 }
            if ball.frame.maxX > view.frame.width { self.views[i].frame.origin.x = view.frame.width - ball.frame.width; self.xValues[i] *= -1 }
            if ball.frame.minY < 0 { views[i].frame.origin.y = 0; self.yValues[i] *= -1 }
            if ball.frame.maxY > view.frame.height { views[i].frame.origin.y = view.frame.height - ball.frame.height; self.yValues[i] *= -1 }
        }
    }
}
