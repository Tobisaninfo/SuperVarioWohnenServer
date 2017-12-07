//
//  BoardEntryJsonHandler.swift
//  SuperVarioWohnenServer
//
//  Created by Tobias on 30.11.17.
//

import Foundation
import SwiftyJSON

extension BoardEntry {
    func toJson() -> JSON {
        let json = JSON([
            "id": id,
            "title": title,
            "message": message,
            
            "createDate": createDate.description,
            "expireDate": expireDate?.description  as Any
        ])

        return json
    }
    
    static func fromJson(json: JSON) -> BoardEntry {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        
        return BoardEntry(
            id: json["id"].intValue,
            title: json["title"].stringValue,
            message: json["message"].stringValue,
            
            createDate: dateFormatter.date(from: json["createDate"].stringValue) ?? Date(),
            expireDate: dateFormatter.date(from: json["expireDate"].stringValue) ?? nil,
            
            objectId: json["objectId"].intValue
        )
    }
}