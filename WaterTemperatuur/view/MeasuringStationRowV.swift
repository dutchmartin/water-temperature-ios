//
//  MeasuringStationRowV.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 16/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import SwiftUI
import CoreLocation

struct MeasuringStationRowV: View {
    let measuringStation: MeasuringStation
    
    var body: some View {
        HStack {
            Text(measuringStation.name)
                .padding(10)
                .font(.headline)
            Spacer()
            Text("\(measuringStation.latestValue, specifier: "%.1f")°")
        }
    }
}

#if DEBUG
struct MeasuringStationRowV_Previews: PreviewProvider {
    static var previews: some View {
//        MeasuringStationRow(
//            measuringStation: MeasuringStation(
//                id: UUID(),
//                name: "Waal - Nijmegen",
//                location: CLLocationCoordinate2D(latitude: 1.1, longitude: 1.4),
//                latestValue: 14.3,
//                latestUpdatedAt: NSDate()
//            )
//        )
        Text("test")
    }
}
#endif
