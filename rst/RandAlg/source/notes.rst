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

* Ein Spannbaum ist ein azyklischer Teilgraph eines Graphen G.
* Das Gewicht des Spannbaums wird als die Summe aller Kantengewichte definiert.
* Ist ein Graph nicht verbunden, so existiert kein Spannbaum.

Fuer einen nicht verbundenen Graphen ist deshalb das Konzept eines Spanwaldes
besonders interessant.

Ein Spannwald :math:`F` ist ein azyklischer Teilgraph eines Graphen G, der 
aus Disjunkten Baeumen in G besteht.
