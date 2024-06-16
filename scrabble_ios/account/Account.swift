import SwiftUI

struct Account: View {
    @AppStorage("log_status") var log_status: Bool = true
    @ObservedObject var profileViewModel: ProfileViewModel = .init()
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geo in
                    VStack {
                        Text((UserDefaults.standard.string(forKey: "jwtUser") == "" ? "LOGIN" : UserDefaults.standard.string(forKey: "jwtUser"))!)
                            .textCase(.uppercase)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        HStack {
                            Button(action: {
                                profileViewModel.deleteUser()
                            }, label: {
                                Text("Deelete account")
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
                                UserDefaults.standard.set("", forKey: "jwtUser")
                                UserDefaults.standard.set("", forKey: "userid")
                                UserDefaults.standard.set("", forKey: "userLogin")
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
