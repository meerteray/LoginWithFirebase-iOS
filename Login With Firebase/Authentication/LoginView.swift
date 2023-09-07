import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Welcome!")
                    .foregroundColor( .black)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -5, y: 1)

                
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .offset(x: 5, y: 100)
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    .offset(x: 5, y: 100)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                Spacer()
            }
        }
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
