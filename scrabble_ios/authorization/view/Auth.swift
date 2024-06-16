import SwiftUI

struct Auth: View {
    @State var login: String = ""
    @State var password: String = ""
    @ObservedObject var authViewModel: AuthViewModel = .init()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 150) {
                    Text ("Welcome to Scrabble")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .frame(width: 180)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    
                    VStack {
                        TextField("Login", text: $authViewModel.userLogin)
                            .bold()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(content: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black)
                            })
                            .padding(.horizontal)
                        
                        SecureInputView("Password", text: $authViewModel.userPassword)
                            .bold()
                            .padding()
                            .background(content: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black)
                            })
                            .padding(.horizontal)
                            .padding(.bottom)
                        Button(action: {
                            authViewModel.login()
                            authViewModel.clearFields()
                        }, label: {
                            Text("Login")
                                .foregroundStyle(.background)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 10)
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.primary)
                                })
                            
                        })
                        .foregroundStyle(.primary)
                        .font(.title3)
                        
                        NavigationLink(destination: Registration()) {
                            Text("Don't have an account? Register now")
                                .underline()
                        }
                        .padding()
                        .foregroundStyle(.secondary)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                } else {
                    TextField(title, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}

#Preview {
    Auth()
}
