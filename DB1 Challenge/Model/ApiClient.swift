import Foundation

final class ApiClient {

    static let shared = ApiClient()
    internal let endpointURI = "https://api.blockchain.info/charts/market-price?format=json&timespan=30days"

    public func fetchQuotation(success: @escaping (BitcoinQuotation) -> Void, fail: @escaping (Error?) -> Void) {
        guard let url = URL(string: endpointURI) else { return }
        let urlSession = URLSession(configuration: .ephemeral)
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                fail(error)
                return
            }
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let quotation = try decoder.decode(BitcoinQuotation.self, from: dataResponse)
                success(quotation)
            } catch let parsingError {
                print("Error", parsingError)
                fail(parsingError)
            }
        }
        task.resume()
    }

}
