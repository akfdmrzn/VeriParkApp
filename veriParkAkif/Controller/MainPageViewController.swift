//
//  MainPageViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class MainPageViewController: BaseController {
    @IBOutlet weak var tableviewOfChoose: UITableView!
    
    var modelEncrypt = ModelEncrypt()
    var imkbChooseList : [String] = ["Hisse Ve Endeksler","IMKB Yükselenler","IMKB Düşenler","IMKB Hacme Göre -30","IMKB Hacme Göre -50","IMKB Hacme Göre -100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewOfChoose?.register(ImkbDetailTableViewCell.nib, forCellReuseIdentifier: ImkbDetailTableViewCell.identifier)
        tableviewOfChoose?.delegate = self
        tableviewOfChoose?.dataSource = self
        
        self.modelEncrypt.encryptDelegate = self
        self.modelEncrypt.sendDataToService()
        self.indicatorShow(status: true)
    }
}
extension MainPageViewController : EncryptDelegate{
    func isEncrypted(isCorrect: Bool, data: String, message: String) {
        self.indicatorShow(status: false)
        if isCorrect{
            print(data)
            encryptedData = data
        }
        else{
            print("error data")
        }
    }
}
extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.view.frame.height * 0.02
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableviewOfChoose.frame.height * 0.12
    }
}
extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ImkbDetailTableViewCell.identifier, for: indexPath) as? ImkbDetailTableViewCell {
            cell.labelOfProcessName.text = self.imkbChooseList[indexPath.section]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.imkbChooseList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
