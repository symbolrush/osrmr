#' for information on OSRM see:
#' https://github.com/Project-OSRM/osrm-backend/wiki/running-osrm

# OSRM prepare (Creating the Hierarchy, creating the graph, nodeset etc..)
OSRM.prepare <- function(){
        wd <- getwd()
        setwd('OSRM')
        shell('osrm-prepare switzerland-exact.osrm', wait=FALSE)
        setwd(wd)
}

# OSRM starten mit der Karte "switzerland-exact.osrm"
OSRM.run <- function(){
        wd <- getwd()
        setwd('OSRM')
        errorcode <- shell('osrm-routed switzerland-exact.osrm', wait=FALSE)
        Sys.sleep(3) # OSRM braucht Zeit
        setwd(wd)
        return(errorcode)
}


# Routenberechnung mit OSRM
OSRM.berechneRoute <- function(lat_start,lng_start,lat_end, lng_end){
        library(rjson)
        route <- data.frame(distance = c(1), time = c(1))
        url <- paste ('http://localhost:5000/viaroute?loc=',lat_start,',', lng_start,'&loc=',lat_end,',',lng_end, sep = "", collapse = NULL)
        route_raw <- fromJSON(file = url)
        return(route_raw$route_summary$total_time)
}


#Testroutinen
#OSRM.prepare()
#OSRM.run()
#test <- OSRM.berechneRoute(47.3, 9.3, 47.5,9.3)
#test <- OSRM.berechneRoute(47.3, 9.3, 47.3,9.3)
#test <- OSRM.berechneRoute(47.43071,9.384005, 47.4641520, 9.3893949)

