//
//	NyResult.swift
//
//	Create by Adil Anwer on 22/9/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class NyResult : Codable {

	let abstractField : String?
	let adxKeywords : String?
	let assetId : Int?
	let byline : String?
	let column : String?
	let id : Int?
	let media : [NyMedia]?
	let publishedDate : String?
	let section : String?
	let source : String?
	let title : String?
	let type : String?
	let url : String?
	let views : Int?


	enum CodingKeys: String, CodingKey {
		case abstractField = "abstract"
		case adxKeywords = "adx_keywords"
		case assetId = "asset_id"
		case byline = "byline"
		case column = "column"
		case id = "id"
		case media = "media"
		case publishedDate = "published_date"
		case section = "section"
		case source = "source"
		case title = "title"
		case type = "type"
		case url = "url"
		case views = "views"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		abstractField = try values.decodeIfPresent(String.self, forKey: .abstractField) ?? String()
		adxKeywords = try values.decodeIfPresent(String.self, forKey: .adxKeywords) ?? String()
		assetId = try values.decodeIfPresent(Int.self, forKey: .assetId) ?? Int()
		byline = try values.decodeIfPresent(String.self, forKey: .byline) ?? String()
		column = try values.decodeIfPresent(String.self, forKey: .column) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		media = try values.decodeIfPresent([NyMedia].self, forKey: .media) ?? [NyMedia]()
		publishedDate = try values.decodeIfPresent(String.self, forKey: .publishedDate) ?? String()
		section = try values.decodeIfPresent(String.self, forKey: .section) ?? String()
		source = try values.decodeIfPresent(String.self, forKey: .source) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		type = try values.decodeIfPresent(String.self, forKey: .type) ?? String()
		url = try values.decodeIfPresent(String.self, forKey: .url) ?? String()
		views = try values.decodeIfPresent(Int.self, forKey: .views) ?? Int()
	}


}
