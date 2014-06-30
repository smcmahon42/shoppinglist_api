class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	
	before_filter :verfyToken

	def render_with_protection(object, parameters = {}) #add in for angular js JSON protection
		render parameters.merge(content_type: 'application/json', text: ")]}',\n" + object.to_json)
	end

	def verfyToken
		
		def sendError
			render :json => [], :status => 420
		end
		
		uriSegment = url_for(action: 'index', only_path: true)
		uriSegment.slice!(0)

		if request.method == 'GET' || (uriSegment == 'users' && request.method == 'POST')
			return true
		elsif !request.headers['X-XSRF-TOKEN'].blank?
			userAuth = User.where( :token => request.headers['X-XSRF-TOKEN'] ).limit(1)
			expireTime = userAuth[0].expire.to_i
			nowTime = Time.now.to_i
			if(nowTime - expireTime) > 86400 #24 hours from now
				sendError
			else
				return true 
			end
		else
			sendError
		end

	end #verfyToken

	private

	def genToken
		o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
		return string = (0...100).map { o[rand(o.length)] }.join
	end

end
