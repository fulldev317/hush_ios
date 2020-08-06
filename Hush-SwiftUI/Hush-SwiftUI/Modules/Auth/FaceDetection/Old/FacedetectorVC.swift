//
//  FacedetectorVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
import ARKit

class FacedetectorVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate,AVCapturePhotoCaptureDelegate {
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    var stillImageOutput = AVCapturePhotoOutput()
    private var drawings: [CAShapeLayer] = []
    let imgView = UIImageView()
    let viewBack = UIView()
    
    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var collectionView_mainFilter: UICollectionView!
    
    @IBOutlet weak var view_close: UIView!
    @IBOutlet weak var collectionView_subCategory: UICollectionView!
    
    @IBOutlet weak var btn_done1: UIButtonX!
    
    @IBOutlet weak var btn_reset: UIButtonX!
    
    @IBOutlet weak var btn_done2: UIButtonX!
    @IBOutlet weak var viewCollection: UIView!
    
    // MARK: - Completion
    public var completion: ((UIImage) -> Void)?
    
    var captureImage = false
    var isARVisible = true
    var mainCategroyImageArr = ["19","13","6","12"]
    var mainCategroyOneImageArr = ["19","20","21","22","23","24"]
    var mainCategroyTwoImageArr = ["13","14","15","16","17"]
    var mainCategroyThreeImageArr = ["1","2","3","4","5","6"]
    var mainCategroyFourImageArr = ["7","8","9","10","11","12"]
    
    var selectedMainCategoryTag = Int()
    
    var selectImage = UIImage()
    
    var stickerView3: StickerView?
    
    private var _selectedStickerView:StickerView?
    
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }
    
    @IBOutlet weak var viewCamera: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCollection.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
        self.registerCollectionviewCellXIB()
        self.collectionView_mainFilter.isHidden = false
        self.collectionView_subCategory.isHidden = true
        self.view_close.isHidden = true
        self.viewSlider.layer.cornerRadius = 5
        self.btn_done1.isHidden = false
        self.btn_reset.isHidden = true
        self.btn_done2.isHidden = true
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)

        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
        
        self.captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = viewCamera.bounds
        //        self.view.addSubview(imgView)
        //createBackView()
    }
    
    
    
    
    
    
    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_done(_ sender: UIButton) {
        
//        captureImage = true
                    capturePhoto()
        //            CGImageRef screen = UIGetScreenImage();
        //            UIImage *shareImage = [UIImage imageWithCGImage:screen];
        //            let screen = UIGetscre
        //            takeImage()
        //            let img = self.viewCamera.screenshot
        //            print(img.size)
        //
        //            let img2 = self.view.screenshot
        //
        //            print(img2.size)
        
    }
    func takeImage(){
        
        //        let layer = previewLayer
        //        let s = layer.frame.size
        //
        //        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        //        let context = CGContext(data: nil, width: Int(s.width), height: Int(s.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        //        // flip Y
        ////        CGContextTranslateCTM(context, 0.0, s.height);
        ////        CGContexttra
        ////        CGContextScaleCTM(context, 1.0, -1.0);
        ////
        //        context!.translateBy(x: 0, y: s.height)
        //        context!.scaleBy(x: 1.0, y: -1.0)
        //
        //        layer.render(in: context!)
        //
        //        // render layer
        //
        //        let imgRef = context?.makeImage()
        //
        //        let img = UIImage.init(cgImage: imgRef!)
        //        // here is your image
        //        print(img.size)
        
        
    }
    func image(with view: UIView) -> UIImage? {
        //        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        //        defer { UIGraphicsEndImageContext() }
        //        if let context = UIGraphicsGetCurrentContext() {
        //            view.layer.render(in: context)
        //            let image = UIGraphicsGetImageFromCurrentImageContext()
        //            return image
        //        }
        return nil
        
        //        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        //
        //        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        //
        //        let image = UIGraphicsGetImageFromCurrentImageContext()!
        //        UIGraphicsEndImageContext()
        //        return image
    }
    
    @IBAction func click_reset(_ sender: UIButton) {
        self.stickerView3?.removeFromSuperview()
        self.collectionView_mainFilter.isHidden = false
        self.selectedMainCategoryTag = 0
        self.collectionView_subCategory.isHidden = true
        self.view_close.isHidden = true
        
        self.btn_done1.isHidden = false
        self.btn_reset.isHidden = true
        self.btn_done2.isHidden = true
    }
    
    @IBAction func click_close(_ sender: UIButton) {
        self.collectionView_mainFilter.isHidden = false
        self.selectedMainCategoryTag = 0
        self.collectionView_subCategory.isHidden = true
        self.view_close.isHidden = true
        
        self.btn_done1.isHidden = false
        self.btn_reset.isHidden = true
        self.btn_done2.isHidden = true
    }
    
    @IBAction func tap(_ sender:UITapGestureRecognizer) {
        self.selectedStickerView?.showEditingHandlers = false
    }
    
    func createBackView(){
        
        viewBack.frame = CGRect.init(x: 16, y: 16, width: 50, height: 50)
        self.view.addSubview(viewBack)
        
        let img = UIImageView.init(frame: CGRect.init(x: 15, y: 15, width: 20, height: 20))
        img.image = #imageLiteral(resourceName: "back")
        viewBack.addSubview(img)
        let btnBack = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        btnBack.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        viewBack.addSubview(btnBack)
        
    }
    
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        
        if captureImage {
            captureImage = false
            guard let outputImage = getImageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
                return
            }
            DispatchQueue.main.async {
                //outputImage.imageOrientation = UIImage.Orientation.up
                
            }
            
            //            UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil)
            
        }
        
        
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        self.detectFace(in: frame)
    }
    
    private func addCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .front).devices.first else {
                fatalError("No back camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
        
        //        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        //        stillImageOutput = AVCapturePhotoOutput()
        //        if let input = try? AVCaptureDeviceInput(device: device) {
        //            if (captureSession.canAddInput(input)) {
        //                captureSession.addInput(input)
        //                if (captureSession.canAddOutput(stillImageOutput)) {
        //                    captureSession.addOutput(stillImageOutput)
        //                    //previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //
        //                }
        //            } else {
        //                print("issue here : captureSesssion.canAddInput")
        //            }
        //        } else {
        //            print("some problem here")
        //        }
    }
    
    private func showCameraFeed() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.viewCamera.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.viewCamera.bounds
    }
    
    private func getCameraFrames() {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
        self.captureSession.addOutput(self.stillImageOutput)
        
        // self.stillImageOutput.capturePhoto(with: <#T##AVCapturePhotoSettings#>, delegate: <#T##AVCapturePhotoCaptureDelegate#>)
        
        //captureSession = AVCaptureSession()
        //        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        //        stillImageOutput = AVCapturePhotoOutput()
        //
        //        if let device = AVCaptureDevice.default(for: .video),
        //           let input = try? AVCaptureDeviceInput(device: device) {
        //            if (captureSession.canAddInput(input)) {
        //                captureSession.addInput(input)
        //                if (captureSession.canAddOutput(stillImageOutput)) {
        //                    captureSession.addOutput(stillImageOutput)
        //                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //                    captureSession.startRunning()
        //                }
        //            } else {
        //                print("issue here : captureSesssion.canAddInput")
        //            }
        //        } else {
        //            print("some problem here")
        //        }
        //
        
        
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage?
    {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        return screenshotImage
    }
    func capturePhoto()
    {
        //        takeScreenshot(true)
        //        return
        //        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        //        guard let context = UIGraphicsGetCurrentContext() else { return }
        //        view.layer.render(in: context)
        //        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        //        UIGraphicsEndImageContext()
        //
        //        //Save it to the camera roll
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //
        //        return
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            let immg = UIImage(data: dataImage)!
            self.imgViewUser.image = immg.fixedOrientation()
            self.imgViewUser.isHidden = false
            //capturePhoto()
            let img2 = self.viewCamera.screenshot
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingGoodVC") as! LookingGoodVC
//            vc.userImage = img2
//            self.navigationController?.pushViewController(vc, animated: true)
            captureSession.stopRunning()
            completion?(img2)
        }
    }
    
   
    

    
    private func detectFace(in image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                if let results = request.results as? [VNFaceObservation] {
                    self.handleFaceDetectionResults(results)
                } else {
                    self.clearDrawings()
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    
    private func handleFaceDetectionResults(_ observedFaces: [VNFaceObservation]) {
        
        self.clearDrawings()
        let facesBoundingBoxes: [CAShapeLayer] = observedFaces.flatMap({ (observedFace: VNFaceObservation) -> [CAShapeLayer] in
            let faceBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            faceBoundingBoxShape.strokeColor = UIColor.clear.cgColor
            var newDrawings = [CAShapeLayer]()
            newDrawings.append(faceBoundingBoxShape)
            if let landmarks = observedFace.landmarks {
                newDrawings = newDrawings + self.drawFaceFeatures(landmarks, screenBoundingBox: faceBoundingBoxOnScreen)
            }
            return newDrawings
        })
        facesBoundingBoxes.forEach({ faceBoundingBox in self.viewCamera.layer.addSublayer(faceBoundingBox) })
        self.drawings = facesBoundingBoxes
        
    }
    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
        self.imgView.isHidden = true
    }
    
    private func drawFaceFeatures(_ landmarks: VNFaceLandmarks2D, screenBoundingBox: CGRect) -> [CAShapeLayer] {
        var faceFeaturesDrawings: [CAShapeLayer] = []
        
        
        if let leftEye = landmarks.leftEye {
            let eyeDrawing = self.drawEye(leftEye, screenBoundingBox: screenBoundingBox)
            //faceFeaturesDrawings.append(eyeDrawing)
            //print("left eye :::: \(screenBoundingBox)")
        }
        if let rightEye = landmarks.rightEye {
            let eyeDrawing = self.drawEye(rightEye, screenBoundingBox: screenBoundingBox)
            //faceFeaturesDrawings.append(eyeDrawing)
            //print("right eye :::: \(screenBoundingBox)")
            
        }
        if let faceContour = landmarks.faceContour {
            let eyeDrawing = self.drawContour(faceContour, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
            //print("faceContour :::: \(faceFeaturesDrawings.)")
            
        }
        // draw other face features here
        return faceFeaturesDrawings
    }
    private func drawEye(_ eye: VNFaceLandmarkRegion2D, screenBoundingBox: CGRect) -> CAShapeLayer {
        let eyePath = CGMutablePath()
        let eyePathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * screenBoundingBox.height + screenBoundingBox.origin.x,
                    y: eyePoint.x * screenBoundingBox.width + screenBoundingBox.origin.y)
            })
        
        eyePath.addLines(between: eyePathPoints)
        eyePath.closeSubpath()
        let eyeDrawing = CAShapeLayer()
        eyeDrawing.path = eyePath
        eyeDrawing.fillColor = UIColor.clear.cgColor
        eyeDrawing.strokeColor = UIColor.green.cgColor
        
        return eyeDrawing
    }
    private func drawContour(_ eye: VNFaceLandmarkRegion2D, screenBoundingBox: CGRect) -> CAShapeLayer {
        let eyePath = CGMutablePath()
        let eyePathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * screenBoundingBox.height + screenBoundingBox.origin.x,
                    y: eyePoint.x * screenBoundingBox.width + screenBoundingBox.origin.y)
            })
        eyePath.addLines(between: eyePathPoints)
        
        eyePath.closeSubpath()
        let eyeDrawing = CAShapeLayer()
        eyeDrawing.path = eyePath
        eyeDrawing.fillColor = UIColor.clear.cgColor
        eyeDrawing.strokeColor = UIColor.clear.cgColor
        
        
        if isARVisible {
            let imageLayer = CALayer()
            var final = CGPoint()
            if selectedMainCategoryTag == 1  {
                final = CGPoint.init(x: screenBoundingBox.width/2+screenBoundingBox.origin.x, y: screenBoundingBox.origin.y+screenBoundingBox.height/2-10)
//                imageLayer.contentsGravity = .resize
                imageLayer.frame = CGRect(x: final.x, y: final.y , width: screenBoundingBox.width, height: (screenBoundingBox.height))

            }else if selectedMainCategoryTag == 2 {
                final = CGPoint.init(x: screenBoundingBox.width/2+screenBoundingBox.origin.x, y: screenBoundingBox.origin.y+screenBoundingBox.height/3-20)

                if selectImage == UIImage.init(named: "17") {
                    imageLayer.bounds = CGRect(x: final.x-30, y: final.y+20 , width: screenBoundingBox.width+screenBoundingBox.width/3, height: (screenBoundingBox.height+screenBoundingBox.height/2))

                }else if selectImage == UIImage.init(named: "13") {
                    imageLayer.bounds = CGRect(x: final.x-20, y: final.y-50 , width: screenBoundingBox.width+screenBoundingBox.width/3, height: (screenBoundingBox.height+screenBoundingBox.height/3))

                } else{
                    imageLayer.bounds = CGRect(x: final.x, y: final.y , width: screenBoundingBox.width, height: (screenBoundingBox.height))

                }
//                imageLayer.contentsGravity = .resizeAspectFill

                
            }else if selectedMainCategoryTag == 3 {
                final = CGPoint.init(x: screenBoundingBox.width/2+screenBoundingBox.origin.x, y: (screenBoundingBox.origin.y+screenBoundingBox.height/3))
                imageLayer.contentsGravity = .resizeAspect
                imageLayer.bounds = CGRect(x: final.x, y: final.y , width: screenBoundingBox.width, height: (screenBoundingBox.height+screenBoundingBox.height/2))

                
            }else if selectedMainCategoryTag == 4 {
                final = CGPoint.init(x: screenBoundingBox.width/2+screenBoundingBox.origin.x, y: screenBoundingBox.origin.y+10)
                imageLayer.contentsGravity = .resizeAspect
                imageLayer.bounds = CGRect(x: final.x, y: final.y , width: screenBoundingBox.width, height: (screenBoundingBox.height+screenBoundingBox.height/2))

            }
            
            print("frame final",final.y)
            imageLayer.backgroundColor = UIColor.clear.cgColor
            imageLayer.position = CGPoint(x:final.x ,y:final.y)
            imageLayer.contents = selectImage.cgImage
            
            eyeDrawing.addSublayer(imageLayer)
        }
        
        
        //previewLayer.addSublayer(imageLayer)
        
        return eyeDrawing
    }
    
    func getImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) ->UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = context.makeImage() else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        return image
    }

    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
         let value = slider.value
         print("slidervalue:::::::: \(value)")
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
                // handle drag began
            case .moved:
                // handle drag moved
                break
            case .ended:
                // handle drag ended
               
               

                if value < 0.5 {
                    isARVisible = false
                    slider.value = 0
                }else{
                    isARVisible = true
                    slider.value = 1
                }
                break
            default:
                break
            }
        }
    }
    
    
}

extension FacedetectorVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionviewCellXIB(){
        self.collectionView_mainFilter.register(UINib(nibName: "editImageVc_mainFilterCell", bundle: nil), forCellWithReuseIdentifier: "editImageVc_mainFilterCell")
        self.collectionView_subCategory.register(UINib(nibName: "editImageVc_mainFilterCell", bundle: nil), forCellWithReuseIdentifier: "editImageVc_mainFilterCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView_mainFilter{
            return self.mainCategroyImageArr.count
        }else{
            if self.selectedMainCategoryTag == 1{
                return self.mainCategroyOneImageArr.count
            }else if self.selectedMainCategoryTag == 2{
                return self.mainCategroyTwoImageArr.count
            }else if self.selectedMainCategoryTag == 3{
                return self.mainCategroyThreeImageArr.count
            }else if self.selectedMainCategoryTag == 4{
                return self.mainCategroyFourImageArr.count
            }else{
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView_mainFilter{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editImageVc_mainFilterCell", for: indexPath) as! editImageVc_mainFilterCell
            cell.img_filter.image = UIImage(named: self.mainCategroyImageArr[indexPath.row])
            cell.btn_filter.isHidden = true
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editImageVc_mainFilterCell", for: indexPath) as! editImageVc_mainFilterCell
            if self.selectedMainCategoryTag == 1{
                cell.img_filter.image = UIImage(named: self.mainCategroyOneImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 2{
                cell.img_filter.image = UIImage(named: self.mainCategroyTwoImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 3{
                cell.img_filter.image = UIImage(named: self.mainCategroyThreeImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 4{
                cell.img_filter.image = UIImage(named: self.mainCategroyFourImageArr[indexPath.row])
            }
            cell.btn_filter.isHidden = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView_mainFilter
        {
            //self.collectionView_mainFilter.isHidden = true
            self.selectedMainCategoryTag = indexPath.row + 1
            self.collectionView_subCategory.isHidden = false
            self.collectionView_subCategory.reloadData()
            //self.view_close.isHidden = false
            viewCollection.isHidden = false
        }
        else
        {
            
            
            if self.selectedMainCategoryTag == 1{
                selectImage = UIImage(named: self.mainCategroyOneImageArr[indexPath.item])!//mask
            }else if self.selectedMainCategoryTag == 2{
                selectImage = UIImage(named: self.mainCategroyTwoImageArr[indexPath.item])!//batman
            }else if self.selectedMainCategoryTag == 3{
                selectImage = UIImage(named: self.mainCategroyThreeImageArr[indexPath.item])!//goggle
            }else if self.selectedMainCategoryTag == 4{
                selectImage = UIImage(named: self.mainCategroyFourImageArr[indexPath.item])!//party mask
            }else{
                
            }
            
            self.view_close.isHidden = true
            self.collectionView_mainFilter.isHidden = false
            //self.selectedMainCategoryTag = 0
            self.collectionView_subCategory.isHidden = true
            self.viewCollection.isHidden = true
            self.btn_done1.isHidden = true
            self.btn_reset.isHidden = false
            self.btn_done2.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView_mainFilter{
            return CGSize(width: self.collectionView_mainFilter.frame.size.width / 3, height: self.collectionView_mainFilter.frame.size.height)
        }else{
            return CGSize(width: self.collectionView_subCategory.frame.size.width, height: self.collectionView_subCategory.frame.size.height/4)
        }
    }
    
}

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    func shadow(size: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = size
    }
    
    var screenshot: UIImage{
        
        UIGraphicsBeginImageContext(self.bounds.size);
        let context = UIGraphicsGetCurrentContext();
        self.layer.render(in: context!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenShot!
    }
    
}

extension UIImage {
 
    func fixedOrientation() -> UIImage? {
        
        guard imageOrientation != UIImage.Orientation.up else {
            //This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            //CGImage is not available
            return nil
        }

        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError()
        }
        
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError()
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .upMirrored)
    }
        
}
