//
//  FavoriteService.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 27/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//
import SwiftUI

class FavoritesService: ObservableObject {
    // the actual MeasuringSations the user has favorited
    private var measuringStations: Set<Int>
    let defaults = UserDefaults.standard

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        let decoder = JSONDecoder()

        if let data = defaults.value(forKey: "Favorites") as? Data {
            let stationsData = try? decoder.decode(Set<Int>.self, from: data)
            self.measuringStations = stationsData ?? []
        } else {
            self.measuringStations = []
        }
    }

    // returns true if our set contains this resort
    func contains(_ measuringStation: MeasuringStation) -> Bool {
        measuringStations.contains(measuringStation.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ measuringStation: MeasuringStation) {
        objectWillChange.send()
        measuringStations.insert(measuringStation.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ measuringStation: MeasuringStation) {
        objectWillChange.send()
        measuringStations.remove(measuringStation.id)
        save()
    }

    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(measuringStations) {
            defaults.set(encoded, forKey: "Favorites")
        }
    }
}
