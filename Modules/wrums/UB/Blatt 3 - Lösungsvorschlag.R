#####################################
#        WRUMS WS 2018/2019         #
#  Loesungsvorschlag fuer Blatt 3   #
#####################################

## Aufgabe 7:

# ggf. vorher install.packages("DAAG")

# Laden der Daten
library(DAAG)
data("hurricNamed")

## Simpson-Funktion vom zweiten Blatt:
simpson <- function(x) {
  D <- 1 - sum( (x/sum(x))^2 )
  n <- length(x)
  Dz <- D * (n/(n-1))
  return(list("Simpsons D" = D, "Simpsons D stand." = Dz))
}

## Leti-Funktion vom zweiten Blatt:
leti <- function(x) {
  n <- length(x)
  DL <- sum(cumsum(x[1:(n-1)])/sum(x) * (1 - cumsum(x[1:(n-1)])/sum(x)))
  DLz <- DL * 4 / (n-1)
  return(list("Letis D"= DL, "Letis D stand." = DLz))
}

## Neue Funktion fuer die Entropie:
entropie <- function(x) { 
  f <- x/sum(x)
  H <- - sum(f*log2(f))
  return(H)
}
# Die Funktion erwartet genau wie simpson() und leti() den Vektor der absoluten
# Haeufigkeiten.
## a)
A <- table(hurricNamed$mf)
entropie(A) # 0.9034536
simpson(A) #  0.8691716

# Beide Werte sprechen fuer eine starke Streuung auf die Geschlechter.

## b)
B <- table(hurricNamed$LF.times)
leti(B) # 0.2111815

# Leti's D spricht fuer eine sehr kleine Streuung. Sehr offensichtlich, da
# 84 von 94 Werten Kategorie 1 sind.

## c)
X <- hurricNamed$BaseDam2014

# Simpson's D, Leti's D und Entropie nicht moeglich, da Daten nicht klassiert
# sind.

# Spannweite:
max(X) - min(X) # 98194.35
# Quartilsdifferenz:
Q0.75 <- quantile(X, type=2, p=0.75)
Q0.25 <- quantile(X, type=2, p=0.25)  
Q0.75 - Q0.25 # 3263.556
# Quartilskoeffizient:
(Q0.75-Q0.25)/((Q0.25+Q0.75)/2)  # 1.893527
# Dass hier noch 75% als Ueberschrift steht, ist ein Relikt aus der vorherigen
# Tabelle. ein as.numeric( ) loest das Problem.
# MAD:
median(abs(X - median(X, type=2)), type=2) # 870.5307
# MD:
mean(abs(X - median(X, type=2))) # 4655.723
# Varianz:
s2 <- ( 1 /(length(X)-1) ) * sum( (X-mean(X))^2 ) # 159,397,330
# Standardabweichung:
sqrt(s2) # 12625.27
# Variationskoeffizient:
sqrt(s2) / mean(X) # 2.613823

# Die nicht standardisierten Streuungsmasse, wie z.B. die Varianz geben enorm
# grosse Werte an - dies ist aber zum Teil der Lage der Daten geschuldet. Besser 
# lesen laesst sich hier zB. der Variationskoeffizient, der auf die Lage der Daten
# normiert ist. Dieser ist mit 2.61 auch enorm gross. Die Streuung wird oft als 
# % interpretiert. D.h. hier: Die Daten streuen 261% des Mittelwerts um eben
# diesen. Die robusten Masse (z.B. MAD) gibt kleinere Werte aus - einzelne Ausreisser
# verzerren ihn nicht. In einem einfachen
plot(X) # oder
hist(X)
# ist leicht zu sehen, dass es einige sehr starke Ausreisser gibt.

## Zu Aufgabe 9:

M <- matrix(c(270,200,230,60,60,90,260,190,170,70,80,170),nrow=2, byrow=T)
dimnames(M)[[1]] <- c("Frauen", "Maenner")
dimnames(M)[[2]] <- c("CDU","SPD","Gruene","Linke","FDP","AfD")
M
# fuer die Summen:
rowSums(M)
colSums(M)
# fuer die relativen Werte:
Ms <- M/sum(M)
rowSums(Ms)
colSums(Ms)
# Bedingt auf das Geschlecht:
Ms[1,]/sum(Ms[1,])
Ms[2,]/sum(Ms[2,])
# Bedingt auf die Parteien:
Ms[1,]/colSums(Ms)
Ms[2,]/colSums(Ms)
