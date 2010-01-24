class Dynamapper

  # this is a test idea; i think it would be nice to have real time ongoing tracking of participants if they want
  # so here we let them submit their information to an ordinary database for use later
  # TODO clearly icecondor and the like are also good places to submit to
  def track
    lat = params[:lat]
    lng = params[:lng]
    username = params[:username]
    password = params[:password]
    @user = User.get_user(username) # User.first(:login => username)
    @status = "Examining user"
    if @user && lat != "0" && lng != "0"
      @status = "Encoded #{lat} and #{lng} for user #{@user}"
      point = Geo.new
      point.lat = lat
      point.lon = lng
      point.user = @user.id
      point.created_at = DateTime::now
      point.save
      return "Encoded #{lat} and #{lng} for user #{user}"
   end
   @results = []
   if @user
      @status = "Points for user"
      @results = Geo.all( :limit => 10, :order => [ :created_at.desc ] )
    else
      @status = "User not found #{@user}"
    end
    render
  end

  # i'm thinking of rolling tracking features into citybot to amalgamate various projects
  # and here we exercise it
  # this is mostly for internal testing
  def trackview
    username = params[:username]
    password = params[:password]
    @user = User.get_user(username) # User.first(:login => username)
    @results = []
    if @user
      points = Geo.all(:limit => 4999, :order => [ :created_at.desc ], :user => @user.id )
      points.each do |p|
        @results << [ p.lat, p.lon ]
      end
    else
     @results = [
       [ 37.4419, -122.1419],
       [ 47.4519, -102.1519],
       [ 57.4619, -132.1819]
     ]
   end
   @map.feature_line(@results)
   render
  end

end

