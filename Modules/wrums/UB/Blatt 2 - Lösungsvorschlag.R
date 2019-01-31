#####################################
#        WRUMS WS 2018/2019         #
#   Loesungsvorschlag für Blatt 2    #
#####################################

## Aufgabe 4

# Laden
data(airquality)
# bereinigen
aq.b <- na.omit(airquality)

# a)
# Ozone (quantitativ)
# Arithmetisches Mittel
mean(aq.b$Ozone) # 42.0991

# Median
median(aq.b$Ozone, type=2) # 31
# type=2 für die Definition der Vorlesung. Andere Definitionen koennen leicht
# abweichen.

## Mittel 42 und Median 31 spricht fuer eine asymmetrische Verteilung
## (in diesem Fall rechtsschief)

# Modalwert
m <- which.max(table(aq.b$Ozone))
names(m)
# 23
# Alternativ, um auch selbstgeschriebene Funktionen zu demonstrieren:
berechne.modus <- function(x){
  anzahl <- max(table(x))
  modus <- names(which.max(table(x)))
  list(Modus=modus, Anzahl=anzahl)
}
berechne.modus(aq.b$Ozone)

# Solar.R (quantitativ)
mean(aq.b$Solar.R) # 184.8018
median(aq.b$Solar.R, type=2) # 207
## Weniger starke Abweichung als bei Ozone, diesmal linksschief
berechne.modus(aq.b$Solar.R) # 238

# Wind (quantitativ)
mean(aq.b$Wind) # 9.93964
median(aq.b$Wind, type=2) # 9.7
## Fast identisch, also kein Hinweis auf Asymmetrie
berechne.modus(aq.b$Wind) # 10.3

# Temp (quantitativ)
mean(aq.b$Temp) # 77.79279
median(aq.b$Temp, type=2) # 79
## Fast identisch, also kein Hinweis auf Asymmetrie
berechne.modus(aq.b$Temp) # 81

## Variablen Day und Month sind nicht quantitativ. Qualitativ ordinal laesst
## sich diskutieren. Klare Ordnung ist gegeben. Wiederholung dieser Ordnung
## kann je nach Anwendungsfall problematisch sein. Hier betrachten wir sie, als
## waeren sie ordinal. Wichtig: Es handelt sich hier nicht um ein Datum!

# Month
berechne.modus(aq.b$Month) # 9 = September
table(aq.b$Month)
median(aq.b$Month, type=2) # 7 = Juli
# Day
berechne.modus(aq.b$Day) # 7   ## Modalwert nicht eindeutig.
table(aq.b$Day)                ## 7, 9, 13, 16, 17, 18, 19, 20
median(aq.b$Day, type=2) # 16

## b)
quantile(aq.b$Temp, type=2) # 71, 79, 85
quantile(aq.b$Wind, type=2) # 7.4, 9.7, 11.5

## c)
aq.b$TempC[aq.b$Temp < 60] <- "sehr kalt"
aq.b$TempC
aq.b$TempC[aq.b$Temp >=60 & aq.b$Temp < 70] <- "kalt"
aq.b$TempC
aq.b$TempC[aq.b$Temp >=70 & aq.b$Temp < 80] <- "mittel"
aq.b$TempC
aq.b$TempC[aq.b$Temp >=80 & aq.b$Temp < 90] <- "warm"
aq.b$TempC
aq.b$TempC[aq.b$Temp >=90] <- "sehr warm"
aq.b$TempC

## Rangwerte, Ansatz "per Hand"  kalt < warm
table(aq.b$TempC)
## 4 Werte "sehr kalt", also die Raenge 1-4 werden geteilt und zu 2.5
aq.b$Rank[aq.b$TempC == "sehr kalt"] <- 2.5

## 21 Werte "kalt", also die Raenge 5-25 geteilt
sum(5:25)/21 # 15
aq.b$Rank[aq.b$TempC == "kalt"] <- 15

## 32 Werte "mittel", also die Raenge 26-57 geteilt
sum(26:57)/32 # 41.5
aq.b$Rank[aq.b$TempC == "mittel"] <- 41.5

## 41 Werte "warm", also die Raenge 58-98 geteilt
sum(58:98)/41 # 78
aq.b$Rank[aq.b$TempC == "warm"] <- 78

## 13 Werte "sehr warm", also die Raenge 99-111
sum(99:111)/13 # 105
aq.b$Rank[aq.b$TempC == "sehr warm"] <- 105

aq.b$Rank

##### Alternativ eleganter
# definiere korrekte Reihenfolge der Klassen
classes <- c("sehr kalt", "kalt", "mittel", "warm", "sehr warm")
# Wandele Characters in Factors um unter Beruecksichtigung der Ordnung
aq.b$TempC <- factor(aq.b$TempC, classes)
rank(aq.b$TempC, ties.method = "average")


## d)
# aus b):
quantile(aq.b$Temp, type=2) # 71, 79, 85
# jetzt mit Rangwerten:
quantile(aq.b$Rank, type=2) # 41.5, 41.5, 78

## Zur Erinnerung: 41.5 war der Rang fuer "mittel". Das heisst sowohl das untere
## Quartil als auch der Median liegt in "mittel". 78 war der Rang fuer "warm",
## also liegt das obere Quartil in "warm". Dies entspricht exakt der direkten
## Einteilung fuer die Temp-Werte 71, 79 und 85. Quartile bleiben generell
## unveraendert, wenn Raenge gebildet werden. Es geht lediglich Information beim
## Klassifizieren verloren. Aus 71 und 79 wurde z.B. jeweils "mittel".

########################
##### Zu Aufgabe 6 #####
########################

## Input: Vektor x mit table-Werten. Fuer Aufgabe 6 also c(40,60,20)
simpson <- function(x) {
  D <- 1 - sum( (x/sum(x))^2 )
  n <- length(x)
  Dz <- D * (n/(n-1))
  return(list("Simpsons D" = D, "Simpsons D stand." = Dz))
}

## Input: Vektor mit table-Werten. Muessen sortiert sein.
leti <- function(x) {
  n <- length(x)
  DL <- sum(cumsum(x[1:(n-1)])/sum(x) * (1 - cumsum(x[1:(n-1)])/sum(x)))
  DLz <- DL * 4 / (n-1)
  return(list("Letis D"= DL, "Letis D stand." = DLz))
}

simpson(c(40,60,20))
simpson(c(20,40,60))
## Reihenfolge bei Simpson unerheblich, da Kennzahl fuer nominale Daten.

leti(c(20,60,40)) ## Aufg. 6
leti(c(60,40,20)) ## Abweichende Ergebnisse -> Reihenfolge wichtig.

## Betrachte Extremfaelle:
## Minimale Streuung nach Simpson: Alle Beobachtungen in einer Gruppe.
simpson(c(50,0,0)) #  Dz = 0
leti(c(50,0,0)) #    DLz = 0
## Maximale Streuung nach Simpson: Alle Beobachtungen gleichmaessig verteilt
simpson(c(50,50,50))# Dz = 1
leti(c(50,50,50)) #  DLz = 0.8888889

## Minimale Streuung nach Leti: Alle Beobachtungen im Median: Siehe oben.
simpson(c(50,0,0)) #  Dz = 0
leti(c(50,0,0)) #    DLz = 0

## Maximale Streuung nach Leti: Alle Beobachtungen gleichmaessig an beiden Raendern
simpson(c(50,0,50)) # Dz = 0.75
leti(c(50,0,50))  #  DLz = 1
