import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isOnboarded = false
    
    var body: some View {
        if isOnboarded {
            BottomBar()
                .environmentObject(locationManager)
        } else {
            OnboardingView(isOnboarded: $isOnboarded, locationManager: locationManager)
        }
    }
}



#Preview {
    ContentView()
}
