//
//  CheckInView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import SwiftUI

struct CheckInView: View {
    @ObservedObject var viewModel: CheckInViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: secondaryColor)
                    .ignoresSafeArea()

                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            HStack(alignment: .top) {
                                Text("CHECK-IN")
                                    .helveticaFont(size: 32, weight: .bold)
                                    .foregroundColor(.white)
                                    .padding(.top, 32)
                                Spacer() // Pushes text to the left
                            }

                            Spacer()

                            if let passengerDetail = viewModel.passengerDetail {
                                let passengers = passengerDetail.reservation.passengers.passenger
                                ForEach(Array(passengers.enumerated()), id: \.element.id) { idx, passenger in
                                    CheckInCardView(passenger: passenger,
                                                    index: idx,
                                                    itinerary: passengerDetail.reservation.itinerary)
                                }
                            }
                            Spacer(minLength: 100)
                        }
                    }


                    Button(action: {
                        viewModel.checkIn()
                    }) {
                        Text("Check in")
                            .helveticaFont(size: 18, weight: .bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .background(Color(hex: primaryColor))
                    .cornerRadius(12)

                    .navigationDestination(isPresented: $viewModel.navigateToBoardingPass) {
                        BoardingPassView(viewModel: BoardingPassViewModel(passengerFlightIds: viewModel.passengerFlightIds))
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

struct CheckInCardView: View {
    let passenger: Passenger
    let index: Int
    let itinerary: Itinerary?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(passenger.personName.first) \(passenger.personName.last)")
                .helveticaFont(size: 18, weight: .semibold)
                .foregroundColor(.white)

            if let itinerary = itinerary,
               index < itinerary.itineraryPart.count,
               let segment = itinerary.itineraryPart[index].segment.first,
               let flightDetail = segment.flightDetail.first {
                Text("\(flightDetail.operatingAirline) \(flightDetail.flightNumber) \(flightDetail.departureCountry)(\(flightDetail.departureAirport)) to \(flightDetail.arrivalCountry)(\(flightDetail.arrivalAirport))")
                    .helveticaFont(size: 16, weight: .regular)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    CheckInView(viewModel: CheckInViewModel(detail: .preview))
}
