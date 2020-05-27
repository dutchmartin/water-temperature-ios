//
//  ContentView.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 15/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var viewContext
    @ObservedObject var favorites = FavoritesService()
 
    var body: some View {
        NavigationView {
            LocationsView()
                .navigationBarTitle(Text("Meetstations watertemperatuur"), displayMode: .inline)
            }
        .environmentObject(favorites)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}


struct LocationsView: View {
    @State var stations: [MeasuringStation] = []
    @EnvironmentObject var favorites: FavoritesService

    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {
        List {
            ForEach(stations, id: \.self) { station in
                NavigationLink(
                    destination: DetailView(station: station)
                ) {
                    Text("\(station.name)")
                    if self.favorites.contains(station) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite measuring station"))
                            .foregroundColor(.red)
                    }
                }
            }
        }.onAppear {
            ApiService().getMeasuringStations { stations in
                self.stations = stations
            }
        }
    }
    
}

struct DetailView: View {
    @ObservedObject var station: MeasuringStation
    @EnvironmentObject var favorites: FavoritesService

    var body: some View {
        VStack {
            Spacer()
            Text("\(station.name)").bold().font(.title)
            Text("\(station.latestValue, specifier: "%.1f")°C").font(.system(size:80))
            Text("Last update: \(station.latestUpdatedAt)").font(.footnote).padding(3)
            Spacer()
            Button(favorites.contains(station) ? "verwijderen uit favorieten" : "Toevoegen aan favorieten") {
                if self.favorites.contains(self.station) {
                    self.favorites.remove(self.station)
                } else {
                    self.favorites.add(self.station)
                }
            }
        }.navigationBarTitle(Text("Details"))
    }
}
