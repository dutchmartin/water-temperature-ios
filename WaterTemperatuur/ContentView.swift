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
 
    var body: some View {
        NavigationView {
            LocationsView()
                .navigationBarTitle(Text("Locaties"))
            Text("Detail view content goes here")
                .navigationBarTitle(Text("Detail"))
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct LocationsView: View {
    @State var stations: [MeasuringStation] = []

    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {
        List {
            ForEach(stations, id: \.self) { station in
                NavigationLink(
                    destination: DetailView(station: station)
                ) {
                    Text("\(station.name)")
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

    var body: some View {
        Text("\(station.name)")
            .navigationBarTitle(Text("Detail"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
