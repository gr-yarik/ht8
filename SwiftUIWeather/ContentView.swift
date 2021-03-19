//
//  ContentView.swift
//  SwiftUIWeather
//
//  Created by Yaroslav Hrytsun on 17.03.2021.
//

import SwiftUI
import Combine

struct CitiesView: View {
    
    @ObservedObject private var viewModel = CitiesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.citiesWeather, id: \.self) { cityWeather in
                HStack {
                    Text(cityWeather.cityName)
                        .frame(maxWidth: .infinity)
                    Image(systemName: cityWeather.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text(cityWeather.temperatureString)
                        .frame(maxWidth: .infinity)
                }
            }
            .environment(\.defaultMinListRowHeight, 70)
            .navigationBarTitle("Weather")
            .navigationBarItems(trailing:
                           Button(action: {
                            let alertHC = UIHostingController(rootView: InputAlert())
                            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet
                            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                        }){
                               Text("Add City")
                           }
                       )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
