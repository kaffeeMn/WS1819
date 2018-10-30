Randomisierte Algorithmen Notizen
#################################

Table Of Contents
#################

10.3. Minimum Spanning Trees (Definitionen und Einleitung)
==========================================================

Grundlegendes
-------------

Allgemeine Definitionen zu Graphen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graphen werden wie ueblich als :math:`G=(V,E)`, mit einer Gewichtungsfunktion
:math:`w: E \rightarrow \mathbb{R}`.

Ferner definieren wir :math:`|V| = n, |E| = m` 

Spannbaum -/ Spannwald
^^^^^^^^^^^^^^^^^^^^^^

* Ein minimaler Spannbaum ist:
    + ein azyklischer Teilgraph eines Graphen G
    + der alle Knoten enthaelt
    + verbunden ist
    + und dessen Summe von Kantengewichten :math:`\sum_{e\in E_T} w(e)`
      minimal ist
* Das Gewicht des Spannbaums wird als die Summe aller Kantengewichte definiert.
* Ist ein Graph nicht verbunden, so existiert kein Spannbaum.

Fuer einen nicht verbundenen Graphen ist deshalb das Konzept eines Spanwaldes
besonders interessant.

|

Ein Spannwald :math:`F` ist ein azyklischer Teilgraph eines Graphen G, der 
aus Disjunkten Spannbaeumen fuer die verbundenen Komponenten in G besteht.
Isolierte Knoten sind Baeume der Groesse 1.

Der minimale Spannwald ist analog zum minimalen Spannbaum definiert.

|

Wir nehmen an, dass alle Kantengewichte einzigartig sind, daraus erfolgt immer
ein eindeutiger Spannbaum/-wald.

Bekannte Algorithem/ State of the art
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Das MSTP ist eines der am besten behandelten Probleme in combinatorischer 
Optimierung. Es gibt bereits viele Algorithmen zu diesem Problem. Die meisten
basieren auf einer "gierigen" Strategie und haben eine worst-case Laufzeit
von:

.. math::

    O(m*log(n))

Darunter fallen u.a. Boruvkas, Kruskals und Prims Algorithmen.

Der momentan beste deterministische Algorithmus hat die Laufzeit

.. math::
    
    O(m*log(n) * \beta(m,n))

wobei :math:`\beta = min\{i | log^{(i)}n \leq m/n\}`  und :math:`log^{(i)}`
die i-te Iteration von :math:`log` auf n ist.

Dieser Algorithmus ist also praktisch linear fuer fast alle praktischen 
Anwendungen, jedoch sind dessen Datenstrukturen kompliziert genug, das die 
simpleren Algorithmen mehr angewandt werden.

Verifikation
^^^^^^^^^^^^

Wir gehen davon aus, dass eine Black-Box gegeben sei, die bei Eingabe eines
Graphen G und eines Baums T verifiziert, ob T der/ ein minimaler Spannbaum von
G ist.

Dieser Black-Box Algorithmus ist deterministisch und linear.

Ferner werden Kanten zurueck gegeben, mit denen "verbesserungen", bzw. 
manipulationen an G, durchgefuehrt werden koennen, die das errechnen eines 
minimalen Spannbaums erleichtern.


10.3.2 Boruvkas Algorithmus
===========================

Boruvka Phasen
--------------

Idee
^^^^

Die Idee einer Boruvka-Phase ist es Kanten, die im MST vorkommen muessen je
Knoten zu kontraktieren.

Solche Kanten sind die, mit den minalen Kantengewichten je Knoten (siehe 10.11)

Kontraktion
^^^^^^^^^^^

Unter einer Kontraktion versteht man das verschmelzen von Knoten in einen 
einzigen Konten, der Die Kanten aller verschmolzenen Knoten enthaelt.

Jedoch werden Selbsschleifen nach der Kontraktion geloescht.

Ablauf
^^^^^^

1. Markiere fuer jeden Knoten die inzidente Kante mit dem kleinsten Gewicht.
2. ermittel die verbundenen Komponenten
3. ersetze jede Komponente durch einen einzelnen Knoten mittels Kontraktion
4. entferne die Selbstschleifen

Greedy Strategie
----------------

Boruvka-Phasen werden solange durchgefuehrt, bis nur noch ein Knoten bleibt.
Dabei ergeben die markierten Kanten den minimalen Spannbaum.

Es scheint offensichtlich, dass nach jeder Phase maximal noch :math:`n/2` Knoten
in G vorhanden sind.

Interessant ist, dass die markierten Kanten nach jeder Phase einen Wald ergeben,
der Teilgraph des MST ist. Diese Erkenntniss wird uns spaeter nuetzlich sein.

Excercises
----------

10.10
^^^^^
:math:`\text{Sei } v \in V \text{ ein beliebiger Knoten in } G.`
:math:`\text{Zeige, dass der MST von } G \text{ die minimal gewichtete Kante }`
:math:`(v,w) \in E , w \in V \text{ enthalten muss.}`

|

Annahme MST muss die Kante nicht enthalten:

1. Fall e=:math:`(v,w)` ist die einzige Kante von v:
Dann muss e im MST vorkommen, da sonst der MST nicht vollstaendig ist.
Daraus folgt ein Widerspruch fuer diesen Fall.

2. Fall v hat mehr Kanten:
Dann muesste im MST mindestens eine andere Kante inzident zu v enthalten sein.
Dessen Kantengewicht waere groesser, als das von e.

Der MST wuerde also alle Knoten bereits verbinden. v ist also von w
bereits erreichbar und umgekehrt. sei :math:`z_1, \ldots, z_k` der Pfad
von v nach w. Entfernen wir die Kante :math:`z=max{z_1,z_k}` und erstzen sie 
Durch e, so haben wir eine Kante mit groesseren Gewicht, als das von e
ersetzt. Ferner haben wir keinen Zyklus geschaffen, da zuvor nur ein Pfad von
v nach w im "MST" existiert haben kann und der Pfad lediglich umgeleitet wurde.
Des Weiteren sind v, w und alle anderen Knoten auf dem Pfad nach wie vor 
erreichbar.
Damit war der "MST" nicht minimal.
Daraus folgt ein Widerspruch fuer diesen Fall.

Durch Widerspruch folgt, dass der MST die Minimale Kante eines jeden Knoten
enthalten muss.

10.11
^^^^^

:math:`\text{Zeige, dass eine Boruvka-Phase in } O(m+n)`
:math:`\text{ umgesetzt werden kann}`

1. :math:`\forall v \in V`:
2. :math:`\ \ \ \ e = \{v,w\} = min\ adj(v)`
3. :math:`\ \ \ \ V_T = V_T \cup \{w\}`
4. :math:`\ \ \ \ E_T = E_T \cup \{e\}`
5. :math:`\forall v \in V_T`:
6. :math:`\ \ \ \ \text{}` kontraktiere v mit allen adjazenten Knoten aus T in G

10.12
^^^^^

:math:`\text{Zeige, dass die waehrend einer Boruvka-Phase markierten Kanten }`
:math:`\text{einen Wald in G aufspannen}`

Zu zeigen ist, dass eine verbunde Komponente Ein Baum ist, bzw. azyklisch.
Minimale Kanten sind eindeutig, da jedes Kantengewicht nur einmal genutzt wird.
Damit ein Zyklus entstehen wuerde muesste ein Knoten Zwei einen Pfad schliessen,
in dem er mindestens eine zusaetzliche Kante nimmt. Dessen Kantengewicht muesste
kleiner, als das der bereits inzidente, markierte Kante sein.

Dadurch, dass alle Kantengewichte nur einmal vorkommen wird entweder ein Pfad/
eine Komponente geschlossen, indem Zwei Knoten eine minimale Kante teilen, oder
der adjazente Knoten hat eine kleinere minimale Kante. 

Ein alternativer Pfad zu dem Knoten mit der schwereren Kante ist also nicht 
moeglich.

10.13
^^^^^

Sei G' der Graph von G nach einer Boruvka Phase. Zeige, dass der MST von G die
Vereinigung der markierten Kanten (der kontraktierten Kanten) mit dem MST von G'
ist.

In 10.10 wurde bereits gezeigt, dass der MST von G alle minimalen Kanten je 
Knoten enthalten muss. Das sind die markierten Kanten.
Nach 10.12 Ist G' ein Wald in G. Damit G' nun also ein MST sein soll muessen
alle verbundenen Komponenten miteinander verbunden werden. 

(i) Dabei darf kein Zyklus entstehen. Deshalb koennen Kanten, die zu solchen Zyklen
fuehren, also Knoten einer jeweiligen Komponenten untereinander Verbinden,
ignoriert werden.
Dies wird durch das loeschen der Selbstschleifen in der 
Boruvka-Phase umgesetzt.
Die Kanten aus G' sind genau die Kanten der jeweiligen verbundenen 
Komponente Die also im MST sind (10.10) und keine Zyklen verursachen. Restliche
Kanten der Komponente untereinander werden also wie bereits gesagt ignoriert.
Das bedeutet insbesondere, dass aus G' nur Kanten geloescht wurden, die nicht
im MST vorkommen koennten, da sie Zuklen induzieren.

Die Darstellung eines Graphen von Komponenten ohne Zyklen und Knoten ohne 
Selbstschleifen die alle aus- und eingehenden Kanten der jeweiligen Komponente
haben ist nun also analog hinsichtlich der Kanten 
:math:`E_{MST-Rest} = E_{MST} - E_{G'-marked}`.

Ferner sind :math:`E_{MST-Rest}` genau die Kanten die die Komponenten zu einem
minimalen Spannbaum verbinden,
da nach 10.10 alle markierten Kanten aus G' im MST enthalten sein muessen, nach 
(i) keine Kanten geloescht wurden, die im MST vorkommen koennten und G' keine 
Knoten geloescht kontraktiert hat, die nicht bereits im MST verbunden waeren.

10.3.2 Schwere Kanten und die Verfikation eines MST
===================================================

Idee: Randomisierte Stichproben
-------------------------------

Wir werden Randomisierung benutzen um die Laufzeit zu verbessern, jedoch muessen
wir erst erfassen, was die Randomisieung bezwecken soll. Dazu fuehren wir die
Begriffe der F-schweren und -leichten Kanten ein.

F-schwere/ -leichte Kanten
--------------------------

Wir betrachren einen Wald F in G. Fuer Knoten :math:`u,v`, die in der selben
verbundenen Komponente/ Baum wenden wir nun folgende Funktion an und deuten
deren Werte hinsichtlich eines minimalen Spannbaums:

.. math::
    
    w_F(u,v) = \begin{cases}
                    \infty, P(u,v) = \emptyset\\
                    max\{P(u,v)\}, \text{sonst}
               \end{cases}

, wobei P(u,v) alle Kanten des Pfades von u nach v ausgibt

|

Wir definieren Ferner Kanten als F-schwere Kanten als :math:`w(u,v) > w_F(u,v)`
und F-leichte Kanten als :math:`w(u,v) \leq w_F(u,v)`

Verbessernde Kanten
^^^^^^^^^^^^^^^^^^^

Aus 10.14 folgt, dass eine Kante, die F-schwer ist nicht im MST liegt, der
Umkehrschluss gilt jedoch nicht.

Eine Kante verbessert einen Wald, wann das Hinzufuegen dieser Kante entweder
die Anzahl an Baeumen im Wald reduziert oder das Entfernen der schwersten Kante 
im entstandenen Zyklus das gewicht des Waldes reduziert.

Exercises
---------

10.14
^^^^^

10.3.3 Randomisierte Stichproben
================================

randomisierte Graphen
---------------------

Lemma zur Guete der Randomisierten Stichproben
----------------------------------------------

Execises
--------

10.15
^^^^^
