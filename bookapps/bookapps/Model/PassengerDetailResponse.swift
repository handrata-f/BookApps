//
//  PassengerDetailResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

struct PassengerDetailResponse: Codable {
    let reservation: Reservation
    let results: [PassengerResult]?
}

struct Reservation: Codable {
    let id: String
    let version: String
    let recordLocator: String
    let passengers: Passengers
    let itinerary: Itinerary?
}

struct Passengers: Codable {
    let passenger: [Passenger]
}

struct Passenger: Codable, Identifiable {
    let id: String
    let syntheticIdentifier: String?
    let personName: PersonName
    let type: PassengerType
    let emergencyContact: [EmergencyContact]?
    let passengerDocument: [PassengerDocumentWrapper]?
    let ticket: [Ticket]?
    let passengerSegments: PassengerSegments?
    let eligibilities: Eligibilities?
    let weightCategory: String?
    let nameNumber: String?
}

struct PersonName: Codable {
    let prefix: String?
    let first: String
    let last: String
    let raw: String?
}

struct PassengerType: Codable {
    let value: String
}

struct EmergencyContact: Codable {
    let id: String
    let name: String
    let countryCode: String
    let contactDetails: String
    let relationship: String
}

struct PassengerDocumentWrapper: Codable {
    let document: PassengerDocument
}

struct PassengerDocument: Codable {
    let id: String
    let number: String
    let personName: SimplePersonName
    let nationality: String
    let dateOfBirth: String
    let issuingCountry: String
    let expiryDate: String
    let gender: String
    let type: String
}

struct SimplePersonName: Codable {
    let first: String
    let last: String
}

struct Ticket: Codable {
    let ticketNumber: TicketNumber
    let issued: Bool
    let ticketCoupon: [TicketCoupon]
}

struct TicketNumber: Codable {
    let number: String
    let airlineAccountingCode: String?
    let serialNumber: String?
    let checkDigit: String?
}

struct TicketCoupon: Codable {
    let couponNumber: String
    let fareBasisCode: String
    let currentStatus: String?
    let segmentRef: String
    let status: String
}

struct PassengerSegments: Codable {
    let passengerSegment: [PassengerSegment]
}

struct PassengerSegment: Codable {
    let id: String
    let segmentRef: String
    let passengerFlight: [PassengerFlight]
}

struct PassengerFlight: Codable {
    let id: String
    let flightRefs: [String]
    let seat: Seat?
    let checkedIn: Bool?
    let boardingPass: BoardingPass?
}

struct Seat: Codable {
    let value: String
}

struct BoardingPass: Codable {
    let source: String
    let priorityVerificationCard: Bool
    let recordLocator: String
    let ticketNumber: TicketNumberDetail
    let ticketCouponNumber: String
    let personName: SimplePersonName
    let flightDetail: FlightDetail
    let fareInfo: FareInfo
    let seat: Seat
    let deck: Deck
    let group: String?
    let zone: String?
    let checkInSequenceNumber: String?
    let barCode: String?
    let formattedBoardingPass: [String: String]?
    let agent: Agent?
    let supplementaryData: SupplementaryData?
    let displayData: DisplayData?
}

struct TicketNumberDetail: Codable {
    let airlineAccountingCode: String
    let serialNumber: String
    let checkDigit: String
    let number: String
}

struct FlightDetail: Codable {
    let id: String
    let estimatedDepartureTime: String
    let estimatedArrivalTime: String
    let departureFlightScheduleStatus: String
    let boardingTime: String
    let departureGate: String
    let departureCountry: String
    let arrivalCountry: String
    let commuter: Bool
    let airline: String
    let arrivalAirport: String
    let arrivalTime: String
    let departureAirport: String
    let departureTime: String
    let equipment: String
    let flightNumber: String
    let operatingAirline: String
    let operatingFlightNumber: String
}

struct FareInfo: Codable {
    let bookingClass: String
}

struct Deck: Codable {
    let value: String
    let code: String
}

struct Agent: Codable {
    let sign: String
    let city: String
    let country: String
}

struct SupplementaryData: Codable {
    let exclusiveWaitingArea: Bool
    let loungeAccess: Bool
}

struct DisplayData: Codable {
    let operatingAirlineName: String
    let boardingTime: String
    let estimatedDepartureDate: String
    let estimatedDepartureTime: String
    let departureAirportName: String
    let estimatedArrivalTime: String
    let arrivalAirportName: String
    let ticketTypeText: String
    let documentTypeText: String
    let pingTipText: String
    let agentCityName: String
}

struct Eligibilities: Codable {
    let eligibility: [Eligibility]
}

struct Eligibility: Codable {
    let reason: [EligibilityReason]
    let notEligible: Bool
    let type: String
}

struct EligibilityReason: Codable {
    let category: String
    let message: String
}

struct Itinerary: Codable {
    let itineraryPart: [ItineraryPart]
}

struct ItineraryPart: Codable {
    let id: String
    let type: String
    let segment: [ItinerarySegment]
}

struct ItinerarySegment: Codable {
    let id: String
    let status: Status
    let flightDetail: [FlightDetail]
    let fareInfo: FareInfo
    let baggageCheckInRules: BaggageCheckInRules
    let number: String
}

struct Status: Codable {
    let value: String
    let code: String
}

struct BaggageCheckInRules: Codable {
    let petAllowed: Bool
    let lateCheckIn: Bool
    let homePrintedBagTagRestricted: HomePrintedBagTagRestricted
}

struct HomePrintedBagTagRestricted: Codable {
    let type: String
    let message: String
}

struct PassengerResult: Codable {
    let designator: Designator
    let status: [StatusMessage]
}

struct Designator: Codable {
    let value: String
    let context: String
}

struct StatusMessage: Codable {
    let message: String
    let type: String
}


extension PassengerDetailResponse {
    static var preview: PassengerDetailResponse {
        PassengerDetailResponse(
            reservation: Reservation(
                id: "res1",
                version: "sample-version",
                recordLocator: "ABC123", passengers: Passengers(
                    passenger: [
                        Passenger(
                            id: "p01.01",
                            syntheticIdentifier: "sample-id",
                            personName: PersonName(prefix: "MR", first: "John", last: "Doe", raw: "DOE/JOHN MR"),
                            type: PassengerType(value: "ADULT"),
                            emergencyContact: [],
                            passengerDocument: [],
                            ticket: [],
                            passengerSegments: PassengerSegments(passengerSegment: []),
                            eligibilities: nil,
                            weightCategory: "ADULT_MALE",
                            nameNumber: "01.01"
                        )
                    ]
                ),
                itinerary: nil
            ),
            results: []
        )
    }
}
