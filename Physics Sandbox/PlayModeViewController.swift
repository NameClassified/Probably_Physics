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
    let screenSize: CGRect = UIScreen.main.bounds
    
    let pi = M_PI
    
    var motionManager = CMMotionManager()


    @IBOutlet weak var rebuildButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue()) {
                (data, error) in
                DispatchQueue.main.async {
                    let xx = data!.acceleration.x
                    let yy = data!.acceleration.y
                    
                    self.gravity.angle = CGFloat(atan2(xx, yy))
                    }


            
            }
            
        }
        
        if prop.gravityMag == 0.00101936799 {
            self.view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named: "space")!, sizeChange: CGSize(width: screenSize.width,height: screenSize.height)))
        }
        else {
            self.view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"background")!, sizeChange: CGSize(width: screenSize.width, height: screenSize.height)))
        }
        
            dynamicAnimator = UIDynamicAnimator(referenceView: view)

        for index in allObjects {
            dynObjects.append(index)
            view.addSubview(index)
            index.dynamicBehavior.elasticity = index.dynamicBehavior.elasticity*CGFloat(prop.elas)
            dynamicAnimator.addBehavior(index.dynamicBehavior)
            
        }
        collisionBehavior = UICollisionBehavior(items: allObjects)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
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

    @IBAction func onStuffBeingDragged(_ sender: UIPanGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.began) {
            for index in allObjects {
                if index.frame.contains(sender.location(in: view)) {
                    
                    item = index
                    gravity.removeItem(index)
                    
                }
            }
        }
        
        
        if let a = item {
            let panGesture = sender.location(in: view)
            a.center = CGPoint(x: panGesture.x, y: panGesture.y)
            dynamicAnimator.updateItem(usingCurrentState: a)
            if sender.state == UIGestureRecognizerState.ended {
                let dragVelocity = sender.velocity(in: view)
                
                let dragPush = UIPushBehavior(items: [a], mode: UIPushBehaviorMode.instantaneous)
                dragPush.pushDirection = CGVector(dx: dragVelocity.x, dy: dragVelocity.y)
                dragPush.magnitude = sqrt((dragVelocity.x*dragVelocity.x)+(dragVelocity.y*dragVelocity.y))/500
                dynamicAnimator.addBehavior(dragPush)
                
                gravity.addItem(a)
                item = nil
            }
            
        }
            }

    @IBAction func onRebuildButtonTapped(_ sender: UIButton) {
        motionManager.stopAccelerometerUpdates()
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageResize(_ imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage!
    }
    

}
