//
//	NyMedia-metadata.swift
//
//	Create by Adil Anwer on 22/9/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class NyMediaMetadata : Codable {

	let format : String?
	let height : Int?
	let url : String?
	let width : Int?


	enum CodingKeys: String, CodingKey {
		case format = "format"
		case height = "height"
		case url = "url"
		case width = "width"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		format = try values.decodeIfPresent(String.self, forKey: .format) ?? String()
		height = try values.decodeIfPresent(Int.self, forKey: .height) ?? Int()
		url = try values.decodeIfPresent(String.self, forKey: .url) ?? String()
		width = try values.decodeIfPresent(Int.self, forKey: .width) ?? Int()
	}


}
