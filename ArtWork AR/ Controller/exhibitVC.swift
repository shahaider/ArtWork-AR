//
//  exhibitVC.swift
//  ArtWork AR
//
//  Created by Syed ShahRukh Haider on 17/11/2017.
//  Copyright © 2017 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CircleMenu
import ARKit

import CoreLocation
import MapKit
import ARCL

class exhibitVC: UIViewController, CLLocationManagerDelegate,CircleMenuDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var InfoLabel: UILabel!
   
    // Creating ARCL variable
    @IBOutlet weak var addButton: CircleMenu!
    let ARViewLocationView = SceneLocationView()

    // Creating CoreLocation Manager
    let locationManager = CLLocationManager()
    
    // Creating ImagePicker Variable
    let imagepickerVC = UIImagePickerController()
    
    
    // Selected IMAGE
    var selectedImage : UIImage?
    
    
    // Selected Button
    var selectedButton = 0
    var currentPtX = 0

    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.isHidden = true
        // CircleMenu Delegate
        addButton.delegate = self

        // Corelocation configuration
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // Imagepicker Delegate & Variable
        imagepickerVC.delegate = self
        
        
        // Start AR + corelocation element
        ARViewLocationView.run()
        
       
        // Add components to ARViewLocationView
        ARViewLocationView.addSubview(labelView)
        ARViewLocationView.addSubview(addButton)
        view.addSubview(ARViewLocationView)

        // Single Tap to make ADD BUTTON to appear
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        ARViewLocationView.addGestureRecognizer(singleTap)
        
        // Pinch to Resize AR-object
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        ARViewLocationView.addGestureRecognizer(pinch)
        
        
        // Rotate to Resize AR-object
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateIt))
        ARViewLocationView.addGestureRecognizer(rotate)
        
        findArt()
    
    }

    // creating LayoutSubview
    
    override func viewDidLayoutSubviews() {
        // setting AR VIEW size w.r.t scene size
        
        ARViewLocationView.frame = view.bounds
        
        
        
    }
    
    
  // TAPPED FUNCTION
    @objc func tapped(recognizer : UITapGestureRecognizer){
        
        DispatchQueue.main.async {
            self.addButton.isHidden = false

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addButton.isHidden = true
        }
        
    }
    
// PINCHED FUNCTION
    @objc func pinched(recognizer : UIPinchGestureRecognizer){
        
        if recognizer.view == ARViewLocationView{
            
            let touchview  = ARViewLocationView
            let touchPoint = recognizer.location(in: recognizer.view)
            
            let hitTest = touchview.hitTest(touchPoint, options: [:])
            
            if !hitTest.isEmpty{
                
                let hitResult = hitTest.first!
                
                
                // PANE is the  HITRESULT
                if hitResult.node.geometry?.name == "Pane"{
                    let node = hitResult.node
                    
                    let pinchAction = SCNAction.scale(by: recognizer.scale, duration: 0)
                    node.runAction(pinchAction)
                    recognizer.scale = 1
                }
            }
        }
        
    }
    
    
    // Func to Rotate AR Object
    @objc func rotateIt(recognizer : UIRotationGestureRecognizer){
        
        if recognizer.view == ARViewLocationView{
            
            let touchview  = ARViewLocationView
            let touchPoint = recognizer.location(in: recognizer.view)
            
            let hitTest = touchview.hitTest(touchPoint, options: [:])
            
            if !hitTest.isEmpty{
                
                let hitResult = hitTest.first!
                
                
                // PANE is the  HITRESULT
                if hitResult.node.geometry?.name == "Pane"{
                    let node = hitResult.node
                    
                    var PtX1 = Int(touchPoint.x)
                    
                    print("x = \(touchPoint.x)")
                    print("y = \(touchPoint.y)")

                    if self.currentPtX > PtX1{
                        self.currentPtX = PtX1

                        print(currentPtX)
                        let rotateAction = SCNAction.rotateBy(x: 0, y: 0, z: 0.02, duration: 0)
                        node.runAction(rotateAction)
                    }
                    else{
                        self.currentPtX = PtX1

                        let rotateAction = SCNAction.rotateBy(x: 0, y: 0, z: -0.02, duration: 0)
                        node.runAction(rotateAction)
                    }
                    
                  
                }
            }
        }
        
    }
    
    // CREATING PERSONAL ART
    func myArt() {
        
        self.InfoLabel.text = ("CHOOSE WHERE YOU WANT TO ADD ART")
        
        
        guard let location = self.locationManager.location else {return}
        
        
        
        if selectedButton == 2{
            
            let paneAnnotationNode = PaneAnnotation(Clocation: locationManager.location)

            DispatchQueue.main.async {
                self.ARViewLocationView.addLocationNodeForCurrentPosition(locationNode: paneAnnotationNode)
                self.selectedButton = 0
            }
            
        }
        
        else{
        if let image = selectedImage{
            

            let ArtAnnotationNode = ArtAnnotation(location: location, Image: image)
            
            
            DispatchQueue.main.async {
                self.ARViewLocationView.addLocationNodeForCurrentPosition(locationNode: ArtAnnotationNode)
            }
        }
        
        }
    }
    // IMPORT ART FROM WEB-SERVICE
    func findArt(){
        
        guard let location = self.locationManager.location else{return}
        
        
        InfoLabel.text = "TAP ON SCREEN TO ADD YOUR ART "
        InfoLabel.textColor = UIColor.white
        
        
       
        
        // ***********************
        
        /*
        // Search Request (From API)  "  get_panes(long,lat,radius, username, token)  "
        let  request = MKLocalSearchRequest()
        
        
        //Presize coordinate of user
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        
        request.region = region
        
        // Link Search Request with Region
        
        let searchResult = MKLocalSearch(request: request)
       
         */
    //****************
    
    
    
    }
    
    // Function which will help in creating CircleMenu Display
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        
     
        
            print(atIndex)
            let logo = ["camera.png","gallery.png", "frame.png"]
            let color = [UIColor.cyan, UIColor.green, UIColor.orange]
            
            
            let image = UIImage(named: logo[atIndex])
            button.backgroundColor = color[atIndex]
            button.setImage(image, for: .normal)
            button.layer.cornerRadius = CGFloat(10)
        

        
    }
    
    // Function which will assist in performing action on selected button
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        
        if atIndex == 0{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagepickerVC.sourceType = .camera
                self.present(imagepickerVC, animated: true, completion: nil)
            }
            else{
                print("Camera not available")
                
            }
        }
       
        else if atIndex == 1{
            imagepickerVC.sourceType = .photoLibrary
            self.present(imagepickerVC, animated: true, completion: nil)
            addButton.isHidden = true
        }
        
        else if atIndex == 2{
            selectedButton = atIndex
            self.myArt()
            addButton.isHidden = true
        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("***********")
        print(info)
        print("*********")
        
        let chooseimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.selectedImage = chooseimage
        
        print(self.selectedImage!)
        
        picker.dismiss(animated: true, completion: nil)
        self.myArt()
    }
    
    // FUNCTION WILL HANDLE CANCEL OPERATION
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

extension UIImage
{
    // convenience function in UIImage extension to resize a given image
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage
    {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copied!
    }
}
