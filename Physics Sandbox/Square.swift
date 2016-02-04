//
//  Square.swift
//  Physics Sandbox
//
//  Created by Connor Pan on 7/10/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit

class Square: Item {

    
    var square = UIView()
    
    var elasticity = 1.0
    var density = 100
    var resistance = 10
    var friction = 1
    
    
    init(x: CGFloat, y: CGFloat) {
        super.init(x: x, y: y, h: 75, w: 75)
        self.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"Crate-1")!, sizeChange: CGSizeMake(self.bounds.width, self.bounds.height)))
        
        var dynamicBehavior = UIDynamicItemBehavior(items: [self])
        dynamicBehavior = UIDynamicItemBehavior(items: [self])
        dynamicBehavior.allowsRotation = true
        
        dynamicBehavior.elasticity = CGFloat(elasticity)
        dynamicBehavior.density = CGFloat(density)
        dynamicBehavior.resistance = CGFloat(resistance)
        dynamicBehavior.friction = CGFloat(friction)
        
        print("square test")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
    }
}
