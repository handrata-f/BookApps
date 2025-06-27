//
//  GetBoardingPassResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

import Foundation

struct BoardingPassInfo: Codable {
    var fullName: String
    var flightInfo: String
    var gate: String
    var seat: String
    var departureAirport: String
    var arrivalAirport: String
    var barcode: String
}
