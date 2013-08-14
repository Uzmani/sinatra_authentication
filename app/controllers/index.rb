enable :sessions

get '/' do
  # render home page
 #TODO: Show all users if user is signed in
 
 @user_array = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
  flash[:error] = "the is an error"
  p flash

  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    puts "logged in"
   
  else
    flash[:error] = 'Invalid Login. Please try to sign in again'
    
  end
  redirect to '/'
end

delete '/logout' do
  session.inspect
  session.clear
  redirect to '/sessions/new'
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  @user = User.new(params[:user])
  if @user.save
     flash[:notice] = 'You signed up!  Now log in!'
    erb :sign_up
  else
    redirect :back, flash[:error] = "Invalid sign up"
   
  end
  
end
