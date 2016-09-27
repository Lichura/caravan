module StatisticsHelper
  def historico_por_precio
    bar_chart @producto_historicos.group(:precio).count, height: '500px', library: {
      title: {text: 'Productos por precio', x: -20},
      yAxis: {
         allowDecimals: false,
         title: {
             text: 'Precios count'
         }
      },
      xAxis: {
         title: {
             text: 'Precio'
         }
      }
    }
  end


  def historico_por_anio
  line_chart @producto_historicos.group(:precio).count, library: {
      title: {text: 'Precios por anio', x: -20},
      yAxis: {
          crosshair: true,
          title: {
              text: 'Precio'
          }
      },
      xAxis: {
          crosshair: true,
          title: {
              text: 'Anio'
          }
      }
  }


  def results_by_country
  result = ProductoHistorico.all.map do |c|
    places = {}
    (1..6).each do |place|
      places[place] = c.producto_historicos.joins(:producto_id).
          where("competition_results.place = #{place}").count
    end
    {
        name: c.name,
        data: places
    }
  end
  render json: result
end
end
end