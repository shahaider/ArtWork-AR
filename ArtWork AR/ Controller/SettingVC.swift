//
//  SettingVC.swift
//  ArtWork AR
//
//  Created by Syed ShahRukh Haider on 06/11/2017.
//  Copyright © 2017 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var unitButton: UISwitch!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var paneSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func radiusSetting(_ sender: Any) {
    
        var radius:Float = 2.0
        print("****** ", radius)
        print(radiusSlider.value * 2, "*******")
        radius = radius  * (radiusSlider.value * 2)
        
        
    }
    
    @IBAction func paneSetting(_ sender: Any) {
    }
    

}
