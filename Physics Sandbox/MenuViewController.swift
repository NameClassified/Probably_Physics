//
//  MenuViewController.swift
//  Physics Sandbox
//
//  Created by Connor Pan on 12/7/15.
//  Copyright © 2015 Connor Pan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var allObjects : [Item] = []


    @IBOutlet weak var gravSlider: UISlider!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var gMultLabel: UILabel!

    @IBOutlet weak var elasLabel: UILabel!
    @IBOutlet weak var elasMultLabel: UILabel!
    @IBOutlet weak var elasSlider: UISlider!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var prop : Properties!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext

        view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        if prop.gravityMag != 0.00101936799 {
            gravSlider.value = (prop.gravityMag)*100
            gMultLabel.text=String(format:"%.2f",gravSlider.value/100)
        }
        else {
            gravSlider.value = 0
            gMultLabel.text = "Space"
        }
        elasSlider.value = (prop.elas)*100
        elasMultLabel.text = String(format:"%.2f",prop.elas)
        
    
    }
    
    @IBAction func onResetButtonTapped(sender: UIButton) {
        gravSlider.value = 100
        prop.gravityMag = Float((gravSlider.value)/100)
        gMultLabel.text=String(format:"%.2f",gravSlider.value/100)
        
        elasSlider.value = 100
        prop.elas = Float((elasSlider.value)/100)
        elasMultLabel.text = String(format:"%.2f",prop.elas)

        
    }

    @IBAction func onSaveButtonTapped(sender: UIButton) {
        if gravSlider.value != 0{
            prop.gravityMag = Float((gravSlider.value)/100)
            prop.elas = Float((elasSlider.value)/100)
           
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                let viewController = UIApplication.sharedApplication().windows[0].rootViewController?.childViewControllers[0] as? ViewController
                viewController?.changeBackground(false)
            })
            
        }
        else {
            prop.gravityMag = Float(0.00101936799)
            
            prop.elas = Float((elasSlider.value)/100)
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                let viewController = UIApplication.sharedApplication().windows[0].rootViewController?.childViewControllers[0] as? ViewController
                viewController?.changeBackground(true)
                
            })
        }
    }

    @IBAction func onDoneButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onGravSliderChanged(sender: UISlider) {
        
        let currentValue = Float(sender.value)
        var gmult = currentValue/Float(100.0)
        if gmult != 0 {
            gMultLabel.text = String(format: "%.2f",gmult)
        }
        else {
            gmult = Float(0.00101936799)
            gMultLabel.text = "Space"
        }
        
        
    }

    @IBAction func onElasSliderChanged(sender: UISlider) {
        let currentValue = Float(sender.value)
        let elasMult = currentValue/100.0
        elasMultLabel.text = String(format:"%.2f",elasMult)
    }



}
