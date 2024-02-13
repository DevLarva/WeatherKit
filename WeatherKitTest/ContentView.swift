//
//  WeatherView.swift
//  SwiftAPIDemo
//
import SwiftUI
import CoreLocation
import OpenAI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var aiViewModel = AiViewModel()
    @StateObject var aiWellMatchViewModel = AiWellMatchViewModel()
    var body: some View {
        TabView {
            
            WellMatched()
                .tabItem {
                    Image(systemName: "gear")
                }
            MainView()
                .tabItem {
                    Image(systemName: "gear")
                }
            Text("Third Tab")
                .tabItem {
                    Image(systemName: "gear")
                }
        }
        .environmentObject(locationManager)
        .environmentObject(aiViewModel)
        .environmentObject(aiWellMatchViewModel)
    }
}
#Preview {
    ContentView()
}
