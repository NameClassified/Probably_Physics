//
//  PlayModeViewController.swift
//  Physics Sandbox
//
//  Created by connorpan on 7/10/15.
//  Copyright © 2015 Connor Pan. All rights reserved.
//

import UIKit

class PlayModeViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator = UIDynamicAnimator()
    var allObjects : [Item] = []
    var dynObjects : [UIDynamicItem] = []
    var collisionBehavior = UICollisionBehavior()
    var gravity : UIGravityBehavior!
    var prop : Properties!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
            
            dynamicAnimator = UIDynamicAnimator(referenceView: view)

        for index in allObjects {
            dynObjects.append(index)
            view.addSubview(index)
            dynamicAnimator.addBehavior(index.dynamicBehavior)
            
        }
        collisionBehavior = UICollisionBehavior(items: allObjects)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        for index in allObjects {
            collisionBehavior.addItem(index)
        }
        gravity = UIGravityBehavior(items: dynObjects)
        gravity.magnitude = CGFloat(prop.gravityMag)
        dynamicAnimator.addBehavior(gravity)
    }
    
    var item : Item!

    @IBAction func onStuffBeingDragged(sender: UIPanGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Began) {
            for index in allObjects {
                if CGRectContainsPoint(index.frame, sender.locationInView(view)) {
                    
                    item = index
                    gravity.removeItem(index)
                    
                }
            }
        }
        
        
        if let a = item {
            let panGesture = sender.locationInView(view)
            a.center = CGPointMake(panGesture.x, panGesture.y)
            dynamicAnimator.updateItemUsingCurrentState(a)
            if sender.state == UIGestureRecognizerState.Ended {
                gravity.addItem(a)
                item = nil
            }
            
        }
            }

}
