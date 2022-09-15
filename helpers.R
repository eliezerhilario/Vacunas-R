# Filtro datos ========================================
filtroDatos = function(datos, filtro, campo) {
  if ({{filtro}} == 'TODAS') datos else
    datos %>% filter(.data[[campo]] %in% {{filtro}})
}


# Consolidar los datos ========================================
consolidado = function(datos, x, y = NULL) {
  if (is.null(y)) {
    datos = datos %>% group_by(.data[[x]])
  } else {
    datos = datos %>% group_by(.data[[x]], .data[[y]])
  }
  datos %>% summarise(MONTO = round(sum(`MONTO AUTORIZADO`)),
                      AUTORIZACIONES = n_distinct(INTEGRALIDAD),
                      `MM AUTORIZACION` = round(MONTO / AUTORIZACIONES),
                      USUARIOS = n_distinct(CDPERSON),
                      `MM USUARIO` = round(MONTO / USUARIOS),
                      .groups = "drop") %>% 
    arrange(x)
}


# # Datos de prueba ========================================
# Prueba = Datos %>% group_by(`TIPO RECLAMANTE`, PERIODO) %>%
#     summarise(MONTO = sum(`MONTO AUTORIZADO`),
#               AUTORIZACIONES = n_distinct(INTEGRALIDAD),
#               `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
#               USUARIOS = n_distinct(CDPERSON),
#               `MM USUARIO` = MONTO / USUARIOS,
#               .groups = "drop"
#     )