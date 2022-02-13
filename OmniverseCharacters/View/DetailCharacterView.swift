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
	var character: RMCharacterModel
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			
			VStack(spacing: 8.0) {
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
				
				Divider()
				
				VStack {
					HStack {
						
						KFImage.url(URL(string: character.image))
							.resizable()
							.scaledToFit()
							.frame(width: 120)
							.cornerRadius(20)

						VStack {
							Text(character.gender)
							Text(character.species)
							Text(character.type)
							Text(character.location.name)
							Text(character.origin.name)
							Text(character.status)
						}
						.foregroundColor(Color.black)

						Spacer()
					}
					.padding(.bottom, 40)
					
					ScrollView {
					ForEach((vm.locationCharacters), id: \.id) { character in
						CharacterCard(character: character)
					}
					}
				}

				
				
				
				
				Spacer()
			}
		}
		.navigationBarHidden(true)
		.onAppear {
			vm.loadCurrentLocation(url: character.location.url)
		}
		
		//		ZStack {
		//			VStack {
//						ScrollView {
//							HStack {
//								AsyncImage(url: URL(string: character.image)) { image in
//									image
//										.resizable()
//										.scaledToFit()
//								} placeholder: {
//									ZStack {
//										Image("character_image_placeholder")
//											.resizable()
//											.scaledToFit()
//											.blur(radius: 3)
//										ProgressView()
//											.progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
//										//								.scaleEffect(2)
//									}
//								}
//								.frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenWidth * 0.3)
//								.cornerRadius(16)
//
//								VStack {
//									Text(character.gender)
//									Text(character.species)
//									Text(character.type)
//									Text(character.location.name)
//									Text(character.origin.name)
//									Text(character.status)
//								}
//
//								Spacer()
//							}
//							.padding(.bottom, 40)
//						}
//
//						ForEach((vm.locationCharacters ?? []), id: \.id) { character in
//							CharacterCard(character: character)
//						}
		//			}
		//			.navigationBarTitle(character.name)
		//		}
		//		.onAppear {
		//			vm.loadCurrentLocation(url: character.location.url)
		//		}
	}
}


//#if DEBUG
//struct DetailCharacterView_Previews: PreviewProvider {
//	static var previews: some View {
//		DetailCharacterView()
//	}
//}
//#endif

