library(RODBC)
# create env for storing the variables/data frames between the functions
assign("getREnvironment", new.env(), envir = .GlobalEnv)

# Function to read data from SQL Server
getSQLServerData <- function() {
    #extract environment settings for storing data
    getREnvironment <- get("getREnvironment", envir = .GlobalEnv, mode = "environment")
    #To get SQL Server data
    con <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-HNF5H2Q\\SQLEXPRESS;database=SupplyChain;trusted_connection=true')
    db_df <- sqlQuery(con, 'select top(10) dimOrders.OrderID,dimOrders.ShipVia
from dimOrders')
    print(db_df)
    plot(db_df)
    close(con)
    #overwrite existing data with new data
    df_overwrite <- db_df
    getREnvironment$db_df <- data.frame(df_overwrite)
    try(assign("getREnvironment", getREnvironment, envir = .GlobalEnv))
    invisible() #do not print the results
}

# Plot graph 
n = 1000 #not iterations
windowQuery = 20 # syncronised with TOP clause in SELECT statement
for (i in 1:(n - windowQuery)) {
    flush.console()
    getSQLServerData()
    getREnvironment <- get("getREnvironment", envir = .GlobalEnv, mode = "environment")
    data <- getREnvironment$db_df
    plot(data$OrderID, data$ShipVia, type = 'h', main = 'Realtime data')
    Sys.sleep(0.5)
}
