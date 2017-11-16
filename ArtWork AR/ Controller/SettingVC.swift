//
//  SettingVC.swift
//  ArtWork AR
//
//  Created by Syed ShahRukh Haider on 06/11/2017.
//  Copyright © 2017 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingVC: UIViewController {

    @IBOutlet weak var unitButton: UISwitch!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var paneSlider: UISlider!
    
    
    let username = globalSetting.userName
    let tokenID = globalSetting.tokenID
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("********")
        print("userid:\(username)")
        print("\n tokenid: \(tokenID)")
        print("********")
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
    @IBAction func logoutButton(_ sender: Any) {
        
        Alamofire.request("https://exhibit-irl.com/api.php/?func=logout&username\(username)=&token=\(tokenID)", method: .post, parameters: nil)
            .validate(contentType: ["application/json"])
            .responseJSON { (response:DataResponse<Any>) in
                
                //                print(response)
                
                print("\n\n ********** JSON  Response ***********")
                let json = JSON(response.value)
                
                
                // check output
                                    print(json)
                
                // parse response data
                let status = json["data"][0]["status"].string!
                let message = json["data"][0]["message"].string
    }
    

}
}
