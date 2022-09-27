# 1. Stringhe -------------------------------------------------------------

# Il linguaggio R utilizza il tipo "character" per rappresentare internamente
# le stringhe di testo. Ad esempio:
"ABC"

# oppure
'ABC'

# Come mostrato sopra, le stringhe devono essere delimitate dai caratteri "
# oppure '. Possiamo concatenare una o piu' stringhe di testo per creare un
# vettore di tipo "character":
x <- c("rosso", "verde", "giallo")

# ma anche
c("1", "2", "3") # i.e. anche i "numeri" li possiamo rappresentare come stringhe

# oppure
y <- c("come un peperone", "di rabbia", "d'invidia")

# Sono gia' implementate diverse funzioni per manipolare vettori di tipo
# character. Ad esempio:

nchar(x) # il numero di caratteri che compongono una stringa
paste(x, y) # concatenazione di stringhe elemento per elemento.
substring(x, 1, 2) # subsetting
grep("giallo", x); grepl("giallo", x) # matching
gsub("o", "*", x) # replacement

# Possiamo anche convertire una stringa di testo in maiuscolo/minuscolo
toupper(x)
tolower(toupper(x))

# Inoltre, il pacchetto R "tools" definisce una funzione chiamata "toTitleCase"
# che permette di scrivere una stringa di testo come se fosse un titolo:
library(tools)
toTitleCase(x)

# NB: Questa funziona e' ottimizzata per il testo scritto in inglese.

# La gestione delle stringhe di testo su R e' un argomento molto complesso ma,
# data la natura del corso di livellamento, ci fermiamo qua. Alcune
# precisazioni:
#
# - Per effettuare operazioni piu' articolate di quelle descritte in precedenza,
# si e' soliti utilizzare espressioni chiamate "regex" (REGular EXpression):
# pattern che descrivono le caratteristiche di una stringa testuale. Ad esempio,
# il seguente comando serve per sostituire il primo carattere di una stringa di
# testo con "*" a meno che questo carattere sia uguale ad "r".
gsub("^[^r]{1}", "*", x)

# Se volete approfondire l'argomento, vi suggerirei di consultare la
# corrispondente pagina di help (?regex), il seguente capitolo
# https://r4ds.had.co.nz/strings.html ed il seguente sito web:
# https://regex101.com/

# NB: Tranne che nei casi' piu' banali, la costruzione di una regex e' abbastanza
# complessa: https://www.reddit.com/r/ProgrammerHumor/comments/lea26p/the_plural_of_regex_is_regrets/

# - Le operazioni sulle stringhe di testo dipendono molto dalla lingua (e, piu'
# in particolare, dal "locale") che viene utilizzato. Anche in questo caso vi
# rimando a https://r4ds.had.co.nz/strings.html#locales

# La funzione is.character() serve per testare se l'input e' un vettore di tipo
# character.
is.character(x)
is.character(42L)

# La funzione strsplit serve a dividere ogni elemento di un vettore di stringhe
# rispetto ad un dato pattern:
strsplit(y, " ")

# L'output di questa funzione e' una lista, una delle strutture dati piu'
# importanti di R che verra' introdotta in seguito.

# ESERCIZIO: Dopo aver letto la help page relativa alla funzione startsWith(),
# provate a
# 1) Definire un vettore chiamato z "incollando" i vettori x ed y;
# 2) Selezionare unicamente quegli elementi di z che
#    a) cominciano per "r"
#    b) finiscono per "o".

# NB1: Devono essere soddisfatte entrambe le condizioni.
# NB2: Come gia' visto durante la scorsa lezione, l'operatore "[" puo' essere
# utilizzato per selezionare solamente alcuni elementi di un vettore.

# ESERCIZIO: Dopo aver letto la pagina di help della funzione chartr() ed aver
# testato qualcuno dei suoi esempi, provate a scrivere una espressione R per
# convertire la stringa "ABBCDD" in "AbbCDD"

# ESERCIZIO: Il linguaggio R definisce due costanti chiamate LETTERS e letters che
# contengono tutte le lettere dell'alfabeto in maiuscolo e minuscolo:
LETTERS

# Come faccio a selezionare solo le prime 10 lettere?

rm(list = ls())

# 2. Fattori --------------------------------------------------------------

# Il linguaggio R implementa una struttura dati chiamata "factor" che facilita
# l'analisi di dati categoriali. I factor sono particolarmente utili per
# rappresentare variabili che possono assumere solo una categoria tra un insieme
# noto e finito di valori (e.g. il genere, la tipologia di impiego, il mese di
# nascita, ...). I valori possono avere un ordinamento (e.g.le gerarchie in
# ambito militare) oppure no (e.g. il colore dei capelli).

# Per creare un oggetto factor possiamo usare la funzione omonima:
elenco_giorni <- c(
  "Lunedi", "Martedi", "Mercoledi", "Giovedi", "Venerdi", "Sabato", "Domenica"
)
factor(c("Lunedi", "Domenica"), levels = elenco_giorni)

# Se non specifico l'argomento "levels", allora essi vengono generati
# automaticamente prendendo le stringhe univoche in input in ordine alfabetico.
factor(c("Lunedi", "Domenica"))

# Per specificare che i possibili valori sono definiti secondo una gerarchia,
# posso usare l'argomento ordered:
gradi_esercito <- c("soldato", "luogotenente", "capitano", "generale")
x <- c("soldato", "soldato", "capitano")
factor(x, levels = gradi_esercito, ordered = TRUE)

#NB: La variabile month.abb (gia' salvata in memoria) continene il nome
#abbreviato dei mesi dell'anno:
month.abb

# ESERCIZIO: La funzione table() serve a generare una tabella di frequenze
# assolute per un dato vettore in input. Ad esempio:
table(c("A", "B", "B"))

# Dato il seguente vettore
x <- c("Jan", "Jan", "Dec", "Mar")

# 1. Si calcoli la tabella di frequenze assolute di x;
# 2. Si definisca una nuova variabile chiamata z corrispondente alla
# rappresentazione factor di x e specificando che l'argomento levels deve essere
# pari a month.abb;
# 3. Si calcoli la tabella di frequenze assolute di z. Che differenza c'e' tra i
# due output mostrati in precedenza? E perche' questo potrebbe essere importante?
# 4. Dato il seguente vettore
y <- c("Mar", "May", "Jun", "Jul")

# si calcoli la tabella a doppia entrata che rappresenta le frequenze assolute
# congiunte delle due osservazioni (i.e. table(x, y)) e si commenti il
# risultato.

# APPROFONDIMENTO: La funzione marginSums() puo' essere utilizzata per calcolare
# delle frequenze marginali data una tabella di contingenza bivariata.

# 5. Cosa cambia se x ed y vengono specificati come factors i cui livelli sono
# pari a month.abb?

# 6. Come pensate si possa calcolare la matrice delle frequenze relative nel
# caso univariato?

# 7. La funzione cut() (?cut) serve per dividere una variabile numerica x in
# livelli (i.e. un factor) dato un secondo vettore che rappresenta i "breaks".
# Dopo aver definito un vettore x che contiene gli interi da 1 a 10, lo si
# divida in due classi a piacere e se ne calcoli la tabella di frequenze
# congiunte. Come sempre, in caso di problemi provate a consultare la pagina di
# help.

rm(list = ls())

# 3. Coercizione ----------------------------------------------------------

# Come detto nella lezione precedente, in R un vettore non e' altro che una
# sequenza di valori aventi lo stesso tipo. La funzione "c" serve per
# concatenare gli elementi di un vettore. Ma cosa succede quando proviamo a
# concatenare elementi di tipi diversi? Ad esempio, cosa restituisce il seguente
# comando?
c(FALSE, 1, "A")

# Come riportato nella help page della funzione "c":

# > The output type is determined from the highest type of the components in the
# hierarchy:
# ... < logical < integer < double < complex < character < list < ...

# In altre parole, in R esiste una gerarchia tra i vari tipi ed ogni volta che
# mischiamo tipi diversi, l'output viene trasformato secondo il tipo piu' in alto
# nella gerarchia.

# In R esistono diverse funzioni che permettono di effettuare una conversione
# esplicita tra tipi diversi. Seguono tutte la sintassi "as.*tipo*". Ad esempio:
as.numeric(c("1", "2", "3.14")) # numeric vuol dire double o integer
as.integer(c("1", "2", "3.88"))

# oppure
as.character(c(pi, TRUE))

# Nel caso in cui la conversione non sia opportunamente definita, R restituisce
# un valore mancante (o NA, vedi sotto) ed un messaggio di warning:
as.numeric("mela")

# NB: L'operazione di coercizione tra valori logici e numeric viene effettuata
# come segue:
as.numeric(TRUE)  # TRUE  ---------------> 1
as.numeric(FALSE) # FALSE ---------------> 0
as.logical(0)     # 0 ---------------> FALSE
as.logical(42)    # tutto il resto ---> TRUE

# Per questo motivo,
FALSE * TRUE + TRUE * 2 - FALSE * 10

# ESERCIZIO: Dato il seguente vettore
x <- c(FALSE, TRUE, log(1), 0)

# cosa vi aspettate che restituiscano i seguenti comandi? Perche'?
sum(x)
min(x)
prod(x + 1)

rm(list = ls())

# 5. Matrici --------------------------------------------------------------

# Le matrici possono essere viste come una generalizzazione dei vettori in due
# dimensioni. Come per i vettori, tutti gli elementi di una matrice devono
# essere dello tesso tipo (applicando le regole viste prima sulla coercizione
# tra elementi).

# Per creare una matrice posso usare la funzione matrix:
matrix(1:10)

# Di default, R crea una matrice con n righe ed 1 colonna (dove n e' il numero di
# elementi in input). Possiamo aggiustare questo aspetto tramite gli argomenti
# nrow e ncol:
matrix(1:10, nrow = 5, ncol = 2)

# Nulla ci vieta di costruire una matrice di elementi di tipo logico:
matrix(c(TRUE, FALSE), nrow = 5, ncol = 2)

# NB: Il vettore in input (i.e. c(TRUE, FALSE)) e' stato duplicato fino a
# raggiungere la lunghezza richiesta (i.e. 5 * 2 = 10 elementi). Notiamo inoltre
# che, di default, la matrice viene "riempita" per colonna.

# o character:
matrix(letters[1:10], nrow = 5, ncol = 2, byrow = TRUE)

# La funzione dim() puo' essere usata per ricavare le dimensioni di una matrice:
(X <- matrix(1:9, 3, 3))
dim(X)

# Analogamente
nrow(X); ncol(X)

# L'operatore "[" puo' essere applicato anche alle matrici utilizzando una
# sintassi simile a quella dei vettori. Il seguente comando estrae l'elemento in
# prima riga e seconda colonna (iniziando a contare righe e colonne dalla
# posizione in alto a sx):
X[1, 2]
X[1, ] # prima riga
X[, c(2, 3)] # seconda e terza colonna

# Vediamo inoltre che, di default, il subset di un singolo elemento o di una
# singola riga/colonna restituisce un vettore e non piu' una matrice (lo si
# riconosce dal modo in cui gli oggetti vengono stampati a schermo). Il
# parametro "drop" serve a modificare questo comportamento:
X[1, , drop = FALSE]

# NB: In questo caso lo spazio tra le due virgole deve essere specificato.

# Le operazioni matematiche viste in precedenza sono estensibili anche alle
# matrici. Ad esempio:
X <- matrix(1:4, nrow = 2, ncol = 2)
Y <- diag(2) # matrice identita' di dimensione 2

X + Y # somma elemento per elemento
X + 1
# NB: il vettore 1 e' implicitamente trasformato in una matrice avente dimensioni
# opportune.

X * Y # prodotto elemento per elemento
X * 2 # vedi sopra

# e, analogamente,
X / (Y + 1)
log(X)
exp(X)
sin(X)
sign(Y)

# Il prodotto matriciale XY e' implementato tramite l'operatore %*%:
X %*% Y

# Il software R implementa anche diverse altre operazioni:
solve(X) # matrice inversa
t(X) # matrice trasposta
crossprod(X, Y) # prodotto incrociato: X'Y
solve(X, Y) # rapporto X^-1 Y
det(X) # determinante
eigen(X) # scomposizione in autovalori/autovettori
svd(X) # singular value decomposition
qr(X) # QR decomposition

# Le ultime 3 funzioni, i.e. eigen(), svd(), e qr() restituiscono in output una
# lista (vedi sotto...).

# APPROFONDIMENTO: Internamente R rappresenta le matrici come vettori a cui
# associa un "attributo" chiamato "dim" avente lunghezza 2. Purtroppo non
# possiamo entrare nel dettaglio di tali argomenti, ma vi invito a consultare le
# pagine di help associate (i.e. ?attributes) e le references del corso
# (
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Getting-and-setting-attributes
# e
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Arrays-and-matrices
# ).

# ESERCIZIO:

# 1. Si crei una matrice A contenente gli interi da 10 a 24 avente 5 righe, 3
# colonne e valori inseriti per colonna.
# 2. Si calcoli la somma per riga e per colonna di A (i.e. ?rowSums)
# 3. Si calcoli la trasposta di A
# 4. Si definisca una nuova matrice B di dimensioni opportune per calcolare il
# prodotto AB (e si calcoli tale prodotto).

rm(list = ls())

# 6. Subset-assignment ----------------------------------------------------

# Nelle lezioni precedenti abbiamo visto che l'operatore "[" puo' essere
# utilizzato per estrarre le componenti di un vettore. Ad esempio:
x <- 7:4
x[c(1, 2)]
x[-3]

# La medesima operazione puo' essere compiuta utilizzando un vettore di valori
# logici:
x[c(TRUE, FALSE)] # subset + recycling

# L'operatore "[" permette di effettuare molte altre operazioni. In particolare,
# se ad un vettore x e' associato un insieme di nomi:
y <- c("Andrea" = 29, "Marco" = 27)

# possiamo selezionare gli elementi tramite tali nomi
y["Andrea"]

# Ripetendo gli indici di tipo numerico o nome, posso duplicare parti di un
# vettore:
x[c(1, 1, 1, 2, 2, 3)]
y[c("Andrea", "Andrea")]

# e, combinando gli operatori di subset (i.e. "[") e assignment (" <- ")
# possiamo sostituire parti di un vettore. Questa operazione viene tipicamente
# chiamata "subset assignment":
x[1:2] <- c(10L, 9L)
x

# Quanto visto prima si applica anche in questo caso:
x[1] <- "A" # coercizione implicita
x

# Le stesse operazioni le applico anche alle matrici con alcuni accorgimenti:
X <- matrix(letters[1:9], 3, 3)
X[c(1, 2), c(2, 3)] <- "Z" # righe 1 e 2; colonne 2 e 3
X[1, 1] <- X[3, 3] <- "Q" # elementi (1, 1) e (3, 3)
X

rm(list = ls())

# 7. Liste ----------------------------------------------------------------

# Le liste rappresentano una generalizzazione del concetto di vettore in quanto
# possono contenere elementi di tipo diverso. Sono chiamate anche strutture
# "ricorsive" in quanto una lista puo' contenere anche un'altra lista:
list(FALSE, 0L, pi, "ABC")
list(list(1, 2), matrix(1:3))

# La funzione str() e' molto utile per analizzare una lista e le sue componenti.
x <- list(1, "A", matrix(1:4, 2, 2))
str(x)

# Il subset (e il subset-assignment) di liste funziona in maniera leggermente
# diversa da quello per i vettori. In particolare:
x[2]

# restituisce UNA LISTA che contiene solamente il secondo elemento. D'altro
# canto
x[[2]]

# estrae il secondo dalla lista.

# Di conseguenza
det(x[3])
det(x[[3]])

# Una spiegazione molto bella su questo argomento:
# https://r4ds.had.co.nz/vectors.html#visualising-lists

# Per eliminare un elemento da una lista posso assegnare NULL al corrispondente
# valore.
x[[1]] <- NULL
str(x)

# Anche gli elementi di una lista possono essere numerati
(y <- list(a = 1, b = "U5"))

# e posso utilizzare tali nomi per estrarre parti di una lista
y$a

# NB: Tantissime funzioni in R (e.g. lm()) restituiscono output di tipo lista.

# ESERCIZIO: Sia X una matrice 2 x 2 che contiene gli interi da 1 a 4. Dopo aver
# letto la pagina di help della funzione svd() (?svd) e averne studiato
# l'output, si provi a ricostruire la matrice di input dati gli elementi
# contenuti nella lista in output.

rm(list = ls())

# 8. Valori mancanti (NA e NaN) -------------------------------------------

# In R si utilizza la costante NA (Not Available) per indicare un valore
# mancante, indefinito o non specificato. Ad esempio:
c("Andrea" = 29, "Marco" = 27, "Luca" = NA)

# La funzione is.na() restituisce un vettore logico che identifica quali degli
# elementi in input sono NA:
x <- c(1, 2, NA)
is.na(x)

# NB: Non e' possibile confrontare NA(s) con l'operatore di uguaglianza logica:
NA == NA

# Perche'? NA rappresenta un placeholder per un valore non noto. Di conseguenza,
# non potendo sapere se i due valori mancanti sono uguali o meno, R restituisce
# NA.

# Analogamente, la seguente operazione "non funziona":
x == NA

# ESERCIZIO: Gli NA in R tipicamente si propagano (nel senso che quasi tutte le
# operazioni i cui input includono NA restituiscono NA). Ad esempio:
x <- c(1, 2, NA)
mean(x)

# Provate a leggere la "help page" di ?mean per capire quale argomento e'
# possibile specificare per alterare questo comportamento.

# ESERCIZIO: Provate a spiegare l'output delle seguenti operazioni:
TRUE | NA
NA & FALSE

# NB: Alcune operazioni matematiche possono anche restituire le costanti Inf e
# -Inf:
1 / 0
(-2) / 0

rm(list = ls())

# 9. Funzioni di probabilita' ----------------------------------------------

# Il software R implementa un insieme di funzioni aventi una sintassi comune per
# gestire particolari variabili casuali. Ad esempio, se assumiamo che X
# rappresenta una variabile casuale Gaussiana a media mu = 0 e deviazione
# standard sigma = 1, il seguente comando genera n = 5 realizzazioni casuali da
# X:
rnorm(n = 5, mean = 0, sd = 1)

# NB1: E' importante distinguere tra una variabile casuale e le sue
# realizzazioni. Di conseguenza, nel precedente esempio, X rappresenta la
# generica v.c. mentre rnorm estrae 5 realizzazioni aleatorie.

# Per calcolare la CDF di X in un punto x, e.g. P(X <= 0), possiamo usare
pnorm(0, mean = 0, sd = 1)

# mentre qnorm calcola i quantili di X
qnorm(0.975, mean = 0, sd = 1)

# e dnorm i valori della funzione di densita'
dnorm(0.5, mean = 0, sd = 1) # uguale a 1/sqrt(2 * pi) * exp(0)

# Tutte queste funzioni seguono un pattern comune. La prima lettera identifica
# l'obiettivo della funzione:
# - d per la funzione di densita'
# - p per calcolare la CDF
# - q per calcolare i quantili
# - r per generare numeri casuali (random)

# mentre le rimanenti lettere descrivono la variabile casuale (e.g. norm per la
# Normale, pois per la Poisson, gamma per la Gamma, unif per l'Uniforme e cosi'
# via).

# ESERCIZIO: Sia X ~ N(5, 5). Dopo aver consultato la pagina di help di ?qnorm e
# aver capitolo la "parametrizzazione" utilizzata da R, si calcoli il quantile
# di ordine 0.7 di X.

# ESERCIZIO: Sia X ~ Poisson(1). Si simuli l'estrazione di n = 100 osservazioni
# da X e se ne calcoli la media. Dopo aver ripetuto questa operazioni diverse
# volte, cosa possiamo concludere?

# ESERCIZIO: Sia X1, ..., Xn un campione casuale da X, variabile casuale avente
# media mu e varianza sigma2 finita. In maniera un poco informale, potremmo dire
# che la Legge dei Grandi numeri afferma che la variabile casuale "media
# campionaria" converge (in probabilita') a mu al divergere di n. Provate a
# verificare empiricamente questo fatto simulando campioni di numerosita' sempre
# maggiore da X ~ Uniforme(0, 10) e calcolandone la media.

# NB: Come si puo' intuire dall'output delle precedenti funzioni, i comandi del
# tipo r* restituiscono ogni volta una realizzazione casuale diversa. La
# variabile casuale puo' rimanere invariata, ma le estrazioni da essa solo
# aleatorie. Per garantire la riproducibilita' dei risultati tra sessioni o PC
# diversi, potrebbe essere utile fissare un "seme" per garantire sempre le
# stesse realizzazioni casuali:

runif(1)
runif(1)

set.seed(1)
runif(1)
set.seed(1)
runif(1)

# La generazione di estrazioni casuali da una variabile casuale e' un argomento
# molto interessante e complesso. Purtroppo non possiamo aggiungere dettagli
# ulteriori, ma vi invito a consultare il libro "The R Software" se volete
# leggere ulteriori dettagli.

# Per concludere riportiamo una citazione secondo me molto divertente:
# "The generation of random numbers is too important to be left to chance."
# — Robert R. Coveyou
