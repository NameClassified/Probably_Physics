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


    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var prop : Properties!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        gravSlider.value = ((prop.gravityMag)*100)
        // Do any additional setup after loading the view.
        saveButton.backgroundColor = UIColor.cyanColor()
        doneButton.backgroundColor = UIColor.greenColor()
        resetButton.backgroundColor = UIColor.redColor()
    
    }

    @IBAction func onResetButtonTapped(sender: UIButton) {
        gravSlider.value = 100
        prop.gravityMag = Float((gravSlider.value)/100)
        
    }

    @IBAction func onSaveButtonTapped(sender: UIButton) {
        prop.gravityMag = Float((gravSlider.value)/100)
        print (prop.gravityMag/100)
    }

    @IBAction func onDoneButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onGravSliderChanged(sender: UISlider) {
        var currentValue = Float(sender.value)

    }


}
