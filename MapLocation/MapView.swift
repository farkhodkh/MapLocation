//
//  ContentView.swift
//  MapLocation
//
//  Created by Farkhod on 24.10.2021.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .accentColor(Color(.systemPink))
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIsLocationServiceEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
