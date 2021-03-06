//
//  File.swift
//  SuperVarioWohnenServerPackageDescription
//
//  Created by Tobias on 11.11.17.
//

import Foundation
import MySQL

struct Tenant: QueryRowResultType, QueryParameterDictionaryType {
    var id: Int
    var name: String
    var lastName: String
    
    var telefon: String
    var mobil: String
    var mail: String
    
    var qrcode: String
    var active: Bool
    
    var objectId: Int
    
    static func decodeRow(r: QueryRowResult) throws -> Tenant {
        return try Tenant(
            id: r <| "id",
            name: r <| "name",
            lastName: r <| "last_name",
            
            telefon: r <| "telefon",
            mobil: r <| "mobil",
            mail: r <| "mail",
            
            qrcode: r <| "qrcode",
            active: (r <| "active") == 0 ? false : true,
            
            objectId : r <| "object_id"
        )
    }
    
    func queryParameter() throws -> QueryDictionary {
        return QueryDictionary([
            "name": name,
            "last_name": lastName,
            
            "telefon": telefon,
            "mobil": mobil,
            "mail": mail,
            
            "qrcode": qrcode,
            "active": active ? 1 : 0,
            
            "object_id" : objectId
        ])
    }
}

extension Tenant {
    static func getTentantByCode(code: String, connection: ConnectionPool) -> Tenant? {
        do {
            let params = build((code))
            let tenants: [Tenant] = try connection.execute { try $0.query("SELECT * FROM Tenant WHERE qrcode = ?;", params) }
            if let first = tenants.first {
                return first
            }
        } catch {
            print("error while fetching tenant by code: \(error)")
        }
        return nil
    }
    
    static func getById(id: Int, connection: ConnectionPool) -> Tenant? {
        do {
            let params = build((id))
            let tenants: [Tenant] = try connection.execute { try $0.query("SELECT * FROM Tenant WHERE id = ?;", params) }
            if let first = tenants.first {
                return first
            }
        } catch {
            print("error while fetching tenant by code: \(error)")
        }
        return nil
    }
}
