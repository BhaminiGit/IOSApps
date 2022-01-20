//
//  ViewController.swift
//  MyFaceARApp1
//
//  Created by Bhamini Sundararaman on 1/9/22.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController,ARSessionDelegate {

   // @IBOutlet weak var leftEyeMatrix: UILabel!
    
   // @IBOutlet weak var rightEyeMatrix: UILabel!
    
    @IBOutlet weak var sceneView: ARView!
    
    var faceConfig = ARWorldTrackingConfiguration()

    
    var leftEyeNode = SCNNode()
    var rightEyeNode = SCNNode()
    var leftString = ""
    var rightString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("World tracking is not supported on this device")
        }
        guard ARWorldTrackingConfiguration.supportsUserFaceTracking else{
            fatalError("Does not support face tracking")
        }
                                        //the view's AR scene information with SceneKit content.
        
        // Create a session configuration
        
        
        sceneView.session.delegate = self
        faceConfig.userFaceTrackingEnabled = true


       
    
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(faceConfig)
    }
    
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
     
        guard #available(iOS 12.0, *), let faceAnchor = anchors[0] as? ARFaceAnchor else { return }

        leftEyeNode.simdTransform = faceAnchor.leftEyeTransform
        rightEyeNode.simdTransform = faceAnchor.rightEyeTransform

        leftString = scnmatToString(m: leftEyeNode.transform)
        rightString = scnmatToString(m: rightEyeNode.transform)
        

        
       // leftEyeMatrix.text = "left\n\(leftString)"
        
        //print(faceAnchor.lookAtPoint)
//        if(faceAnchor.lookAtPoint.x > 0){
//            print("right \(faceAnchor.lookAtPoint.x)")
//        }
//        else if(faceAnchor.lookAtPoint.x < 0){
//            print("left \(faceAnchor.lookAtPoint.x)")
//        }
//        else{
//            print("center \(faceAnchor.lookAtPoint.x)")
//        }
        

       // rightEyeMatrix.text = "right\n\(rightString)"
        
        var lXYP = calcLocation(rM: leftEyeNode.transform, z: 10.0)
        var rXYP = calcLocation(rM: rightEyeNode.transform, z: 10.0)
        
        print("(\(lXYP.xp), \(lXYP.yp)) (\(rXYP.xp), \(rXYP.yp)) ")


       

//        print("""
//        \(leftString)
//        \(rightString)
//        """)
//
        
        
    }

    

    
    
    func scnmatToString(m: SCNMatrix4) -> String{
            let tempString : String = """
            \(fs(s: m.m11)) \(fs(s: m.m21)) \(fs(s: m.m31)) \(fs(s: m.m41))
            \(fs(s: m.m12)) \(fs(s: m.m22)) \(fs(s: m.m32)) \(fs(s: m.m42))
            \(fs(s: m.m13)) \(fs(s: m.m23)) \(fs(s: m.m33)) \(fs(s: m.m43))
             \(fs(s: m.m14)) \(fs(s: m.m24)) \(fs(s: m.m34)) \(fs(s: m.m44))
            """
            return tempString
    
        }
    
    func fs(s: Float ) -> String{
        
        let temp  = NSString(format: "%.2f", s)
        
        return String(temp)
    }
    
    func calcLocation(rM: SCNMatrix4, z: Float) -> (xp: Float, yp: Float){
        
        let oriVec :SCNVector4 = SCNVector4(0, 0, z, 1)
        
        let after: SCNVector4 = rM * oriVec
        
        let xp = after.x
        let yp = after.y
        
            
        
        return(xp,yp)
    }

    
    
    func makeViewMove(x: Float, y: CGFloat){
        sceneView.frame.x
    }
}


