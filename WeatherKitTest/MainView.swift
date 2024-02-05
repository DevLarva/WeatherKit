//
//  MainView.swift
//  WeatherKitTest
//
//  Created by 백대홍 on 2/6/24.
//

import SwiftUI
import CoreLocation
import OpenAI

struct MainView: View {
    @StateObject var locationManager = LocationManager()
    @State private var weather: Weather?
    @State private var cityName: String?
    @State private var aiViewModel = AiViewModel()
    @State private var age: Int = 21
    @State private var sexual: String = "man"
    let koreanSnacks = [
        "떡볶이",
        "김치전",
        "파전",
        "오뎅탕",
        "치킨",
        "닭꼬치",
        "곱창",
        "삼겹살",
        "피자",
        "만두",
        "라면",
        "떡",
        "호떡",
        "순대",
        "콘치즈",
        "감자튀김",
        "죽",
        "밥버거",
        "옥수수 떡볶이",
        "계란빵",
    ]

    let beerNames = [
        "하이네켄",
        "버드와이저",
        "기네스",
        "코로나",
        "스텔라",
        "인디아 페일 에일",
        "필스너 우르켈",
        "삿포로",
        "시메",
        "블루 문",
        "시에라 네바다",
        "새뮤얼 아담스",
        "벡스",
        "모델로",
        "아사히",
        "칭따오",
        "페로니",
        "미켈로브 울트라",
        "헤가든",
        "밀러 라이트",
    ]
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
            HStack {
                Text(aiViewModel.respond)
                    .task {
                        await aiViewModel.request(prompt: "Please recommend snacks and drinks that go well with this weather. and i'm \(age)years old \(sexual). Please refer to the below list behind you for the sake of snacks. Please recommend one each for snacks and drinks. When printing snacks and drinks \(String(describing: weather?.main)) ---dish List: \(koreanSnacks) ---drink List:\(beerNames)")
                        print("\(String(describing: weather?.main))")
                    }
                Text("어때요?")
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
    MainView()
}
