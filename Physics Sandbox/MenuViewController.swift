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
         
        gravSlider.value = (prop.gravityMag)*100
        gMultLabel.text=String(format:"%.2f",gravSlider.value/100)
      
        elasSlider.value = (prop.elas)*100
        elasMultLabel.text = String(format:"%.2f",prop.elas)
        
       // Do any additional setup after loading the view.
        saveButton.backgroundColor = UIColor.cyanColor()
        doneButton.backgroundColor = UIColor.greenColor()
        resetButton.backgroundColor = UIColor.redColor()
    
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
        prop.gravityMag = Float((gravSlider.value)/100)
        prop.elas = Float((elasSlider.value)/100)

    }

    @IBAction func onDoneButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onGravSliderChanged(sender: UISlider) {
        var currentValue = Float(sender.value)
        var gmult = currentValue/Float(100.0)
        gMultLabel.text = String(format: "%.2f",gmult)
    }

    @IBAction func onElasSliderChanged(sender: UISlider) {
        var currentValue = Float(sender.value)
        var elasMult = currentValue/100.0
        elasMultLabel.text = String(format:"%.2f",elasMult)
    }



}
