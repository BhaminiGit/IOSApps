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
    
    @IBOutlet weak var movingCameraView: UIView!  //x = 40, y = 75
   
    @IBOutlet weak var sceneView: ARView!
       
    var faceConfig = ARWorldTrackingConfiguration()

    var leftEyeNode = SCNNode()
    var rightEyeNode = SCNNode()
    var leftString = ""
    var rightString = ""
    
    private let movingCircle = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("World tracking is not supported on this device")
        }
        guard ARWorldTrackingConfiguration.supportsUserFaceTracking else{
            fatalError("Does not support face tracking")
        }
                                        
        
        // Create a session configuration
        
        

        sceneView.session.delegate = self
        faceConfig.userFaceTrackingEnabled = true
        
        movingCircle.backgroundColor = .cyan
        view.insertSubview(movingCircle, aboveSubview: sceneView)
        
        


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
        
        
        let lXYP = calcLocation(rM: leftEyeNode.transform, z: 700)
        let rXYP = calcLocation(rM: rightEyeNode.transform, z: 700)

       // print("(\(lXYP.xp), \(lXYP.yp)) (\(rXYP.xp), \(rXYP.yp)) ")
        
        makeViewMove(left: lXYP, right: rXYP)
//        if(movingCameraView.frame.origin.x == 20.0){
//            movingCameraView.frame.origin.x = 60.0
//        }
//        else if(movingCameraView.frame.origin.x == 60.0){
//            movingCameraView.frame.origin.x = 20.0
//        }
//        else {
//            movingCameraView.frame.origin.x = 20.0
//        }
//
        
//      leftEyeMatrix.text = "left\n\(leftString)"
//      rightEyeMatrix.text = "right\n\(rightString)"
        
        
//      print(faceAnchor.lookAtPoint)
//        if(faceAnchor.lookAtPoint.x > 0){
//            print("right \(faceAnchor.lookAtPoint.x)")
//        }
//        else if(faceAnchor.lookAtPoint.x < 0){
//            print("left \(faceAnchor.lookAtPoint.x)")
//        }
//        else{
//            print("center \(faceAnchor.lookAtPoint.x)")
//        }
  
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
    
    func calcLocation(rM: SCNMatrix4, z: Float) -> CGPoint{
        
        let oriVec :SCNVector4 = SCNVector4(0, 0, z, 1)
        
        let after: SCNVector4 = rM * oriVec
        
        let xp = after.x
        let yp = after.y
        let ret = CGPoint(x: CGFloat(xp) , y: CGFloat(yp))
        return ret
        
    }

    
    func makeViewMove(left: CGPoint, right: CGPoint){
        let middle = (left.x + right.x) / CGFloat(2)
        let yMid = (left.y + right.y) / CGFloat(2)
        //movingCameraView.frame.origin = CGPoint(x: middle , y: CGFloat(75) )
        movingCircle.frame.origin = CGPoint(x: middle + CGFloat(170), y: CGFloat(200))
        print("hi")
    }
}


