import SwiftUI

struct Registration: View {
    @State var login: String = ""
    @State var password: String = ""
    @Environment(\.dismiss) var dismiss
    @State var showError: Bool = false
    @ObservedObject var regViewModel = RegistrationViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 150) {
                Text ("Registration")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                VStack {
                    TextField("Login", text: $regViewModel.userLogin)
                        .bold()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black)
                        })
                        .padding(.horizontal)
                    
                    SecureInputView("Password", text: $regViewModel.userPassword)
                        .bold()
                        .padding()
                        .background(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                    Button(action: {
                        regViewModel.register()
                        if (regViewModel.registered == true) {
                            dismiss()
                            regViewModel.clearFields()
                        } else {
                            showError.toggle()
                        }
                    }, label: {
                        Text("Register")
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
                    
                    if showError {
                        Text("Some error accured. Maybe you've already been registered?")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                    }
                    
                }
                Spacer()
            }
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    regViewModel.clearFields()
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.primary)
                })
                .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    Registration()
}
