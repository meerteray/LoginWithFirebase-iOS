import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var vm = SignUpViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State var showingPopup = false
    @State var errorPopup = false
    
    var body: some View {

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
                //    signUp
                    vm.signUp(email: email, password: password) { result in
                        switch result {
                        case .success(_):
                            showingPopup = true
                            coordinator.path.append(.login)
                            
                        case .failure(let error):
                            vm.errorMessage = error.errorMessage
                            errorPopup = true
                        }
                    }
                    
                } label:  {
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
                .alert(isPresented: $showingPopup) {
                    Alert(
                        title: Text("Successful"),
                        message: Text("Kayıt işleminiz gerçekleşmiştir"))
                }

                .alert(isPresented: $errorPopup) {
                    Alert(
                        title: Text("Failed"),
                        message: Text("Bu Email zaten kayıtlı."))
                }
                
                Button {
                    login()
                } label:  {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 110)
                
            }
            .frame(width: 350)

        }
        .ignoresSafeArea()

    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("1984", error!.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        } .navigationDestination(for: Route.self) { route in
            switch route {
            case .login:
                Text("LOGIN SCREEN")
            }
        }
    
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
