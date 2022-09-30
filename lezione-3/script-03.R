###########################################################################
################# Livellamento al Software R - Lezione 3 ##################
###########################################################################

# 1. Grafici di base ------------------------------------------------------

# 1.1 plot() --------------------------------------------------------------

# La funzione R piu' semplice (e, probabilmente, anche la piu' importante) per
# creare un grafico e' plot(). Il suo comportamento dipende dalla "classe" degli
# oggetti che vengono passati in input (vedi ?plot e sezione 2 di questo
# script).

# Il primo grafico che andiamo a creare e' uno "scatter plot":
x1 <- 1:10
y1 <- 10:1
plot(x1, y1)

# Vediamo che il grafico viene mostrato nella console denominata "Plots" la
# quale, di default, e' nel pannello in basso a dx di Rstudio.

# Dalla pagina di help ?base::plot leggiamo quanto segue:
# > For simple scatter plots, plot.default will be used.

# e, dalla pagina di help ?plot.default vediamo che la funzione accetta diversi
# argomenti (descritti nella sezione Arguments) e diversi "graphical parameters"
# (descritti nella sezione Details) per modificare ed aggiustare l'aspetto di un
# grafico. Ad esempio:
plot(x1, y1, col = "red", cex = 2, pch = 20, xlab = "Hi!", ylab = "", main = "My second plot!")

# Tipicamente, ogni volta che eseguiamo la funzione plot() viene generato un
# grafico nuovo. Per aggiungere un "nuovo" insieme di punti ad un grafico
# esistente possiamo usare la funzione "points()":
x2 <- runif(100, min = 0, max = 10)
y2 <- runif(100, min = 0, max = 10)
points(x2, y2, col = "blue", cex = 2, pch = 20)

# D'altro canto, se vogliamo rappresentare i due insiemi di punti in due grafici
# distinti nello stesso pannello dobbiamo modificare il parametro "mfrow" (o
# "mfcol"):
old_par <- par(mfrow = c(2, 1)) # vogliamo una matrice di grafici con 1 riga e 2 colonne riempita per riga
plot(x1, y1, type = "b", col = "red", cex = 2, pch = 20)
plot(x2, y2, col = "blue", cex = 2, pch = 20)

# NB: la funzione layout() puo' essere utilizzata per definire layout grafici
# molto piu' complessi di quelli creabili tramite "mfrow" e "mfcol". Se volete
# leggere piu' dettagli, vi rimando alla pagina di help ed alla sezione 7.1.2 di
# "The R Software".

# Per "cancellare" tutti i grafici salvati in memoria da Rstudio possiamo usare
dev.off()

# e, per resettare i vecchi parametri grafici:
par(old_par)

# 1.2 segments() e lines() ------------------------------------------------

# Le funzioni segments() e lines() possono essere usate per aggiungere linee e
# segmenti ad un grafico gia' esistente. Ad esempio:
plot(x2, y2, xlim = c(-0.25, 10.25), ylim = c(-0.25, 10.25), pch = 20)
segments(
  x0 = c(0,   0, 10, 10),
  y0 = c(0,  10, 10,  0),
  x1 = c(0,  10, 10,  0),
  y1 = c(10, 10,  0,  0),
  lwd = 2, # spessore della linea
  col = 2, # Provate a leggere la sezione "Color Specification" in ?par
  lty = 2 # tipologia di tratto
)

# NB: La funzione plot e' vettorizzata anche rispetto ai suoi parametri
plot(x1, y1, col = 1:10, pch = 1:10, cex = 1:10 / 2, lwd = 3, xlab = "", ylab = "")

# oppure
x3 <- seq(-5, 5, by = 0.1)
plot(x3, sin(x3), type = "l", ylab = "", xlab = "x", lwd = 2, col = "red")
lines(x3, cos(x3), lwd = 2, col = "blue")

rm(list = ls())

# 1.3 hist() and density() ------------------------------------------------

# Le funzioni hist() e density() possono essere utilizzate per ricavare una
# rappresentazione grafica che descrive l'andamento di una variabile numerica.
# In particolare, hist() serve per calcolare e rappresentare un "istogramma"
# dato un insieme di valori in input:
set.seed(1)
x <- rnorm(n = 500)
hist(x)

# Tramite l'argomento "breaks" possiamo modificare il numero di "breakpoints"
# utilizzati nella funzione:
hist(x, breaks = 30)

# Inoltre notiamo come, di default, la funzione crea un istogramma con i
# conteggi di frequenze. Possiamo modificare questo aspetto tramite l'argomento
# "freq":
hist(x, breaks = 30, freq = FALSE)

# La funzione density() serve per ricavare una stima non-parametrica di una
# funzione di densita' f partendo da un campione di osservazioni X1, ..., Xn ed
# uno stimatore kernel. In maniera molto informale, potremmo dire che density()
# puo' essere usata per ottenere una versione lisciata di un istogramma di
# frequenze. Senza soffermarci troppo sui dettagli teorici (che pero' sono molto
# importanti, provate infatti a leggere ?density e alcune delle references li'
# riportate), l'utilizzo e' piuttosto immediato.
density(x)

# L'output e' un po' criptico. Tuttavia, grazie alle "magiche" proprieta' della
# funzione plot() possiamo rappresentarlo molto facilmente:
plot(density(x))

# Vediamo tra poco perche' e' possibile fare cio'. Per il momento, possiamo solo
# notare graficamente la somiglianza tra l'istogramma e la stima di densita'
# kernel. L'argomento di gran lunga piu' imporante di density() e' "bw" il quale
# serve a specificare il "grado" di lisciamento desiderato. Ad esempio:
plot(density(x, bw = 1))
plot(density(x, bw = 0.1))

# Anche la funzione lines() gode delle stesse proprieta' magiche di plot(). Per
# questo motivo, possiamo sfruttarla per sovrapporre una stima di densita' non
# parametrica all'istogramma di frequenze relative.
hist(x, breaks = 30, col = "white", border = "darkred", freq = FALSE)
lines(density(x), lwd = 2, col = grey(0.4), lty = 2)

# 1.4 curve() -------------------------------------------------------------

# La funzione curve serve per disegnare una funzione (nel senso che intende R) o
# una espressione matematica del tipo x |-> f(x) specificata tramite il suo
# primo argomento. Ad esempio:
curve(expr = x ^ 3 - x ^ 2 - 3 * x, from = -2, to = 2.5)

# oppure
curve(dnorm, from = -3, to = 3)

# Il grafico creato da curve() puo' essere personalizzato analogamente a quanto
# visto prima:
curve(
  expr = x ^ 3 - x ^ 2 - 3 * x,
  from = -2,
  to = 2.5,
  lwd = 2,
  col = 2,
  main = bquote(x^3 - x ^ 2 - 3 * x), # see ?plotmath
  xlab = "",
  ylab = "",
  cex.axis = 1.25,
  cex.main = 2,
  lty = 2
)

# Concludiamo questa parte mostrando come si puo' calcolare la "Empirical
# Cumulative Distribution Function" (ECDF, ?ecdf) dato un vettore numerico x in
# input. In particolare, la ECDF e' una funzione F(t) costante a tratti che
# calcola la percentuale di valori di x che calcola la percentuale di valori in
# x che e' minore o uguale a t. Ad esempio:
x <- c(1, 2, 3)
plot(ecdf(x))

# Nel seguente esempio proviamo a confrontare la ECDF per un campione casuale
# normale di ampiezza n = 100 con il suo equivalente teorico (aggiunto alla
# figure tramite curve()).
set.seed(1)
x <- rnorm(100)
plot(ecdf(x), cex = 0.1) # anche qua vediamo la "magia" di plot!
curve(pnorm, add = TRUE, col = 2, lwd = 2) #NB: Notare add = TRUE

# Chiaramente ci sono tantissimi argomenti che non abbiamo ancora coperto (le
# palette di colori, la legenda, i parametri di par(), ...). Per tutto questo vi
# rimando alle pagine di help e alla bibliografia suggerita.

# ESERCIZIO: Dopo aver simulato un vettore x contenente n = 500 realizzazioni
# iid da una v.c. N(0, 1), si rappresenti l'istogramma dei valori ottenuti
# scegliendo un opportuno numero di bins.

# ESERCIZIO: Si aggiunga al grafico precedente la funzione di densita' teorica
# (in rosso) e la sua stima non parametrica ottenuta tramite il comando density
# (in blu). Si commenti il risultato.

rm(list = ls())

# 2. class() --------------------------------------------------------------

# Gli oggetti R possono avere dei "metadati" chiamati "attributi" che ne
# descrivono le caratteristiche. Possiamo controllare gli attributi (non
# intrinsechi) di un oggetto x tramite la funzione attributes(). Tutti gli
# oggetti R hanno almeno due attributi: "length" (il numero di elementi) e
# "mode" (che rappresenta una generalizzazione del concetto di "tipo" visto
# nella prima lezione). Questi due attributi vengono denominati "attributi
# intrinsechi" e non vengono restituiti da attributes(). Ad esempio:
x <- c("A", "B", "C")
length(x); mode(x)
attributes(x)

x <- list(list(list(1)))
length(x); mode(x)
attributes(x)

# Molte altre tipologie di oggetti hanno degli attributi extra. Ad esempio:
x <- matrix(1:9, 3, 3)
length(x); mode(x)
attributes(x)

x <- factor(letters)
length(x); mode(x)
attributes(x)

# La "classe" e' uno degli attributi piu' importanti in R poiche ci permette di
# sfruttare la programmazione ad oggetti denominata S3. Ad esempio:
x <- rnorm(100)
my_hist <- hist(x, plot = FALSE)
class(my_hist)

my_density <- density(x)
class(my_density)

my_ecdf <- ecdf(x)
class(my_ecdf)

# 3. Pillole di S3 --------------------------------------------------------

# Il linguaggio R implementa un sistema di programmazione ad oggetti molto
# semplice denominato S3. Alla base di questo sistema giace un insieme di
# funzioni chiamate "generic functions", i.e. funzioni il cui comportamento
# varia in base alla classe degli oggetti che vengono passati in input.

# Possiamo riconoscere che una funzione f e' una "generic functions" se ha un
# costrutto di questo tipo:
plot

# L'istruzione 'UseMethod("plot")' ci permette di capire che plot e' una "generic
# function". Di conseguenza, essa richiama un'altra funzione (solitamente
# chiamata "method") in base alla classe del primo oggetto passato in input.
# Possiamo elencare tutti i metodi associati ad una generic tramite la funzione
# methods():
methods("plot")

# Vediamo che i methods hanno la forma: generic.class (e.g. plot.factor).

# Di conseguenza, quando noi scriviamo plot(ecdf(x)), R implicitamente richiama
# il metodo plot.ecdf(). Analogamente, l'istruzione plot(density(x)) richiama
# plot.density() (e cosi' via...).

# Possiamo consultare la definizione di un "method" come segue:
getS3method("plot", "ecdf")

rm(list = ls())

# 4. Nuove funzioni su R!  ------------------------------------------------

# Implementare nuove funzioni su R serve per ripetere lo stesso set di
# operazioni piu' e piu' volte modificando unicamente gli oggetti in input.

# Ad esempio, se volessimo calcolare la media potenziata di ordine r = 5 (i.e.
# (1 / n * sum_i x_i ^ r) ^ 1/r) per un vettore tipo
x <- 1:10

# dovremmo implementare il seguente set di operazioni
exp(log(mean(x ^ 5)) / 5)

# Per calcolare la media potenziata di ordine r = 10:
exp(log(mean(x ^ 10)) / 10)

# Abbiamo ripetuto le stesse operazioni cambiando unicamente il numero associato
# ad r. Queste ripetizioni aumentano le probabilita' di errori quando copiamo ed
# incolliamo il codice tra un set di operazioni e l'altro. Inoltre, nel caso in
# cui decidessimo di modificare l'algoritmo sottostante, dovremmo modificarlo
# manualmente in tutte le parti dello script (il che aumenta nuovamente la
# probabilita' di commettere errori). Di conseguenza, potrebbe essere conveniente
# definire una nuova funzione come segue:
powered_mean <- function(x, r = 1) {
  exp(log(mean(x ^ r)) / r)
}

# ed eseguirla modificando solo il valore associato ad r
powered_mean(x, r = 5)
powered_mean(x, r = 10)

# Per creare una nuova funzione si utilizza la seguente sintassi:

# name <- function(list or arguments) {
#   body of the function
# }

# In particolare:

# - Il nome della funzione segue le stesse regole dell'assegnazione viste in
# precedenza.
# - Il body della funzione e' una sequenza di istruzioni R (e, eventualmente,
# commenti);
# - Gli argomenti della funzione vengono identificati tramite il loro nome (che
# deve essere univoco). Uno, alcuni o tutti gli argomenti possono avere un
# valore di default (che verra' usato nel caso in cui l'utente non specifichi
# nulla quando richiama tale funzione). Nel caso precedente, x non ha un
# valore di default, r si'.

# Se eseguiamo il nome di una funzione senza le parentesi, R stampa a schermo il
# "body":
powered_mean

# ESERCIZIO: Provate a definire una funzione f la quale, dato un vettore
# numerico in input, restituisce una lista contenente la media, la varianza, il
# minimo ed il massimo di tale vettore. Assegnate un nome opportuno agli
# elementi della lista.

# 4.2 Return value --------------------------------------------------------

# Ogni funzione R restituisce un valore in output (in maniera implicita od
# esplicita). Possiamo definire degli output espliciti tramite la funzione
# return(). Ad esempio:
test_return <- function(x, y) {
  out <- list(x = x, y = y, z = x + y)
  return(out)
}

test_return(1, 2)

# Se R raggiunge la fine delle istruzioni incluse nel body senza aver incontrato
# nessuna istruzione di return, allora egli restituisce l'ultimo oggetto
# valutato. Ad esempio:
test_return_2 <- function(x, y) {
  list(x = x, y = y, z = x + y)
}
test_return_2(1, 2)

# La funzione test_return_2 e' identica a test_return. Per questo motivo, in R il
# return esplicito viene utilizzato unicamente per implementare un comportamento
# denominato "early return" (vedremo esempi piu' avanti).

# ESERCIZIO: Supponiamo che X1, ..., Xn sia un campione casuale estratto da una
# popolazione X ~ Poisson(lambda). Si implementi una funzione che, dati in input
# un vettore numerico x ed una stima per lambda, restituisce il valore della
# funzione di verosimiglianza.

# ESERCIZIO (AVANZATO): Dato il seguente campione casuale,
x <- rpois(n = 100, lambda = 2)
# si rappresenti la funzione di verosimiglianza calcolata al punto precedente
# fissando un opportuno range di valori per lambda. Suggerimento: consultare
# l'help della funzione "curve()" per capire come rappresentare funzioni
# definite ad-hoc.

# ESERCIZIO: Supponiamo che X1, ..., X100 sia un campione casuale estratto da
# una popolazione X ~ N(mu, 1). Si implementi una funzione che, dato in input un
# valore mu0, permetta di calcolare il pvalue del test
#                        H0: mu = mu0 vs H1: mu > mu0.

rm(list = ls())

# 4.3 Lexical scoping (avanzato) ------------------------------------------

# Ma cosa succede quando eseguiamo una funzione che modifica una variabile
# avente lo stesso nome di un'altra variabile nel global environment? Ad
# esempio:
x <- 5
my_sum1 <- function(x) {
  x <- x + 1
  x
}
my_sum1(x)
x # ????

# Questo succede perche' le variabili definite dentro ad una funzione "nascono e
# muoiono" dentro a quella funzione e non vanno ad intaccare l'ambiente esterno.

# Cosa succede invece quando una funzione richiama una variabile non definita
# in quella stessa funzione?
my_c <- function(x) {
  c(x, y) # y non e' tra gli argomenti di my_c
}

my_c(1)

# Tuttavia
y <- 2
my_c(1)

# R non trova y tra gli argomenti di y e, come ultima risorsa prima di
# restituire un messaggio di errore, controlla anche se y "esiste" nel global
# enviroment.

# NB: Questo e' un comportamento che puo' avere conseguenza estremamente difficili
# da prevedere ed errori difficili da diagnosticare. E' sempre meglio essere
# ESPLICITI elencando tutti gli argomenti di cui necessita una funzione.

rm(list = ls())

# 5. Le strutture di controllo --------------------------------------------

# Le strutture di controllo servono per modificare il flusso di esecuzione di
# uno script o una funzione. Le piu' comuni sono:

# - if/else (per testare una condizione);
# - for (per eseguire un ciclo di operazioni);
# - while (per eseguire la stessa operazioni piu' volte fino a che un test non viene valutato a FALSE)

# Meno comuni:
# - repeat (esegue un loop all'infinito);
# - break (interrompe un loop);
# - next (salta una iterazione di un loop).

# 5.1 if and if/else ------------------------------------------------------

# Una istruzione del tipo if o if/else puo' essere usata nel seguente modo:

# if (TEST) {
#   do - something
# }

# if (TEST) {
#   do - something
# } else {
#   in any other case, do something else
# }

# Per esempio:
x <- runif(1)
y <- runif(1)
if (x < y) {print("x e' piu' piccolo di y!")}
if (x < y) {print("x e' piu' piccolo di y!")} else {print("x e' piu' grande di y!")}

# NB: Il TEST utilizzato per valutare una "if" clause deve necessariamente
# essere un vettore logico di lunghezza 1, pena un errore o un messaggio di
# warning:
if (c(TRUE, FALSE)) {print("AIUTO")}

# ESERCIZIO: La congettura di Collatz afferma che, dato un qualsiasi numero
# naturale n, applicando il seguente algoritmo:
# a) se n e' pari lo divido per 2;
# b) se n e' dispari lo moltiplico per 3 ed aggiungo 1;
# allora la successione di elementi arrivera' sempre a raggiungere il numero 1.

# Si implementi una funzione che, dato in input un numero naturale n, calcola il
# suo successivo tramite l'algoritmo della congettura di Collatz.

rm(list = ls())

# La struttura di controllo "if" puo' essere implementata in una funzione per
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
# tale fdd dati un insieme di valori a, b, e c scelti da voi.

# 5.2 Cicli for -----------------------------------------------------------

# Un ciclo for puo' essere implementato utilizzando il seguente costrutto:

# for (sequenza di indici o elemento) {
#   corpo del ciclo
# }

# Ad esempio:
for (i in 1:10) {
  print(i ^ 2) # NB: E' importante esplicitare il print
}

# Oppure
x <- rnorm(10)
for (i in seq_along(x)) {
  temp <- x[i]
  msg <- paste0(
    "x e' pari a ", round(temp, 2),
    "; x quadro e' pari a ", round(temp ^ 2, 2)
  )
  print(msg)
}

# NB: seq_along crea una sequenza di indici lunga tanto quanto il vettore in input

# ESERCIZIO: Provate ad implementare un ciclo for che stampa a schermo le lyrics
# della famosa canzone "99 bottles of beer on the wall":
# http://www.99-bottles-of-beer.net/

# ESERCIZIO: Provate ad implementare il celebre algoritmo "fizzbuzz". Tale
# algoritmo chiede di ciclare su un vettore numerico in input (i.e. x) e restituire un
# secondo vettore (i.e. y) in cui:
# - se l'input in posizione i e' multiplo di 3, allora y[i] deve essere pari a "fizz";
# - se l'input in posizione i e' multiplo di 5, allora y[i] deve essere pari a "buzz";
# - se l'input in posizione i e' multiplo di 3 E 5, allora y[i] deve essere pari a "fizzbuzz";
# - altrimenti, y[i] deve essere pari a x[i].

# NB: E' importante PREALLOCARE un vettore y utilizzato in un ciclo for invece
# che farlo crescere ogni volta che lo manipolate.

