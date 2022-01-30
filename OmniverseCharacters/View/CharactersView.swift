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
			ZStack {
				VStack {
					ScrollView {
						ForEach(vm.characters ?? [], id: \.id) { character in
							NavigationLink {
								DetailCharacterView(character: character)
							} label: {
								CharacterCard(character: character)
							}
							.padding(.horizontal)
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
						Text("\(currentPage)/42")
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
					.padding(.horizontal)
				}
				.navigationBarTitle("Characters")
				.onAppear {
					vm.loadCharacters(page: currentPage)
			}
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
			.frame(width: 120, height: 120)
			.cornerRadius(20)
			
			VStack(alignment: .leading) {
				Text(character.name)
					.font(.system(.title3, design: .rounded).weight(.bold))
					.foregroundColor(Color.orange)
				Text("Last location:")
					.font(.system(.footnote, design: .rounded).weight(.regular))
					.foregroundColor(Color(UIColor.label))
				Text(character.location.name)
					.font(.system(.body, design: .rounded).weight(.medium))
					.foregroundColor(Color(UIColor.label))
					.lineLimit(1)
					.minimumScaleFactor(0.5)
				Text("First seen in:")
					.font(.system(.footnote, design: .rounded).weight(.regular))
					.foregroundColor(Color(UIColor.label))
				Text(firstEpisode)
					.font(.system(.body, design: .rounded).weight(.medium))
					.foregroundColor(Color(UIColor.label))
					.lineLimit(1)
					.minimumScaleFactor(0.5)
					.onAppear {
						vm.loadEpisodeName(url: character.episode.first ?? "") { episodeName in
							firstEpisode = episodeName
						}
					}
			}
			.padding(.vertical, 8)
			.padding(.trailing, 8)
			
			Spacer()
		}
		.background(Color(UIColor.systemBackground))
		.cornerRadius(20)
		.shadow(color: Color(UIColor.label).opacity(0.2), radius: 5, x: 2, y: 2)
	}
}

