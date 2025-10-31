%%%% IDENTIFICATION %%%%
\NeedsTeXFormat{LaTeX2e}[2024-11-01]
\ProvidesClass{zhw-handout}[2025-10-11 v0.2 Document class for making short handouts and syllabi, designed to fit visually with the zhw-notes class.]

%%%% OPTIONS %%%%
\DeclareOption*{%
    \PackageWarning{zhw-notes}{Unknown option `\CurrentOption'}%
}
%Paper Size
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{article} \PassOptionsToClass{a4paper}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{article}}
%Font Size
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
\newif\iffootmisc
\newif\ifbookman
\newif\ifgaramond
\newif\ifbembo
\newif\ifutopia
\newif\ifdfbf
\newif\ifsyllabus
\newif\ifcourse
\DeclareOption{twoside}{%
\PassOptionsToClass{twoside}{article}
\PassOptionsToPackage{top=1in, bottom=1in, inner=0.5in, outer=3in, marginparwidth=2.5in, marginparsep=0.25in}{geometry}
\PassOptionsToPackage{side}{footmisc}
%Evil Font Size Hack---I need to find a better way of doing this
\footmisctrue
}
\DeclareOption{oneside}{%
\PassOptionsToPackage{margin=1.5in}{geometry}
}
\DeclareOption{course}{\coursetrue}
\DeclareOption{syllabus}{\syllabustrue}
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

\LoadClass{article}
\RequirePackage{footmisc}
\RequirePackage{geometry}
\RequirePackage{hanging}

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
\let\@oldfootnotesize\footnotesize
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
\newcommand{\@building}{Building}
\newcommand{\cl@ssroom}{Room XXX}
\newcommand{\@schedule}{Mondays, 11:00-13:00}
\newcommand{\@license}{\copyright{} \@author. All rights reserved.}

\newcommand{\coursecode}[1]{\renewcommand{\@coursecode}{#1}}
\newcommand{\semester}[1]{\renewcommand{\@semester}{#1}}
\newcommand{\academicyear}[1]{\renewcommand{\@cademicyear}{#1}}
\newcommand{\email}[1]{\renewcommand{\em@il}{#1}}
\newcommand{\building}[1]{\renewcommand{\@building}{#1}}
\newcommand{\classroom}[1]{\renewcommand{\cl@ssroom}{#1}}
\newcommand{\schedule}[1]{\renewcommand{\@schedule}{#1}}
\newcommand{\license}[1]{\renewcommand{\@license}{#1}}

\newcommand{\thecoursecode}{\textsc{\MakeLowercase{\@coursecode}}}

\RequirePackage{fancyhdr}

\fancypagestyle{main}{%
    \fancyhead{}%
    \fancyfoot{}%
\if@twoside
    \fancyhead[LE]{\@oldfootnotesize\textit{\@title}\quad\thepage}
    \fancyheadwidth[LE][r]{\headwidth}
\else
    \fancyhead[R]{\@oldfootnotesize\textit{\@title}\quad\thepage}
    \fancyheadwidth[R][r]{\headwidth}
\fi
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

\ifsyllabus
\renewcommand*{\maketitle}{%
    {\noindent\large\scshape\MakeLowercase{\@coursecode}}\\
    {\Huge\bfseries\@title}\\[1em]
    {\Large\@author}\\
    \normalsize
    {\@oldfootnotesize\href{mailto:\em@il}{\em@il}}\\[1em]
    {\@semester, \@cademicyear. \@building, \cl@ssroom.\\
    \@schedule}
}
\else
\renewcommand{\maketitle}{%
\begingroup
    \thispagestyle{empty}
    \ifcourse{\noindent\large\scshape\MakeLowercase{\@coursecode}}\\ \fi
    {\Huge\bfseries\@title}\\[1em]
    {\Large\@author}\\
    \normalsize
    {\@oldfootnotesize\href{mailto:\em@il}{\em@il}}\\[1em]
    {\@semester, \@cademicyear.}
\endgroup
\setcounter{page}{1}
\pagestyle{main}
}
\fi

%%%% OPTION FOR SYLLABUS %%%%
\newcounter{week}

\newenvironment{week}[1][]{%
\refstepcounter{week}{\vspace{1em}\noindent\normalsize\scshape week~\theweek: \MakeLowercase{#1}}\vspace{1em}\addcontentsline{toc}{subsection}{\protect{Week \theweek: #1}}\par\begin{hangparas}{15pt}{1}}{%
\end{hangparas}}

\newenvironment{recommended}{%
\vspace{1ex}\noindent\@oldfootnotesize{\textit{Recommended}}\par\@oldfootnotesize\begin{hangparas}{15pt}{1}}{%
\end{hangparas}}

\AtBeginDocument{%
    \fancypagestyle{plain}[main]{}
}
