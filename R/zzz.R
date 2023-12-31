## Parse the xml file containing the defaults for the respective FlowJo tags
## Internal environment to store the parsed defaults

.fuEnv <-  new.env(parent=emptyenv())
.onLoad <- function(...)
{	
    
     mdef <- xmlSApply(xmlTreeParse(system.file("defaults.xml",
                                              package="flowUtils"),
                                              addAttributeNamespaces=TRUE)[["doc"]][[1]][["macdefaults"]],
                     function(x)
                     if(!is(x, "XMLCommentNode")) as.list(xmlAttrs(x)))
    wdef <- xmlSApply(xmlTreeParse(system.file("defaults.xml",
                                              package="flowUtils"),
                                              addAttributeNamespaces=TRUE)[["doc"]][[1]][["windefaults"]],
                     function(x)
                     if(!is(x, "XMLCommentNode")) as.list(xmlAttrs(x)))
    mdef <- mdef[!sapply(mdef, is.null)]
    wdef <- wdef[!sapply(wdef, is.null)]
    assign("winDefaults", wdef, .fuEnv)
    assign("macDefaults", mdef, .fuEnv)
}



.onAttach <- function(libname, pkgname) {
    msg <- sprintf(
        "Package '%s' is deprecated and will be removed from Bioconductor
         version %s", pkgname, "3.17")
    .Deprecated(msg=paste(strwrap(msg, exdent=2), collapse="\n"))
}
