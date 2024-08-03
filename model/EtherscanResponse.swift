import Foundation

struct EtherscanResponse: Decodable {
    let message: String
    let result: EtherscanGas
    
    enum CodingKeys: CodingKey {
        case message
        case result
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        result = try container.decode(EtherscanGas.self, forKey: .result)
    }
}
