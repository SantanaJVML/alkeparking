import UIKit

enum VehicleType {
    case car, motorcycle, microbus, bus
    
    var tarifa: Int {
        switch self {
            case .car: return 20
            case .motorcycle: return 15
            case .microbus: return 25
            case .bus: return 30
        }
    }
}

protocol Parkable {
    var plate: String { get }
    var vehicleType: VehicleType { get }
    var discountCard: String? { get set }
    var checkInTime: Date { get }
    var parkedTime: Int { get }
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let vehicleType: VehicleType
    let checkInTime: Date
    var discountCard: String?
    var parkedTime: Int {
        get { Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0 }
    }
    
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
    
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish:
    (Bool) -> Void) {

    }
}

var alkeParking = Parking()

let car = Vehicle(plate: "AA111AA", vehicleType: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

let moto = Vehicle(plate: "B222BBB", vehicleType: .motorcycle, checkInTime: Date(), discountCard: nil)

let miniBus = Vehicle(plate: "CC333CC", vehicleType: .microbus, checkInTime: Date(), discountCard:
nil)

let bus = Vehicle(plate: "DD444DD", vehicleType: .bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

alkeParking.vehicles.insert(car)

alkeParking.vehicles.insert(moto)

alkeParking.vehicles.insert(miniBus)

alkeParking.vehicles.insert(bus)

let car1 = Vehicle(plate: "AA111AA", vehicleType: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

let car2 = Vehicle(plate: "AA111AA", vehicleType: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")

print(alkeParking.vehicles.insert(car).inserted)

print(alkeParking.vehicles.insert(car2).inserted)

alkeParking.vehicles.remove(moto)
