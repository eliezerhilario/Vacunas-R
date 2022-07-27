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




