//
//  YLDBManager.swift
//  WDCBDemo
//
//  Created by Steven Xie on 2019/2/14.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import Foundation
import WCDBSwift
// MARK: 数据库
enum WCMDataBase: String, DataBaseProtocol{
    /// 沙盒document路径
    fileprivate static let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
    FileManager.SearchPathDomainMask.userDomainMask, true).first!
    
    
    case account = "account.db"
    case city = "city.sqlite"
    case area = "area.sqlite"
    case children = "children.db"
    /// 数据库文件路径
    var path: String {
        switch self {
        case .account, .children :
            return WCMDataBase.documentPath + "/" + self.rawValue
        case .city, .area :
            return Bundle.main.bundlePath + "/" + self.rawValue
       
        }
    }
    
    /// 数据库标签
    var tag: Int{
        switch self {
        case .account:
            return 1
        case .city :
            return 2
        case .area :
            return 3
        case .children:
            return 4;
        }
    }
    
    /// 真实的数据库
    var db: Database{
        let db = Database(withPath: self.path);
        db.tag = tag
        return db
    }
}


// MARK:表名
enum WCMTableName:String,TableNameProtocol {
    
    case account = "account"
    case children = "children"
    /// city
    case city = "city"
    case province = "province"
    
    /// area
    case district = "district"
    
    
    /// 表对应的数据库
    var database: Database {
        switch self {
        case .account,.children:
            return WCMDataBase.account.db;
        case .city, .district, .province:
            return WCMDataBase.area.db;
        }
    }
    
    
    /// 查询 提前定义
    var selectTable: Select?{
         var pre_select: Select?
         switch self {
            case .account:
              pre_select = try? database.prepareSelect(of: User.self, fromTable: tableName, isDistinct: true)
         case .city:
            pre_select = try? database.prepareSelect(of: City.self, fromTable: tableName, isDistinct: true)
         case .province:
            pre_select = try? database.prepareSelect(of: Province.self, fromTable: tableName, isDistinct: true)
            
         case .district:
            pre_select = try? database.prepareSelect(of: District.self, fromTable: tableName, isDistinct: true)
         case .children:
            pre_select = try? database.prepareSelect(of: Children.self, fromTable: tableName, isDistinct: true);
            
        }
   
        return pre_select;
    }
    
   
    /// 表的名称
    var tableName: String{
        return self.rawValue;
    }
    
}






class WCMDBManager: NSObject {
    
    static let `default` = WCMDBManager();
    override init() {
        super.init();
        self.initializa();
    }
    /// 数据库表的初始化
    final func initializa(){
        debugPrint("数据库表的初始化");
        do {
            
            // 库创建表
         try WCMDataBase.account.db.run(transaction: {
            
              try WCMDataBase.account.db.create(table: WCMTableName.account.tableName, of: User.self);
             try WCMDataBase.account.db.create(table: WCMTableName.children.tableName, of: Children.self);
            })
            
            
            
            // 开启事务
            try WCMDataBase.area.db.run(transaction: {
                
                try WCMDataBase.area.db.create(table: WCMTableName.district.tableName, of: District.self);
                
                try WCMDataBase.area.db.create(table: WCMTableName.city.tableName, of: City.self);
                
                try WCMDataBase.area.db.create(table: WCMTableName.province.tableName, of: Province.self);
                
                
            });
        } catch  {
            print("初始化数据库及ORM对应关系建立失败 \(error)");
        }
        
    }
    
}


extension WCMDBManager : DBManagerProtocol {
    
    typealias ErrorType = (WCDBSwift.Error?)->Void
    typealias SuccessType = ()->Void
    
    
    ///更新数据
    class func update<T>(_ table: TableNameProtocol, object: T, propertys: [PropertyConvertible], conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T : TableEncodable {
        WCDBManager.default.update(table.database, tableName: table.tableName, object: object, propertys: propertys, conditioin: conditioin, errorClosure: errorClosure, successClosure: successClosure);
    }
    
    /// 插入数据
    class func insert<T>(_ table: TableNameProtocol, objects: [T], errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T : TableEncodable {
        WCDBManager.default.insert(table.database, tableName: table.tableName, objects: objects, errorClosurer: errorClosure, success: successClosure);
    }
    
    /// 查询数据
    class func select<T>(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?) -> [T]? where T : TableEncodable {
       return WCDBManager.default.select(table.selectTable, conditioin: conditioin, errorClosure: errorClosure);
    }
    
    /// 删除数据
    class func delete(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?) {
        WCDBManager.default.delete(table.database, tableName: table.tableName, condition: conditioin, errorClosure: errorClosure);
    }
    
    /// 增量添加
    class func insertOrReplace<T>(_ table: TableNameProtocol, objects: [T], errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T : TableEncodable {
        WCDBManager.default.insertOrReplace(table.database, tableName: table.tableName, objects: objects, errorClosure: errorClosure, successClosure: successClosure);
    }


    
}





