import UIKit

class DiscoveryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DiscoveryCollectionView: UICollectionView!
    
    var arrPhotos = ["img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1"]
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    let cellReuseIdentifier = "cell"
    
    var Filterview: FilterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DiscoveryCollectionView.delegate = self
        DiscoveryCollectionView.dataSource = self
        
        Filterview = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)![0] as? FilterView
        Filterview?.frame = self.view.bounds
        Filterview?.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        Filterview?.addGestureRecognizer(tap)
        
        Filterview?.isUserInteractionEnabled = true
        
        Filterview?.btnEditGender.addTarget(self, action: #selector(EditGenderButtonClick(Sender:)), for: .touchUpInside)
        Filterview?.btnEditLocation.addTarget(self, action: #selector(EditLocationButtonClick(Sender:)), for: .touchUpInside)
        Filterview?.btnCancelLocation.addTarget(self, action: #selector(CancelLocationClick(Sender:)), for: .touchUpInside)
        Filterview?.btnClose.addTarget(self, action: #selector(CloseButtonClick(Sender:)), for: .touchUpInside)
        
        Filterview?.LocationView.isHidden = true
        
        Filterview?.txtLocation.addTarget(self, action: #selector(locationTextChange), for: .editingChanged)
        Filterview?.DistanceSlider.addTarget(self, action: #selector(distanceSliderValueChanged), for: UIControl.Event.valueChanged)

        
        Filterview?.tblLocation.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        Filterview?.tblLocation.tableFooterView = UIView()
        Filterview?.tblLocation.delegate = self
        Filterview?.tblLocation.dataSource = self
//        filteredData = data
        self.view.addSubview(Filterview!)
        self.view.bringSubviewToFront(Filterview!)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        Filterview?.isHidden = true
        Filterview?.LocationView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func EditLocationButtonClick(Sender:UIButton){
        Filterview?.LocationView.isHidden = false
    }
    
    @objc func CancelLocationClick(Sender:UIButton){
        Filterview?.LocationView.isHidden = true
    }
    
    @objc func CloseButtonClick(Sender:UIButton){
        Filterview?.isHidden = true
    }
    
    @objc func locationTextChange(_ textField: UITextField) {
        filteredData = textField.text!.isEmpty ? nil : data.filter { (item: String) -> Bool in
            return item.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        self.Filterview?.tblLocation.reloadData()
    }
    
    @objc func distanceSliderValueChanged(sender: UISlider){
        print(sender.value)
        self.Filterview?.lblDistance.text = (NSString(format: "%.0f", sender.value) as String) + " Yards"
    }
    
    @objc func EditGenderButtonClick(Sender:UIButton){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let maleAction = UIAlertAction(title: "Male", style: .default)
        { (_) in
            self.Filterview?.lblGender.text = "Male"
        }
        let femaleAction = UIAlertAction(title: "Female", style: .default)
        { (_) in
            self.Filterview?.lblGender.text = "Female"
        }
        let lasbianAction = UIAlertAction(title: "Lasbian", style: .default)
        { (_) in
            self.Filterview?.lblGender.text = "Lasbian"
        }
        let gayAction = UIAlertAction(title: "Gay", style: .default)
        { (_) in
            self.Filterview?.lblGender.text = "Gay"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(maleAction)
        optionMenu.addAction(femaleAction)
        optionMenu.addAction(lasbianAction)
        optionMenu.addAction(gayAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        DiscoveryCollectionView.register(UINib.init(nibName: "DiscoveryViewCell", bundle: nil), forCellWithReuseIdentifier: "DiscoveryViewCell\(indexPath.row)")
        let cell = DiscoveryCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveryViewCell\(indexPath.row)", for: indexPath) as! DiscoveryViewCell
        
        cell.setRotation(cell: indexPath.row)
       
        
        cell.CellImageView.image = UIImage(named: self.arrPhotos[indexPath.row])
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    //MARK: tableview delegate and datasource method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.filteredData != nil)
        {
            return self.filteredData.count
        }
        else{
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = (self.Filterview?.tblLocation.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Filterview?.txtLocation.text = filteredData[indexPath.row]
        Filterview?.LocationView.isHidden = true
        Filterview?.lblLocation.text = filteredData[indexPath.row]
    }
    
    @IBAction func Filter_Click(_ sender: Any) {
//        UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
////            self.Filterview?.alpha = 0
//        }, completion:  {
//           (value: Bool) in
//            self.Filterview?.isHidden = false
//        })
        Filterview?.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
}
