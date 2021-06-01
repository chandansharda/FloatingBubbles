//
//  FloatingBubbleView.swift
//  FloatingBubbles
//
//  Created by Chandan Sharda on 30/05/21.
//  Copyright © 2021 Chandan Sharda. All rights reserved.
//

import Foundation
import UIKit

public class FloatingBubbleView: UIView {
    
    public weak var delegate: FloatingBubblesPresenable!
    private var service: FloatingBubblesService? = FloatingBubblesService()
    private var timer: Timer?
    
    deinit {
        timer = nil
        print("timer nil")
    }
    
    public func startAnimation() {
        setViews()
        timer = Timer(fire: .init(), interval: 1 / delegate.fps, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.service?.performTimer(withFps: CGFloat(self.delegate.fps), onView: self)
        })
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    func reloadData() {
        for k in 0..<(service?.views.count ?? 0) {
            guard let innerView = delegate.viewForBubbleAt(withIndex: k) else { return }
            innerView.translatesAutoresizingMaskIntoConstraints = false
            if !(service?.views[k].subviews.contains(innerView) ?? false) {
                service?.views[k].addSubview(innerView)
                NSLayoutConstraint.activate([
                    innerView.leadingAnchor.constraint(equalTo: service!.views[k].leadingAnchor),
                    innerView.trailingAnchor.constraint(equalTo: service!.views[k].trailingAnchor),
                    innerView.topAnchor.constraint(equalTo: service!.views[k].topAnchor),
                    innerView.bottomAnchor.constraint(equalTo: service!.views[k].bottomAnchor)
                ])
            }
        }
    }
    
    private func setViews() {
        timer?.invalidate()
        timer = nil
        
        service?.makeBubblesOn(view: self, delegate: delegate)
        reloadData()
    }
    
    private func move(ball i: Int) {
        service?.move(ball: i, withFps: CGFloat(delegate.fps))
    }
    
    private func reflect(ball: Int, nx: CGFloat, ny: CGFloat) {
        service?.reflect(ball: ball, nx: nx, ny: ny)
    }
}
