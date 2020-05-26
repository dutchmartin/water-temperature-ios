//
//  MainHomeVM.swift
//  WaterTemperatuur
//
//  Created by Martijn Groeneveldt on 16/05/2020.
//  Copyright © 2020 Martijn Groeneveldt. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class MainHomeVM: ObservableObject {
    
    var measuringStations: [MeasuringStation] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MainHomeVM, Never>()
    
    func search(forQuery searchQuery: String) {
        

    }
}
