//
//  DetailCharacterViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class DetailCharacterViewModel: ObservableObject {
	
	@Published var locationCharacters = [RMCharacterModel]()
	
	let rmClient = RMClient()
	var cancellable: AnyCancellable?
	var cancellable2: AnyCancellable?
	
	init() {
	
	}
	
	func loadCurrentLocation(url: String) {
		cancellable = rmClient.location().getLocationByURL(url: url)
			.sink(receiveCompletion: { _ in }, receiveValue: { location in
				for n in 0..<(location.residents.count) where n < 9 {
					guard let url = URL(string: location.residents[n]) else { return }
					
					URLSession.shared.dataTask(with: url) { (data, resp, err) in
						
						DispatchQueue.main.async {
							guard let data = data else { return }
							do {
								let character = try JSONDecoder().decode(RMCharacterModel.self, from: data)
								self.locationCharacters.append(character)
							} catch {
								print("Failed to decode JSON:", error)
							}
						}
						
					}.resume()
				}
			})
	}
	
	func loadEpisodeName(url: String, callback: @escaping (String) -> ()) {
		cancellable2 = rmClient.episode().getEpisodeByURL(url: url)
			.sink(receiveCompletion: { _ in }, receiveValue: { episode in
				callback(episode.name)
			})
	}
}
