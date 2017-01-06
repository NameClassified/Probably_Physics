//
//  ViewController.swift
//  Physics Sandbox
//
//  Created by caganhawthorne on 7/10/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class ViewController: UIViewController{

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
    let screenSize: CGRect = UIScreen.main.bounds
    var space = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
            changeBackground(space)
            print("menu test")
            optionsView.backgroundColor =  optionsView.backgroundColor?.withAlphaComponent(0.7)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        property.append(Properties(gravityMag: 1,elas:1))
        

      

        masterBall.backgroundColor = UIColor.purple
        masterBall.layer.cornerRadius = 15
        masterBall.clipsToBounds = true
        
        masterBrick.backgroundColor = UIColor(patternImage: UIImage(named: "brick")!)
        masterSquare.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"Crate-1")!, sizeChange: CGSize(width: masterSquare.bounds.width, height: masterSquare.bounds.height)))
    }
    
    func changeBackground(_ space: Bool) {
        if space == false {
            view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"background")!, sizeChange: CGSize(width: screenSize.width, height: screenSize.height)))
        }
        else {
            view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"space")!, sizeChange: CGSize(width: screenSize.width, height: screenSize.height)))
        }
    }
    override func didReceiveMemoryWarning() {
        for item in itemsArray{
            itemsArray.removeAll()
        }
        
    }
    override var shouldAutorotate : Bool {
        return false
    }
    
    
    @IBAction func onMenuButtonTapped(_ sender: UIButton) {
        print ("tapped")
    }
    
    @IBAction func screenIsTapped(_ sender: UITapGestureRecognizer) {
    

    if masterBall.frame.contains(sender.location(in: optionsView)) {
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
        
        if masterBrick.frame.contains(sender.location(in: optionsView)) {
            
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
        if masterSquare.frame.contains(sender.location(in: optionsView)) {
            if squareSelected == false {
                resetMenu()
                masterSquare.alpha = 0.5
                squareSelected = true
                print ("square selected")
            }
            else{
                masterSquare.alpha = 1
                squareSelected = false
            }
            
        }

        
        
        if view.frame.contains(sender.location(in: buildView)) && !(view.frame.contains(sender.location(in:optionsView))) {
            let tapGesture = sender.location(in: view)
            print ("build screen tapped")

            if ballSelected {
                let ball = Ball(x: CGFloat(tapGesture.x-10), y: CGFloat(tapGesture.y-40))
                buildView.addSubview(ball)
                itemsArray.append(ball)
                view.bringSubview(toFront: optionsView)
            }
            else if brickSelected {
                let brick = Brick(x: CGFloat(tapGesture.x-30), y: CGFloat(tapGesture.y-50))
                buildView.addSubview(brick)
                itemsArray.append(brick)
                view.bringSubview(toFront: optionsView)
            }
            else if squareSelected {
                let square = Square(x: CGFloat(tapGesture.x-37), y: CGFloat(tapGesture.y-70))
                buildView.addSubview(square)
                itemsArray.append(square)
                view.bringSubview(toFront: optionsView)
            }
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        savedItemsArray.items = itemsArray

        if segue.identifier == "showPlayController" {
            let dvc = segue.destination as! PlayModeViewController
            dvc.allObjects = itemsArray
            let index = property[0]
            dvc.prop = index       }
       
        if segue.identifier == "showMenuController" {
            print ("loaded1")
            let dvc = segue.destination as! MenuViewController

            dvc.allObjects = itemsArray
            let index = property[0]
            dvc.prop = index
            
        }
        
        
        }
    func imageResize(_ imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage!
    }

    func spaceMode(_ isModeTrue: Bool) {
        if isModeTrue == true {
            view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"space")!, sizeChange: CGSize(width: screenSize.width, height: screenSize.height)))
            space = true
        }
        else {
            space = false
            view.backgroundColor = UIColor(patternImage: imageResize(UIImage(named:"background")!, sizeChange: CGSize(width: screenSize.width, height: screenSize.height)))
        }
    }
}

