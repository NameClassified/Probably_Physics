//
//  ViewController.swift
//  Physics Sandbox
//
//  Created by caganhawthorne on 7/10/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var buildView: UIView!
    
    @IBOutlet weak var masterBall: UIView!
    
    @IBOutlet weak var masterBrick: UIView!
    
    @IBOutlet weak var masterSquare: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var buttonForReset: UIButton!
    
    @IBOutlet weak var stack: UIStackView!
    var ballSelected = false
    var brickSelected = false
    var squareSelected = false
    var itemsArray : [Item] = []
    var property : [Properties] = []
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        property.append(Properties(gravityMag: 1,elas:1))
        menuButton.backgroundColor = UIColor.cyanColor()
        playButton.backgroundColor = UIColor.greenColor()
        buttonForReset.backgroundColor = UIColor.redColor()
        view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"background")!, sizeChange: CGSizeMake(screenSize.width, screenSize.height)))
      


        masterBall.backgroundColor = UIColor.purpleColor()
        masterBall.layer.cornerRadius = 15
        masterBall.clipsToBounds = true
        
        masterBrick.backgroundColor = UIColor(patternImage: UIImage(named: "brick")!)
        masterSquare.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"Crate-1")!, sizeChange: CGSizeMake(masterSquare.bounds.width, masterSquare.bounds.height)))
    }
    
    override func didReceiveMemoryWarning() {
        for item in itemsArray{
            itemsArray.removeAll()
        }
        
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    @IBAction func onMenuButtonTapped(sender: UIButton) {
        print ("tapped")
    }
    
    @IBAction func screenIsTapped(sender: UITapGestureRecognizer) {
    

    if CGRectContainsPoint(masterBall.frame, sender.locationInView(optionsView)) {
        if ballSelected == false {
            resetMenu()
            masterBall.alpha = 0.5
            
            ballSelected = true
        }
        else{
            masterBall.alpha = 1
            ballSelected = false
        }
        
    }
        
        if CGRectContainsPoint(masterBrick.frame, sender.locationInView(optionsView)) {
            
            if brickSelected == false {
                resetMenu()
                masterBrick.alpha = 0.5
                brickSelected = true
            }

            else{
                masterBrick.alpha = 1
                brickSelected = false
            }
    
            
        }
        if CGRectContainsPoint(masterSquare.frame, sender.locationInView(optionsView)) {
            if squareSelected == false {
                resetMenu()
                masterSquare.alpha = 0.5
                squareSelected = true
            }
            else{
                masterSquare.alpha = 1
                squareSelected = false
            }
            
        }

        
        
        
        
        
        
        
        
        if CGRectContainsPoint(buildView.frame, sender.locationInView(view)) {
            let tapGesture = sender.locationInView(view)

            if ballSelected {
                let ball = Ball(x: CGFloat(tapGesture.x-10), y: CGFloat(tapGesture.y-40))
                buildView.addSubview(ball)
                itemsArray.append(ball)
            }
            else if brickSelected {
                let brick = Brick(x: CGFloat(tapGesture.x-30), y: CGFloat(tapGesture.y-50))
                buildView.addSubview(brick)
                itemsArray.append(brick)
            }
            else if squareSelected {
                let square = Square(x: CGFloat(tapGesture.x-37), y: CGFloat(tapGesture.y-70))
                buildView.addSubview(square)
                itemsArray.append(square)
            }
        }
    }
    
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        for e in itemsArray {
            e.removeFromSuperview()
        }
        resetMenu()
        itemsArray.removeAll()
        
        
    }
    
    func resetMenu() {
        ballSelected = false
        brickSelected = false
        squareSelected = false
        masterBrick.alpha = 1
        masterSquare.alpha = 1
        masterBall.alpha = 1
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        savedItemsArray.items = itemsArray

        if segue.identifier == "showPlayController" {
            let dvc = segue.destinationViewController as! PlayModeViewController
            dvc.allObjects = itemsArray
            let index = property[0]
            dvc.prop = index       }
       
        if segue.identifier == "showMenuController" {
            print ("loaded1")
            let dvc = segue.destinationViewController as! MenuViewController
            dvc.allObjects = itemsArray
            let index = property[0]
            dvc.prop = index
            
        }
        
        
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

