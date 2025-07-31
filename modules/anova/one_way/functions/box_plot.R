

box_plot <- function(.data, .n_col, x = 'Treatments', y = 'Variable', .order = FALSE, .order_by, title_name) {

  names(.data)[1] <- x
  names(.data)[.n_col] <- y
  vars <- c(x, y)

  if (.order) {
    .data <- select(all_of(vars)) %>%
      mutate(x = fct_reorder(x, y, .fun = .order_by, .na_rm = TRUE, .desc = .order))
  }

  .data <- .data %>% select(all_of(vars))

  gg <- ggplot(.data, aes(x = .data[[x]], y = .data[[y]])) +
    geom_boxplot(aes(color = .data[[x]]), na.rm = T) +
    ggtitle(title_name) +
    labs(x = "", y = y)

  gg <- gg %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1))

  return(gg)
}


x <- read_xlsx('www/database_example/experimentacion.xlsx')

box_plot(.data = x, x = "Hola", y = 'adios', .n_col = 2, .order_by = 'mean', title_name = "")


x %>%
  select(c(1, 2)) %>%
  # mutate(TRATAMIENTO = fct_reorder(TRATAMIENTO, `PESO(g)_HOJAS_FRESCAS`, .fun = 'mean', .na_rm = TRUE, .desc = TRUE)) %>%
  ggplot(aes(TRATAMIENTO, `PESO(g)_HOJAS_FRESCAS`)) +
  geom_boxplot()






grafica <- function(d, n_col, nombre, eje_y){

  g <- ggplot(d, aes(d %>% .[[1]], d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)

  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_as_mean <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], d %>% .[[n_col]], FUN = mean), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_des_mean <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], desc(d %>% .[[n_col]]), FUN = mean), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_as_median <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], d %>% .[[n_col]], FUN = median), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_des_median <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], desc(d %>% .[[n_col]]), FUN = median), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_as_sd <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], d %>% .[[n_col]], FUN = function(x){sd(x)}), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}

g_des_sd <- function(d, n_col, nombre, eje_y){
  g <- ggplot(d, aes(reorder(d %>% .[[1]], desc(d %>% .[[n_col]]), FUN = function(x){sd(x)}), d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]), na.rm = T) +
    ggtitle(nombre) +
    labs(x = "", y = eje_y)
  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h', y = -0.1, title = list(text = '<b> treatments </b>')))
}
