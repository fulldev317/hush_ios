//
//  FilterView.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import Foundation
import UIKit

class FilterView: UIView {
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var TopView: UIView!
    
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var btnEditGender: UIButton!
    @IBOutlet weak var btnCancelLocation: UIButton!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var btnEditLocation: UIButton!
    
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var LocationSearchBar: UISearchBar!
    @IBOutlet weak var tblLocation: UITableView!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var DistanceSlider: UISlider!
    @IBOutlet weak var lblDistance: UILabel!
    
    
    override class func awakeFromNib() {
       
    }
    
}
