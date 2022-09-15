ui <- dashboardPage(
  title = 'Vacunas', skin = 'green',

  ## Header ----------------------------------------
  dashboardHeader(title = 'Vacunas'),

  ## Sidebar ----------------------------------------
  dashboardSidebar(
    sidebarMenu(id='sidebarID',
      menuItem('General', tabName = 'general', icon = shiny::icon('home')),
      menuItem('Tipo Cobertura', tabName = 'tipo_cob', icon = shiny::icon('home')),
      menuItem('Tipo Reclamante', tabName = 'tipo_pss', icon = shiny::icon('home')),
      menuItem('Reclamante', tabName = 'reclamante', icon = shiny::icon('home')),
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
        fluidRow(medidaUI('general')),
        graficoUI('general', 'DATOS GENERALES'),
        tablaUI('general', 'DATOS GENERALES')
      ),
      
      ### Tab Tipo Cobertura ----------------------------------------
      tabItem(tabName = 'tipo_cob',
        fluidRow(medidaUI('tipo_cob'), filtroUI('tipo_cob', 'TIPO COBERTURA')),
        graficoUI('tipo_cob', 'TIPO COBERTURA'),
        tablaUI('tipo_cob', 'TIPO COBERTURA')
      ),
      
      ### Tab Tipo Reclamante ----------------------------------------
      tabItem(tabName = 'tipo_pss',
        fluidRow(medidaUI('tipo_pss'), filtroUI('tipo_pss', 'TIPO RECLAMANTE')),
        graficoUI('tipo_pss', 'TIPO RECLAMANTE'),
        # tablaUI('tipo_pss', 'TIPO RECLAMANTE')
      ),
      
      ### Tab Reclamante ----------------------------------------
      tabItem(tabName = 'reclamante',
        fluidRow(
          medidaUI('reclamante'),
          filtroUI('tipo_pss_pss', 'TIPO RECLAMANTE'),
          filtroUI('pss', 'RECLAMANTE')
        ),
        graficoUI('reclamante', 'RECLAMANTE'),
        tablaUI('reclamante', 'RECLAMANTE')
      ),
      
      ### Tab Coberturas ----------------------------------------
      tabItem(tabName = 'coberturas',
        fluidRow(medidaUI('coberturas')),
        graficoUI('coberturas', 'COBERTURAS')
      ),
      
      ### Tab PSS por Cobertura ----------------------------------------
      tabItem(tabName = 'pss_cob', 
        fluidRow(medidaUI('pss_cob'), filtroUI('pss_cob', 'COBERTURA')),
        graficoUI('pss_cob', 'COBERTURAS POR PSS'),
        # tablaUI('pss_cob', 'COBERTURA')
      )
    )
  )
)