//
//  CharactersView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct CharactersView: View {
	@ObservedObject var vm = CharacterViewModel()
	
    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(vm.characters ?? [], id: \.id) { character in
					CharacterCard(character: character)
				}
			}
			.navigationBarTitle("Omniverse Characters")
			.onAppear {
				vm.loadCharacters(page: 1)
			}
		}
    }
}

#if DEBUG
struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
#endif

struct CharacterCard: View {
	@ObservedObject var vm = CharacterViewModel()
	var character: RMCharacterModel
	@State var firstEpisode: String = ""
	
	var body: some View {
		HStack {
			AsyncImage(url: URL(string: character.image)) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				ZStack {
					Image("character_image_placeholder")
						.resizable()
						.scaledToFit()
						.blur(radius: 3)
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
					//								.scaleEffect(2)
				}
			}
			.frame(width: 80, height: 80, alignment: .center)
			.cornerRadius(16)
			
			VStack {
				Text(character.name)
				Text(firstEpisode)
					.onAppear {
						vm.loadEpisodeName(url: character.episode.first ?? "") { episodeName in
							firstEpisode = episodeName
						}
					}
			}
			
			Spacer()
		}
		.cornerRadius(20)
		.background(Color.blue.opacity(0.2))
	}
}
