//
//  ViewController.swift
//  WCDBManager
//
//  Created by Steven Xie on 2019/2/15.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addUser(_ sender: Any) {
        
        let user = User();
        user.uid = "10011";
        user.name = "qweq1adasdwe"
        user.sex = 1;
        user.mobile = "17011962766"
        
        WCMDBManager.default.addUserAccount(user);
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        
        let user = User();
        user.uid = "100";
        user.name = "qweq1adasdwe"
        user.sex = 0;
        user.mobile = "17011962766"
        
        WCMDBManager.default.deleteUserAccount(user);
    }
    
    @IBAction func checkUser(_ sender: Any) {
        
        let user = User();
        user.uid = "100";
        user.name = "qweq1adasdwe"
        user.sex = 0;
        user.mobile = "17011962766"
        
        if let users = WCMDBManager.default.selectUser(user) {
            for u in users{
                debugPrint("\(u.name)=====\(u.mobile)")
            }
        }
    }
    
    @IBAction func addChild(_ sender: Any) {
        
        let child = Children();
        child.age = 10;
        child.name = "哈哈😁"
        child.sex = 1;
        
        WCMDBManager.default.addUserChild(child);
    }
    
    @IBAction func checkChildren(_ sender: Any) {
        
        let user = User();
        user.uid = "100";
        user.name = "qweq1adasdwe"
        user.sex = 0;
        user.mobile = "17011962766"
        
        if let childs = WCMDBManager.default.checkUserChild(user){
            for child in childs{
                debugPrint("\(child.name) -----\(child.parentId)");
            }
        }
    }
}

