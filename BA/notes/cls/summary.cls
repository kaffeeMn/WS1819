\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summary}

\LoadClass[titlepage]{article}

\RequirePackage[left=2cm, right=3cm, top=2cm, bottom=2cm]{geometry}
\RequirePackage{titlesec}
%\RequirePackage{color}
\RequirePackage[dvipsnames]{xcolor}

\renewcommand{\maketitle}{
    \textcolor{CadetBlue}{
    \ \\
    \begin{Huge}
        \\
        \\
        \\
        \\
        \@title
    \end{Huge}\\
    }
    \begin{Large}
        \\
        \\
        \@author
    \end{Large}\\
    \\
    \\
}
\titleformat{\section}{\color{CadetBlue}\Large\raggedright}{\thesection\ \ \ \ }{0em}{}[\rule{0.75\linewidth}{1pt}] 
\titleformat{\subsection}{\color{CadetBlue}\large\raggedright}{\thesubsection\ }{0em}{}
\titleformat{\subsubsection}{\color{CadetBlue}\small\raggedright}{\thesubsubsection\ }{0em}{}
