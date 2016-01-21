//
//  Item.swift
//  Physics Sandbox
//
//  Created by travis on 7/13/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import Foundation
import UIKit

class  Item : UIView {
    
    var dynamicBehavior = UIDynamicItemBehavior()
    var gravity = UIPushBehavior()
    init(x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat)
    {
        super.init(frame: CGRectMake(x, y, h, w))
        //gravity = UIPushBehavior(items:[self], mode: UIPushBehaviorMode.Continuous)
        //gravity.pushDirection = CGVectorMake(0.0, 4.9)
        
        
        
        
    }
    
    required init(coder aDecoder: NSCoder ){
        fatalError("init(coder:) has not been implemented")
    }
}