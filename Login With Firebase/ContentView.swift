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
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red, .blue], startPoint:
                        .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -560)
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor( .white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: 0)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
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
                            .fill(.linearGradient(colors: [.white], startPoint:
                                    .top, endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.black)
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
                // Login
              /*  Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        self.activeAlert = .emptyPopup
                        showAlert = true
                        return
                    }
                    lvm.login1(email: email, password: password)
                    //     coordinator.path.append(.login)
                }
                
                
            label:  {
                Text("Already have an account? Login")
                    .bold()
                    .foregroundColor(.white)
            } */
                
                NavigationLink(destination: LoginView()) {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundColor(.white)
                }
            .padding(.top)
            .offset(y: 110)
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
