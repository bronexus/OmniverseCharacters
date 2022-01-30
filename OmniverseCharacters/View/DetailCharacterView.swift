//
//  DetailCharacterView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct DetailCharacterView: View {
	@ObservedObject var vm = DetailCharacterViewModel()
	var character: RMCharacterModel
	
	var body: some View {
		ZStack {
			VStack {
				ScrollView {
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
						.frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenWidth * 0.3)
						.cornerRadius(16)
						
						VStack {
							Text(character.gender)
							Text(character.species)
							Text(character.type)
							Text(character.location.name)
							Text(character.origin.name)
							Text(character.status)
						}
						
						Spacer()
					}
					.padding(.bottom, 40)
				}
				
				ForEach((vm.locationCharacters ?? []), id: \.id) { character in
					CharacterCard(character: character)
				}
			}
			.navigationBarTitle(character.name)
		}
		.onAppear {
			vm.loadCurrentLocation(url: character.location.url)
		}
	}
}


//struct DetailCharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCharacterView()
//    }
//}
