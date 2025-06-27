//
//  CheckInPassengerResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

struct CheckInPassengerResponse: Codable {
    let boardingPasses: [BoardingPassInfo]
    let results: [CheckInResult]
}

struct BoardingPassInfo: Codable {
    let passengerFlightId: String
    let boardingPass: BoardingPass
}

struct CheckInResult: Codable {
    let status: [CheckInStatus]
    let passengerFlightRef: String
}

struct CheckInStatus: Codable {
    let type: String
}
