//
//  IndexInfoDetailViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
var encryptedData : String = ""
var isFirstOpen : Bool = true
class AllCurrencyDataViewController: BaseController {
    
    
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var tableViewOfIndex: UITableView!
    
    var modelIndexInfo = ModelIndexInfo()
    var choosenIndex = ResponseModelIndexInfo()
    var arrayOfSearch = [ResponseModelIndexInfo]()
    var isSearching = false
    var displayByRise : Int = 0  // 0 - all data , 1 - yükselenler, 2 - düşenler
    
    
    
    fileprivate var indexInfoList : [ResponseModelIndexInfo] = []{
        didSet{
                self.tableViewOfIndex.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        isFirstOpen = true
        serachBar.returnKeyType = UIReturnKeyType.done
        serachBar.delegate = self
        
        tableViewOfIndex?.register(ImkbValueCellTableViewCell.nib, forCellReuseIdentifier: ImkbValueCellTableViewCell.identifier)
        tableViewOfIndex?.delegate = self
        tableViewOfIndex?.dataSource = self
        
        self.modelIndexInfo.indexInfoDelegate = self
        self.modelIndexInfo.encryptedData = encryptedData
        self.modelIndexInfo.imkbType = self.displayByRise
        self.modelIndexInfo.sendDataToService()
        self.indicatorShow(status: true)
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if user.nightModeEnabled{
            self.serachBar.barStyle = .black
        }
        else{
            self.serachBar.barStyle = .default
        }
        if !isFirstOpen{
            self.modelIndexInfo.encryptedData = encryptedData
            self.modelIndexInfo.sendDataToService()
            self.indicatorShow(status: true)
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! IndexDetailViewController
        destinationVC.infoIndex = self.choosenIndex
    }
    
}
extension AllCurrencyDataViewController : IndexInfoDelegate{
    func IndexInfoDelegate(isCorrect: Bool, data: [ResponseModelIndexInfo], message: String) {
        self.indicatorShow(status: false)
        if isCorrect{
            print(encryptedData)
            self.indexInfoList = data
        }
        else{
            
        }
    }
}
extension AllCurrencyDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.view.frame.height * 0.002
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewOfIndex.frame.height * 0.1
    }
}
extension AllCurrencyDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ImkbValueCellTableViewCell.identifier, for: indexPath) as? ImkbValueCellTableViewCell {
            
            if isSearching{
                cell.configureWithItem(item: self.arrayOfSearch[indexPath.section])
                return cell
            }
            else{
                cell.configureWithItem(item: self.indexInfoList[indexPath.section])
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching{
        return self.arrayOfSearch.count
        }
        else{
        return self.indexInfoList.count
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
        self.choosenIndex = self.arrayOfSearch[indexPath.section]
        }
        else{
        self.choosenIndex = self.indexInfoList[indexPath.section]
        }
        self.performSegue(withIdentifier: "segueGoToIndexDetailVC", sender: nil)
        
        
    }
}
extension AllCurrencyDataViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            tableViewOfIndex.reloadData()
        }
        else {
            isSearching = true
            arrayOfSearch = indexInfoList.filter { $0.symbol.localizedCaseInsensitiveContains(searchBar.text!) }
            tableViewOfIndex.reloadData()
        }
    }
    
}





