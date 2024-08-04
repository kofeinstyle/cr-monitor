import Foundation

struct Secrets {
    private let fileName: String = "AppSecrets"
    
    public var apiKey: String {
      get {
          guard let filePath = Bundle.main.path(forResource: fileName, ofType: "plist") else {
              fatalError("Couldn't find file 'AppSecrets.plist'.")
          }
          
          let plist = NSDictionary(contentsOfFile: filePath)
      
          guard let value = plist?.object(forKey: "ETHERSCAN_API_URL") as? String else {
              fatalError("Couldn't find key 'ETHERSCAN_API_URL'.")
          }
          
          if (!value.starts(with: "https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=")) {
              fatalError("Value must be URL to etherscan with token like https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey={YOUR_TOKEN}")
          }
          
          return value
      }
    }
}
