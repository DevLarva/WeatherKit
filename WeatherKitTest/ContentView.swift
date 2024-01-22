//
//  WeatherView.swift
//  SwiftAPIDemo
//
import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var weather: Weather?
    @State private var cityName: String?

    var body: some View {
        VStack {
            if let weather = weather {
                LottieView(jsonName: getAnimationName(for: weather.main))
                    .frame(width: 200, height: 200)
                Text(getKoreanWeatherDescription(for: weather.main))
            } else {
                LottieView(jsonName: "Loading")
            }
        }
        .onReceive(locationManager.$location) { location in
                    if let location = location {
                        WeatherAPI.shared.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { weather in
                            self.weather = weather
                        }
                    }
                }
            }
    
    private func getKoreanWeatherDescription(for weather: String) -> String {
        switch weather {
        case "Clouds":
            return "오늘은 흐림.."
        case "Clear":
            return "오늘은 굉장히 맑아요!"
        case "Rain":
            return "오늘은 비가 오네요.."
        case "Snow":
            return "와우~눈이 와요!"
        case "Thunderstorm":
            return "천둥 조심하세요!"
        default:
            return "알 수 없음"
        }
    }
    
    private func getAnimationName(for weather: String) -> String {
        switch weather {
        case "Clouds":
            return "Clouds"
        case "Clear":
            return "Sun"
        case "Rain":
            return "Rain"
        case "Snow":
            return "Snow"
        case "Thunderstorm":
            return "thunderstormAnimation"
        default:
            return "unknownWeatherAnimation"
        }
    }
}
