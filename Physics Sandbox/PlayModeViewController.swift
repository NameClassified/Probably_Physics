//
//  PlayModeViewController.swift
//  Physics Sandbox
//
//  Created by connorpan on 7/10/15.
//  Copyright © 2015 Connor Pan. All rights reserved.
//

import UIKit
import CoreMotion

class PlayModeViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator = UIDynamicAnimator()
    var allObjects : [Item] = []
    var dynObjects : [UIDynamicItem] = []
    var collisionBehavior = UICollisionBehavior()
    var gravity : UIGravityBehavior!
    var prop : Properties!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var motionManager = CMMotionManager()


    @IBOutlet weak var rebuildButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.accelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                (data, error) in
                dispatch_async(dispatch_get_main_queue()) {
                    var xx = data!.acceleration.x
                    var yy = data!.acceleration.y
                    
                    self.gravity.angle = CGFloat(atan2(xx, yy))
                    }


            
            }
        }

        
        
        self.view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"background")!, sizeChange: CGSizeMake(screenSize.width, screenSize.height)))
        
        
            dynamicAnimator = UIDynamicAnimator(referenceView: view)

        for index in allObjects {
            dynObjects.append(index)
            view.addSubview(index)
            index.dynamicBehavior.elasticity = index.dynamicBehavior.elasticity*CGFloat(prop.elas)
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
    
    override func didReceiveMemoryWarning() {
            allObjects.removeAll()
            dynObjects.removeAll()
        
        
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

    @IBAction func onRebuildButtonTapped(sender: UIButton) {
        motionManager.stopAccelerometerUpdates()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
    }
    

}
