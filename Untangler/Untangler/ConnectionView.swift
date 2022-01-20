//
//  ConnectionView.swift
//  Untangler
//
//  Created by Bhamini Sundararaman on 8/5/21.
//

import UIKit

class ConnectionView: UIView {

    var dragChanged: (() -> Void)? //optional
    var dragFinished: (() -> Void)?
    var touchStartPos = CGPoint.zero
    var after: ConnectionView! //will always exist
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchStartPos = touch.location(in: self) //where did they start to touch
        
        touchStartPos.x -= frame.width / 2
        touchStartPos.y -= frame.height / 2
        
        transform = CGAffineTransform(scaleX: 1.15, y: 1.15) //make the view 15% bigger than usual, make it easier for us to see
        superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return}
        let point = touch.location(in: superview)
        
        center = CGPoint(x: point.x - touchStartPos.x, y: point.y - touchStartPos.y) //offset the touch start pos
        dragChanged?()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform = .identity
        dragFinished?()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
