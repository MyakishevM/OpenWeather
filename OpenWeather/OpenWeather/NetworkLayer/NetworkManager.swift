import Foundation

final class NetworkManager {
    private let host = "api.openweathermap.org"
    private  let scheme = "https"
    private let apiKey = "1e2e6db83f9f1cb57fced5cfb321d23e"
    func request(lat: Double, long: Double, completion: @escaping (Result<Data, Error>) -> Void){
        let path = "/data/2.5/onecall"
        let session = URLSession(configuration: .default)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = path
        urlConstructor.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "exclude", value: "minutely"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(data))
        }.resume()
    }
}

