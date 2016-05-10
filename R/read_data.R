##' Read data from a Shimmer device.
##'
##' This function reads data from a Shimmer device (in the CSV format).
##'
##' @param filename The filename with the Shimmer data.
##'  
##' @return The data as a recording structure (list).
##'  
##' @export 
read.shimmer <- function(filename) {
    con <- file(filename)
    open(con)

    ## Get item separator
    shimmer_sep <- substring(readLines(con, n = 1), 6, 6)

    ## Get the header line
    shimmer_header  <- strsplit(readLines(con, n = 1), split = shimmer_sep)[[1]]
    shimmer_unit_name <- strsplit(shimmer_header[1], "_")[[1]][1]
    shimmer_unit_id <- strsplit(shimmer_header[1], "_")[[1]][2]

    shimmer_header <- gsub(shimmer_unit_name, "", shimmer_header)
    shimmer_header <- gsub(shimmer_unit_id, "", shimmer_header)
    shimmer_header <- gsub("^__", "", shimmer_header)

    shimmer_header <- gsub("_CAL", "", shimmer_header)
    shimmer_header <- gsub("_LN", "", shimmer_header)

    shimmer_units        <- strsplit(readLines(con, n = 1), split = shimmer_sep)[[1]]
    names(shimmer_units) <- shimmer_header
    close(con)

    ## Get the channel data
    data <- read.csv(file = filename, sep = shimmer_sep, skip = 3)
    colnames(data) <- shimmer_header
    data[,which(is.na(names(data)))] <- NULL

    ## Prepare a new recording
    recording <- new_recording()

    ## Add the channel data to the recording
    tvec <- (data[[shimmer_header[[1]]]] - data[[shimmer_header[[1]]]][1]) / 1000
    fs  <- 1000 / (data[[shimmer_header[[1]]]][2] - data[[shimmer_header[[1]]]][1])
    recording$signal <- lapply(shimmer_header[-1], function(i) list("data" = data[[i]], t = tvec, samplingrate = fs, unit = shimmer_units[[i]]))
    names(recording$signal) <- shimmer_header[-1]

    ## Add header
    recording$properties$time.start.raw <- data[[shimmer_header[[1]]]][1]
    recording$properties$time.start     <- as.POSIXct(data[[shimmer_header[[1]]]][1] / 1000, origin="1970-01-01", tz = "UTC")
    recording$properties$time.stop.raw  <- rev(tvec)[1]
    recording$properties$time.stop      <- as.POSIXct(rev(data[[shimmer_header[[1]]]])[1] / 1000, origin="1970-01-01", tz = "UTC")
    recording$properties$zerotime       <- recording$properties$time.start
    recording$properties$subject        <- NA
    recording$properties$format         <- "shimmer"
    recording$properties$format.long    <- "shimmer"
    recording$properties$device.type    <- shimmer_unit_name
    recording$properties$device.serial  <- shimmer_unit_id
    recording$properties$device.version <- NA
    recording$properties$length         <- rev(tvec)[1] / 1000
    
    recording
}
