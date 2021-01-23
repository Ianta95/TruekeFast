//
//  article.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import Foundation
import UIKit

struct Article {
    var art_category: String
    var art_city: String
    let art_country: String
    var art_description: String
    var art_district: String
    var art_id: String
    var art_brand: String
    var art_model: String
    let art_month: Int
    let art_new: Bool
    let art_num_rank: Int
    let art_num_visits: Int
    let art_rank: Double
    let art_status: ArticleStatus
    let art_stock: Int
    let art_subcategory: String
    let art_title: String
    let art_urls: [String]
    let art_week: Int
    let art_year: Int
    let art_owner_id: String
    let art_owner_name: String
    let search_category_1: Int
    let search_category_2: Int
    let search_category_3: Int
    let timestamp_publish: String
    let timestamp_register: String
    let timestamp_paused: String
    let timestamp_deleted: String
    
    init(dict: [String: Any]) {
        self.art_category = dict["art_category"] as? String ?? "no category"
        self.art_city = dict["art_city"] as? String ?? "no city"
        self.art_country = dict["art_country"] as? String ?? "no country"
        self.art_description = dict["art_description"] as? String ?? ""
        self.art_district = dict["art_district"] as? String ?? "no district"
        self.art_id = dict["art_id"] as? String ?? "null"
        self.art_brand = dict["art_brande"] as? String ?? "no brand"
        self.art_model = dict["art_model"] as? String ?? "no model"
        self.art_month = dict["art_month"] as? Int ?? 0
        self.art_new = dict["art_new"] as? Bool ?? false
        self.art_num_rank = dict["Double"] as? Int ?? 0
        self.art_num_visits = dict["Int"] as? Int ?? 0
        self.art_rank = dict["art_rank"] as? Double ?? 0
        self.art_status = ArticleStatus(rawValue: dict["art_status"] as? Int ?? 0) ?? ArticleStatus.NO_ARTICLE
        self.art_stock = dict["art_stock"] as? Int ?? 0
        self.art_subcategory = dict["art_subcategory"] as? String ?? "no subcategory"
        self.art_title = dict["art_title"] as? String ?? "no title"
        self.art_urls = dict["art_urls"] as? [String] ?? [String]()
        self.art_week = dict["art_week"] as? Int ?? 0
        self.art_year = dict["art_year"] as? Int ?? 0
        self.art_owner_id = dict["art_owner_id"] as? String ?? "null"
        self.art_owner_name = dict["art_owner_name"] as? String ?? "no name"
        self.search_category_1 = dict["search_category_1"] as? Int ?? 0
        self.search_category_2 = dict["search_category_2"] as? Int ?? 0
        self.search_category_3 = dict["search_category_3"] as? Int ?? 0
        self.timestamp_publish = dict["timestamp_publish"] as? String ?? "2121-21-21 21:21:21"
        self.timestamp_register = dict["timestamp_register"] as? String ?? "2121-21-21 21:21:21"
        self.timestamp_paused = dict["timestamp_paused"] as? String ?? "2121-21-21 21:21:21"
        self.timestamp_deleted = dict["timestamp_deleted"] as? String ?? "2121-21-21 21:21:21"
        
    }
    
}
