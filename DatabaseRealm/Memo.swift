//
//  Memo.swift
//  DatabaseRealm
//
//  Created by ryo on 2022/08/19.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
