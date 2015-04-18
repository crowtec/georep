class WelcomeController < ApplicationController

  require 'xmlrpc/client'

  def index
    @zones = get_all_zones
  end

  def get_current_zone
    # @zones = get_current_zone
  end

  def coordinates_container_zones

    server = XMLRPC::Client.new2("http://178.62.1.193/api")
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        },
        coordinates:
            [params[:coordinates]]
    }
    resp = server.call("ctos.coordinatesContainerZones", p)

    # puts params[:coordinates]
    # render html: CtosRubyClient.hola_unauthenticated
  end

  def get_all_zones
    server = XMLRPC::Client.new2("http://178.62.1.193/api")
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        }
    }
    resp = server.call("ctos.getAllZones", p)
  end

end
