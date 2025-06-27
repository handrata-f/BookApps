//
//  BoardingPassViewModel.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation

class BoardingPassViewModel: ObservableObject {
    @Published var passengerFlightIds: [String] = []
    @Published var boardingPasInfos: [BoardingPassInfo] = []
    @Published var isLoading: Bool = false

    init(passengerFlightIds: [String]) {
        self.passengerFlightIds = passengerFlightIds
    }

    func fetchBoardingPass() {
        isLoading = true
        APIManager.shared.getBoardingPass(passengerFlightIds: passengerFlightIds) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                print("✅ Save successful: \(response)")
                if let responseDic = convertToDictionary(from: response) {
                    self?.handleResponse(responseDic)
                }
            case .failure(let error):
                print("❌ Save failed: \(error.localizedDescription)")
            }
        }
    }

    func handleResponse(_ responseDic: [String: Any]) {
        guard let boardingPasses = responseDic["boardingPasses"] as? [[String: Any]] else { return }

        var currentBoardingPassInfos: [BoardingPassInfo] = []
        for (idx, boardingPass) in boardingPasses.enumerated() {
            var fullName: String = ""
            var flightInfo: String = ""
            var gate: String = ""
            var seat: String = ""
            var departureAirport: String = ""
            var arrivalAirport: String = ""
            var barcode: String = ""

            if let boardingPassInfo = boardingPass["boardingPass"] as? [String: Any] {
                if let personName = boardingPassInfo["personName"] as? [String: Any] {
                    if let lastName = personName["last"] as? String {
                        fullName = lastName
                    }
                    if let firstName = personName["first"] as? String {
                        if fullName.count > 0 {
                            fullName += " \(firstName)"
                        } else {
                            fullName = firstName
                        }
                    }
                }
                if let flightDetail = boardingPassInfo["flightDetail"] as? [String: Any] {
                    flightInfo = "\(flightDetail["operatingAirline"] as? String ?? "") \(flightDetail["flightNumber"] as? String ?? "")"
                    gate = flightDetail["departureGate"] as? String ?? ""
                    departureAirport = flightDetail["departureAirport"] as? String ?? ""
                    arrivalAirport = flightDetail["arrivalAirport"] as? String ?? ""
                }
                if let seatDic = boardingPassInfo["seat"] as? [String: Any],
                   let value = seatDic["value"] as? String {
                    seat = value
                }
                if let barcodeID = boardingPassInfo["barCode"] as? String {
                    barcode = barcodeID
                }
            }

            let info = BoardingPassInfo(fullName: fullName,
                                        flightInfo: flightInfo,
                                        gate: gate,
                                        seat: seat,
                                        departureAirport: departureAirport,
                                        arrivalAirport: arrivalAirport,
                                        barcode: barcode)
            currentBoardingPassInfos.append(info)
        }

        boardingPasInfos = currentBoardingPassInfos
    }
}
