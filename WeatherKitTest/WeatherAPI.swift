import SwiftUI
import CoreLocation
import Lottie

struct WeatherData: Decodable {
    let weather: [Weather]
    let name: String
}

struct Weather: Decodable {
    let main: String
    let description: String
}

class WeatherAPI {
    static let shared = WeatherAPI()
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "51790403d0d2987674c951f8acfd3325"  // OpenWeatherMap에서 발급받은 API

    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Weather?) -> Void) {
        let weatherURL = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: weatherURL) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                completion(weatherData.weather.first)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
}


