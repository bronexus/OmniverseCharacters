//
//  MainViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation

class MainViewModel: ObservableObject {
	
	@Published var character: Character?
	
//	init() {
//		
//	}
	
	func getCharacters(urlString: String) {
		guard let url = URL(string: urlString) else { return }
		let session = URLSession(configuration: .default)
		
		session.dataTask(with: url) { (data, resp, error) in
			guard let data = data else { return }
			do {
				let json = try JSONDecoder().decode(Character.self, from: data)
				DispatchQueue.main.async {
					self.character = json
				}
			} catch {
				print("Lusione: \(error.localizedDescription)")
			}
		}.resume()
	}
}
