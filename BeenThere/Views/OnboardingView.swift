import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarded: Bool
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "map.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.blue)
            
            Text("Welcome to BeenThere")
                .font(.largeTitle)
                .bold()
            
            Text("See where you’ve been, and share your memories.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                locationManager.requestAuthorization()
                UserDefaults.standard.set(true, forKey: "isOnboarded")
                isOnboarded = true
            } label: {
                Text("Allow Location")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(12)
            }
            .padding()
            
            Button("Open Settings to Allow Always") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .foregroundStyle(.blue)
            .padding(.bottom, 20)
        }
        .padding()
    }
}

#Preview {
    OnboardingView(isOnboarded: .constant(false), locationManager: LocationManager())
}
