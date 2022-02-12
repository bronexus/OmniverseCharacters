//
//  CharactersView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
	@ObservedObject var vm = CharacterViewModel()
	@State var currentPage: Int = 1
	
	var body: some View {
		NavigationView {
			VStack(spacing: 0.0) {
				HStack {
					Text("Omniverse Characters")
						.font(.system(.title, design: .rounded).weight(.bold))
						.foregroundColor(Color.black)
					
					Spacer()
					
					NavigationLink {
						SearchCharacter()
					} label: {
						CustomButtonImage(image: "magnifyingglass")
					}
				}
				.padding(.horizontal)
				
				Divider()
					.padding(.top, 8)
				
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
				
				Divider()
					.padding(.bottom, 8)
				
				HStack {
					Button {
						if currentPage > 1 {
							currentPage -= 1
							vm.loadCharacters(page: currentPage)
						}
					} label: {
						CustomButtonImage(image: "arrow.up")
							.rotationEffect(.degrees(-90))
					}
					
					Spacer()
					Text("\(currentPage)/42")
						.font(.system(.body, design: .rounded).weight(.medium))
						.foregroundColor(Color.black)
					Spacer()
					
					Button {
						if currentPage < 42 {
							currentPage += 1
							vm.loadCharacters(page: currentPage)
						}
					} label: {
						CustomButtonImage(image: "arrow.up")
							.rotationEffect(.degrees(90))
					}
				}
				.padding(.horizontal)
			}
			.onAppear {
				vm.loadCharacters(page: currentPage)
			}
			.navigationBarHidden(true)
			.background(Color.white.ignoresSafeArea())
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
			KFImage.url(URL(string: character.image))
				.resizable()
				.scaledToFit()
				.frame(width: 96)
				.cornerRadius(20)
			
			VStack(alignment: .leading) {
				Text(character.name)
					.font(.system(.headline, design: .rounded).weight(.bold))
					.foregroundColor(Color.orange)
				Text("Last location:")
					.font(.system(.caption, design: .rounded).weight(.regular))
				Text(character.location.name)
					.font(.system(.footnote, design: .rounded).weight(.medium))
					.lineLimit(1)
					.minimumScaleFactor(0.5)
				Text("First seen in:")
					.font(.system(.caption, design: .rounded).weight(.regular))
				Text(firstEpisode)
					.font(.system(.footnote, design: .rounded).weight(.medium))
					.lineLimit(1)
					.minimumScaleFactor(0.5)
					.onAppear {
						vm.loadEpisodeName(url: character.episode.first ?? "") { episodeName in
							firstEpisode = episodeName
						}
					}
			}
			.foregroundColor(Color.black)
			.padding(.vertical, 8)
			.padding(.trailing, 8)
			
			Spacer()
		}
		.padding(.trailing, 8)
		.background(Color(hex: "EDEDED"))
		.cornerRadius(20)
		.shadow(color: Color(hex: "EDEDED"), radius: 4, x: 2, y: 2)
	}
}


struct CustomButtonImage: View {
	var image: String
	
	var body: some View {
		Image(systemName: image)
			.foregroundColor(Color.black)
			.padding(12)
			.overlay(
				RoundedRectangle(cornerRadius: 15)
					.stroke(Color(hex: "#CFCFCF"), lineWidth: 1)
			)
	}
}
