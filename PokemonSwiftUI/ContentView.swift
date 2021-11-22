//
//  ContentView.swift
//  PokemonSwiftUI
//
//  Created by Ryan Gross on 11/20/21.
//

import SwiftUI

struct ContentView: View {
	@StateObject var service = PokemonViewModel()
	
	@ViewBuilder
	var body: some View {
		VStack {
			Text(service.currentPokemon)
				.font(.title)
			Spacer()
				.frame(height: 150)
			Button("Click Me!", action: {
				service.changeName()
			})
		}
		
		.opacity(service.currentPokemon.isEmpty ? 0.0 : 1.0)
		
		.overlay {
			if service.currentPokemon.isEmpty {
				ProgressView("Loading...")
					.fixedSize(horizontal: false, vertical: false)
					.progressViewStyle(.circular)
			}
		}
		
		.task {
			await service.getPokedex()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
