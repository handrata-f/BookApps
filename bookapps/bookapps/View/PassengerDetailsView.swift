//
//  PassengerDetailsView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import SwiftUI

struct PassengerDetailsView: View {
    @ObservedObject var viewModel: PassengerDetailsViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Passenger\nDetails")
                                .helveticaFont(size: 32, weight: .bold)
                                .padding(.top, 32)

                            Spacer()
                            Spacer()

                            if let passengerDetail = viewModel.passengerDetail {
                                PassengerListView(
                                    passengers: passengerDetail.reservation.passengers.passenger,
                                    itinerary: passengerDetail.reservation.itinerary,
                                    passportNumbers: $viewModel.passportNumbers,
                                    focusedField: _focusedField
                                )
                            }

                            Spacer()
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .background(Color.white)

                    Button(action: {
                        viewModel.savePassportDetails()
                    }) {
                        Text("Save")
                            .helveticaFont(size: 18, weight: .bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .background(Color(hex: primaryColor))
                    .cornerRadius(12)

                    .navigationDestination(isPresented: $viewModel.navigateToCheckIn) {
                        if let detail = viewModel.passengerDetail {
                            CheckInView(viewModel: CheckInViewModel(detail: detail))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PassengerListView: View {
    let passengers: [Passenger]
    let itinerary: Itinerary?
    @Binding var passportNumbers: [String: String]
    @FocusState var focusedField: String?

    var body: some View {
        ForEach(Array(passengers.enumerated()), id: \.element.id) { idx, passenger in
            let passportBinding = Binding<String>(
                get: { passportNumbers[passenger.id] ?? "" },
                set: { passportNumbers[passenger.id] = $0 }
            )

            PassengerCardView(
                passenger: passenger,
                index: idx,
                itinerary: itinerary,
                passportNumber: passportBinding
            )
            .focused($focusedField, equals: passenger.id)
        }
    }
}

struct PassengerCardView: View {
    let passenger: Passenger
    let index: Int
    let itinerary: Itinerary?

    @Binding var passportNumber: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(passenger.personName.first) \(passenger.personName.last)")
                    .helveticaFont(size: 18, weight: .semibold)

                if let itinerary = itinerary,
                   index < itinerary.itineraryPart.count,
                   let segment = itinerary.itineraryPart[index].segment.first,
                   let flightDetail = segment.flightDetail.first {
                    Text("\(flightDetail.operatingAirline) \(flightDetail.flightNumber) \(flightDetail.departureCountry)(\(flightDetail.departureAirport)) to \(flightDetail.arrivalCountry)(\(flightDetail.arrivalAirport))")
                        .helveticaFont(size: 16, weight: .regular)
                }
            }

            HStack(alignment: .top) {
                Text("Passport information\nis required")
                    .helveticaFont(size: 16, weight: .medium)
                    .foregroundColor(.white)
                Spacer() // Pushes text to the left
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color(hex: primaryColor))
            .cornerRadius(12)

            Text("Please enter the required\ndocument details below")
                .font(.system(size: 16))
                .foregroundColor(.black)

            VStack(alignment: .leading, spacing: 8) {
                Text("Passport Number")
                    .font(.system(size: 16, weight: .semibold))

                TextField("Enter passport number", text: $passportNumber)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)
            }
        }
    }
}

#Preview {
    PassengerDetailsView(viewModel: PassengerDetailsViewModel(detail: .preview))
}
