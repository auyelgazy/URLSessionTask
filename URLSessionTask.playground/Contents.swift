import Foundation

func getData(url: String) {
    let url = URL(string: url)
    guard let url = url else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("[error] \(String(describing: error))")
        }

        guard let response = response as? HTTPURLResponse else { return }
        guard let data = data else { return }
        let dataAsString = String(data: data, encoding: .utf8)

        print("[responseStatusCode] = \(String(describing: response.statusCode))")
        print("\n[data] = \(String(describing: String(data: data, encoding: .utf8)))")
    }.resume()
}

getData(url: "https://api.breakingbadquotes.xyz/v1/quotes")
