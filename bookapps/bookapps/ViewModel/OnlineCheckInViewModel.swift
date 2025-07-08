//
//  OnlineCheckInViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation
import Combine

class OnlineCheckInViewModel: ObservableObject {
    @Published var pnr: String = ""
    @Published var lastName: String = ""
    @Published var isLoading: Bool = false
    @Published var passengerDetail: PassengerDetailResponse? = nil
    @Published var navigateToDetails: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorTitle: String = "Error"
    @Published var errorMessage: String = ""

    func requestToken() {
        APIManager.shared.requestToken { [weak self] result in
            switch result {
            case .success(let detail):
                Swift.print("✅ Request Token loaded : \(detail)")
                // you can also trigger navigation or UI update here
            case .failure(let error):
                self?.showErrorAlert = true
                self?.errorMessage = "Failed to fetch request token: \(error.localizedDescription)"
                Swift.print("❌ \(error)")
            }}
    }

    func buttonContinueAction() {
        // Your check-in logic here
        print("Submitted PNR: \(pnr.uppercased()), Last Name: \(lastName)")

        isLoading = true
        APIManager.shared.getPassengerDetails(recordLocator: pnr.uppercased(), lastName: lastName) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let detail):
                Swift.print("✅ Passenger details loaded : \(detail)")
                self?.passengerDetail = detail
                // you can also trigger navigation or UI update here
                self?.navigateToDetails = true
            case .failure(let error):
                self?.showErrorAlert = true
                self?.errorMessage = "Failed to fetch passenger details: \(error.localizedDescription)"
                Swift.print("❌ \(error)")
            }
        }
    }
}
