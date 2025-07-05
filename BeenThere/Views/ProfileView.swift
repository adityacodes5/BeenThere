import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // profile picture
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color("PrimaryDark"))
                        .padding(.top, 20)
                    
                    // name
                    Text("Aditya Makhija")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // user stats
                    HStack(spacing: 32) {
                        VStack {
                            Text("24")
                                .font(.headline)
                            Text("Friends")
                                .font(.caption)
                        }
                        VStack {
                            Text("12")
                                .font(.headline)
                            Text("Places")
                                .font(.caption)
                        }
                        VStack {
                            Text("1,245")
                                .font(.headline)
                            Text("Points")
                                .font(.caption)
                        }
                    }
                    .padding(.top, 12)
                    
                    // achievements
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Achievements")
                            .font(.headline)
                            .padding(.top, 24)
                        
                        ForEach(0..<3) { index in
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("Sample Achievement \(index + 1)")
                                Spacer()
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    // settings
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Settings")
                            .font(.headline)
                            .padding(.top, 24)
                        
                        Button {
                            // action
                        } label: {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                Text("Account Settings")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Button {
                            // action
                        } label: {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                Text("Sign Out")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
