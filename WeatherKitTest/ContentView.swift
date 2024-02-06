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
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "gear")
                }
            Text("Second Tab")
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
    }
}
#Preview {
    ContentView()
}
