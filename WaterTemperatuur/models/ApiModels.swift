// This file was generated from JSON Schema using quicktype, do not modify it directly.

import Foundation

// MARK: - FeatureProperties
struct FeatureProperties: Decodable {
    let name: String
    let measurements: [Measurement]
    let locationCode: String
    let locationColor: String
    let featured: Bool
}

// MARK: - Feature
struct Feature: Decodable {
    let geometry: Geometry
    let properties: FeatureProperties
}

// MARK: - FeatureCollection
struct FeatureCollection: Decodable {
    let features: [Feature]
}

// MARK: - Measurement
struct Measurement: Decodable {
    let latestValue: Double
    let dateTime: String
    let possiblyFaulty: Bool
    let unitCode: String
}

// MARK: - Geometry
struct Geometry: Decodable {
    let type: String
    let coordinates: [Double]
}
