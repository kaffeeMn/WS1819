\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summary}

\LoadClass[titlepage]{article}

\RequirePackage[left=2cm, right=3cm, top=1.5cm, bottom=1.5cm]{geometry}
\RequirePackage{titlesec}

\renewcommand{\maketitle}{
    \ \\ 
    \begin{huge}
        \@title
    \end{huge}\\
    \begin{large}
        \\
        \@author
    \end{large}\\
    \\
}
\titleformat{\section}{\large\raggedright}{\thesection\ }{0em}{}[\rule{0.75\linewidth}{1pt}] 
\titleformat{\subsection}{\large\raggedright}{\thesubsection\ }{0em}{}
\titleformat{\subsubsection}{\large\raggedright}{\thesubsubsection\ }{0em}{}
