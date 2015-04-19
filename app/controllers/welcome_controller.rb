class WelcomeController < ApplicationController
  include WelcomeHelper
  require 'xmlrpc/client'

  TEST_COORDINATE = [40.453787, -3.678227]
  AUTHENTICATION = {
      email: "a@b.c",
      user_code: "a0066bbcbe25d7029a0e6934e1aa",
      app_code: "49456203c8e64d3690ed0e0dccf151e4e693"
  }
  def index
    @zones = get_all_barrios
    @valoraciones = get_all_repvalues
    @current_zone = get_current_zone
    @current_zone.deep_symbolize_keys!
    @current_zone = @current_zone[:params][:zones][0]

  end

  def add_repvalue
    data = {
        texto: params[:texto],
        foto: params[:foto],
        etiquetas: params[:etiquetas],
        valor: params[:valor]
    }

    p = {
        authentication: AUTHENTICATION,
        name: "new_reputation_" + (0..10).map { ('a'..'z').to_a[rand(26)] }.join,
        is_object: true,
        zone_class: "repvalue",
        shape:{
            shape_class: "circular",
            coordinate: TEST_COORDINATE,
            radius: 1
        },
        data_info:{
            data: data.to_json
        }

    }
    queryCtOS("ctos.createZone", p)



    parent_zone = get_current_zone
    parent_zone.deep_symbolize_keys!
    update_barriovalue(parent_zone[:params][:zones][0], data[:valor].to_f)


    redirect_to root_path
  end

  def update_barriovalue(barrio, valor)
    barrio_data = eval(barrio[:data_info][:data])
    if barrio_data[:value]
      old_value = barrio_data[:value].to_f
      old_values_count = barrio_data[:count].to_f
      new_values_count = old_values_count+1
      new_value = ((old_value * old_values_count) + valor)/(new_values_count)
      data = {
          value: new_value,
          count: new_values_count
      }
    else
      data = {
          value: valor,
          count: 1
      }
    end

    p = {
        authentication: AUTHENTICATION,
        name: barrio[:name],
        data_info:{
            data: data
        }

    }
    queryCtOS("ctos.updateZone", p)
  end


  def get_current_zone
    p = {
        authentication: AUTHENTICATION,
        parameters:{
          zone_class: "barrio",
          name: "Barrio Hispanoamerica"
        }
    }
    queryCtOS("ctos.getZones", p)
  end

  def get_current_repvalues
    p = {
        authentication:AUTHENTICATION,
        zone_class: "repvalue",
        coordinates:
            [TEST_COORDINATE]
    }
    queryCtOS("ctos.coordinatesContainerZones", p)
  end

  def get_all_zones
    p = {
        authentication: AUTHENTICATION
    }
    queryCtOS("ctos.getAllZones", p)
  end

  def get_all_barrios
    p = {
        authentication: AUTHENTICATION,
        parameters:{
            is_object: false,
            zone_class: "barrio"
        }
    }
    queryCtOS("ctos.getZones", p)
  end

  def get_all_repvalues

    p = {
        authentication: AUTHENTICATION,
        parameters:{
            is_object: true,
            zone_class: "repvalue"
        }
    }
    queryCtOS("ctos.getZones", p)

  end

end
