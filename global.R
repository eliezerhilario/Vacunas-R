# LIBRERÍAS ==========================================
library(shiny)
library(shinydashboard)
# library(echarts4r)
# library(shinydashboardPlus)
# library(shinyWidgets)
library(tidyverse)
library(lubridate)
library(reactlog)
reactlog_enable()
library(readxl)
require(scales) # Para que la función scale_y_continuous de los gráficos funcione

# IMPORTAR DATOS ==========================================
if (!exists('Datos')) {
  Datos <- read_excel('data/Datos.xlsx', 
                      col_types = c('text', 'text', 'date', 'text', 'text', 'text', 'text', 'text', 'numeric')) %>% 
    mutate(AÑO = strftime(`FECHA APERTURA`,'%Y'), MES = strftime(`FECHA APERTURA`,'%m'),
           PERIODO = paste0(AÑO, '-', MES),
           # PERIODO = floor_date(`FECHA APERTURA`, 'month')
  )

  # Datos1 <- vroom::vroom('data/Datos.csv', col_types = c('FECHA APERTURA' = 'D')) %>%
  # mutate(AÑO = strftime(`FECHA APERTURA`,'%Y'), MES = strftime(`FECHA APERTURA`,'%m'),
  #        PERIODO = paste0(AÑO, '-', MES),
  # PERIODO1 = floor_date(`FECHA APERTURA`, 'month')
  # )#Revisar como importar fechas con este método
}


# CARGAR MÓDULOS ==========================================
source('helpers.R')
source('modules/filtros.R')
source('modules/grafico.R')
source('modules/tabla.R')