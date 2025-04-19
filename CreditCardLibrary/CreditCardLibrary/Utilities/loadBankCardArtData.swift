import Foundation

typealias BankCardArtData = [String: [String]]

func loadBankCardArtData() -> BankCardArtData? {
    let fileName = "BankCardArtData"
    
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("Could not find \(fileName).json in the bundle.")
        return nil
    }
    
    do {
        // Read raw data from the file
        let data = try Data(contentsOf: url)
        // Decode the data into our dictionary type
        let decoded = try JSONDecoder().decode(BankCardArtData.self, from: data)
        return decoded
    } catch {
        print("Error decoding \(fileName).json: \(error)")
        return nil
    }
}
