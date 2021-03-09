# Java
#install.packages("rJava")
library(rJava)

.jinit()
.jcall("java/lang/System","S","getProperty","java.runtime.version")

setwd("C:/Repositories/r-course/code/Tema 13/java-files")

.jaddClassPath(getwd())
.jclassPath()

#### String de Java
s <- .jnew("java/lang/String", "Hola que lindo día")
print(s)
.jstrVal(s)
.jcall(s,"S","toLowerCase")
.jcall(s, "S", "toUpperCase")
.jcall(s,"S","replaceAll","día","giorno")

#Valores de retorno en Java
#I : int
#D : double
#J : long
#F : float
#V : void
#Z : boolean
#C : char
#B : byte
#L<class> : Objetos de la clase <class>
#S : String (java.lang.String)
#[<type>: arrays de objetos de tipo <type>, [S: array de Strings

#### Vectores de Java
v <- .jnew("java/util/Vector")
months <- month.abb
months
sapply(months,v$add) # v.add(months) 
v$size()
v$toString()

#### Calendario
monthArray <- .jarray(month.abb)
yearsArray <- .jarray(as.numeric(2011:2017))
calArray <- .jarray(list(monthArray,yearsArray))
print(calArray)
.jevalArray(calArray)
.jevalArray(monthArray)
print(l <- .jevalArray(calArray))
l
lapply(l,.jevalArray)

#### Clase Hello World
hw <- .jnew("HelloWorld")
hello <- .jcall(hw,"S","getString")
hello

greet <- .jnew("Greeting")
print(greet)

ms <- .jcall(greet,"S","getString", "Martin")
print(ms)
.jstrVal(ms)

# Parámetros de config de la JVM
jvm <- .jnew("java.lang.System")
jvm.props <- jvm$getProperties()$toString()
jvm.props
#jvm.props <- strsplit(gsub("\\{(.*)}","\\1", jvm.props), ", ")
#jvm.props[[1]]

#Lista de métodos disponibles
.jmethods(s)
.jmethods(s, "trim")
