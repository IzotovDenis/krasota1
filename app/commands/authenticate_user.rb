class AuthenticateUser
    prepend SimpleCommand 

    def initialize(email, password) 
        @email = email 
        @password = password 
    end 

    def call
        if user
            token = JsonWebToken.encode(user_id: user.id)
            {auth_token: token, user: {id: user.id, email: user.email}}
        end
    end 

    private 

    attr_accessor :email, :password 

    def user 
        user = User.find_by_email(email)
        return user if user && user.authenticate(password) 

        errors.add :user_authentication, 'invalid credentials' 
        nil 
    end 
end