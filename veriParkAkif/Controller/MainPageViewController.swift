//
//  MainPageViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class MainPageViewController: BaseController,NavigationBarSetUpProtocol,TabbarSetupControl {
    
    @IBOutlet weak var imageViewOfNightState: UIImageView!
    @IBOutlet weak var tableviewOfChoose: UITableView!
    @IBOutlet weak var switchMode: UISwitch!    
    
    var modelEncrypt = ModelEncrypt()
    var imkbChooseList : [String] = ["Hisse Ve Endeksler","IMKB Yükselenler","IMKB Düşenler","IMKB Hacme Göre -30","IMKB Hacme Göre -50","IMKB Hacme Göre -100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicatorShow(status: false)
        self.switchMode.isUserInteractionEnabled = true
    
        if user.nightModeEnabled{
            self.switchMode.isOn = true
            self.imageViewOfNightState.image = #imageLiteral(resourceName: "night")
            setupNavigationBar(color: UIColor(red: 27/255, green: 40/255, blue: 40/255, alpha: 1.0),textColor: .white)
            setupTabBar(color: UIColor(red: 47/255, green: 48/255, blue: 50/255, alpha: 1.0))
        }
        else{
            self.switchMode.isOn = false
            self.imageViewOfNightState.image = #imageLiteral(resourceName: "morning")
            setupNavigationBar(color: .white,textColor: .black)
            setupTabBar(color: .white)
        }
        self.switchMode.isUserInteractionEnabled = true
        switchMode.addTarget(self, action: #selector(self.switchChanged(_:)), for: UIControlEvents.valueChanged)
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableNightMode"), object: nil)

        
        
        tableviewOfChoose?.register(ImkbDetailTableViewCell.nib, forCellReuseIdentifier: ImkbDetailTableViewCell.identifier)
        tableviewOfChoose?.delegate = self
        tableviewOfChoose?.dataSource = self
        
        self.modelEncrypt.encryptDelegate = self
        self.modelEncrypt.sendDataToService()
        self.indicatorShow(status: true)
    }
    
    @objc func switchChanged(_ mySwitch: UISwitch) {
        if switchMode.isOn {
            setupNavigationBar(color: UIColor(red: 27/255, green: 40/255, blue: 40/255, alpha: 1.0),textColor: .white)
            setupTabBar(color: UIColor(red: 47/255, green: 48/255, blue: 50/255, alpha: 1.0))
            UITabBar.appearance().barTintColor = UIColor.black
            self.tabBarController?.setNeedsStatusBarAppearanceUpdate()
            user.nightModeEnabled = true
            self.imageViewOfNightState.image = #imageLiteral(resourceName: "night")
        } else {
            setupNavigationBar(color: .white, textColor: .black)
            setupTabBar(color: .white)
            UITabBar.appearance().barTintColor = UIColor.white
            self.tabBarController?.setNeedsStatusBarAppearanceUpdate()
            
            user.nightModeEnabled = false
            self.imageViewOfNightState.image = #imageLiteral(resourceName: "morning")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableNightMode"), object: nil)

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

