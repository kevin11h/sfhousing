source("key.r")

geocode_url <- function(address) {
  geo <- "http://maps.google.com/maps/geo?"
  
  params <- c(
    key = key,
    q = address,
    output = "csv"
  )
  
  p <- paste(names(params), "=", laply(params,URLencode), sep="", collapse ="&")
  paste(geo, p, sep="")
}

geocode <- function(addresses) {
  paths <- laply(addresses, geocode_url)
  
  read <- function(path) {
    suppressWarnings(read.csv(url(path), header = FALSE))
  }
  ldply(paths, read, .progress = "text")
}

addy <- function(row) {
  paste(row$street, ", ", row$city, " ", row$zip, sep="")
}