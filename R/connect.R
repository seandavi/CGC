#' Get the SevenBridges access token
sb_token = function() {
    return(Sys.getenv("SB_TOKEN"))
}

#' Perform an API GET request from SevenBridged CGC api
#'
#' @param path path for the API call
#' @param token the auth token for the API. See \link{sb_token} for details.
#' @param ... passed to the httr GET
#'
#' @importFrom httr GET
#' 
#' @export
sb_GET = function(path, ..., token = sb_token()) {
    req = GET("https://cgc-api.sbgenomics.com",
              path = paste('v2',path,sep="/"),
              add_headers("X-SBG-Auth-Token" = token),...)
    print(req)
    return(req)
}

#' Parse requests from SevenBridges API
#'
#' @importFrom jsonlite fromJSON
sb_parse = function(req) {
    return(fromJSON(content(req,type='text')))
}

##############################################################
###
###
###                  PROJECTS
###
###
##############################################################

#' Get a list of projects
#'
#' @export
sb_project_list = function() {
    path = "projects"
    res = sb_parse(sb_GET(path))
    return(res)
}

#' Get project details
#'
#' @param owner the SevenBridges owner name
#' @param project the name of the SevenBridges project
#'
#' @export
sb_project_details = function(owner,project) {
    return(sb_parse(sb_GET(paste("projects",owner,project,sep="/"))))
}

##############################################################
###
###
###                      FILES
###
###
##############################################################

#' Get a list of files associate with a project
#'
#' @param owner The project owner
#' @param project The project id
#' 
#' @export
sb_file_list = function(owner,project) {
    return(sb_parse(sb_GET(paste0("files?project=",paste(owner,project,sep="/")))))
}

#' Get file details
#'
#' @param f The file
#' 
#' @export
sb_file_details = function(f) {
    return(sb_parse(sb_GET(paste("files",f,sep="/"))))
}    
