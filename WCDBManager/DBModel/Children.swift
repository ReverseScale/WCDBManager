//
//  Children.swift
//  WDCBDemo
//
//  Created by Steven Xie on 2019/2/14.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import Foundation
import WCDBSwift

class Children: WCDBSwift.TableCodable {
    //Your own properties
    var name: String = ""
    var sex: Int = 0 // Optional if it would be nil in some WCDB selection.
    var age: Int = 0 // Optional if it would be nil in some WCDB selection.
    var parentId:String = "100"
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Children
        
        //List the properties which should be bound to table.
        case name
        case sex
        case age
        case parentId
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        //static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        //    return [
        //        .variable1: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
        //        .variable2: ColumnConstraintBinding(isUnique: true)
        //    ]
        //}
        
        //Index bindings. It is optional.
        //static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
        //    return [
        //        "_index": IndexBinding(indexesBy: CodingKeys.variable2)
        //    ]
        //}
        
        //Table constraints for multi-primary, multi-unique and so on. It is optional.
        //static var tableConstraintBindings: [TableConstraintBinding.Name: TableConstraintBinding]? {
        //    return [
        //        "MultiPrimaryConstraint": MultiPrimaryBinding(indexesBy: variable2.asIndex(orderBy: .descending), variable3.primaryKeyPart2)
        //    ]
        //}
        
        //Virtual table binding for FTS and so on. It is optional.
        //static var virtualTableBinding: VirtualTableBinding? {
        //    return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .WCDB))
        //}
    }
    
    //Properties below are needed when the primary key is auto-increment.
    //var isAutoIncrement: Bool = false
    //var lastInsertedRowID: Int64 = 0
}
