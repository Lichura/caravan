module StatisticsHelper


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