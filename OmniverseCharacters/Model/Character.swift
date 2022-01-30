////
////  Character.swift
////  OmniverseCharacters
////
////  Created by Dumitru on 30.01.2022.
////
//
//import Foundation
//
//
//// MARK: - Character
//struct Character: Codable {
//	let info: Info
//	let results: [Characters]
//}
//
//// MARK: - Info
//struct Info: Codable {
//	let count, pages: Int
//	let next: String?
//	let prev: String?
//}
//
//// MARK: - Result
//struct Characters: Codable {
//	let id: Int
//	let name: String
//	let status: String
//	let species: String
//	let type: String
//	let gender: String
//	let origin: Origin
//	let location: Location
//	let image: String
//	let episode: [String]
//	let url: String
//	let created: String
//}
//
//// MARK: - Location
//struct Location: Codable {
//	let name: String
//	let url: String
//}
//
//// MARK: - Origin
//struct Origin: Codable {
//	let name: String
//	let url: String
//}
