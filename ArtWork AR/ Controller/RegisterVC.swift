//
//  RegisterVC.swift
//  ArtWork AR
//
//  Created by Syed ShahRukh Haider on 14/11/2017.
//  Copyright © 2017 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {

    
    @IBOutlet weak var newUser: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//         ******************** CHECK *****************************
//        let params = ["func": "register_user",
//                      "username":"test3",
//                      "password" : "test34234",
//                      "email" : "nconsolo@me.com"
//        ]
//
//        Alamofire.request("https://exhibit-irl.com/api.php/?func=register_user&username=test3&password=test34234&email=nconsolo@me.com", method: .post, parameters: nil)
//            .validate(contentType: ["application/json"])
//            .responseJSON { (response:DataResponse<Any>) in
//                print(response)

//                let json = JSON(response.value)
//
//                let status = json[0][0].string
//
//
//                print (status)
//
//                print(globalSetting.tokenID)

        }
        
        

    

    @IBAction func submitButton(_ sender: Any) {
        
        
            
            let enterUser = newUser.text
            let enterPassword = password.text
            let emailAddress = email.text
            let params = ["func": "register_user",
                          "username": "\(String(describing:enterUser))",
                "password" : "\(String(describing: enterPassword))",
                "email" : "\(String(describing: emailAddress))"
                        ]
        
        
        // Alamofire
        
        print(enterUser!, enterPassword!, emailAddress!)
        
        Alamofire.request("https://exhibit-irl.com/api.php/?func=register_user&username=t\(enterUser!)&password=\(enterPassword!))&email=\(emailAddress!)", method: .post, parameters: nil)
            
//            Alamofire.request("https://exhibit-irl.com/api.php/?func=register_user&username=test3&password=test34234&email=nconsolo@me.com", method: .post, parameters: nil)
            
            .validate(contentType: ["application/json"])
            .responseJSON { (response:DataResponse<Any>) in
//                print(response)
                
                let json = JSON(response.value)
                
                
                // check output
                print(json)

                
                let status = json["data"][0]["status"].string!
                let message = json["data"][0]["message"].string
                
                
                // json result
                print(status)
                print(message)
               
                
                
                if status == "yes"{

                    print(enterUser , enterPassword, emailAddress)

                    print ("sucess")
                    
                    
                    // POP UP ALERT CONTROLLER
                    let alertVC = UIAlertController(title: "SUCCESS", message: "ACCOUNT CREATED", preferredStyle: .alert)
                    
                    // PERFORM SEGUE
                    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "backtomain", sender: nil)
                    }))
                   
                    //PRESENT ALERT VIEWCONROLLER ON CURRENT VC VIEW
                    self.present(alertVC, animated: true, completion: nil)
                }
                else{
                    
                    let alertVC = UIAlertController(title: "ERROR", message: message!, preferredStyle: .alert)
                    
                    alertVC.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))

                    self.present(alertVC, animated: true, completion: nil)

                }
                
            
        }
    }
    

}
