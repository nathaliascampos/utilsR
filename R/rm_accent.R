#' @title rm.accent - REMOVE ACENTOS DE PALAVRAS
#' 
#' @description Função que tira todos os acentos e pontuações de um vetor de strings.
#' 
#' @param str - vetor de strings que terão seus acentos retirados.
#' @param patterns - vetor de strings com um ou mais elementos indicando quais acentos deverão ser retirados.
#'            Para indicar quais acentos deverão ser retirados, um vetor com os símbolos deverão ser passados.
#'            Exemplo: pattern = c("´", "^") retirará os acentos agudos e circunflexos apenas.
#'            Outras palavras aceitas: "all" (retira todos os acentos, que são "´", "`", "^", "~", "¨", "ç")
#' 
rm_accent <- function(str, pattern = "all") {
    
    if(!is.character(str))
        str <- as.character(str)
    
    pattern <- unique(pattern)
    
    if(any(pattern=="Ç"))
        pattern[pattern=="Ç"] <- "ç"
    
    symbols <- c(
        acute = "áéíóúÁÉÍÓÚýÝ",
        grave = "àèìòùÀÈÌÒÙ",
        circunflex = "âêîôûÂÊÎÔÛ",
        tilde = "ãõÃÕñÑ",
        umlaut = "äëïöüÄËÏÖÜÿ",
        cedil = "çÇ"
    )
    
    nudeSymbols <- c(
        acute = "aeiouAEIOUyY",
        grave = "aeiouAEIOU",
        circunflex = "aeiouAEIOU",
        tilde = "aoAOnN",
        umlaut = "aeiouAEIOUy",
        cedil = "cC"
    )
    
    accentTypes <- c("´","`","^","~","¨","ç")
    
    if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
        return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))
    
    for(i in which(accentTypes%in%pattern))
        str <- chartr(symbols[i],nudeSymbols[i], str)
    
    return(str)
}
