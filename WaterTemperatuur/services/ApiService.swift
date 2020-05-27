//
//  ApiService.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 15/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import Foundation
import CoreLocation

public class ApiService: NSObject {
    private let endPoint = URL(string: "https://waterinfo.rws.nl/api/point/latestmeasurements?parameterid=watertemperatuur")

    private func getAllFeatures(completion: @escaping (FeatureCollection) -> ()) {
        guard let url = endPoint else {
            fatalError("API URL is incorrect")
        }
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            var featureCollection = FeatureCollection(
                features: []
            )
            do {
                featureCollection = try JSONDecoder().decode(FeatureCollection.self, from: data!)
            }
            catch {
                print("An error occured parsing the JSON")
            }
            DispatchQueue.main.async {
                completion(featureCollection)
            }
        }.resume()
    }
    public func getMeasuringStations(completion: @escaping ([MeasuringStation]) -> ()) {
        getAllFeatures(completion: {(featureData) -> () in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            var stations: [MeasuringStation] = []
            for (index, element) in featureData.features.enumerated() {
                stations.append(MeasuringStation (
                    id: index,
                    name: element.properties.name,
                    location: CLLocationCoordinate2D(
                        latitude: element.geometry.coordinates[0],
                        longitude: element.geometry.coordinates[1]
                    ),
                    latestValue: element.properties.measurements[0].latestValue,
                    latestUpdatedAt: dateFormatter.date(from: element.properties.measurements[0].dateTime) ?? Date()
                ))
            }
            completion(stations)
        })
    }
}
