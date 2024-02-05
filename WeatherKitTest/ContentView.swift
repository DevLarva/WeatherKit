//
//  WeatherView.swift
//  SwiftAPIDemo
//
import SwiftUI
import CoreLocation
import OpenAI

struct ContentView: View {
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
            Text("Forth Tab")
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}
#Preview {
    ContentView()
}
