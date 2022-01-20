//
//  ViewController.swift
//  MyStoryboard
//
//  Created by Bhamini Sundararaman on 7/4/21.
//
import QuartzCore
import UIKit
import AVFoundation
import ARKit


class ViewController: UIViewController {

    @IBOutlet weak var CameraView: UIView!
    
    
    var faceArSession: ARSession!
    var faceConfig: ARFaceTrackingConfiguration!
    
    
    
    var session: AVCaptureSession?
    
    //photo output
    let output = AVCapturePhotoOutput()
    
    //video preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    //shudder button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x:0, y:0, width:100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    private func setUpCamera(){
            let session = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        {
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                    
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
            }
            catch{
                print(error)
                
            }
        }
    }
    
    @objc private func didTapTakePhoto(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
    }


    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            //request
            AVCaptureDevice.requestAccess(for: .video){[weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            
            }
        case .restricted:
            break
        case .authorized:
            setUpCamera()
        case .denied:
            break
        @unknown default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = CameraView.bounds
        
        shutterButton.center = CGPoint(x: CameraView.frame.size.width/2,
                                       y: CameraView.frame.size.height - 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black //it's a camera, so default to black

      
        CameraView.layer.addSublayer(previewLayer)
       // CameraView.addSubview(shutterButton)
        
        checkCameraPermissions()
        
        //shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
       
        // Do any additional setup after loading the view.
        
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("This app requres support for Face Tracking")
        }
        
        faceArSession = ARSession()
        faceConfig = ARFaceTrackingConfiguration()
        faceArSession.run(faceConfig)
    }

}



extension ViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
              return
        }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}


