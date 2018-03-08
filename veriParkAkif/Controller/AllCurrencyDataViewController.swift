//
//  IndexInfoDetailViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
var encryptedData : String = ""

class AllCurrencyDataViewController: BaseController {
    
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var tableViewOfIndex: UITableView!
    var modelIndexInfo = ModelIndexInfo()
   
    fileprivate var indexInfoList : [ResponseModelIndexInfo] = []{
        didSet{
                self.tableViewOfIndex.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOfIndex?.register(ImkbValueCellTableViewCell.nib, forCellReuseIdentifier: ImkbValueCellTableViewCell.identifier)
        tableViewOfIndex?.delegate = self
        tableViewOfIndex?.dataSource = self
        
        self.modelIndexInfo.indexInfoDelegate = self
        self.modelIndexInfo.encryptedData = encryptedData
        self.modelIndexInfo.sendDataToService()
        
        
        
        
    }
}
extension AllCurrencyDataViewController : IndexInfoDelegate{
    func IndexInfoDelegate(isCorrect: Bool, data: [ResponseModelIndexInfo], message: String) {
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
            
            cell.configureWithItem(item: self.indexInfoList[indexPath.section])
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexInfoList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}





