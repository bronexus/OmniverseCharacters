//
//  CharactersView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct CharactersView: View {
	@ObservedObject var vm = CharacterViewModel()
	@State var currentPage: Int = 1
	
    var body: some View {
		NavigationView {
			VStack {
				ScrollView {
					ForEach(vm.characters ?? [], id: \.id) { character in
						CharacterCard(character: character)
					}
				}
				
				HStack {
					Button {
						if currentPage > 1 {
							currentPage -= 1
							vm.loadCharacters(page: currentPage)
						}
					} label: {
						Image(systemName: "arrow.up.circle")
							.rotationEffect(.degrees(-90))
					}
					
					Spacer()
					
					Button {
						if currentPage < 42 {
							currentPage += 1
							vm.loadCharacters(page: currentPage)
						}
					} label: {
						Image(systemName: "arrow.up.circle")
							.rotationEffect(.degrees(90))
					}
				}
			}
			.padding(.horizontal)
			.navigationBarTitle("Omniverse Characters")
			.onAppear {
				vm.loadCharacters(page: currentPage)
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
