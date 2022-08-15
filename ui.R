ui <- dashboardPage(
  title = 'Vacunas', skin = 'green',

  ## Header ----------------------------------------
  dashboardHeader(title = 'Vacunas'),

  ## Sidebar ----------------------------------------
  dashboardSidebar(
    sidebarMenu(id='sidebarID',
      menuItem('General', tabName = 'general', icon = shiny::icon('home')),
      menuItem('Tipo Cobertura', tabName = 'tipo_cob', icon = shiny::icon('home')),
      menuItem('Tipo PSS', tabName = 'tipo_pss', icon = shiny::icon('home')),
      menuItem('Centros Especializados', tabName = 'centros_esp', icon = shiny::icon('home')),
      menuItem('Coberturas', tabName = 'coberturas', icon = shiny::icon('home')),
      menuItem('PSS por Cobertura', tabName = 'pss_cob', icon = shiny::icon('home'))
    )
  ),
  
  ## Body ----------------------------------------
  dashboardBody(
    # tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    
    tabItems(
      ### Tab General ----------------------------------------
      tabItem(tabName = 'general',
        box(title = NULL, status = 'success', solidHeader = T, #width = 12, 
            medidaUI('general')),
        tablaUI('general', 'DATOS GENERALES'),
        graficoUI('general', 'DATOS GENERALES'),
      ),
      
      ### Tab Tipo Cobertura ----------------------------------------
      tabItem(tabName = 'tipo_cob',
        fluidRow(
          medidaUI('tipo_cob'),
          filtroUI('tipo_cob', 'TIPO COBERTURA'),
        ),
        tablaUI('tipo_cob', 'TIPO COBERTURA'),
        graficoUI('tipo_cob', 'TIPO COBERTURA')
      ),
      
      ### Tab Tipo PSS ----------------------------------------
      tabItem(tabName = 'tipo_pss',
        medidaUI('tipo_pss'),
        filtroUI('tipo_pss', 'TIPO RECLAMANTE'),
        tablaUI('tipo_pss', 'TIPO RECLAMANTE'),
        plotOutput('tipo_pss')
      ),
      
      ### Tab Centros Especializados ----------------------------------------
      tabItem(tabName = 'centros_esp',
        medidaUI('centros_esp'),
        filtroUI('pss', 'RECLAMANTE'),
        tablaUI('centros_esp', 'CENTRO ESPECIALIZADO, RECLAMANTE'),
        plotOutput('centros_espec')
      ),
      
      ### Tab Coberturas ----------------------------------------
      tabItem(tabName = 'coberturas',
        medidaUI('coberturas'),
        
        fluidRow(
          box(title = 'Coberturas', 
              plotOutput('coberturas'),
              status = 'success',
              width = 12, 
              solidHeader = T)
        )
      ),
      
      ### Tab PSS por Cobertura ----------------------------------------
      tabItem(tabName = 'pss_cob', 
        medidaUI('pss_cob'),
              
        fluidRow(
          box(title = 'PSS por Cobertura', 
              plotOutput('pss_cob'),
              status = 'success',
              width = 12, 
              solidHeader = T)
        )
      )
    )
  )
)