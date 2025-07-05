//
//  BottomBar.swift
//  BeenThere
//
//  Created by Aditya Makhija on 2025-07-04.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
            TabView {
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                
                Text("Friends")
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Friends")
                    }
                
                Text("Leaderboards")
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Leaderboards")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
            }
    }
}

#Preview {
    BottomBar()
}
