import Foundation

//      "LastBlock":"20419971",
//      "SafeGasPrice":"13",
//      "ProposeGasPrice":"14",
//      "FastGasPrice":"16",
//      "suggestBaseFee":"12.054630916",
//      "gasUsedRatio":"0.443183766666667,0.443926366666667,0.391789166666667,0.458401066666667,0.5319044"

enum GasLevel {
    case low
    case medium
    case high
}

struct EtherscanGas: Decodable {
    let suggestBaseFee: String
    let safeGasPrice: String
    let standart: String
    let level: GasLevel
    
    enum CodingKeys: CodingKey {
        case suggestBaseFee
        case SafeGasPrice
    }
    
    init(from decoder: any Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        suggestBaseFee = try container.decode(String.self, forKey: .suggestBaseFee)//Float(suggestBaseFee) ?
        safeGasPrice = try container.decode(String.self, forKey: .SafeGasPrice)
        let price: Float = Float(suggestBaseFee) ?? 0.0
        standart = String(format: "%.1f", price)
        
        if price < 10.0 {
            level = GasLevel.low
        } else if price >= 10.0 && price < 25.0 {
            level = GasLevel.medium
        } else {
            level = GasLevel.high
        }
    }
}
