#####################################
#        WRUMS WS 2018/2019         #
#   Lösungsvorschlag für Blatt 1    #
#####################################

## Aufgabe 1:
# a)
# Patientennummer:      Ordinal, falls nummeriert. Nominal, falls verschlüsselt.
# Vorname:              Nominal
# Nachname:             Nominal
# Geschlecht:           Nominal (ggf. binär)
# Alter in Jahren:      Quantitativ diskret
# Blutgruppe:           Nominal
# Blutdruck:            Quantitativ stetig, obwohl meist diskret (ganzzahlig) 
#                       gemessen
# Herzfrequenz:         Quantitativ stetig, obwohl meist diskret (/min) gemessen
# Anz. Vorerkrankungen: Quantitativ diskret

# b)
# Datum des Spiels:       Sonderfall. Zuerst Nominal, Umwandlung in Quantitativ 
#                         möglich. Bspw. Umwandlung in Tage seit Neujahr
# Namen der Mannschaften: Nominal
# Tore der Mannschaften:  Quantitativ diskret
# Ex. Uhrzeit d Anstoßes: Sonderfall. Zuerst Nominal, Umwandlung in Quantitativ 
#                         möglich. Bspw. Umwandlung in Minuten oder Sekunden 
#                         seit Mittag.
# Tabellenplätze:         Ordinal
# Anzahl Zuschauer:       Quantitativ diskret


## Aufgabe 2:
data(airquality)
# a)
?airquality
# Ozone parts per billion
# Solar.R Solar radiation in Langleys in the frequency band 4000-7700 Angstroms
# Wind miles/hour
# Month: 1-12 für Jan-Dez.
# Day: 1-31

# b)
aq.bereinigt <- na.omit(airquality)

# c)
summary(aq.bereinigt$Temp) # min = 57, max = 97
# alternativ
min(aq.bereinigt$Temp)
max(aq.bereinigt$Temp)

hist(aq.bereinigt$Temp, breaks=c(55,70,75,85,90,100))
# zum Vergleich:
hist(aq.bereinigt$Temp, breaks=10)

remove(airquality, aq.bereinigt)

## Aufgabe 3:
ID <- 1:150
set.seed(1)
location <- sample(c(rep("A",70), rep("B",60), rep("C",20)))
result <- c()
result[location=="A"] <- rnorm(70, mean=10, sd=3)
result[location=="B"] <- rnorm(60, mean=12, sd=6)
result[location=="C"] <- rnorm(20, mean=9, sd=2)
dat <- data.frame(ID=ID, location=location, result=result)
remove(ID,location,result)

# a)
table(dat$location)
# A  B  C 
# 70 60 20
barplot(table(dat$location)/150,  ylab="Anteil an Patienten pro Ort", 
        xlab="Studienort")

# b)
welcheA <- dat$location=="A"
welcheB <- dat$location=="B"
welcheC <- dat$location=="C"

par(mfrow=c(3,1))
plot.ecdf(dat$result[welcheA], xlim=c(-5,30))
plot.ecdf(dat$result[welcheB], xlim=c(-5,30))
plot.ecdf(dat$result[welcheC], xlim=c(-5,30))
par(mfrow=c(1,1))

# c)
# A und C ähneln sich stark bezüglich Lage und Streuung. 
# B ist daher die Ausreißergruppe.
plot.ecdf(dat$result[welcheB], col="blue", pch=16)
plot.ecdf(dat$result[c(welcheA,welcheC)], add=T, col="red", pch=17)
legend(x="bottomright", legend=c("A & C", "B"), col=c("red", "blue"), 
       pch=c(17,16))
