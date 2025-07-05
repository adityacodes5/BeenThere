import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // fallback
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var centerCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    @State private var regionName: String = "Loading..."
    @State private var didCenterOnUser = false
    @State private var geocodeWorkItem: DispatchWorkItem?
    
    private let stateProvinceNames: [String: String] = [
        "AB": "Alberta", "BC": "British Columbia", "MB": "Manitoba", "NB": "New Brunswick",
        "NL": "Newfoundland and Labrador", "NS": "Nova Scotia", "NT": "Northwest Territories",
        "NU": "Nunavut", "ON": "Ontario", "PE": "Prince Edward Island", "QC": "Quebec",
        "SK": "Saskatchewan", "YT": "Yukon",
        "AL": "Alabama", "AK": "Alaska", "AZ": "Arizona", "AR": "Arkansas", "CA": "California",
        "CO": "Colorado", "CT": "Connecticut", "DE": "Delaware", "FL": "Florida", "GA": "Georgia",
        "HI": "Hawaii", "ID": "Idaho", "IL": "Illinois", "IN": "Indiana", "IA": "Iowa",
        "KS": "Kansas", "KY": "Kentucky", "LA": "Louisiana", "ME": "Maine", "MD": "Maryland",
        "MA": "Massachusetts", "MI": "Michigan", "MN": "Minnesota", "MS": "Mississippi",
        "MO": "Missouri", "MT": "Montana", "NE": "Nebraska", "NV": "Nevada", "NH": "New Hampshire",
        "NJ": "New Jersey", "NM": "New Mexico", "NY": "New York", "NC": "North Carolina",
        "ND": "North Dakota", "OH": "Ohio", "OK": "Oklahoma", "OR": "Oregon", "PA": "Pennsylvania",
        "RI": "Rhode Island", "SC": "South Carolina", "SD": "South Dakota", "TN": "Tennessee",
        "TX": "Texas", "UT": "Utah", "VT": "Vermont", "VA": "Virginia", "WA": "Washington",
        "WV": "West Virginia", "WI": "Wisconsin", "WY": "Wyoming"
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .mapControls {
                    MapUserLocationButton()
                }
                .ignoresSafeArea()
                .onReceive(locationManager.$location) { location in
                    if let loc = location, !didCenterOnUser {
                        region.center = loc
                        centerCoordinate = loc
                        didCenterOnUser = true
                        reverseGeocode(loc, region.span.latitudeDelta)
                    }
                }
                .onReceive(
                    Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                ) { _ in
                    let center = region.center
                    if center.latitude != centerCoordinate.latitude || center.longitude != centerCoordinate.longitude {
                        centerCoordinate = center
                        geocodeDebounced(center, region)
                    }
                }
            
            Text(regionName)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color("PrimaryDark").opacity(0.85), in: Capsule())
                .padding(.top, 20)
        }
    }
    
    private func geocodeDebounced(_ coordinate: CLLocationCoordinate2D, _ region: MKCoordinateRegion) {
        geocodeWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            reverseGeocode(coordinate, region.span.latitudeDelta)
        }
        geocodeWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: workItem)
    }
    
    private func reverseGeocode(_ coordinate: CLLocationCoordinate2D, _ regionSpan: CLLocationDegrees) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            DispatchQueue.main.async {
                if let place = placemarks?.first {
                    let city = place.locality
                    let admin = place.administrativeArea
                    let adminFull = stateProvinceNames[admin ?? ""] ?? admin
                    let country = place.country
                    
                    if regionSpan < 0.3 {
                        regionName = city ?? adminFull ?? country ?? ""
                    } else if regionSpan < 10.0 {
                        regionName = adminFull ?? country ?? ""
                    } else {
                        regionName = country ?? ""
                    }
                } else {
                    regionName = "Unknown"
                }
            }
        }
    }
}
