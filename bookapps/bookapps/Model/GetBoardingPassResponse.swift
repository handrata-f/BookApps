//
//  GetBoardingPassResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

struct GetBoardingPassResponse: Codable {
    let reservation: Reservation
    let boardingPasses: [BoardingPassInfo]
    let results: [BoardingPassResult]
}

struct PassengerWrapper: Codable {
    let passenger: [Passenger]
}

struct ContactDetails: Codable {
    let address: [Address]
}

struct Address: Codable {
    let id: String
    let street1: String
    let postalCode: String
    let country: String
    let city: String
    let stateProvince: String
    let type: String
}

struct Document: Codable {
    let id: String
    let number: String
    let personName: PersonName
    let nationality: String
    let countryOfBirth: String?
    let dateOfBirth: String
    let issuingCountry: String
    let issuingPlace: String?
    let issueDate: String?
    let expiryDate: String
    let gender: String
    let type: String
}

struct TicketNumberOnly: Codable {
    let number: String
}

struct StatusCode: Codable {
    let value: String
    let code: String
}

struct RestrictionMessage: Codable {
    let type: String
    let message: String
}

// MARK: - Boarding Pass Result

struct BoardingPassResult: Codable {
    let status: [BoardingPassStatus]
    let passengerSegmentRef: String
}

struct BoardingPassStatus: Codable {
    let message: String?
    let type: String
}

