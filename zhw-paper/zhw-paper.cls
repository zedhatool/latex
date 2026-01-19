%%%% IDENTIFICATION %%%%
\NeedsTeXFormat{LaTeX2e}[2024-11-01]
\ProvidesClass{zhw-paper}[2026-01-18 v0.1 Document class that styles papers in a way that I like]

%%%% OPTIONS %%%%
\DeclareOption*{%
    \PackageWarning{zhw-paper}{Unknown option `\CurrentOption'}%
}
%Paper Size
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{article} \PassOptionsToClass{a4paper}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{article}}
\DeclareOption{doublespacing}{%
\AtBeginDocument{\doublespacing}
}
%Font Size
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
%Fonts
\newif\ifbookman
\newif\ifgaramond
\newif\ifbembo
\newif\ifutopia
\newif\ifdfbf
\newif\ifcoursepaper
\DeclareOption{coursepaper}{\coursepapertrue}
\DeclareOption{utopia}{\utopiatrue}
\DeclareOption{bembo}{\bembotrue}
\DeclareOption{garamond}{\garamondtrue}
\DeclareOption{bookman}{\bookmantrue}
\newcommand{\textdf}[1]{\textit{#1}}
\DeclareOption{dfbf}{%
\renewcommand{\textdf}[1]{\textbf{#1}}
\dfbftrue
}
%Executing Options
\ExecuteOptions{a4paper, 12pt, utopia}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{setspace}
\RequirePackage[no-math]{fontspec}
\ifutopia
\setmainfont[Numbers={Proportional, OldStyle}]{Erewhon}
\setsansfont{Cabin}[scale=MatchUppercase]
\fi
\ifbembo
\setmainfont[Numbers={Proportional, OldStyle}]{fbb}
\setsansfont{Cabin}[scale=MatchUppercase]
\fi
\ifgaramond
\setmainfont[Numbers={Proportional, OldStyle}]{EBGaramond}
\setsansfont{Linux Biolinum O}[scale=MatchUppercase]
\fi
\ifbookman
\setmainfont[Numbers={Proportional, OldStyle}]{TeX Gyre Bonum}
\setsansfont{Verdana}[scale=MatchUppercase]
\fi
\setmonofont{Latin Modern Mono}[scale=MatchLowercase]

\RequirePackage[tracking]{microtype}

%%%% TITLE %%%%
\newcommand{\@coursecode}{Course Code}
\newcommand{\coursecode}[1]{\renewcommand{\@coursecode}{#1}}
\newcommand{\thecoursecode}{\textsc{\MakeLowercase{\@coursecode}}}

\RequirePackage{fancyhdr}
\fancypagestyle{main}{%
    \fancyhead{}%
    \fancyfoot{}%
    \fancyhead[L]{\ifnum\thepage=1 {}\else\itshape{\thecoursecode---\@title}\fi}
    \fancyhead[R]{\ifnum\thepage=1 {}\else\thepage\fi}
}

\renewcommand*{\maketitle}{%
    \pagestyle{main}
    {\raggedright
    {\bfseries\thecoursecode}\\
    {\Large\bfseries\@title}\\
    {\normalsize\normalfont\@author}\\
    {\normalsize\normalfont\@date}}\par
}

%%%% CHAPTERS AND SECTIONS %%%%
\RequirePackage{titlesec}
\setcounter{secnumdepth}{0}
\titleformat{\section}[hang]{\large\scshape\MakeLowercase}{\thesection}{1em}{}[]
\ifdfbf
\titleformat{\subsection}[runin]{\itshape\normalsize}{\thesubsection}{1ex}{}[.]
\else
\titleformat{\subsection}[runin]{\bfseries\normalsize}{\thesubsection}{1ex}{}[.]
\fi

\RequirePackage{hyperref}
