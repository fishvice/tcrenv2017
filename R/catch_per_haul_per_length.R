catch_per_haul_per_length <- function(le) {

  le %>%
    group_by(latin, id, length) %>%
    summarise(n = sum(n)) %>%
    mutate(b = n * (0.01 * length^3)/1000) %>%
    ungroup()

}