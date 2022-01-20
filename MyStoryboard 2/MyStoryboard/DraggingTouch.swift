//
//  DraggingTouch.swift
//  MyStoryboard
//
//  Created by Bhamini Sundararaman on 8/11/21.
//

import UIKit

class DraggingTouch: UIImageView {

    
    var touchStartPos = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touchStartPos = touch.location(in: self)
        touchStartPos.x -= frame.width / 2
        touchStartPos.y -= frame.height / 2
        
        layer.borderColor = UIColor.blue.cgColor
        
    
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.location(in:superview)
        center = CGPoint(x: point.x - touchStartPos.x, y:point.y - touchStartPos.y)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.borderColor = UIColor.red.cgColor
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
