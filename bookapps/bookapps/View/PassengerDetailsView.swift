//
//  PassengerDetailsView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import SwiftUI

struct PassengerDetailsView: View {
    @ObservedObject var viewModel: PassengerDetailsViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Passenger Details")
                        .helveticaFont(size: 32, weight: .bold)
                        .padding(.top, 32)

                    if let passengerDetail = viewModel.passengerDetail {
                        let passengers = passengerDetail.reservation.passengers.passenger
                        ForEach(Array(passengers.enumerated()), id: \.element.id) { idx, passenger in
                            PassengerCardView(passenger: passenger, index: idx, itinerary: passengerDetail.reservation.itinerary)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color.white)

            Button(action: {
                viewModel.savePassportDetails()
            }) {
                if viewModel.isSaving {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Save")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(Color(hex: "#FF6600"))
            .cornerRadius(12)
            .disabled(viewModel.isSaving)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct PassengerCardView: View {
    let passenger: Passenger
    let index: Int
    let itinerary: Itinerary?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(passenger.personName.first) \(passenger.personName.last)")
                .helveticaFont(size: 18, weight: .semibold)

            if let itinerary = itinerary,
               index < itinerary.itineraryPart.count,
               let segment = itinerary.itineraryPart[index].segment.first,
               let flightDetail = segment.flightDetail.first {
                Text("\(flightDetail.operatingAirline) \(flightDetail.flightNumber) \(flightDetail.departureCountry)(\(flightDetail.departureAirport)) to \(flightDetail.arrivalCountry)(\(flightDetail.arrivalAirport))")
                    .helveticaFont(size: 16, weight: .regular)
            }

            Text("Passport information\nis required")
                .helveticaFont(size: 16, weight: .medium)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: primaryColor))
                .cornerRadius(12)

            Text("Please enter the required\ndocument details below")
                .font(.system(size: 16))
                .foregroundColor(.black)

            VStack(alignment: .leading, spacing: 8) {
                Text("Passport Number")
                    .font(.system(size: 16, weight: .semibold))

                // You may want to bind this to a `@Binding` if needed per passenger
                TextField("", text: .constant("")) // Replace with actual binding if needed
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    PassengerDetailsView(viewModel: PassengerDetailsViewModel(detail: .preview))
}
