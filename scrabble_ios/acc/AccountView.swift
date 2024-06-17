//
//  AccountView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 17.06.2024.
//

import SwiftUI

struct Account: View {
    @AppStorage("log_status") var log_status: Bool = true
    @ObservedObject var profileViewModel: ProfileViewModel = .init()
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geo in
                    VStack {
                        Text((UserDefaults.standard.string(forKey: "userLogin") == nil ? "LOGIN" : UserDefaults.standard.string(forKey: "userLogin"))!)
                            .textCase(.uppercase)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        HStack {
                            Button(action: {
                                profileViewModel.deleteUser()
                            }, label: {
                                Text("Delete account")
                                    .frame(width: (geo.size.width - 32) / 2)
                                    .foregroundStyle(.background)
                                    .padding(.vertical, 10)
                                    .background(content: {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(red: 160/255, green: 0, blue: 0))
                                    })
                            })
                            .frame(width: (geo.size.width - 32) / 2)
                            Button(action: {
                                log_status.toggle()
                                UserDefaults.standard.set(nil, forKey: "jwtUser")
                                UserDefaults.standard.set(nil, forKey: "userid")
                                UserDefaults.standard.set(nil, forKey: "userLogin")
                                UserDefaults.standard.set(nil, forKey: "currentRoomId")
                            }, label: {
                                Text("Logout")
                                    .frame(width: (geo.size.width - 32) / 2)
                                    .foregroundStyle(.background)
                                    .padding(.vertical, 10)
                                    .background(content: {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.primary)
                                    })
                            })
                            
                            .foregroundStyle(.primary)
                        }
                        .hSpacing(.center)
                    }
                }
            }
        }
    }
}

#Preview {
    Account()
}
