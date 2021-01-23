//
//  User.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import Foundation
import UIKit

struct User {
    let timestamp_user_register: String
    let timestamp_user_suspended: String
    let timestamp_user_deleted: String
    var user_age: Int
    var user_charge_method: Bool
    var user_district: String
    let user_email: String
    let user_name: String
    var user_phone: String
    var user_rank: Double
    var user_status: UserStatus
    var user_surname: String
    var user_type: UserType
    var user_udid: String
    var user_uid: String
    var user_urls: [String]
    var user_minSeekingKm: Int = 0
    var user_maxSeekingKm: Int = 40
    var user_city: String
    var user_country: String
    
    init(dict: [String: Any]) {
        self.timestamp_user_register = dict["timestamp_user_register"] as? String ?? "2121-21-21 21:21:21"
        self.timestamp_user_suspended = dict["timestamp_user_suspended"] as? String ?? "2121-21-21 21:21:21"
        self.timestamp_user_deleted = dict["timestamp_user_deleted"] as? String ?? "2121-21-21 21:21:21"
        self.user_age = dict["user_age"] as? Int ?? 0
        self.user_charge_method = dict["user_charge_method"] as? Bool ?? false
        self.user_district = dict["user_district"] as? String ?? "no district"
        self.user_email = dict["user_email"] as? String ?? "no email"
        self.user_name = dict["user_name"] as? String ?? "no name"
        self.user_phone = dict["user_phone"] as? String ?? "no phone"
        self.user_rank = dict["user_rank"] as? Double ?? 0
        self.user_status = UserStatus(rawValue: dict["user_status"] as? Int ?? 0) ?? UserStatus.NO_EXIST
        self.user_surname = dict["user_surname"] as? String ?? "no surname"
        self.user_type = UserType(rawValue: dict["user_type"] as? Int ?? 0) ?? UserType.NO_USER
        self.user_udid = dict["user_udid"] as? String ?? "null"
        self.user_uid = dict["user_uid"] as? String ?? "null"
        self.user_urls = dict["user_urls"] as? [String] ?? [String]()
        self.user_minSeekingKm = dict["user_minSeekingKm"] as? Int ?? 0
        self.user_maxSeekingKm = dict["user_maxSeekingKm"] as? Int ?? 40
        self.user_city = dict["user_city"] as? String ?? "no city"
        self.user_country = dict["user_country"] as? String ?? "no country"
    }
    
    init(name: String, surname: String, email: String, phone: String, uid: String) {
        self.user_name = name
        self.user_surname = surname
        self.user_email = email
        self.user_phone = phone
        self.user_type = UserType.USER
        self.user_rank = 5
        self.user_uid = uid
        self.user_status = UserStatus.REGISTER_DATA
        
        self.timestamp_user_register = "2121-21-21 21:21:21"
        self.timestamp_user_suspended =  "2121-21-21 21:21:21"
        self.timestamp_user_deleted =  "2121-21-21 21:21:21"
        self.user_age = 0
        self.user_charge_method = false
        self.user_district = "no district"
        self.user_udid = "null"
        self.user_urls = [String]()
        self.user_minSeekingKm = 0
        self.user_maxSeekingKm = 40
        self.user_city = "no city"
        self.user_country = "no country"
    }
    
    func data() -> [String: Any] {
        return [
            "timestamp_user_register": self.timestamp_user_register,
            "user_age": self.user_age,
            "user_charge_method": self.user_charge_method,
            "user_district": self.user_district,
            "user_email": self.user_email,
            "user_name": self.user_name,
            "user_phone": self.user_phone,
            "user_rank": self.user_rank,
            "user_status": self.user_status.rawValue,
            "user_surname": self.user_surname,
            "user_type": self.user_type.rawValue,
            "user_udid": self.user_udid,
            "user_uid": self.user_uid,
            "user_urls": self.user_urls,
            "user_minSeekingKm": self.user_minSeekingKm,
            "user_maxSeekingKm": self.user_maxSeekingKm,
            "user_city": self.user_city,
            "user_country": self.user_country
        ] as! [String: Any]
    }
    
}
