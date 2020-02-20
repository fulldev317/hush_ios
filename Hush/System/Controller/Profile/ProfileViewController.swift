//
//  ProfileViewController.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileimageHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var drawerProfileimage: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tbl_storieslist: UICollectionView!
    @IBOutlet weak var tbl_photosList: UICollectionView!
    
    var arrPhotos = ["img1","img1","img1","img1"]
    var arrstories = ["img1","img1","img1","img1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbl_photosList.delegate = self
        tbl_photosList.dataSource = self
        tbl_photosList.reloadData()
        
        tbl_storieslist.delegate = self
        tbl_storieslist.dataSource = self
        tbl_storieslist.reloadData()
        
        profileimageHeightConstraints.constant = UIScreen.main.bounds.height - ((self.tabBarController?.tabBar.frame.size.height)! + 100)
    }
   
    //open profile drawer on swipe
    @IBAction func BtnOpenDrawe_OnClick(_ sender: Any) {
        let topOffset = CGPoint(x: 0, y: (UIScreen.main.bounds.height - ((self.tabBarController?.tabBar.frame.size.height)! + 100)))
        scrollview.setContentOffset(topOffset, animated: true)
    }
}
extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tbl_storieslist
        {
            return self.arrstories.count
        }
        else
        {
            return self.arrPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tbl_storieslist
        {
            tbl_storieslist.register(UINib.init(nibName: "PhotosCellView", bundle: nil), forCellWithReuseIdentifier: "PhotosCellView\(indexPath.row)")
            let cell = tbl_storieslist.dequeueReusableCell(withReuseIdentifier: "PhotosCellView\(indexPath.row)", for: indexPath) as! PhottosCellView
                       
            cell.img.image = UIImage(named: self.arrstories[indexPath.row])
            return cell
        }
        else
        {
            tbl_photosList.register(UINib.init(nibName: "PhotosCellView", bundle: nil), forCellWithReuseIdentifier: "PhotosCellView\(indexPath.row)")
            let cell = tbl_photosList.dequeueReusableCell(withReuseIdentifier: "PhotosCellView\(indexPath.row)", for: indexPath) as! PhottosCellView
             cell.img.image = UIImage(named: self.arrPhotos[indexPath.row])
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.size.width / 5
           return CGSize(width: 50, height: 50)
    }
    
}
