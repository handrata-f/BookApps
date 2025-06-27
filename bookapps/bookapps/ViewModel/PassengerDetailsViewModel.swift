//
//  PassengerDetailsViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class PassengerDetailsViewModel: ObservableObject {
    @Published var passengerDetail: PassengerDetailResponse?
    @Published var passportNumber: String = ""
    @Published var isSaving: Bool = false


    init(detail: PassengerDetailResponse?) {
        self.passengerDetail = detail
    }

    func savePassportDetails() {
        guard !passportNumber.isEmpty else {
            print("Passport number is empty")
            return
        }

        isSaving = true

        // Simulate a network call or APIManager usage
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            print("Passport number saved:", self.passportNumber)
            self.isSaving = false
        }
    }
}
