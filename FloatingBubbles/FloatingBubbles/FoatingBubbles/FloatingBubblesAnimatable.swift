//
//  FloatingBubblesAnimatable.swift
//  FloatingBubbles
//
//  Created by Rahul Patra on 29/05/21.
//

import Foundation
import UIKit

public class BouncyFloatingViews: UIView {
    
    weak var delegate: BouncyFloatingPresenable!
    private var xvel = [CGFloat]()
    private var yvel = [CGFloat]()
    private var timer: Timer?
    
    deinit {
        timer = nil
    }
    
    func startAnimation() {
        print("")
        timer = Timer(fire: .init(), interval: 1 / delegate.fps, repeats: true, block: { [weak self] _ in
            
            guard let self = self else { return }
            // Apply movement
            for i in 0 ..< self.delegate!.floatingViews.count {
                self.move(ball: i)
            }
            // Check for collisions
            for i in 0 ..< self.delegate!.floatingViews.count {
                for j in 0 ..< self.delegate!.floatingViews.count {
                    if i != j && self.doesCollide(self.delegate!.floatingViews[i], self.delegate!.floatingViews[j]) {
                        // Calculate the normal vector between the two balls
                        let nx = self.delegate!.floatingViews[j].center.x - self.delegate!.floatingViews[i].center.x
                        let ny = self.delegate!.floatingViews[j].center.y - self.delegate!.floatingViews[i].center.y
                        // Reflect both balls
                        self.reflect(ball: i, nx: nx, ny: ny)
                        self.reflect(ball: j, nx: -nx, ny: -ny)
                        // Move both balls out of each other's hitboxes
                        self.move(ball: i)
                        self.move(ball: j)
                    }
                }
            }
            // Check for boundary collision
            for (i, ball) in self.delegate!.floatingViews.enumerated() {
                if ball.frame.minX < 0 { self.delegate!.floatingViews[i].frame.origin.x = 0; self.xvel[i] *= -1 }
                if ball.frame.maxX > self.frame.width { self.delegate!.floatingViews[i].frame.origin.x = self.frame.width - ball.frame.width; self.xvel[i] *= -1 }
                if ball.frame.minY < 0 { self.delegate!.floatingViews[i].frame.origin.y = 0; self.yvel[i] *= -1 }
                if ball.frame.maxY > self.frame.height { self.delegate!.floatingViews[i].frame.origin.y = self.frame.height - ball.frame.height; self.yvel[i] *= -1 }
            }
        })
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    private func setViews() {
        for ball in  delegate?.floatingViews ?? [] {
            ball.frame = CGRect(x: 0, y: 0, width: delegate?.heightWidth ?? 20, height: delegate?.heightWidth ?? 20)
            ball.layer.cornerRadius = ball.frame.height / 2
            ball.backgroundColor = .green
            // Try random positions until we find something valid
            while true {
                ball.frame.origin = CGPoint(x: .random(in: 0 ... self.frame.width - delegate.heightWidth),
                                            y: .random(in: 0 ... self.frame.height - delegate.heightWidth))
                // Check for collisions
                if delegate?.floatingViews.allSatisfy({ !doesCollide($0, ball) }) ?? false { break }
            }
            addSubview(ball)
            
            // Randomly generate a direction
            let theta = CGFloat.random(in: -.pi ..< .pi)
            let speed: CGFloat = 20     // Pixels per second
            xvel.append(cos(theta) * speed)
            yvel.append(sin(theta) * speed)
        }
    }
    
    private func move(ball i: Int) {
        delegate?.floatingViews[i].frame = (delegate?.floatingViews[i].frame.offsetBy(dx: self.xvel[i] / CGFloat(delegate?.fps ?? 16.0), dy: self.yvel[i] / CGFloat(delegate?.fps ?? 16.0)))!
    }
    
    private func reflect(ball: Int, nx: CGFloat, ny: CGFloat) {
        
        // Normalize the normal
        let normalMagnitude = sqrt(nx * nx + ny * ny)
        let nx = nx / normalMagnitude
        let ny = ny / normalMagnitude
        // Calculate the dot product of the ball's velocity with the normal
        let dot = xvel[ball] * nx + yvel[ball] * ny
        // Use formula to calculate the reflection. Explanation: https://chicio.medium.com/how-to-calculate-the-reflection-vector-7f8cab12dc42
        let rx = -(2 * dot * nx - xvel[ball])
        let ry = -(2 * dot * ny - yvel[ball])
        
        // Only apply the reflection if the ball is heading in the same direction as the normal
        if xvel[ball] * nx + yvel[ball] * ny >= 0 {
            xvel[ball] = rx
            yvel[ball] = ry
        }
    }
    
    private func doesCollide(_ a: UIView, _ b: UIView) -> Bool {
        let radius = a.frame.width / 2
        let distance = sqrt(pow(a.center.x - b.center.x, 2) + pow(a.center.y - b.center.y, 2))
        return distance <= 2 * radius
    }
}
