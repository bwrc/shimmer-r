#' Return and initialise an empty recording structure.
#' The recording structure is a list.
#'
#' @return An empty recording structure.
#' 
#' @export
new_recording <- function() {
    ## Create containers
    recording                   <- list()
    recording$properties        <- list()
    recording$signal            <- list()
    recording$events            <- list()
    recording$properties$header <- list()
    
    recording$properties$time.start.raw <- NA
    recording$properties$time.start     <- NA
    recording$properties$time.stop.raw  <- NA
    recording$properties$time.stop      <- NA

    ## Set subject and casename information
    recording$properties$subject        <- NA

    ## Information on the data format
    recording$properties$format         <- NA
    recording$properties$format.long    <- NA
    recording$properties$device.type    <- NA
    recording$properties$device.version <- NA

    ## The length of the recording in seconds
    recording$properties$length         <- NA

    recording
}

