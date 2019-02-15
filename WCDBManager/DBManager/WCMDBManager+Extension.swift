//
//  YLDBManager+Extension.swift
//  WDCBDemo
//
//  Created by Steven Xie on 2019/2/14.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import Foundation
import WCDBSwift

extension WCMDBManager {
    
    func addUserAccount(_ account:User){
        WCMDBManager.insert(WCMTableName.account, objects: [account], errorClosure: { (error) in
            debugPrint("\(String(describing: error))")
        }) {
            debugPrint("更新账号信息");
        }
    }
    
    
    func deleteUserAccount(_ account:User){
        WCMDBManager.delete(WCMTableName.account, conditioin: User.Properties.name == account.name) { (error) in
            debugPrint("删除用户资料报错");
        }
    }
    
    
    func selectUser(_ account:User)->[User]? {
        return WCMDBManager.select(WCMTableName.account, conditioin: User.Properties.name == account.name) { (error) in
            debugPrint("筛选数据");
        }
        
    }
    
    
    
    func addUserChild(_ child:Children){
        
        WCMDBManager.insert(WCMTableName.children, objects: [child], errorClosure: { (error) in
            debugPrint("添加孩子失败");
        }) {
            debugPrint("添加孩子")
        }
    }
    
    
    func checkUserChild(_ account:User) -> [Children]?{
        return  WCMDBManager.select(WCMTableName.children, conditioin: Children.Properties.parentId == account.uid) { (error) in
            debugPrint("查询失败");
        };
        
        
    }
    
    
    
}
