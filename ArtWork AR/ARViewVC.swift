//
//  ARViewVC.swift
//  ArtWork AR
//
//  Created by Syed ShahRukh Haider on 06/11/2017.
//  Copyright © 2017 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import ARKit

class ARViewVC: UIViewController,ARSCNViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var ARsceneview: ARSCNView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var PlaneStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ARsceneview.delegate = self
        
        ARsceneview.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // disable label & button
        actionButton.isHidden =  true
        PlaneStatus.isHidden = true
    
        
        let scene = SCNScene()
        
        self.ARsceneview.scene = scene

    }

    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        ARsceneview.session.run(configuration)
        
    }
  
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        DispatchQueue.main.async {
            guard  anchor is ARPlaneAnchor else{
                return
            }
            self.actionButton.isHidden = false
            self.PlaneStatus.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.PlaneStatus.isHidden = true
        }
        
        
    }
    
    
    @IBAction func addbutton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertVC = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        // "PHOTO LIBRARY" OPTION

        alertVC.addAction(UIAlertAction(title: "PHOTO LIBRARY", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        // "CAMERA" OPTION
        alertVC.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                print("Camera not available")
                
            }
        }))
        
        alertVC.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // storing IMAGE
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // dismiss picker
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
