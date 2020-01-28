//
//  editImageVc.swift
//  Hush
//
//  Created by RAVI on 22/01/20.
//  Copyright © 2020 Reveralto. All rights reserved.
//

import UIKit

class editImageVc: UIViewController {

    @IBOutlet weak var img_filter: UIImageView!
    @IBOutlet weak var collectionView_mainFilter: UICollectionView!
    
    @IBOutlet weak var view_close: UIView!
    @IBOutlet weak var collectionView_subCategory: UICollectionView!
    
    @IBOutlet weak var btn_done1: UIButtonX!
    
    @IBOutlet weak var btn_reset: UIButtonX!
    
    @IBOutlet weak var btn_done2: UIButtonX!
    
    
    var mainCategroyImageArr = ["19","13","6","12"]
    var mainCategroyOneImageArr = ["19","20","21","22","23","24"]
    var mainCategroyTwoImageArr = ["13","14","15","16","17","18"]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerCollectionviewCellXIB()
        self.collectionView_mainFilter.isHidden = false
        self.collectionView_subCategory.isHidden = true
        self.view_close.isHidden = true
        
        self.btn_done1.isHidden = false
        self.btn_reset.isHidden = true
        self.btn_done2.isHidden = true
        
        self.img_filter.image = self.selectImage
        
    }
    

    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_done(_ sender: UIButton) {
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
    
}

extension editImageVc: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
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
        if collectionView == self.collectionView_mainFilter{
            self.collectionView_mainFilter.isHidden = true
            self.selectedMainCategoryTag = indexPath.row + 1
            self.collectionView_subCategory.isHidden = false
            self.collectionView_subCategory.reloadData()
            self.view_close.isHidden = false
        }else{
            
            if self.selectedMainCategoryTag == 1{
                self.initialize(selectImage: self.mainCategroyOneImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 2{
                self.initialize(selectImage: self.mainCategroyTwoImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 3{
                self.initialize(selectImage: self.mainCategroyThreeImageArr[indexPath.row])
            }else if self.selectedMainCategoryTag == 4{
                self.initialize(selectImage: self.mainCategroyFourImageArr[indexPath.row])
            }
            
            self.view_close.isHidden = true
            self.collectionView_mainFilter.isHidden = false
            self.selectedMainCategoryTag = 0
            self.collectionView_subCategory.isHidden = true
            
            self.btn_done1.isHidden = true
            self.btn_reset.isHidden = false
            self.btn_done2.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView_mainFilter{
            return CGSize(width: self.collectionView_mainFilter.frame.size.width / 3, height: self.collectionView_mainFilter.frame.size.height)
        }else{
            return CGSize(width: self.collectionView_subCategory.frame.size.width / 4, height: self.collectionView_subCategory.frame.size.height)
        }
    }
    
}


// MARK: Functions
extension editImageVc {
    func initialize(selectImage: String) {
        
        // UIImageView as a container
        let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        testImage.image = UIImage.init(named: selectImage)
        
        self.stickerView3 = StickerView.init(contentView: testImage)
        self.stickerView3?.center = CGPoint.init(x: 150, y: 150)
        self.stickerView3?.delegate = self
        self.stickerView3?.setImage(UIImage.init(named: "cancel")!, forHandler: StickerViewHandler.close)
        self.stickerView3?.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
        self.stickerView3?.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
        self.stickerView3?.showEditingHandlers = false
        self.view.addSubview(stickerView3!)
        
//        self.selectedStickerView = stickerView
        
    }
}

// MARK: StickerViewDelegate
extension editImageVc: StickerViewDelegate {
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
}
