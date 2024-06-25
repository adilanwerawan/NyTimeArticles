//
//	NyArticle.swift
//
//	Create by Adil Anwer on 22/9/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class NyArticle : Codable {

	let copyright : String?
	let numResults : Int?
	let results : [NyResult]?
	let status : String?


	enum CodingKeys: String, CodingKey {
		case copyright = "copyright"
		case numResults = "num_results"
		case results = "results"
		case status = "status"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright) ?? String()
		numResults = try values.decodeIfPresent(Int.self, forKey: .numResults) ?? Int()
		results = try values.decodeIfPresent([NyResult].self, forKey: .results) ?? [NyResult]()
		status = try values.decodeIfPresent(String.self, forKey: .status) ?? String()
	}
}
