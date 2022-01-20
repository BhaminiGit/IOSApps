//
//  ViewController.swift
//  CameraTrial
//
//  Created by Bhamini Sundararaman on 6/14/21.
//  https://www.youtube.com/watch?v=ZYPNXLABf3c


import AVFoundation
import UIKit
import SwiftUI

class ViewController: UIViewController {

    //capture session
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
    
    private let flipButton: UIButton = {
        let button = UIButton(frame: CGRect(x:60, y:400, width:30, height: 30))
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lets set the background
        view.backgroundColor = .black //it's a camera, so default to black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(flipButton)
        
        
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        
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
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2,
                                       y: view.frame.size.height - 100)
    }
    
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



struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
