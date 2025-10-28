%%%% IDENTIFICATION %%%%
\NeedsTeXFormat{LaTeX2e}[2024-11-01]
\ProvidesClass{zhw-notes}[2025-10-07 v0.5 Document class for making notes, both for myself and to distribute to others.]

%%%% OPTIONS %%%%
\DeclareOption*{%
    \PackageWarning{zhw-notes}{Unknown option `\CurrentOption'}%
}
%Paper Size
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{book} \PassOptionsToClass{a4paper}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{book}}
%Font Size
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}
%One- or Two-Sided
\DeclareOption{oneside}{%
\PassOptionsToClass{oneside}{book}
\PassOptionsToPackage{margin=1in}{geometry}}
\newif\iffootmisc
\newif\ifbookman
\newif\ifgaramond
\newif\ifbembo
\newif\ifutopia
\newif\ifdfbf
\DeclareOption{twoside}{%
\PassOptionsToClass{twoside,openright}{book}
\PassOptionsToPackage{top=1in, bottom=1in, inner=0.5in, outer=3in, marginparwidth=2.5in, marginparsep=0.25in}{geometry}
\PassOptionsToPackage{side}{footmisc}
\PassOptionsToPackage{odd}{emptypage}
%Evil Font Size Hack---I need to find a better way of doing this
\footmisctrue
}
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
\ExecuteOptions{a4paper, 12pt, twoside, utopia}
\ProcessOptions\relax

\LoadClass{book}
\RequirePackage{footmisc}
\RequirePackage{geometry}
\RequirePackage{emptypage}

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

\iffootmisc
\let\oldfootnotesize\footnotesize
\renewcommand\footnotesize{\fontsize{7pt}{8.5pt}\selectfont}
\fi

%Handy values for figures and such
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}

%%%% TITLE %%%%
\newcommand{\@coursecode}{Course code}
\newcommand{\@semester}{Semester}
\newcommand{\@cademicyear}{20XX}
\newcommand{\em@il}{zed@zedhoffmanweldon.me}
\newcommand{\@license}{\copyright{} \@author. All rights reserved.}

\newcommand{\coursecode}[1]{\renewcommand{\@coursecode}{#1}}
\newcommand{\semester}[1]{\renewcommand{\@semester}{#1}}
\newcommand{\academicyear}[1]{\renewcommand{\@cademicyear}{#1}}
\newcommand{\email}[1]{\renewcommand{\em@il}{#1}}
\newcommand{\license}[1]{\renewcommand{\@license}{#1}}


\RequirePackage{fancyhdr}

\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}

\fancypagestyle{main}{%
    \fancyhead{}%
    \fancyfoot{}%
    \fancyhead[LE]{\oldfootnotesize\textit{\Chaptername}\quad\thepage}
    \fancyheadwidth[LE][r]{\headwidth}
}

%%%% ABSTRACT %%%%
\newsavebox{\abstractbox}
\if@titlepage
    \newenvironment{abstract}{%
    \global\setbox\abstractbox=\vtop\bgroup\oldfootnotesize%
    }{\par\egroup}
    \newcommand{\maketitlehookd}{%
    \par\vfil
    \box\abstractbox}
\fi

%%%% CHAPTERS AND SECTIONS %%%%
\RequirePackage{titlesec}
\setcounter{secnumdepth}{0}%Only number "chapters" (=weeks)
\titleformat{\chapter}[display]{\bfseries}{\normalsize\scshape{week \thechapter}}{0pt}{\large}[]
\titleformat{\section}[hang]{\large\scshape\MakeLowercase}{\thesection}{1em}{}[]
\ifdfbf
\titleformat{\subsection}[runin]{\itshape\normalsize}{\thesubsection}{1ex}{}[.]
\else
\titleformat{\subsection}[runin]{\bfseries\normalsize}{\thesubsection}{1ex}{}[.]
\fi
\RequirePackage{hyperref}

\def\drop{0.3\textheight}

\renewcommand{\maketitle}{%
\begin{titlepage}
    \pagestyle{empty}
    \null\vfil\par
    \vspace*{\drop}
    \raggedright
    {\normalsize\bfseries\scshape\MakeLowercase{\@coursecode}}\newline
    {\Huge\bfseries\@title}\\[2\baselineskip]
    {\Large\@author}\newline
    {\noindent\oldfootnotesize\href{mailto:\em@il}{\em@il}}\\[2\baselineskip]
    {\normalsize\@semester, \@cademicyear.}\\[2\baselineskip]
    \maketitlehookd
    \vfill\null
\end{titlepage}
\cleardoublepage
\setcounter{page}{1}
\pagestyle{main}
}

\AtBeginDocument{%
    \fancypagestyle{plain}[main]{}
}
