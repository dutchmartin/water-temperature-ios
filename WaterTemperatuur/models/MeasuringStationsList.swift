//
//  MeasuringStationsList.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 27/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import SwiftUI

class MeasuringStationsList: ObservableObject {
    @Published var measuringStations: [MeasuringStation] = []
    
    public func add(measuringStations: [MeasuringStation]) {
        self.measuringStations.append(contentsOf: measuringStations)
    }
}
