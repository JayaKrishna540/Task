import Foundation
 
class APIClient {
    
private let apiUrl = "https://icanhazdadjoke.com/api"
    
    func fetchJoke(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            if let joke = String(data: data, encoding: .utf8) {
                completion(.success(joke))
            } else {
                completion(.failure(NSError(domain: "Failed to parse joke", code: 0, userInfo: nil)))
            }
        }.resume()
    }
}
