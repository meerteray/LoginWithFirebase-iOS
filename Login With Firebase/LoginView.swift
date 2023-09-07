import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        NavigationView {
        ZStack {
            Color.white
            VStack(spacing: 24) {
                Text("Welcome Back!")
                    .foregroundColor( .black)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -50, y: -140)
                
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
                   /* suvm.signUp(email: email, password: password) { result in
                        switch result {
                        case .success(_):
                    //     coordinator.path.append(.login)
                        case .failure(let error):
                           suvm.errorMessage = error.errorMessage
                        }
                    } */
                }
            label:  {
                Text("Login")
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
            .offset(y: 50)
            }
            .frame(width: 350)
        }
    }
        .ignoresSafeArea()
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
