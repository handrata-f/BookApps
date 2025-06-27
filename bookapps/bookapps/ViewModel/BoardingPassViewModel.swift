//
//  BoardingPassViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class BoardingPassViewModel: ObservableObject {
    @Published var passengerFlightIds: [String] = []

    init(passengerFlightIds: [String]) {
        self.passengerFlightIds = passengerFlightIds
    }
}
