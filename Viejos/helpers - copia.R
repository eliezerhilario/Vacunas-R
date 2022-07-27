source('dependencies.R')

# Importar datos ==========================================
if (!exists('Datos')) {
  # Datos <- vroom::vroom('Datos.zip', show_col_types = FALSE) Revisar como importar fechas con este método
  Datos <- read_excel('data/Datos.xlsx', 
                      col_types = c('numeric', 'text', 'date', 'text', 'text', 'text', 'text', 'text', 'numeric')) %>%  
    mutate(AÑO = strftime(`FECHA APERTURA`,'%Y'), MES = strftime(`FECHA APERTURA`,'%m'),
           PERIODO1 = paste0(AÑO, '-', MES),
           PERIODO = floor_date(`FECHA APERTURA`, 'month')
    )
}

Indicadores = choices = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')

# Datos Inputs ==========================================
# Coberturas = Datos %>% distinct(`COD COBERTURA`, COBERTURA)

# Indicadores = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')


# Funciones ==========================================


## Datos Graficos ---------------------------------------- 
DataGraficos = function(x, y = NULL) {
  Datos %>% group_by({{x}}, {{y}}) %>%
    summarise(MONTO = sum(`MONTO AUTORIZADO`),
              AUTORIZACIONES = n_distinct(INTEGRALIDAD),
              `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
              USUARIOS = n_distinct(CDPERSON),
              `MM USUARIO` = MONTO / USUARIOS, 
              .groups = "drop"
    )
}

## Datos Graficos con filtro ---------------------------------------- 
DataGraficosConFiltro = function(x, y = NULL, filter = NULL, value_filter = NULL) {
  Datos %>% filter({{filter}} == value_filter) %>% 
    group_by({{x}}, {{y}}) %>%
    summarise(MONTO = sum(`MONTO AUTORIZADO`),
              AUTORIZACIONES = n_distinct(INTEGRALIDAD),
              `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
              USUARIOS = n_distinct(CDPERSON),
              `MM USUARIO` = MONTO / USUARIOS
    )
}


# Modelos ==========================================
## Modelo Gráfico General ---------------------------------------- 
ModeloGrafico = function(data, x, y, group = NULL, color = NULL) {
  ggplot(data, aes(x = .data[[x]], y = .data[[y]], group, color)) +
    geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) + 
    scale_y_continuous(labels = comma) + theme_minimal()
}

require(scales) 
# Para que la función scale_y_continuous de los gráficos funcione