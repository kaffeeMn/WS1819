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

Es folgt, dass eine F-leichte Kante den Wald verbessern kann, eine F-schwere
nicht.

Es ist moeglich auf dieser Erkenntnis einen Greedy-Algorithmus aufzubauen, der 
die Kanten sortiert und mit einem Leerem Wald startet. (Kruskal)

Verifikation
------------

Aufbauend auf den Erkenntnissen zu F-leichten Kanten laesst sich ein recht 
einfacher Verfikationsalgorithmus bauen, der als Eingaben einen Baum T und einen
einen Graph G bekommt und dann testet, ob die einzigen T-leichten Kanten auch in 
T sind.
Es gibt Algorithmen, die dies in O(m+n) bewerstelligen und/ oder sogar alle 
F-schweren und -leichten Kanten in HInsicht zu jedem Wald F ermitteln koennen.

Exercises
---------

10.14
^^^^^
:math:`\text{Sei } F \text{ ein beliebiger Baum in einem Graphen } G.`
:math:`\text{Zeige, dass F-schwere Kanten nicht im MST enthalten sind und dass}`
:math:`\text{der Umkehrschluss nicht wahr ist.}`

Existiert eine F-schwere Kante (u,v), so gelten zwei Eigenschaften in F.

1. Es existiert ein Pfad zwischen u und v in F, bzw. u und v sin bereits 
   verbunden und es existiert kein Zyklus
2. Jede Kante auf diesem Pfad ist leichter als die Kante (u,v)

Das hinzufuegen der Kante wuerde also weder eine Zusammenhaengende Komponente um
einen Knoten erweitern (1.), noch das Gewicht des Baumes verkleinern, da durch
das hinzufuegen der Kante ein Zyklus entstehen wuerde und eine andere, leichtere
Kante entfernt werden muesste.

Ein Gegenbeispiel fuer den Umkehrschluss waere ein nicht eindeutiger MST. Hier
koennten auch Kanten, die nicht im MST sind gleichen MST-leicht durch
:math:`w(e_1) = w_F(e_1), P(e_1) = (e_2,e_3), w(e_1) = w(e_2) > w(e_3)`
, mit zwei gleich gewichteten Kanten :math:`e_1, e_2` sein.

10.3.3 Randomisierte Stichproben
================================

Randomisierte Graphen
---------------------

Wir bezeichnen mit :math:`G(p)` den Graphen der jede in G enthaltene Kante 
unabhaengig mit der Wahrscheinlichkeit p enthaelt.

:math:`G(p)` hat damit n Knoten und erwartete m*p Kanten. Es existiert 
insbesondere keine Garantie, das G(p) verbunden ist.

Approximation durch Spannwaelder
--------------------------------

F sei der minimale Spannwald von G(p).
Intuitiv sind wenige Kanten aus G F-leicht und F approximiert den MST von G 
hinreichend gut fuer ein moderat gewaehltes p.

Wahrsheinlichkeitstheorie zur Intuition
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hier wiederholen wir nocheinmal ein paar Grundlagen der 
Wahrscheinlichkeitstheorie, die wir zum Verstaendnis des folgenden Lemma 
benoetigen.

Eine Zufallsvariable :math:`X` hat die negative Binomialverteilung mir parametern n 
und p, wenn sie korrespondierend zu der Anzahl unabhaengiger Versuche fuer
n erfolge ist, wobei jeder Versuch eine Erfolgswahrscheinlichkeit von p hat.
Mit anderen Worten der Erwartungswert von X ist :math:`n/p`.

Eine Zufallsvariable X dominiert ein andere Y, wenn gilt:

.. math::
    \forall z \in \mathbb{R}: Pr[X > z] \geq Pr[Y > z]

Ferner sei gegeben, dass wenn X Y domniert, so gilt auch :math:`E[X] \geq E[Y]`

Lemma zur Guete der Randomisierten Stichproben
----------------------------------------------

kurz:

Sei F der MSF von G(p), dann ist die Anzahl an F-leichten Kanten in G
definiert durch die Zufallvariable X, wobei X die negative Binomialverteilung
mit parametern n un dp hat. Also hat G einen Erwartungswert von hoechstens
n/p F-leichten Kanten

Beweis
^^^^^^

Wir betrachten Alle Kanten von G nach ihren **Gewichten aufsteigend sortiert**.

Nun konstruieren wir G(p), indem diese **Kanten** in ihrer sortierten Reihenfolge 
betrachten und mit der Wahrscheinlichkeit **p=0,5 inkludieren**, bzw. wenn wir eine
Muenze werfen und diese auf Kopf landet.

Der minimale Spannwald F **(MSF)** kann dabei "online" konstruiert werden.
Dazu koennen wir an **Kruskals** Algorithmus angelehnt einen leeren Wald 
initialisieren und Kanten 
:math:`e_i = (u_i,v_i)`
die in G(p) aufgenommen werden genau dann in 
den Wald inkludieren, wenn ihre Endpunkte :math:`u_i` und :math:`v_i` zu 
zwei unterschliedlichen verbundenen Komponenten gehoeren.

Durch die Ordnung der Kanten und der daraus resultierenden Betrachtungsreihenfolge
koennen wir folgende Aussage Treffen:
**Eine Kannte aus G ist zum Zeitpunkt ihrer Betrachtung genau dann F-leicht, 
wenn deren Knoten in zwei 
verschiedenen verbundenen Komponenten in F liegen**

|

Was sind hierbei die entscheidenden Beobachtungen?

1. Ob eine Kante :math:`e_i` F-leicht ist oder nicht ist alleinig von den 
   vorhegehenden Zufallsexperimenten (Muenzwuerfe) abhaengig.
2. Keine Kanten werden aus F entfernt.
3. Eine Kante :math:`e_i` ist nach dem i-ten Experiment F-leicht, genau dann wenn
   sie zu Beginn des i-ten Experiments F-leicht ist.

|

Neben den Iterationen/ Zuafallsexperimenten moechten wir nun noch **"Phasen"**
einfuehren. Eine Phase k beginnt, sobald F k-1 Kanten hat und endet 
dementsprechend nach Hinzunahme der k-ten Kante.
Wir behandeln nun also die Anzahl an Iterationen/ Zufallsexperimenten, bis eine
Kante **in F** hinzugenommen wird.

*(Ferner sind F-schwere Kanten fuer uns hier irrelevant)*

Jede F-leichte Kante hat ferner die Wahrscheinlichkeit p um in F inkludiert zu
werden. Aus unserer Definition von Phasen folgt insbesondere fuer jede Phase,
dass sie endet, wenn eine F-leichte kante hinzugenommen wird. In anderen Worten:

*Eine Phase endet genau dann, wenn eine F-leichte Kannte zum ersten mal in dieser
Phase hinzugenommen wird.* (Nur F-leichte Kanten werden hinzugenommen)

Daraus folgt auch, dass die Anzahl von F-leichten Kanten, die waehrend einer 
Phase betrachtet werden die geometrische Verteilung hat. 
*(Erwartungswert von* :math:`(1-p)^k*p` *)*

Die Groesse des Waldes F sei s nach allen Iterationen/ Zufallsexperimenten.
Die Anzahl aller betrachteten F-leichten Kanten bis zum ende der s-ten Phase
ist dann die Summe aller unabhaengigen geometrisch verteilten Zufallsvariablen,
je mit dem Parameter p.
Um die Kanten die nach der s-ten Phase betrachtet wurden aber nicht gewaehlt
wurden zu kompensieren fuer wir solange weitere Zufallsexperimente durch, bis
n mal "Kopf" erschienen ist.

Die Anzahl an Zufallsexperimenten ist ein Zufallsvariable :math:`X_{coinflips}`
mit negativer Binomialverteilung und den paramtern n, p.

Da s kleinergleich n-1 ist, folgt, dass die Anzahl an F-leichten Kanten durch 
:math:`X_{coinflips}` stochastisch dominiert ist.

Damit ist die erwartete Anzahl an F-leichten Kanten von oben beschraenkt durch
:math:`Pr[X_{coinflips}] = n/p`.

Execises
--------

10.15
^^^^^
:math:`X \text{ habe die negative Binomialverteilung mit paramatern } n_1,p.`
:math:`Y \text{ habe die negative Binomialverteilung mit paramatern } n_2,p.`
:math:`\text{Zeige, dass } X Y \text{ stochastisch dominiert, wenn } n_1 \geq n_2.`

Widerspruch unter nutzen von

.. math::
    \forall z \in \mathbb{R}: Pr[X > z] \geq Pr[Y > z]


10.3.4 Der Linearzeit MST Algorithmus
=====================================

Die Idee ist durch Boruvka-Phasen Knoten zu reduzieren und durch Stichproben
Kanten zu reduzieren.

Der Algorithmus gibt einen MSF und keinen MST zurueck


Algorithmus
-----------

**MST**

Eingabe: G (Gewichtet und ungerichtet)

Ausgabe: MSF fuer G

1. :math:`G_1, C = \text{ 3 Boruvka-Phasen auf G}`
2. :math:`G_2 = G_1(p=0,5)`
3. :math:`F_2 = MST(G_2)`
4. :math:`G_3 = (V_{G1}, E_{G1} - E_{F2-heavy})`
5. :math:`F_3 = MST(G_3)`
6. :math:`\text{return } C \cup F_3`
