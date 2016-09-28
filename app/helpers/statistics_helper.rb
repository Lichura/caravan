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
  line_chart @producto_historicos.group(&:producto_id), library: {
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


def evolucion_precios
  line_chart evolucion_precios_path, library: {
      title: {text: 'Competitions by year', x: -20},
      yAxis: {
          crosshair: true,
          title: {
              text: 'Competitions count'
          }
      },
      xAxis: {
          crosshair: true,
          title: {
              text: 'Year'
          }
      }
  }
end

end

end