//
//  Ball.swift
//  Physics Sandbox
//
//  Created by caganhawthorne on 7/10/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit

class Ball: Item {
    
    
    
    var elasticity = 0.7
    var density = 0.1
    var resistance = 0.6
    var friction = 0.05
    
    
    init(x: CGFloat, y: CGFloat)
    {
        
        super.init(x: x,y: y, h: 30, w: 30)
        self.backgroundColor = UIColor.purple
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        dynamicBehavior = UIDynamicItemBehavior(items: [self])
        
        
        dynamicBehavior.friction = CGFloat(friction)
        dynamicBehavior.resistance = CGFloat(resistance)
        dynamicBehavior.elasticity = CGFloat(elasticity)
        dynamicBehavior.density = CGFloat(density)
        dynamicBehavior.allowsRotation = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
