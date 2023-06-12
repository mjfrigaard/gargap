#' Removes the null from a vector
#'
#' @export drop_nulls
#'
#' @examples
#' drop_nulls(list(1, NULL, 2))
drop_nulls <- function(x) {
  x[!sapply(x, is.null)]
}
