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
                                .padding(.top, 12)

                            Spacer()
                            Spacer()

                            if let passengerDetail = viewModel.passengerDetail {
                                PassengerListView(
                                    passengers: passengerDetail.reservation.passengers.passenger,
                                    itinerary: passengerDetail.reservation.itinerary,
                                    passportNumbers: $viewModel.passportNumbers,
                                    nationalities: $viewModel.nationalities,
                                    countryOfBirths: $viewModel.countryOfBirths, dateOfBirths: $viewModel.dateOfBirths,
                                    issuingCountries: $viewModel.issuingCountries,
                                    issuingPlaces: $viewModel.issuingPlaces,
                                    issueDates: $viewModel.issueDates,
                                    expiryDates: $viewModel.expiryDates,
                                    genders: $viewModel.genders,
                                    addressStreet1s: $viewModel.addressStreet1s,
                                    addressStreet2s: $viewModel.addressStreet2s,
                                    addressPostalCodes: $viewModel.addressPostalCodes,
                                    addressCountries: $viewModel.addressCountries,
                                    addressCities: $viewModel.addressCities,
                                    addressStateProvinces: $viewModel.addressStateProvinces,
                                    addressTypes: $viewModel.addressTypes,
                                    emergencyContactNames: $viewModel.emergencyContactNames,
                                    emergencyContactCountryCodeIDs: $viewModel.emergencyContactCountryCodeIDs,
                                    emergencyContactNumbers: $viewModel.emergencyContactNumbers,
                                    emergencyContactRelationships: $viewModel.emergencyContactRelationships,
                                    focusedField: _focusedField
                                )
                            }

                            Spacer()
                        }
                    }
                    .scrollIndicators(.hidden)
                    .scrollDismissesKeyboard(.interactively)
                    .background(Color.white)
                    .padding(.top, 20)

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
    @Binding var nationalities: [String: String]
    @Binding var countryOfBirths: [String: String]
    @Binding var dateOfBirths: [String: Date]
    @Binding var issuingCountries: [String: String]
    @Binding var issuingPlaces: [String: String]
    @Binding var issueDates: [String: Date]
    @Binding var expiryDates: [String: Date]
    @Binding var genders: [String: String]
    @Binding var addressStreet1s: [String: String]
    @Binding var addressStreet2s: [String: String]
    @Binding var addressPostalCodes: [String: String]
    @Binding var addressCountries: [String: String]
    @Binding var addressCities: [String: String]
    @Binding var addressStateProvinces: [String: String]
    @Binding var addressTypes: [String: String]
    @Binding var emergencyContactNames: [String: String]
    @Binding var emergencyContactCountryCodeIDs: [String: String]
    @Binding var emergencyContactNumbers: [String: String]
    @Binding var emergencyContactRelationships: [String: String]

    @FocusState var focusedField: String?

    var body: some View {
        ForEach(Array(passengers.enumerated()), id: \.element.id) { idx, passenger in
            let passportBinding = Binding<String>(
                get: { passportNumbers[passenger.id] ?? "" },
                set: { passportNumbers[passenger.id] = $0 }
            )
            let nationalityBinding = Binding<String>(
                get: { nationalities[passenger.id] ?? "" },
                set: { nationalities[passenger.id] = $0 }
            )
            let countryOfBirthBinding = Binding<String>(
                get: { countryOfBirths[passenger.id] ?? "" },
                set: { countryOfBirths[passenger.id] = $0 }
            )
            let dateOfBirthBinding = Binding<Date>(
                get: { dateOfBirths[passenger.id] ?? Date() },
                set: { dateOfBirths[passenger.id] = $0 }
            )
            let issuingCountryBinding = Binding<String>(
                get: { issuingCountries[passenger.id] ?? "" },
                set: { issuingCountries[passenger.id] = $0 }
            )
            let issuingPlaceBinding = Binding<String>(
                get: { issuingPlaces[passenger.id] ?? "" },
                set: { issuingPlaces[passenger.id] = $0 }
            )
            let issueDateBinding = Binding<Date>(
                get: { issueDates[passenger.id] ?? Date() },
                set: { issueDates[passenger.id] = $0 }
            )
            let expiryDateBinding = Binding<Date>(
                get: { expiryDates[passenger.id] ?? Date() },
                set: { expiryDates[passenger.id] = $0 }
            )
            let genderBinding = Binding<String>(
                get: { genders[passenger.id] ?? "" },
                set: { genders[passenger.id] = $0 }
            )
            let emergencyContactNameBinding = Binding<String>(
                get: { emergencyContactNames[passenger.id] ?? "" },
                set: { emergencyContactNames[passenger.id] = $0 }
            )

            let addressStreet1Binding = Binding<String>(
                get: { addressStreet1s[passenger.id] ?? "" },
                set: { addressStreet1s[passenger.id] = $0 }
            )

            let addressStreet2Binding = Binding<String>(
                get: { addressStreet2s[passenger.id] ?? "" },
                set: { addressStreet2s[passenger.id] = $0 }
            )

            let addressPostalCodeBinding = Binding<String>(
                get: { addressPostalCodes[passenger.id] ?? "" },
                set: { addressPostalCodes[passenger.id] = $0 }
            )

            let addressCountryBinding = Binding<String>(
                get: { addressCountries[passenger.id] ?? "" },
                set: { addressCountries[passenger.id] = $0 }
            )

            let addressCityBinding = Binding<String>(
                get: { addressCities[passenger.id] ?? "" },
                set: { addressCities[passenger.id] = $0 }
            )

            let addressStateProvinceBinding = Binding<String>(
                get: { addressStateProvinces[passenger.id] ?? "" },
                set: { addressStateProvinces[passenger.id] = $0 }
            )

            let addressTypeBinding = Binding<String>(
                get: { addressTypes[passenger.id] ?? "" },
                set: { addressTypes[passenger.id] = $0 }
            )

            let emergencyContactCountryCodeIDBinding = Binding<String>(
                get: { emergencyContactCountryCodeIDs[passenger.id] ?? "" },
                set: { emergencyContactCountryCodeIDs[passenger.id] = $0 }
            )
            let emergencyContactNumberBinding = Binding<String>(
                get: { emergencyContactNumbers[passenger.id] ?? "" },
                set: { emergencyContactNumbers[passenger.id] = $0 }
            )
            let emergencyContatcRelationshipBinding = Binding<String>(
                get: { emergencyContactRelationships[passenger.id] ?? "" },
                set: { emergencyContactRelationships[passenger.id] = $0 }
            )

            PassengerCardView(
                passenger: passenger,
                index: idx,
                itinerary: itinerary,
                passportNumber: passportBinding,
                nationality: nationalityBinding,
                countryOfBirth: countryOfBirthBinding,
                dateOfBirth: dateOfBirthBinding,
                issuingCountry: issuingCountryBinding,
                issuingPlace: issuingPlaceBinding,
                issuingDate: issueDateBinding,
                expiryDate: expiryDateBinding,
                gender: genderBinding,
                addressStreet1: addressStreet1Binding,
                addressStreet2: addressStreet2Binding,
                addressPostalCode: addressPostalCodeBinding,
                addressCountry: addressCountryBinding,
                addressCity: addressCityBinding,
                addressStateProvince: addressStateProvinceBinding,
                addressType: addressTypeBinding,
                emergencyContactName: emergencyContactNameBinding,
                emergencyContactCountryCodeID: emergencyContactCountryCodeIDBinding,
                emergencyContactNumber: emergencyContactNumberBinding,
                emergencyContactRelationship: emergencyContatcRelationshipBinding
            )
            .focused($focusedField, equals: passenger.id)
        }
    }
}

struct PassengerCardView: View {
    let passenger: Passenger
    let index: Int
    let itinerary: Itinerary?

    let genderArray = ["MALE", "FEMALE"]

    @Binding var passportNumber: String
    @Binding var nationality: String
    @Binding var countryOfBirth: String
    @Binding var dateOfBirth: Date
    @Binding var issuingCountry: String
    @Binding var issuingPlace: String
    @Binding var issuingDate: Date
    @Binding var expiryDate: Date
    @Binding var gender: String
    @Binding var addressStreet1: String
    @Binding var addressStreet2: String
    @Binding var addressPostalCode: String
    @Binding var addressCountry: String
    @Binding var addressCity: String
    @Binding var addressStateProvince: String
    @Binding var addressType: String
    @Binding var emergencyContactName: String
    @Binding var emergencyContactCountryCodeID: String
    @Binding var emergencyContactNumber: String
    @Binding var emergencyContactRelationship: String

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(passenger.personName.last) \(passenger.personName.first)")
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
                    .helveticaFont(size: 16, weight: .semibold)

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

            VStack(alignment: .leading, spacing: 8) {
                Text("Nationality")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Enter nationality", text: $nationality)
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

            VStack(alignment: .leading, spacing: 8) {
                Text("Country of Birth")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Enter country of birth", text: $countryOfBirth)
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

            VStack(alignment: .leading, spacing: 8) {
                DatePicker(selection: $dateOfBirth, displayedComponents: [.date]) {
                    Text("Date of Birth")
                        .helveticaFont(size: 16, weight: .semibold)
                }
                    .datePickerStyle(.compact)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Issuing Country")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Enter issuing country", text: $issuingCountry)
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

            VStack(alignment: .leading, spacing: 8) {
                Text("Issuing Place")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Enter issuing place", text: $issuingPlace)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                DatePicker(selection: $issuingDate, displayedComponents: [.date]) {
                    Text("Issuing Date")
                        .helveticaFont(size: 16, weight: .semibold)
                }
                    .datePickerStyle(.compact)

                DatePicker(selection: $expiryDate, displayedComponents: [.date]) {
                    Text("Expiring Date")
                        .helveticaFont(size: 16, weight: .semibold)
                }
                    .datePickerStyle(.compact)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Gender")
                    .helveticaFont(size: 16, weight: .semibold)

                Picker("Gender", selection: $gender) {
                    ForEach(genderArray, id: \.self) { genderStr in
                        Text(genderStr).tag(genderStr)
                    }
                }
                .pickerStyle(.menu) // Other options: .menu, .wheel, etc.
                .onAppear {
                    if gender.isEmpty {
                        gender = genderArray.first!
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Address")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Street 1", text: $addressStreet1)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Street 2", text: $addressStreet2)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Postal Code", text: $addressPostalCode)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Country", text: $addressCountry)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("City", text: $addressCity)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("State Province", text: $addressStateProvince)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

//                TextField("Type", text: $addressType)
//                    .padding()
//                    .frame(height: 44)
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
//                    )
//                    .focused($isFocused)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Emergency Contact")
                    .helveticaFont(size: 16, weight: .semibold)

                TextField("Enter Emergency Contact Name", text: $emergencyContactName)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Enter Emergency Contact Country Code", text: $emergencyContactCountryCodeID)
                    .padding()
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Enter Emergency Contact Number", text: $emergencyContactNumber)
                    .padding()
                    .keyboardType(.numberPad)
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused($isFocused)

                TextField("Enter Emergency Contact Relationship", text: $emergencyContactRelationship)
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
