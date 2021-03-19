//
//  InputAlert.swift
//  SwiftUIWeather
//
//  Created by Yaroslav Hrytsun on 18.03.2021.
//

import SwiftUI
import Combine

struct InputAlert: View {
    @State private var text: String = ""
    let service = WeatherService()
    let storage = Storage()
    
    var body: some View {

        VStack {
            Text("Enter Input").font(.headline).padding()

            TextField("Type text here", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    service.checkIfValidCityName(cityName: text) { isValid in
                        if isValid {
                            storage.addCity(name: text)
                            NotificationCenter.default.post(name: .didAddCity, object: nil)
                        }
                        
                    }
                    
                    
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {
                    Text("Add")
                }
                Spacer()

                Divider()

                Spacer()
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {
                    Text("Cancel")
                }
                Spacer()
            }.padding(0)


            }.background(Color(white: 0.9))
    }
}
