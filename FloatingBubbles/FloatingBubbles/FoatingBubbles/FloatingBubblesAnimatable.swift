//
//  FloatingBubblesAnimatable.swift
//  FloatingBubbles
//
//  Created by Chandan Sharda on 29/05/21.
//

import Foundation
import UIKit

public class BouncyFloatingViews: UIView {
    
    public weak var delegate: BouncyFloatingPresenable!
    
    private var balls = [UIView]()
    private var xvel = [CGFloat]()
    private var yvel = [CGFloat]()
    private var fps: Double {
        get {
            delegate.fps
        }
    }
    
    private var timer: Timer?
    
    deinit {
        timer = nil
        print("timer nil")
    }
    
    public func startAnimation() {
        setViews()
        timer = Timer(fire: .init(), interval: 1 / delegate.fps, repeats: true, block: { [weak self] _ in
            
            guard let self = self else { return }
            // Apply movement
             for i in 0 ..< self.balls.count {
                 self.move(ball: i)
             }
             // Check for collisions
             for i in 0 ..< self.balls.count {
                 for j in 0 ..< self.balls.count {
                     if i != j && self.doesCollide(self.balls[i], self.balls[j]) {
                         // Calculate the normal vector between the two balls
                         let nx = self.balls[j].center.x - self.balls[i].center.x
                         let ny = self.balls[j].center.y - self.balls[i].center.y
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
             for (i, ball) in self.balls.enumerated() {
                 if ball.frame.minX < 0 { self.balls[i].frame.origin.x = 0; self.xvel[i] *= -1 }
                 if ball.frame.maxX > self.frame.width { self.balls[i].frame.origin.x = self.frame.width - ball.frame.width; self.xvel[i] *= -1 }
                 if ball.frame.minY < 0 { self.balls[i].frame.origin.y = 0; self.yvel[i] *= -1 }
                 if ball.frame.maxY > self.frame.height { self.balls[i].frame.origin.y = self.frame.height - ball.frame.height; self.yvel[i] *= -1 }
             }
        })
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    private func setViews() {
        
        balls = []
        xvel = []
        yvel = []
        
        for k in 0 ..< delegate.floatingViews {
            let ball = UIView(frame: CGRect(x: 0, y: 0, width: delegate.heightWidth, height: delegate.heightWidth))
            ball.layer.cornerRadius = delegate.heightWidth / 2
            ball.backgroundColor = .green
            ball.clipsToBounds = true
            // Try random positions until we find something valid
            while true {
                ball.frame.origin = CGPoint(x: .random(in: 0 ... self.frame.width - delegate.heightWidth),
                                            y: .random(in: 0 ... self.frame.height - delegate.heightWidth))
                // Check for collisions
                if balls.allSatisfy({ !doesCollide($0, ball) }) { break }
            }
            self.addSubview(ball)
            balls.append(ball)
            // Randomly generate a direction
            let theta = CGFloat.random(in: -.pi ..< .pi)
            let speed: CGFloat = 20     // Pixels per second
            xvel.append(cos(theta) * speed)
            yvel.append(sin(theta) * speed)
            
            guard let innerView = delegate.viewForBubbleAt(withIndex: k) else { return }
            innerView.translatesAutoresizingMaskIntoConstraints = false
            ball.addSubview(innerView)
            NSLayoutConstraint.activate([
                innerView.leadingAnchor.constraint(equalTo: ball.leadingAnchor),
                innerView.trailingAnchor.constraint(equalTo: ball.trailingAnchor),
                innerView.topAnchor.constraint(equalTo: ball.topAnchor),
                innerView.bottomAnchor.constraint(equalTo: ball.bottomAnchor)
            ])
        }
    }
    
    private func move(ball i: Int) {
        balls[i].frame = balls[i].frame.offsetBy(dx: self.xvel[i] / CGFloat(fps), dy: self.yvel[i] / CGFloat(fps))
    }
    
    private func reflect(ball: Int, nx: CGFloat, ny: CGFloat) {
        
        let normalMagnitude = sqrt(nx * nx + ny * ny)
        let nx = nx / normalMagnitude
        let ny = ny / normalMagnitude
        let dot = xvel[ball] * nx + yvel[ball] * ny
        let rx = -(2 * dot * nx - xvel[ball])
        let ry = -(2 * dot * ny - yvel[ball])
        
        if xvel[ball] * nx + yvel[ball] * ny >= 0 {
            xvel[ball] = rx
            yvel[ball] = ry
        }
    }
    func doesCollide(_ a: UIView, _ b: UIView) -> Bool {
        let radius = a.frame.width / 2
        let distance = sqrt(pow(a.center.x - b.center.x, 2) + pow(a.center.y - b.center.y, 2))
        return distance <= 2 * radius
    }
}
