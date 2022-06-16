import UIKit

var vehiclesList: Set<Vehicle> = [
    Vehicle(plate: "AAA", vehicleType: VehicleType.car, checkInTime: Date(), discountCard: "123"),
    Vehicle(plate: "BBB", vehicleType: VehicleType.car, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "CCC", vehicleType: VehicleType.car, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "DDD", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "EEE", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "FFF", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "GGG", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "HHH", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "III", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "JJJ", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "KKK", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "LLL", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "MMM", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "NNN", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "OOO", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "PPP", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "QQQ", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "RRR", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "SSS", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "TTT", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "UUU", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil),
]

//var vehiclesList: Set<Vehicle> = []

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

struct Parking {
    let maxVehicles: Int
    var vehicles: Set<Vehicle> = Set()
    
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard (vehicles.count < maxVehicles) && !vehicles.contains(vehicle) else {
            return onFinish(false)
        }
        onFinish(vehicles.insert(vehicle).inserted)
    }
    
    mutating func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: (String) -> Void) {
        guard let vehicleIndex = vehicles.firstIndex(where: { $0.plate == plate}) else {
            return onError("O veículo de placa \(plate) não foi encontrado")
        }
        
        let vehicle = vehicles.remove(at: vehicleIndex)

        onSuccess(calculateFee(vehicleType: vehicle.vehicleType, parkedTimeInMinutes: 180, hasDiscountCard: vehicle.discountCard != nil))
    }

    func calculateFee(vehicleType: VehicleType, parkedTimeInMinutes: Int, hasDiscountCard: Bool) -> Int {
        let parkedTimeInMinutes = parkedTimeInMinutes - 120
        var tariff = vehicleType.tarifa
        
        if(parkedTimeInMinutes > 0) {
            tariff += Int(5 * ceilf(Float(parkedTimeInMinutes) / 15))
        }
        
        return hasDiscountCard ? Int(Float(tariff) * 0.85) : tariff
    }
        
}
    // MARK: - Verificador de quantidade máxima e print mensagem
    
    var alkeParking = Parking(maxVehicles: 20)
    
    for vehicleList in vehiclesList {
        alkeParking.checkInVehicle(vehicleList) { success in
            print(success ? "Welcome to AlkeParking!" : "Sorry, the check-in failed")
        }
    }
alkeParking.checkOutVehicle(plate: "AAA", onSuccess: { print($0) }, onError: { print($0) })

