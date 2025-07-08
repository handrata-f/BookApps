//
//  PassengerDetailsViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class PassengerDetailsViewModel: ObservableObject {
    @Published var passengerDetail: PassengerDetailResponse?
    @Published var focusedPassengerID: String? = nil
    @Published var isLoading: Bool = false
    @Published var navigateToCheckIn: Bool = false

    @Published var passportNumbers: [String: String] = [:]
    @Published var nationalities: [String: String] = [:]
    @Published var countryOfBirths: [String: String] = [:]
    @Published var dateOfBirths: [String: Date] = [:]
    @Published var issuingCountries: [String: String] = [:]
    @Published var issuingPlaces: [String: String] = [:]
    @Published var issueDates: [String: Date] = [:]
    @Published var expiryDates: [String: Date] = [:]
    @Published var genders: [String: String] = [:]
    @Published var addressStreet1s: [String: String] = [:]
    @Published var addressStreet2s: [String: String] = [:]
    @Published var addressPostalCodes: [String: String] = [:]
    @Published var addressCountries: [String: String] = [:]
    @Published var addressCities: [String: String] = [:]
    @Published var addressStateProvinces: [String: String] = [:]
    @Published var addressTypes: [String: String] = [:]
    @Published var emergencyContactNames: [String: String] = [:]
    @Published var emergencyContactCountryCodeIDs: [String: String] = [:]
    @Published var emergencyContactNumbers: [String: String] = [:]
    @Published var emergencyContactRelationships: [String: String] = [:]

    init(detail: PassengerDetailResponse?) {
        self.passengerDetail = detail
    }

    func savePassportDetails() {
        guard let passengerDetail = passengerDetail else { return }
        let passengers = passengerDetail.reservation.passengers.passenger

        var passengerDetailsPayloads: [[String: Any]] = []
        var documents: [[String: Any]] = []
        var addresses: [[String: Any]] = []
        var emergencyContacts: [[String: Any]] = []
        for (idx, passenger) in passengers.enumerated() {
            let passportNumber = passportNumbers[passenger.id]
            let nationality = nationalities[passenger.id]
            let countryOfBirth = countryOfBirths[passenger.id]
            let dateOfBirth = dateOfBirths[passenger.id]
            let issuingCountry = issuingCountries[passenger.id]
            let issuingPlace = issuingPlaces[passenger.id]
            let issuingDate = issueDates[passenger.id]
            let expiryDate = expiryDates[passenger.id]
            let gender = genders[passenger.id]
            let addressStreet1 = addressStreet1s[passenger.id]
            let addressStreet2 = addressStreet2s[passenger.id]
            let addressPostalCode = addressPostalCodes[passenger.id]
            let addressCountry = addressCountries[passenger.id]
            let addressCity = addressCities[passenger.id]
            let addressStateProvince = addressStateProvinces[passenger.id]
            let addressType = addressTypes[passenger.id]
            let emergencyContactName = emergencyContactNames[passenger.id]
            let emergencyContactCountryCodeId = emergencyContactCountryCodeIDs[passenger.id]
            let emergencyContactNumber = emergencyContactNumbers[passenger.id]
            let emergencyContactRelationship = emergencyContactRelationships[passenger.id]

            var idxStr = "\(idx + 1)"
            if (idx + 1) < 10 {
                idxStr = "0\(idx + 1)"
            }

            let document: [String: Any] = [
                "number": passportNumber ?? "SqKSLArJg",
                "personName": [
                    "prefix": passenger.personName.prefix ?? "Mr",
                    "first": passenger.personName.first,
                    "last": passenger.personName.last
                ],
                "nationality": nationality ?? "MY",
                "countryOfBirth": countryOfBirth ?? "MY",
                "dateOfBirth": dateToString(dateOfBirth ?? Date(timeIntervalSince1970: 0)),
                "issuingCountry": issuingCountry ?? "MY",
                "issuingPlace": issuingPlace ?? "Kuala Lumpur",
                "issueDate": dateToString(issuingDate ?? Date()),
                "expiryDate": dateToString(expiryDate ?? Date()),
                "gender": gender ?? "MALE",
                "id": "\(passenger.id).d\(idxStr)",
                "type": "PASSPORT"
            ]
            documents.append(document)

            let addressDetail1: [String: Any] = [
                "street1": addressStreet1 ?? "123 Dallas St",
                "street2": addressStreet2 ?? "Apt 123",
                "postalCode": addressPostalCode ?? "En14087",
                "country": addressCountry ?? "ET",
                "city": addressCity ?? "Southlake",
                "stateProvince": addressStateProvince ?? "Texas",
                "id": "\(passenger.id).a\(idxStr)",
                "type": "RESIDENCE"
            ]
            addresses.append(addressDetail1)

            let addressDetail2: [String: Any] = [
                "street1": addressStreet1 ?? "123 Dallas St",
                "street2": addressStreet2 ?? "Apt 123",
                "postalCode": addressPostalCode ?? "En14087",
                "country": addressCountry ?? "ET",
                "city": addressCity ?? "Southlake",
                "stateProvince": addressStateProvince ?? "Texas",
                "id": "\(passenger.id).a\("0\(idx + 2)")",
                "type": "DESTINATION"
            ]
            addresses.append(addressDetail2)

            let emergencyContact: [String: Any] = [
                "name": emergencyContactName ?? "John Doe",
                "countryCode": emergencyContactCountryCodeId ?? "ID",
                "contactDetails": emergencyContactNumber ?? "1234567890",
                "relationship": emergencyContactRelationship ?? "brother",
                "id": "\(passenger.id).ec\(idxStr)"
            ]
            emergencyContacts.append(emergencyContact)
        }

        let passengerDetailsPayload: [String: Any] = [
            "documents": documents,
            "addresses": addresses,
            "emergencyContacts": emergencyContacts,
            "weightCategory": "ADULT_MALE",
            "passengerId": passengers.first?.id ?? ""
        ]
        passengerDetailsPayloads.append(passengerDetailsPayload)

        let payload: [String: Any] = [
            "returnSession": false,
            "passengerDetails": [passengerDetailsPayloads]
        ]

        isLoading = true
        APIManager.shared.savePassengerDocuments(payload: payload) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                print("✅ Save successful: \(response)")
            case .failure(let error):
                print("❌ Save failed: \(error.localizedDescription)")
            }
            self?.navigateToCheckIn = true
        }
    }
}
