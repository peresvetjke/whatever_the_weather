# We'll start by defining our API module and our base or root class that will inherit from Grape::API.
# We set up our API module, define our Base class (which inherits from Grape::API) 
# and mount some other stuff within that class. 
# Before we talk about what we're mounting, let's learn what the mount keyword does.

# The mount keyword tells your Rails app that another application 
# (usually a rack application and this case our Grape API) exists at that location. 
# Mounting a rack app here means that the functionality of that app/code base is now available inside our Rails application.

# This class mounts the base class that is specific to version one of our api.
module Api
  class Base < Grape::API
    mount Api::V1::Base
  end
end
