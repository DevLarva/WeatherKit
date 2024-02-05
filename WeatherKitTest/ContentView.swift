//
//  WeatherView.swift
//  SwiftAPIDemo
//
import SwiftUI
import CoreLocation
import OpenAI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var weather: Weather?
    @State private var cityName: String?
    @State private var aiViewModel = AiViewModel()
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
        Spacer().frame(height: 40)
        VStack(alignment:.leading) {
            Text("오늘의 추천 술")
                .bold()
                .font(.title2)
            Text(aiViewModel.respond)
                .task {
                    await aiViewModel.request(prompt: "Please recommend one type of snack that goes well with \(String(describing: weather?.main)) using one word using Korean from the following list. ---List: 떡볶이 피자 치킨 파전 김치전 닭꼬치 곱창 삼겹살 오뎅탕 짬뽕")
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
            return "Snow"
        case "Rain":
            return "Rain"
        case "Snow":
            return "Sun"
        case "Thunderstorm":
            return "thunderstormAnimation"
        default:
            return "unknownWeatherAnimation"
        }
    }
}
#Preview {
    ContentView()
}
