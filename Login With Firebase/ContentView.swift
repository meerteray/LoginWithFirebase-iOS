import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var suvm = SignUpViewModel()
    @StateObject private var lvm = LoginViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .showingPopup
    
    enum ActiveAlert {
        case showingPopup, errorPopup, emptyPopup
    }
    
    var body: some View {
        
        NavigationView {
        ZStack {
            Color.white
            VStack(spacing: 24) {
                Text("Welcome!")
                    .foregroundColor( .black)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -90, y: -100)
                
                Text("Email Adress")
                    .bold()
                    .offset(x: -125, y: 20)
                TextField("name@examplecom", text: $email)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)

                Text("Password")
                    .bold()
                    .offset(x: -136, y: 20)
                SecureField("Enter Your Password", text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        showAlert = true
                        self.activeAlert = .emptyPopup
                        return
                    }
                    suvm.signUp(email: email, password: password) { result in
                        switch result {
                        case .success(_):
                            showAlert = true
                            self.activeAlert = .showingPopup
                            //     coordinator.path.append(.login)
                        case .failure(let error):
                            suvm.errorMessage = error.errorMessage
                            showAlert = true
                            self.activeAlert = .errorPopup
                        }
                    }
                }
            label:  {
                Text("Sign up")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.blue], startPoint:
                                    .top, endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.white)
            }
            .padding(.top)
            .offset(y: 110)
            //POP UPS
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .showingPopup:
                    return Alert(title: Text("Successful"), message: Text("Kayıt işleminiz gerçekleşmiştir."))
                case .errorPopup:
                    return Alert(title: Text("Failed"), message: Text("Bu Email zaten kayıtlı."))
                case .emptyPopup:
                    return Alert(title: Text("Failed"), message: Text("Hatalı Giriş."))
                }
            }
                NavigationLink(destination: LoginView()) {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundColor(.blue)
                }
            .padding(.top)
            .offset(y: 170)
            }
            .frame(width: 350)
        }
    }
        .ignoresSafeArea()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
