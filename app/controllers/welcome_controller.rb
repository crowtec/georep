class WelcomeController < ApplicationController
  include WelcomeHelper
  require 'xmlrpc/client'

  def index
    @zones = get_all_zones
  end

  def add_repvalue
    data = {
        texto: params[:texto],
        foto: params[:foto],
        etiquetas: params[:etiquetas],
        valor: params[:valor]
    }
    coordinate = [40.452666, -3.678407]
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
            coordinate: coordinate,
            radius: 1
        },
        data_info:{
            data: data.to_json
        }

    }
    queryCtOS("ctos.createZone", p)
  end

  def get_current_zone
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

  def get_current_repvalues
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
