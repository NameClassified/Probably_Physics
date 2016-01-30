//
//  Properties.swift
//  Physics Sandbox
//
//  Created by Connor Pan on 1/15/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class Properties: NSObject {
    var gravityMag : Float = 1
    var elas : Float = 1
    convenience init(gravityMag:Float, elas:Float){
        self.init()
        self.gravityMag = gravityMag
        self.elas = elas
        
    }
}
