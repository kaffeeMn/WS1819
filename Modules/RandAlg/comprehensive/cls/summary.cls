\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summary}

\LoadClass[titlepage]{article}

\RequirePackage[left=2cm, right=2cm, top=2cm, bottom=2cm]{geometry}
\RequirePackage{titlesec}

\renewcommand{\maketitle}{
    \ \\
    \begin{Huge}
        \\
        \\
        \\
        \\
        \@title
    \end{Huge}\\
    \begin{large}
        \\
        \@author
    \end{large}\\
    \\
    \\
}
\titleformat{\section}{\large\raggedright}{\thesection\ }{0em}{}[\rule{0.75\linewidth}{1pt}] 
\titleformat{\subsection}{\large\raggedright}{\thesubsection\ }{0em}{}
