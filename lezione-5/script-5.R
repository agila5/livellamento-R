###########################################################################
################# Livellamento al Software R - Lezione 5 ##################
###########################################################################

# 1. Le strutture di controllo --------------------------------------------

# Le strutture di controllo servono per modificare il flusso di esecuzione di
# uno script o una funzione. In base alla mia esperienza, le piu' comuni sono:

# - if/else (per testare una condizione);
# - for (per eseguire un ciclo di operazioni);

# Meno comuni:
# - while (per eseguire la stessa operazioni piu' volte fino a che un test
#   non viene valutato FALSE)
# - repeat (esegue un loop all'infinito);
# - break (interrompe un loop);
# - next (salta una iterazione di un loop).

# 1.1 if, if/else e ifelse ------------------------------------------------

# Una istruzione del tipo if o if/else puo' essere usata nel seguente modo:

# if (TEST) {
#   do - something
# }

# if (TEST) {
#   do - something
# } else {
#   do - something - else
# }

# if (TEST) {
#   do - something
# } else if (ANOTHER TEST) {
#   do - something - else
# } else {
#   do - something - else
# }

# Per esempio:
x <- runif(1)
y <- runif(1)
if (x < y) {
  print("x e' piu' piccolo di y!")
} else {
  print("x e' piu' grande di y!")
}

# ESERCIZIO: La congettura di Collatz afferma che, dato un qualsiasi numero
# naturale n, applicando il seguente algoritmo:
# a) se n e' pari lo divido per 2;
# b) se n e' dispari lo moltiplico per 3 ed aggiungo 1;
# allora la successione di elementi termina sempre raggiungendo il numero 1.

# Si implementi una funzione (e.g. my_collatz()) la quale, dato in input un
# numero naturale n (i.e. un integer positivo) di lunghezza 1, restituisce il
# successivo secondo l'algoritmo definito della congettura di Collatz. Ad
# esempio, my_collatz(4) deve restituire 2, my_collatz(5) deve restituire 16 e
# così via.

# Suggerimento: Controllate ?"Arithmetic" per capire quale operatore può essere
# usato per determinare se un numero n è pari a dispari.

# La struttura di controllo "if" puo' essere aggiunta ad una funzione f per
# testare una condizione ed, eventualmente, restituire un messaggio di errore.
# Ad esempio:
test_positive <- function(x) {
  if (any(x < 0)) {
    stop("Almeno un elemento di x e' negativo", call. = FALSE)
  }
  x
}
test_positive(-1:1)
test_positive(1:10)

# oppure
my_empty_collatz <- function(x) {
  if (length(x) > 1L) {
    stop("L'input x deve avere lunghezza 1", call. = FALSE)
  }
  is_integer <- abs(x - round(x)) < 1e-10
  if (x < 0 || !is_integer) {
    stop("L'input x deve essere necessariamente un intero positivo")
  }
  # do - something
  x
}
my_empty_collatz(c(1, 2))
my_empty_collatz(1.5)
my_empty_collatz(-2)

# Questo "pattern" è molto utile per verificare che i valori passati agli
# argomenti di una funzione rispettano un insieme di ipotesi riguardanti il loro
# campo di variazione.

# ESERCIZIO: Una variabile casuale X segue una distribuzione "triangolare"
# (https://en.wikipedia.org/wiki/Triangular_distribution) di parametri
# a <= b <= c se la sua funzione di densita' e' esprimibile nel seguente modo:
# f(x) =
# 0 se x < a;
# 2(x - a) / ((b - a)(c - a)) se a <= x < c
# 2 / (b - a)  se x = c
# 2(b - x) / ((b - a)(b - c)) se c < x <= b
# 0 se b < x

# Si implementi una funzione dtriangular(x, a, b, c) che permette di calcolare
# tale fdd dato un set di valori per a, b, e c scelto da voi. Si implementi
# anche un insieme di test per verificare la ragionevolezza dei valori passati
# ad a, b, e c.

# ESERCIZIO: Si rappresenti la funzione dtriangular(x, a = 1, b = 3, c = 2) per
# un opportuno range di x.

rm(list = ls())

# NB: Il TEST utilizzato per valutare una "if" clause deve necessariamente
# essere un vettore logico di lunghezza 1, pena un messaggio di warning o,
# addirittura, un errore (dipende dalla versione di R che state utilizzando):
if (c(TRUE, FALSE)) {
  print("AIUTO")
}

# La funzione ifelse può essere utilizzata per sostituire parti di un vettore
# secondo un test logico:
(x <- rnorm(10))
ifelse(x < 0, abs(x), x)

# Tuttavia, la funzione ifelse presenta alcune peculiarità (i.e. rimuove gli
# attributes da x). Di conseguenza, è preferibile usare un costrutto di questo
# tipo:
(x <- rnorm(10))
x[x < 0] <- abs(x[x < 0 ])

# 1.2 Cicli for -----------------------------------------------------------

# Un ciclo for puo' essere implementato utilizzando il seguente costrutto:

# for (id in sequenza-di-indici o vettore) {
#   corpo del ciclo
# }

# Ad esempio:
for (i in 1:10) {
  print(i ^ 2) # NB: In un ciclo for è necessario esplicitare il print
}

# Oppure
x <- rpois(10, lambda = 10)
x <- sort(x)
for (i in seq_along(x)) {
  temp <- x[i]
  msg <- paste0(
    "x e' pari a ", sprintf("%02d", temp),
    "; x quadro e' pari a ", sprintf("%03d", temp ^ 2)
  )
  print(msg)
}

# NB: seq_along crea una sequenza di indici lunga tanto quanto il vettore in input

# NB: Una volta che noi creiamo ed eseguiamo un ciclo for, la variabile rispetto
# a cui cicliamo non può essere modificata. Ad esempio:
for (i in 1:10) {
  print(i)
  i <- i + 1
}

# ESERCIZIO: Provate ad implementare un ciclo for che stampa a schermo le lyrics
# della famosa canzone "99 bottles of beer on the wall":
# http://www.99-bottles-of-beer.net/

# ESERCIZIO: Provate ad implementare il celebre algoritmo "fizzbuzz". Tale
# algoritmo chiede di ciclare su un vettore numerico in input (i.e. x = 1:100)
# applicando le seguenti condizioni:
# - se l'input in posizione i di x e' multiplo di 3, si stampi la stringa "fizz";
# - se l'input in posizione i di x e' multiplo di 5, si stampi la stringa "buzz";
# - se l'input in posizione i di x e' multiplo di 3 e 5, si stampi la stringa "fizzbuzz";
# - altrimenti, si stampi il valore di x[i]

rm(list = ls())

# NB: Nel caso in cui il ciclo for richieda di modificare ad ogni iterazioni gli
# elementi di un vettore y, è importante (dal punto di vista computazione)
# pre-allocare tutti gli elementi di tale vettore y.

# Ad esempio, il seguente codice può essere utilizzato per generare una
# realizzazione di un processo chiamato Random Walk (RW) (o, anche, Passeggiata
# Aleatoria).

n <- 150 # numero di passi del cammino aleatorio
y <- numeric(length = n)
for (i in 2:n) {
  y[i] <- y[i - 1] + rnorm(1)
}

# ESERCIZIO: Provate a creare una rappresentazione grafica per mostrare
# l'andamento di y. Ripetete la simulazione diverse volte per vedere diverse
# realizzazioni di un processo RW.

# Quanto mostrato sopra è estremamente più efficiente della seguente operazione
y2 <- 0
for (i in 2:n) {
  y2 <- c(y2, y2[i - 1] + rnorm(1))
}

# ESERCIZIO: Provate a sviluppare due funzioni (e.g. f1 ed f2) che implementano
# i due approcci appena mostrati ed a confrontarne i tempi di esecuzione
# (?system.time) per diversi valori di n.

# Purtroppo ciò non è sempre possibile...

# ESERCIZIO: Provate a sviluppare una funzione (e.g. my_collatz_sequence) che,
# dato in input un numero naturale n, restituisce in output un vettore
# contenente la sequenza completa dei valori restituiti dall'algoritmo di
# colltaz descritto sopra fino a raggiungere 1. Ad esempio,
# my_collatz_sequence(5) deve restituire il vettore composto dagli elementi c(5,
# 16, 8, 4, 2, 1).

rm(list = ls())

# NEXT STEPS: Il linguaggio R implementa un insieme di funzioni (e.g. apply,
# lapply, vapply, mapply, ..., comunemente chiamate la *apply family) che
# permettono applicare una stessa funzione a tutti gli elementi di un
# vettore/matrice/lista. Sono un argomento molto importante ma che, purtroppo,
# non riusciamo a coprire. Vi rimando alle pagine di help e alla bibliografia
# del corso per maggiori informazioni ed esempi.

# 2. Data frame -----------------------------------------------------------

# R utilizza un oggetto chiamato "data.frame" (i.e. di classe "data.frame") per
# rappresentare le matrici dei dati. Le righe di un data.frame corrispondono
# alle unità statistiche (i.e. le osservazioni) e le colonne alle variabili.

# Il software contiene già salvati in memoria alcuni dataframe(s):
iris
class(iris)

# In questi casi, è sempre utile leggere la pagina di help associata
# all'oggetto:
?iris

# La funzione data(package = "package-name") consente di elencare tutti i
# dataframe salvati in un pacchetto R (con anche una mini descrizione):
data(package = "datasets")
data(package = "cluster")

# NB: Internamente, un oggetto di classe data.frame viene salvato come una lista
# i cui elementi hanno tutti la stessa lunghezza e, tipicamente, un nome. Di
# conseguenza:
str(iris) # Controllate bene la descrizione delle variabili
length(iris) # Il numero di elementi della lista

# Analogamente, per estrarre una o più colonne del data.frame (i.e. gli elementi
# dalla lista) possiamo usare la sintassi nota:
iris$Sepal.Length # output: vettore
iris[["Sepal.Length"]] # output: vettore
iris[1] # output: dataframe con 1 colonna chiamata Sepal.Length

# Inoltre, dato che, per costruzione, le variabili di un dataframe hanno tutte
# lo stesso numero di elementi (i.e. ricordano una matrice di dati), R ci
# permette di usare una sintassi tipica delle matrici per estrarre parti di un
# dataframe:
iris[1, ] # prima riga
iris[1, 3] # prima riga e terza colonna
iris[1, "Petal.Length", drop = FALSE]
nrow(iris); ncol(iris)

# ESERCIZIO: Cosa restituiscono i seguenti comandi? Perchè?
iris[1]
iris[[1]]
iris[, 1]

# 2.1 Importare dataset esterni -------------------------------------------

# La funzione read.table (e affini, vedi ?read.table) può essere usata per
# importare un dataset esterno. Ad esempio:
small_flights <- read.table(
  file = "lezione-5/small-flights.csv",
  header = TRUE,
  sep = ","
)

# NB1: Il tab "Import Dataset" di Rstudio nella scheda Environment può essere
# utilizzato per importare i dataset più semplici.

# NB2: Potete modificare la directory dove R lavora tramite il comando setwd().
# Per un approccio alternativo ed un utilizzo più avanzato, vi suggerisco di
# consultare https://rstats.wtf/index.html.

# NB3: Il file small_flights.csv è stato estratto da un dataset contenuto nel
# pacchetto R nycflights13. Proviamo a consultarne la documentazione:

#  install.packages("nycflights13")
library(nycflights13)
?flights

# NB4: Potete usare readLines("file-path", n = ...) per avere un'idea della
# struttura di un file testuale. Ad esempio:
readLines(con = "lezione-5/small-flights.csv", n = 5)

# Possiamo ottenere una breve descrizione del dataset come segue:
dim(small_flights)
head(small_flights)
str(small_flights)
summary(small_flights)

# 2.2 Breve esplorazione --------------------------------------------------

# Come facciamo a selezionare i voli che sono partiti il primo gennaio?
idx <- small_flights[["month"]] == 1 & small_flights[["day"]] == 1
small_flights[idx, ]

# oppure
subset(small_flights, month == 1 & day == 1)

# E se volessimo solo alcune colonne?
small_flights[, c("carrier", "flight", "tailnum")]

# oppure
subset(small_flights, select = c("carrier", "flight", "tailnum"))

# Quali voli hanno accumulato più ritardo?
idx <- order(small_flights[["arr_delay"]], decreasing = TRUE)
head(small_flights[idx, ])

# E se volessimo aggiungere altre variabili? Ad esempio, potremmo voler
# convertire "dep_time" in una stringa di testo che descrive l'orario in maniera
# più leggibile.
small_flights$hour_dep_time <- small_flights$dep_time %/% 100
small_flights$hour_dep_time <- sprintf("%02d", small_flights$hour_dep_time)
small_flights$minute_dep_time <- small_flights$dep_time %% 100
small_flights$minute_dep_time <- sprintf("%02d", small_flights$minute_dep_time)
small_flights$string_dep_time <- paste0(small_flights$hour_dep_time, ":", small_flights$minute_dep_time)
head(small_flights[, c("dep_time", "string_dep_time")])

# 3. Next steps -----------------------------------------------------------

# Ci sono ancora tantissimi argomenti che sarebbe bello coprire (debugging,
# metodi numerici, formulae ed espressioni, Rcpp, ...) ma, purtroppo, dobbiamo
# fermarci qua. Inoltre, in base ai vostri interessi, mi sento di consigliarvi i
# seguenti libri:

# https://rstudio-education.github.io/hopr/ (un'altra semplice introduzione al linguaggio);
# https://r4ds.had.co.nz/ (Data science con R, ESTREMAMENTE CONSIGLIATO PER QUALSIASI AMBITO);
# https://bookdown.org/yihui/rmarkdown/ (R Markdown!)
# https://geocompr.robinlovelace.net/ (dati spaziali)
# https://otexts.com/fpp3/ (time series)

