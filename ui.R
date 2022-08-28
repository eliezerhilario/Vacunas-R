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
        
        # GRAFICO DE PRUEBA
        # Prueba %>% group_by(`TIPO RECLAMANTE`) %>%
        #   e_charts(PERIODO) %>%
        #   e_line(serie = MONTO, symbol = 'circle', symbolSize = 10) %>%
        #   e_tooltip() %>% #e_tooltip(trigger = 'axis') %>%
        #   e_grid(right = '30%', left = '80') %>%
        #   e_legend(orient = 'vertical', right = '15', top = '15%',
        #            selector = list(
        #              list(type = 'inverse', title = 'Invertir'),
        #              list(type = 'all', title = 'Todos')
        #            )) %>%
        #   e_title(text = "Monthly Median Single-Family Home Prices", subtext = "Source: Zillow.com",
        #           sublink = "https://www.zillow.com/research/data/", left = "center"),

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
        plotOutput('tipo_pss'),
        tablaUI('tipo_pss', 'TIPO RECLAMANTE')
      ),
      
      ### Tab Reclamante ----------------------------------------
      tabItem(tabName = 'reclamante',
        fluidRow(
          medidaUI('reclamante'),
          filtroUI('tipo_pss_pss', 'TIPO RECLAMANTE'),
          filtroUI('pss', 'RECLAMANTE')
        ),
        plotOutput('reclamante'),
        tablaUI('reclamante', 'RECLAMANTE')
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
        fluidRow(medidaUI('pss_cob'), filtroUI('pss_cob', 'COBERTURA')),
        plotOutput('pss_cob'),
        tablaUI('pss_cob', 'COBERTURA')
      )
    )
  )
)