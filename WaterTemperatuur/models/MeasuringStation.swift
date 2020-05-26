//
//  MeasuringStation.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 16/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import Foundation
import CoreLocation

public class MeasuringStation: Identifiable, ObservableObject {
    public var id: Int
    public var name: String
    public var location: CLLocationCoordinate2D
    public var latestValue: Double
    public var latestUpdatedAt: Date
    
    public init (
        id: Int,
        name: String,
        location: CLLocationCoordinate2D,
        latestValue: Double,
        latestUpdatedAt: Date
    ){
        self.id = id
        self.name = name
        self.location = location
        self.latestValue = latestValue
        self.latestUpdatedAt = latestUpdatedAt
    }
}

extension MeasuringStation: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}

extension MeasuringStation: Equatable {

    public static func ==(lhs: MeasuringStation, rhs: MeasuringStation) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude;
    }
}
