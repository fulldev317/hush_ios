//
//  FaceDetection_NewVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit
import CoreImage
import Vision

class FaceDetection_NewVC: UIViewController {
    
    
    @IBOutlet weak var imgViewUser: UIImageView!

    
    @IBOutlet weak var collectionView_mainFilter: UICollectionView!
    
    @IBOutlet weak var view_close: UIView!
    @IBOutlet weak var collectionView_subCategory: UICollectionView!
    
    @IBOutlet weak var btn_done1: UIButtonX!
    
    @IBOutlet weak var btn_reset: UIButtonX!
    
    @IBOutlet weak var btn_done2: UIButtonX!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var viewCamera: UIView!
    
    var mainCategroyImageArr = ["19","13","6","12"]
    var mainCategroyOneImageArr = ["19","20","21","22","23","24"]
    var mainCategroyTwoImageArr = ["13","14","15","16","17","18"]
    var mainCategroyThreeImageArr = ["1","2","3","4","5","6"]
    var mainCategroyFourImageArr = ["7","8","9","10","11","12"]
    
    var selectedMainCategoryTag = Int()
    
    var selectImage = UIImage()
    var selectProp = UIImage()

    var stickerView3: StickerView?
    let imgView = UIImageView()
    var stokeColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 0).cgColor
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCollection.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.3)
        imgViewUser.image = selectImage
        self.registerCollectionviewCellXIB()
        self.collectionView_mainFilter.isHidden = false
        self.collectionView_subCategory.isHidden = true
        self.view_close.isHidden = true
        
        self.btn_done1.isHidden = false
        self.btn_reset.isHidden = true
        self.btn_done2.isHidden = true
        // Do any additional setup after loading the view.
    }
    
     @IBAction func click_back(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @IBAction func click_done(_ sender: UIButton) {
            
    //      let story = UIStoryboard(name: "Main", bundle:nil)
    //       let vc = story.instantiateViewController(withIdentifier: "CardsTabbarViewController") as! CardsTabbarViewController
    //       UIApplication.shared.windows.first?.rootViewController = vc
    //       UIApplication.shared.windows.first?.makeKeyAndVisible()
            
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
    
    func detect() {
        
//        guard let personciImage = CIImage(image: imgViewUser.image!) else {
//            return
//        }
//
//        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
//        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
//        let faces = faceDetector!.features(in: personciImage)
//
//        // For converting the Core Image Coordinates to UIView Coordinates
//        let ciImageSize = personciImage.extent.size
//        var transform = CGAffineTransform(scaleX: 1, y: -1)
//        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
//
//        for face in faces as! [CIFaceFeature] {
//
//            print("Found bounds are \(face.bounds)")
//
//            // Apply the transform to convert the coordinates
//            var faceViewBounds = face.bounds.applying(transform)
//
//            // Calculate the actual position and size of the rectangle in the image view
//            let viewSize = imgViewUser.bounds.size
//            let scale = min(viewSize.width / ciImageSize.width,
//                            viewSize.height / ciImageSize.height)
//            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2
//            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2
//
//            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
//            faceViewBounds.origin.x += offsetX - 55
//            faceViewBounds.origin.y += offsetY - 15
//
//            let faceBox = UIView(frame: faceViewBounds)
//
//            faceBox.layer.borderWidth = 3
//            faceBox.layer.borderColor = UIColor.red.cgColor
//            faceBox.backgroundColor = UIColor.clear
//
//            let imgView = UIImageView()
//
//            imgView.frame = faceBox.frame
//
//            imgView.image = #imageLiteral(resourceName: "Group_2")
//
//            imgViewUser.addSubview(faceBox)

//            if face.hasLeftEyePosition {
//                print("Left eye bounds are \(face.leftEyePosition)")
//            }
//
//            if face.hasRightEyePosition {
//                print("Right eye bounds are \(face.rightEyePosition)")
//            }
//        }
        
        self.imgView.removeFromSuperview()
        var orientation:Int32 = 0
        
        // detect image orientation, we need it to be accurate for the face detection to work
        switch selectImage.imageOrientation {
        case .up:
            orientation = 1
        case .right:
            orientation = 6
        case .down:
            orientation = 3
        case .left:
            orientation = 8
        default:
            orientation = 1
        }
        
        // vision
        let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: self.handleFaceFeatures)
        let requestHandler = VNImageRequestHandler(cgImage: selectImage.cgImage!, orientation: CGImagePropertyOrientation(rawValue: CGImagePropertyOrientation.RawValue(orientation))! ,options: [:])
        do {
            try requestHandler.perform([faceLandmarksRequest])
        } catch {
            print(error)
        }
    }
    
    func handleFaceFeatures(request: VNRequest, errror: Error?) {
        guard let observations = request.results as? [VNFaceObservation] else {
            fatalError("unexpected result type!")
        }
        
        for face in observations {
            addFaceLandmarksToImage(face)
        }
    }
    
    func addFaceLandmarksToImage(_ face: VNFaceObservation) {
        UIGraphicsBeginImageContextWithOptions(selectImage.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the image
        selectImage.draw(in: CGRect(x: 0, y: 0, width: selectImage.size.width, height: selectImage.size.height))
        
        context?.translateBy(x: 0, y: selectImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        // draw the face rect
        let w = face.boundingBox.size.width * selectImage.size.width
        let h = face.boundingBox.size.height * selectImage.size.height
        let x = face.boundingBox.origin.x * selectImage.size.width
        let y = face.boundingBox.origin.y * selectImage.size.height
        let faceRect = CGRect(x: x, y: y, width: w, height: h)
        
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imgViewUser.frame.size.height)
               
        let translate = CGAffineTransform.identity.scaledBy(x: imgViewUser.frame.size.width, y: imgViewUser.frame.size.height)
        
        let facebounds = face.boundingBox.applying(translate).applying(transform)
        
        context?.saveGState()
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setLineWidth(8.0)
        context?.addRect(faceRect)
        context?.drawPath(using: .stroke)
        context?.restoreGState()
        
        
        if self.selectedMainCategoryTag == 3{
            imgView.frame = CGRect.init(x: facebounds.origin.x, y: facebounds.origin.y-(facebounds.size.height/4), width: facebounds.size.width, height: facebounds.size.height)

        }else{
            imgView.frame = CGRect.init(x: facebounds.origin.x, y: facebounds.origin.y-(facebounds.size.height/2), width: facebounds.size.width, height: facebounds.size.height)

        }
        //imgView.frame = CGRect.init(x: facebounds.origin.x, y: facebounds.origin.y-(facebounds.size.height/2), width: facebounds.size.width, height: facebounds.size.height)

        imgView.contentMode = .scaleAspectFit
        imgView.image = selectProp

        self.viewCamera.addSubview(imgView)

        
        
        
        // face contour
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.faceContour {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // outer lips
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.outerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // inner lips
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.innerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eye
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.leftEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eye
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.rightEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left pupil
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.leftPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right pupil
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.rightPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eyebrow
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.leftEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eyebrow
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.rightEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.nose {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose crest
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.noseCrest {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // median line
        context?.saveGState()
        context?.setStrokeColor(stokeColor)
        if let landmark = face.landmarks?.medianLine {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // get the final image
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end drawing context
        UIGraphicsEndImageContext()
        
        imgViewUser.image = finalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FaceDetection_NewVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
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
                //selectProp = UIImage(named: self.mainCategroyOneImageArr[indexPath.item])!
            }else if self.selectedMainCategoryTag == 2{
                //selectProp = UIImage(named: self.mainCategroyTwoImageArr[indexPath.item])!
            }else if self.selectedMainCategoryTag == 3{
                selectProp = UIImage(named: self.mainCategroyThreeImageArr[indexPath.item])!
            }else if self.selectedMainCategoryTag == 4{
                selectProp = UIImage(named: self.mainCategroyFourImageArr[indexPath.item])!
            }else{
                
            }
            detect()
            self.view_close.isHidden = true
            self.collectionView_mainFilter.isHidden = false
            self.selectedMainCategoryTag = 0
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
