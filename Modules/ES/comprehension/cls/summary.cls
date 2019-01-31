\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summary}

\LoadClass[titlepage]{article}

\RequirePackage[left=2cm, right=3cm, top=2cm, bottom=2cm]{geometry}
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
    \begin{Large}
        \\
        \\
        \@author
    \end{Large}\\
    \\
    \\
}
\titleformat{\section}{\Large\raggedright}{\thesection\ \ \ \ }{0em}{}[\rule{0.75\linewidth}{1pt}] 
\titleformat{\subsection}{\large\raggedright}{\thesubsection\ }{0em}{}
\titleformat{\subsubsection}{\small\raggedright}{\thesubsubsection\ }{0em}{}
