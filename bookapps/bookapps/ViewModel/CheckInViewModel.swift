//
//  CheckInViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class CheckInViewModel: ObservableObject {
    @Published var passengerDetail: PassengerDetailResponse?
    @Published var passengerFlightIds: [String] = []
    @Published var isLoading: Bool = false
    @Published var navigateToBoardingPass: Bool = false

    init(detail: PassengerDetailResponse?) {
        self.passengerDetail = detail
    }
    
    func checkIn() {
        var passengerIds: [String] = []
        if let passengerDetail = passengerDetail {
            for passenger in passengerDetail.reservation.passengers.passenger {
                passengerIds.append(passenger.id)
            }
        }

        isLoading = true
        APIManager.shared.checkInPassenger(passengerIds: passengerIds) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.passengerFlightIds = []
                for boardingPass in response.boardingPasses {
                    self?.passengerFlightIds.append(boardingPass.passengerFlightId)
                }
                print("✅ Save successful: \(response)")
                self?.navigateToBoardingPass = true
            case .failure(let error):
                print("❌ Save failed: \(error.localizedDescription)")
            }

        }
    }
}
