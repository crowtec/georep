class WelcomeController < ApplicationController
  include WelcomeHelper
  require 'xmlrpc/client'

  def index
    @zones = get_all_zones
  end

  def add_repvalue
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        },
        name: "new_reputation_" + (0..10).map { ('a'..'z').to_a[rand(26)] }.join,
        is_object: true,
        zone_class: "repvalue",
        shape:{
            shape_class: "circular",
            coordinates:
                [params[:coordinates]]
        }
    }
    queryCtOS("ctos.createZone", p)
  end

  def get_location_barrio
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        },
        zone_class: "barrio",
        coordinates:
            [params[:coordinates]]
    }
    queryCtOS("ctos.coordinatesContainerZones", p)
  end

  def get_location_repvalues
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        },
        zone_class: "barrio",
        coordinates:
            [params[:coordinates]]
    }
    queryCtOS("ctos.coordinatesContainerZones", p)
  end

  def get_all_zones
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        }
    }
    queryCtOS("ctos.getAllZones", p)
  end

  def get_all_repvalues
    p = {
        authentication:{
            email: "a@b.c",
            user_code: "a0066bbcbe25d7029a0e6934e1aa",
            app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
        },
        parameters:{
            is_object: true,
            zone_class: "repvalue"
        }
    }
    queryCtOS("ctos.getAllZones", p)
  end

end
