import Foundation
import CryptoKit

let publicKey = "d547b70b9ceb80d73036b2fcbb140842"
let privateKey = "136ffee995063d262a6512586f44f58445e3f6f3"
var hash: String {
    MD5(string: ts + privateKey + publicKey)
}
private let ts = String(Int.random(in: 1...99))

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

func getData(url: String) {
    let url = URL(string: url)
    guard let url = url else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("[error] \(String(describing: error))")
        }

        guard let response = response as? HTTPURLResponse else { return }
        guard let data = data else { return }
        let dataAsString = String(data: data, encoding: .utf8)

        print("[responseStatusCode] = \(String(describing: response.statusCode))")
        print("\n[data] = \(String(describing: String(data: data, encoding: .utf8)))")
    }.resume()
}

getData(url: "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)")
