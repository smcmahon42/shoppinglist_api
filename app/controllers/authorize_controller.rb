class AuthorizeController < ApplicationController

  def login
    
    def output(success)
      if success
      	token = genToken
      	@authUser[0].update_attributes(:token => token, :expire => Time.now.to_s)
        render :json => [{ 
          :token => token, 
          :id => @authUser[0].id, 
          :first_name => @authUser[0].first_name,
          :last_name => @authUser[0].last_name,
          }], :status => 200
      else
        render :json => [{ :token => 'null' }], :status => 400
      end
    end

    def verify(verfyUser = '')
      userEmail = verfyUser[0]
      userPassword = verfyUser[1]
      
      @authUser = User.where( :email => userEmail ).limit(1)
      if !@authUser.blank?
        authorized = @authUser[0].authenticate(userPassword) 
        authorized ? output(true) : output(false)
      else
        output(false)
      end
  
    end

    def auth
      if request.headers['Authorization'] != ''
        decoded = Base64.decode64(request.headers['Authorization'].to_s)
        verify(decoded.split(":"))
      else
        output(false)
      end
    end

    auth  

  end # login

end
