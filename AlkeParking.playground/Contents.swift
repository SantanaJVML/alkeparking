import UIKit

enum VehicleType {
    case carro, motocicleta, microonibus, onibus
    
    var tarifa: Int {
        switch self {
            case .carro: return 20
            case .motocicleta: return 15
            case .microonibus: return 25
            case .onibus: return 30
        }
    }
}

protocol Parkable {
    var plate: String { get }
    var vehicleType: VehicleType { get }
    var discountCard: String? { get set }
    var checkInTime: Date { get }
    
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let vehicleType: VehicleType
    let checkInTime: Date = Date()
    var discountCard: String?
    
    //Hashtable
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    //Equatable
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking{
    var vehicles: Set<Vehicle> = Set()
}

let alkeParking: Parking = Parking()
