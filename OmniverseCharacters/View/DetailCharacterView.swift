//
//  DetailCharacterView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI
import Kingfisher

struct DetailCharacterView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var vm = DetailCharacterViewModel()
	@State var character: RMCharacterModel
	@State var firstEpisode: String = ""
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			
			VStack(spacing: 0.0) {
				HStack {
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						CustomButtonImage(image: "chevron.left")
					}
					
					Spacer()
					
					Text(character.name)
						.font(.system(.title, design: .rounded).weight(.bold))
						.foregroundColor(Color.black)
						.minimumScaleFactor(0.5)
						.multilineTextAlignment(.center)
					
					Spacer()
					
					CustomButtonImage(image: "chevron.left")
						.opacity(0)
				}
				.padding(.horizontal)
				.padding(.bottom, 8)
				
				VStack {
					
					KFImage.url(URL(string: character.image))
						.resizable()
						.scaledToFit()
						.frame(width: 180)
						.cornerRadius(20)
					
					VStack {
						CharacterDetailLine(title: "Gender", text: character.gender)
						CharacterDetailLine(title: "Species", text: character.species)
						CharacterDetailLine(title: "Type", text: character.type)
						CharacterDetailLine(title: "Location", text: character.location.name)
						CharacterDetailLine(title: "Origin", text: character.origin.name)
						CharacterDetailLine(title: "Status", text: character.status)
					}
					.padding(.horizontal)
				}
				.padding(.bottom, 8)
				
				Text("Also from episode ‘\(firstEpisode)’")
					.font(.system(.body, design: .rounded).weight(.medium))
					.foregroundColor(Color.black)
					.multilineTextAlignment(.center)
					.padding(.horizontal)
					.onAppear {
						vm.loadEpisodeName(url: character.episode.first ?? "") { episodeName in
							firstEpisode = episodeName
						}
					}
				
				Divider()
				
				ScrollView {
					ForEach((vm.locationCharacters), id: \.id) { resident in
						Button {
							self.character = resident
						} label: {
							CharacterCard(character: resident)
						}
						.padding(.horizontal)
						.padding(.top, resident.name == vm.locationCharacters.first?.name ? 10 : 0)
						.padding(.bottom, resident.name == vm.locationCharacters.last?.name ? 10 : 0)
					}
				}
			}
		}
		.onAppear {
			vm.loadCurrentLocation(url: character.location.url)
		}
	}
}


//#if DEBUG
//struct DetailCharacterView_Previews: PreviewProvider {
//	static var previews: some View {
//		DetailCharacterView()
//	}
//}
//#endif


struct CharacterDetailLine: View {
	var title: String
	var text: String
	
	var body: some View {
		HStack {
			Text(title)
				.font(.system(.caption, design: .rounded).weight(.regular))
			Spacer()
			Text(text)
				.font(.system(.footnote, design: .rounded).weight(.medium))
		}
		.foregroundColor(Color.black)
	}
}
