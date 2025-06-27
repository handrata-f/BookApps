//
//  PassengerDetailsViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class PassengerDetailsViewModel: ObservableObject {
    @Published var passengerDetail: PassengerDetailResponse?
    @Published var passportNumbers: [String: String] = [:]
    @Published var focusedPassengerID: String? = nil
    @Published var isLoading: Bool = false
    @Published var navigateToCheckIn: Bool = false

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
                "nationality": passenger.passengerDocument?.first?.document.nationality ?? "MY",
                "countryOfBirth": "MY",
                "dateOfBirth": passenger.passengerDocument?.first?.document.dateOfBirth ?? "1990-01-01",
                "issuingCountry": passenger.passengerDocument?.first?.document.issuingCountry ?? "MY",
                "issuingPlace": "Kuala Lumpur",
                "issueDate": "2015-01-01",
                "expiryDate": passenger.passengerDocument?.first?.document.expiryDate ?? "2030-01-01",
                "gender": passenger.passengerDocument?.first?.document.gender ?? "MALE",
                "id": "\(passenger.id).d\(idxStr)",
                "type": "PASSPORT"
            ]
            documents.append(document)

            let address = [
                "street1": "123 Dallas St",
                "street2": "Apt 123",
                "postalCode": "En14087",
                "country": "ET",
                "city": "Southlake",
                "stateProvince": "Texas",
                "id": "\(passenger.id).a\(idxStr)",
                "type": "RESIDENCE"
            ]
            addresses.append(address)

            let emergencyContact = [
                "name": "John Doe",
                "countryCode": "US",
                "contactDetails": "1234567890",
                "relationship": "brother",
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
            "passengerDetails": passengerDetailsPayloads
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
