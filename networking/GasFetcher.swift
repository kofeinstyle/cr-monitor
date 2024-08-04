import Foundation

class GasFetcher: ObservableObject {
    // model
    @Published var gas: EtherscanGas?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    var timer: Timer?
    
    init() {
        fetchData()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            self.fetchData()
        })
    }
    
    deinit {
        timer?.invalidate()
    }
    
    
    @objc func fetchData() {
        isLoading = true
        let url = URL(string:  Secrets().apiKey)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
            
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let resp = try decoder.decode(EtherscanResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.gas = resp.result
                    }
                } catch {
                    print(error)
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription.description
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = nil
                } 
            }
        }
        task.resume()
    }
}
