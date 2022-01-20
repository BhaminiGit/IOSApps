//
//  DragingBox.swift
//  MyStoryboard
//
//  Created by Bhamini Sundararaman on 8/10/21.
//

import UIKit

class DragingBox: UIView {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        
        transform = CGAffineTransform(scaleX: 1.15, y: 1.15) //make the view 15% bigger than usual, make it easier for us to see
        superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return}
        
     
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform = .identity
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

}
