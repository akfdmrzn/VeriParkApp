//
//  IMKBDisplayByVolumeViewController.swift
//  veriParkAkif
//
//  Created by akif demirezen on 10/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class IMKBDisplayByVolumeViewController: BaseController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewOfImkbList: UITableView!
    
    var encryptDateForList : String = ""
    var imkbType : Int = 0
    var modelImkb = ModelImkbList()
    var choosenIndexForSearch = ResponseModelIMKBList()
    var arrayOfSearch = [ResponseModelIMKBList]()
    var isSearching = false
    
    fileprivate var imkbList : [ResponseModelIMKBList] = []{
        didSet{
            self.tableViewOfImkbList.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user.nightModeEnabled{
            self.searchBar.barStyle = .black
        }
        else{
            self.searchBar.barStyle = .default
        }
        self.isSearching = false
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        tableViewOfImkbList?.register(IMKBListTableViewCell.nib, forCellReuseIdentifier: IMKBListTableViewCell.identifier)
        tableViewOfImkbList?.delegate = self
        tableViewOfImkbList?.dataSource = self
        
        self.modelImkb.imkbListDelegate = self
        self.modelImkb.encryptedData = encryptedData
        self.modelImkb.imkbType = self.imkbType
        self.modelImkb.sendDataToService()
        self.indicatorShow(status: true)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension IMKBDisplayByVolumeViewController : ImkbListDelegate{
  
    func getImkbList(isCorrect: Bool, data: [ResponseModelIMKBList], message: String) {
        self.indicatorShow(status: false)
        if isCorrect{
            print(encryptedData)
            self.imkbList = data
        }
        else{
            
        }
    }
}
extension IMKBDisplayByVolumeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.view.frame.height * 0.002
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewOfImkbList.frame.height * 0.1
    }
}
extension IMKBDisplayByVolumeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: IMKBListTableViewCell.identifier, for: indexPath) as? IMKBListTableViewCell {
            
            if isSearching{
                cell.configureWithItem(item: self.arrayOfSearch[indexPath.section])
                return cell
            }
            else{
                cell.configureWithItem(item: self.imkbList[indexPath.section])
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
            return self.imkbList.count
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension IMKBDisplayByVolumeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            tableViewOfImkbList.reloadData()
        }
        else {
            isSearching = true
            arrayOfSearch = imkbList.filter { $0.symbol.localizedCaseInsensitiveContains(searchBar.text!) }
            tableViewOfImkbList.reloadData()
        }
    }
    
}

