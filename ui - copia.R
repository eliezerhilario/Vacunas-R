source('helpers.R')
source('modules.R')

# UI ================================================
ui <- dashboardPage(
  title = 'Vacunas', skin = 'green',

  ## Header ----------------------------------------
  dashboardHeader(title = 'Vacunas'),

  ## Sidebar ----------------------------------------
  dashboardSidebar(
    sidebarMenu(id='sidebarID',
      menuItem('General', tabName = 'general', icon = shiny::icon('home')),
      menuItem('Tipo Cobertura', tabName = 'tipo_cobertura', icon = shiny::icon('home')),
      menuItem('Tipo PSS', tabName = 'tipo_pss', icon = shiny::icon('home')),
      menuItem('Centros Especializados', tabName = 'centros_especializados', icon = shiny::icon('home')),
      menuItem('Coberturas', tabName = 'coberturas', icon = shiny::icon('home')),
      menuItem('PSS por Cobertura', tabName = 'pss_cobertura', icon = shiny::icon('home'))
    )
  ),
  
  ## Body ----------------------------------------
  dashboardBody(
    # tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    
    tabItems(
      ### Tab General ----------------------------------------
      tabItem(tabName = 'general',
        modSelectIndicadoresUI('general'),
        modGraficoUI('general'),
        bodyUI('indicador_general', labelBox = 'INDICADORES GENERALES', widthBox = 6, grafContinuo = 1)
      ),
      
      ### Tab Tipo Cobertura ----------------------------------------
      tabItem(tabName = 'tipo_cobertura',
        fluidRow(column(4, selectInput('tipo_cobertura', 'INDICADOR', choices = Indicadores))),
        fluidRow(
          box(title = 'Tipo Coberturas', 
              plotOutput('tipo_cobertura'),
              status = 'success',  
              width = 12, 
              solidHeader = T)
        )
      ),
      
      ### Tab Tipo PSS ----------------------------------------
      tabItem(tabName = 'tipo_pss',
        fluidRow(column(4, selectInput('tipo_pss', 'INDICADOR', choices = Indicadores))),
        fluidRow(
          box(title = 'Tipo PSS', 
              plotOutput('tipo_pss'),
              status = 'success',  
              width = 12, 
              solidHeader = T)
        )
      ),
      
      ### Tab Centros Especializados ----------------------------------------
      tabItem(tabName = 'centros_especializados',
        fluidRow(column(4, selectInput('centros_espec', 'INDICADOR', choices = Indicadores))),
        fluidRow(
          box(title = 'Centros Especializados', 
              plotOutput('centros_espec'),
              status = 'success',  
              width = 12, 
              solidHeader = T)
        )
      ),
      
      ### Tab Coberturas ----------------------------------------
      tabItem(tabName = 'coberturas',
        fluidRow(column(4, selectInput('coberturas', 'INDICADOR', choices = Indicadores))),
        fluidRow(
          box(title = 'Coberturas', 
              plotOutput('coberturas'),
              status = 'success',
              width = 12, 
              solidHeader = T)
        )
      ),
      
      ### Tab PSS por Cobertura ----------------------------------------
      tabItem(tabName = 'pss_cobertura',  
        fluidRow(column(4, selectInput('pss_cobertura', 'INDICADOR', choices = Indicadores))),
        fluidRow(
          box(title = 'PSS por Cobertura', 
              plotOutput('pss_cobertura'),
              status = 'success',
              width = 12, 
              solidHeader = T)
        )
      )
    )
  )
)