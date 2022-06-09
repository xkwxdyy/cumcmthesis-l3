\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cumcmthesis}[2022/03/11 v1.0 Standard LaTeX Template for CUMCM]
\LoadClass[a4paper,12pt]{article}




\ExplSyntaxOn

\RequirePackage
{
  ctex       ,     tabularx    ,   amsmath      ,
  amsfonts   ,     amssymb     ,   bm           ,
  tikz       ,     graphicx    ,   float        ,
  array      ,     longtable   ,   booktabs     ,
  multirow   ,     bigstrut    ,   bigdelim     ,
  listings   ,     url         ,   subcaption   ,
  enumitem   ,     etoolbox    ,   hyperref     ,
  cleveref   ,
}

\RequirePackage[titles]{tocloft}
\RequirePackage[titletoc,title]{appendix}

\prop_const_from_keyval:Nn \l_cumcm_theorem_prop
{
  definition   =   定义,
  theorem      =   定理,
  lemma        =   引理,
  corollary    =   推论,
  assumption   =   假设,
  conjecture   =   猜想,
  axiom        =   公理,
  principle    =   定律,
  problem      =   问题,
  example      =   例, 
  proof        =   证明,
  solution     =   解
}
\prop_map_inline:Nn \l_cumcm_theorem_prop 
{
  \newtheorem{#1}{#2}
}


\sys_if_engine_xetex:F
{
  \msg_error:nn{cumcmthesis}{unsupported-engine}
}
\clist_map_inline:nn
{
  tihao        ,
  baominghao   ,
  schoolname   ,  
  supervisor   ,
  year         ,
  month        ,
  day          ,
  title        ,
}
{
  \tl_clear_new:c{l_cumcm_#1_tl}
}
\clist_new:N \l_cumcm_member_clist
\keys_define:nn{cumcm/info}
{
  tihao.tl_set:N        =      \l_cumcm_tihao_tl        ,
  baominghao.tl_set:N   =      \l_cumcm_baominghao_tl   ,
  schoolname.tl_set:N   =      \l_cumcm_schoolname_tl   ,
  supervisor.tl_set:N   =      \l_cumcm_supervisor_tl   ,
  year.tl_set:N         =      \l_cumcm_year_tl         ,
  year.initial:V        =      \c_sys_year_int          ,
  month.tl_set:N        =      \l_cumcm_month_tl        ,
  month.initial:V       =      \c_sys_month_int         ,
  day.tl_set:N          =      \l_cumcm_day_tl          ,
  day.initial:V         =      \c_sys_day_int           ,
  member.clist_set:N    =      \l_cumcm_member_clist    ,
  title.tl_set:N        =      \l_cumcm_title_tl        ,
}

\bool_new:N \l_cumcm_preface_bool
\keys_define:nn{cumcm}
{
  info.meta:nn     =     {cumcm/info}{#1},
  preface.bool_set:N = \l_cumcm_preface_bool ,
  preface.initial:n  = true  ,
}
\NewDocumentCommand{\cumcmsetup}{+m}
{
  \keys_set:nn{cumcm}{#1}
}

\msg_new:nnn{cumcmthesis}{unsupported-engine}
{
  you~must~use~`xelatex`,Just~choose~`xelatex',~no~`pdflatex'~or~`latex'~and~so~on.
}


\RenewDocumentCommand{\maketitle}{}
{
  \bool_if:NTF \l_cumcm_preface_bool 
  {
    \__cumcm_commit:
    \__cumcm_numberpage: 
  }
  {
    \par
    \newpage
    \setcounter{page}{1}
    {\centering \zihao{3}\bfseries
    \tl_use:N \l_cumcm_title_tl
    \par}
    \vspace*{1ex}
  }
}

\cs_new:Npn \__cumcm_define_commit_const:nn#1#2
{
  \tl_const:cn{l_cumcm_commit_#1_tl}{#2}
} 
\clist_map_inline:nn
{
  {headname}{赛区评阅编号（由赛区组委会填写）：},
  {titlea}{高教社杯全国大学生数学建模竞赛},
  {titleb}{承\hspace{1em}诺\hspace{1em}书},
  {contents}{我们仔细阅读了《全国大学生数学建模竞赛章程》和《全国大学生数学建模竞赛参赛规则》（以下简称 “竞赛章程和参赛规则”，可从http://www.mcm.edu.cn下载）。\par 
  我们完全清楚，在竞赛开始后参赛队员不能以任何方式，包括电话、电子邮件、“贴吧”、QQ群、微信群等，与队外的任何人（包括指导教师）交流、讨论与赛题有关的问题；无论主动参与讨论还是被动接收讨论信息都是严重违反竞赛纪律的行为。\par 
  我们完全清楚，在竞赛中必须合法合规地使用文献资料和软件工具，不能有任何侵犯知识产权的行为。否则我们将失去评奖资格，并可能受到严肃处理。\par 
  {\bfseries\song 我们以中国大学生名誉和诚信郑重承诺，严格遵守竞赛章程和参赛规则，以保证竞赛的公正、公平性。如有违反竞赛章程和参赛规则的行为，我们将受到严肃处理。}\par 
  我们授权全国大学生数学建模竞赛组委会，可将我们的论文以任何形式进行公开展示（包括进行网上公示，在书籍、期刊和其他媒体进行正式或非正式发表等）。
  },
  {problemnum}{我们参赛选择的题号（从A/B/C/D/E中选择一项填写）：},
  {signupnum}{我们的报名参赛队号（12位数字全国统一编号）：},
  {schoolname}{参赛学校（完整的学校全称，不含院系名）：},
  {membername}{参赛队员 (打印并签名) ：},
  {supervisorname}{指导教师或指导教师组负责人(打印并签名)：},
  {zsxing}{指导教师签名意味着对参赛队的行为和论文的真实性负责},
  {inform}{\noindent{（\bfseries\kai 请勿改动此页内容和格式。此承诺书打印签名后作为纸质论文的封面，注意电子版论文中不得出现此页。以上内容请仔细核对，如填写错误，论文可能被取消评奖资格。）}}
}
{
  \__cumcm_define_commit_const:nn#1
}

\cs_new:Npn \__cumcm_define_numberpage_const:nn#1#2
{
  \tl_const:cn{l_cumcm_numberpage_#1_tl}{#2}
} 

\clist_map_inline:nn
{
  {headname}{赛区评阅编号：},
  {headnameb}{（由赛区填写）},
  {allcountrynum}{全国评阅编号：},
  {allcountrynumb}{（全国组委会填写）},
  {titlea}{高教社杯全国大学生数学建模竞赛},
  {titleb}{编\hspace{.5em}号\hspace{.5em}专\hspace{.5em}用\hspace{.5em}页},
  {appraiselog}{赛区评阅记录（可供赛区评阅时使用）：},
  {countrynum}{送全国评阅统一编号:\par \hspace*{2em}（赛区组委会填写）},
  {inform}{\noindent（{\bfseries\kai 请勿改动此页内容和格式。此编号专用页仅供赛区和全国评阅使用，参赛队打印后装订到纸质论文的第二页上。注意电子版论文中不得出现此页。}）}
}
{
  \__cumcm_define_numberpage_const:nn#1
}


\cs_new:Npn \__cumcm_commit:n #1
{
  \tl_use:c {l_cumcm_commit_#1_tl}
}
\cs_new:Npn \__cumcm_numberpage:n #1
{
  \tl_use:c {l_cumcm_numberpage_#1_tl}
}






\cs_new:Npn \__cumcm_commit:
{
  \newpage
  \vspace*{2ex}

  \thispagestyle{empty}
  {\zihao{4}\noindent   
  \__cumcm_commit:n{headname}  \\[-8pt]
  \noindent\rule[5pt]{\dim_eval:n{\textwidth-1.34em}}{.5pt}\par}
  \begin{center}
    {\zihao{-3}\bfseries\heiti
    {\the\year \__cumcm_commit:n{titlea} }\par}
    {
      \vspace*{1ex}
    
    \zihao{3}\bfseries\songti \__cumcm_commit:n{titleb} \par}
  \end{center}\par 
  {\zihao{-4} \__cumcm_commit:n{contents} \par}
  {
    \vspace*{5ex}\zihao{-4}
    \__cumcm_commit:n{problemnum}
    \CJKunderline{\hspace*{1em}\tl_use:N \l_cumcm_tihao_tl\hfill}\makebox[0.66em]{}\par 
    \__cumcm_commit:n{signupnum}
    \CJKunderline{\hspace*{1em}\tl_use:N\l_cumcm_baominghao_tl\hfill}\makebox[0.66em]{}\par 
    \__cumcm_commit:n{schoolname}
    \CJKunderline{\hfill\tl_use:N\l_cumcm_schoolname_tl\hfill}\makebox[0.66em]{}\par 
    \box_new:N \l_cumcm_member_box 
    \hbox_set:Nn \l_cumcm_member_box
    {\__cumcm_commit:n{membername}\mbox{\hspace{1em}}1.}
    \__cumcm_commit:n{membername}
    \begin{minipage}[t]{\dim_eval:n{\textwidth - \box_wd:N \l_cumcm_member_box}}
      1.\CJKunderline{\hspace*{1em}\clist_item:Nn \l_cumcm_member_clist{1}\hfill}\makebox[0.46em]{}\par
      2.\CJKunderline{\hspace*{1em}\clist_item:Nn \l_cumcm_member_clist{2}\hfill}\makebox[0.46em]{}\par
      3.\CJKunderline{\hspace*{1em}\clist_item:Nn \l_cumcm_member_clist{3}\hfill}\makebox[0.46em]{}\par
    \end{minipage}\par\vspace*{1ex}
    \__cumcm_commit:n{supervisorname} \CJKunderline{\hspace*{1em}\tl_use:N\l_cumcm_supervisor_tl\hfill}\makebox[0.66em]{}\par 
    \hspace{0.1cm} （{\kaishu \__cumcm_commit:n{zsxing}}）\par 

  \vspace*{2ex}

  \hfill 日期：\CJKunderline{\hspace*{1em}\tl_use:N\l_cumcm_year_tl\hspace*{1em}}年 \CJKunderline{\tl_use:N \l_cumcm_month_tl}月\CJKunderline{\tl_use:N \l_cumcm_day_tl}日 \makebox[1em]{}\par 
  }
  \vspace*{1ex}
  {\kaishu\bfseries
  \__cumcm_commit:n{inform}
  \par}
  \vfill
}

\cs_new:Npn \__cumcm_numberpage:
{
  \newpage
  \thispagestyle{empty}
  {\zihao{4}\noindent\begin{tabularx}{\textwidth}{cXcX@{}}
    \__cumcm_numberpage:n{headname} & & \__cumcm_numberpage:n{allcountrynum}& \\[-5pt]
    \__cumcm_numberpage:n{headnameb} & & \__cumcm_numberpage:n{allcountrynumb}&\\
    \cline{2-2}\cline{4-4}
    \end{tabularx}\par 

    \vspace*{1.2em}

  \noindent\rule{\textwidth}{1pt}\par
  }
  \begin{center}
    {\zihao{4}\bfseries\heiti 
    \the\year \__cumcm_numberpage:n{titlea}
    \par}
    {\vskip1ex\zihao{3}\songti\bfseries
    \__cumcm_numberpage:n{titleb}
    \par}
  \end{center}\par
  {\zihao{4}
  \vspace*{3ex}
  \hspace*{2em} \__cumcm_numberpage:n{appraiselog} \par 
  \hspace*{1.5em}
  \newcolumntype{P}{@{}p{\dim_eval:n{(\textwidth - 8.72em)/6 }}@{}}
  \begin{tabular}
    {|!{\hspace{4pt}}c!{\hspace{4pt}}|*{6}{P|}}
    \hline 
    \rule{0pt}{5em}\raisebox{0.6em}[0pt][0pt]{\shortstack{评\\ 阅\\ 人}} & & & & & &  \\\cline{1-7}
    \rule{0pt}{4em}\raisebox{0.6em}[0pt][0pt]{\shortstack{备\\ 注}} & & & & & &  \\
    \hline   
  \end{tabular}\par 
  \vspace*{5em}
  \hspace*{2em}\__cumcm_numberpage:n{countrynum}
  }
  \vfill
  {\zihao{-4}\kaishu\bfseries
  \__cumcm_numberpage:n{inform}
  }
  \par
  \newpage
  \setcounter{page}{1}
  {\centering \zihao{3}\bfseries
  \tl_use:N \l_cumcm_title_tl
  \par}
  \vspace*{1ex}
}

\NewDocumentCommand{\keywords}{+m}
{
  \par
	\vspace*{1ex}
  {\noindent\zihao{-4}\heiti 关键词：}~{#1}
}
\ExplSyntaxOff
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}} 
\RequirePackage{geometry}
\geometry{top=25mm,bottom=25mm,left=25mm,right=25mm}
\setCJKfamilyfont{kai}[AutoFakeBold]{KaiTi}
\newcommand*{\kai}{\CJKfamily{kai}}
\setCJKfamilyfont{song}[AutoFakeBold]{SimSun}
\newcommand*{\song}{\CJKfamily{song}}

\setmainfont{Times New Roman}
\setsansfont{Arial}


\renewcommand*{\topfraction}{0.9}
\renewcommand*{\bottomfraction}{0.8}
\renewcommand*{\floatpagefraction}{0.85}


\DeclareCaptionFont{song}{\songti}
\DeclareCaptionFont{minusfour}{\zihao{-4}}
\captionsetup[figure]{%
	format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
	labelsep=quad, % 分隔符是一个空格
	font={song,minusfour,bf}, % 图的字体, 宋体小四
	position=bottom % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
\captionsetup[table]{%
	format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
	labelsep=quad, % 分隔符是一个空格
	font={song,minusfour,bf}, % 表的字体, 宋体小四
	position=top % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
% 列表环境设置
\setlist{%
	topsep=0.3em, % 列表顶端的垂直空白
	partopsep=0pt, % 列表环境前面紧接着一个空白行时其顶端的额外垂直空白
	itemsep=0ex plus 0.1ex, % 列表项之间的额外垂直空白
	parsep=0pt, % 列表项内的段落之间的垂直空白
	leftmargin=1.5em, % 环境的左边界和列表之间的水平距离
	rightmargin=0em, % 环境的右边界和列表之间的水平距离
	labelsep=0.5em, % 包含标签的盒子与列表项的第一行文本之间的间隔
	labelwidth=2em % 包含标签的盒子的正常宽度；若实际宽度更宽，则使用实际宽度。
}

% 超链接
	 \hypersetup{%
%         xetex,
		% unicode=false, % hyperref 和 xetex 同时使用时不能开启 Unicode 选项.
         pdfstartview=FitH,
         CJKbookmarks=true,
         bookmarksnumbered=true,
         bookmarksopen=true,
         colorlinks, %注释掉此项则交叉引用为彩色边框(将colorlinks和pdfborder同时注释掉)
         pdfborder=001,   %注释掉此项则交叉引用为彩色边框
		 allcolors=black,
		 breaklinks=true}%
% \if@mcm@bwprint
% \AtBeginDocument{\hypersetup{hidelinks}}
% \else\relax\fi
\pdfstringdefDisableCommands{%
	\def\cftdotfill{ }%
}
\lstnewenvironment{tcode}
  {
    \lstset{basicstyle = \small\ttfamily,
        language=TeX,
        tabsize = 4,
        frame = single,
        escapechar = `,
        breaklines = true,
        breakatwhitespace = true,
        frameround = tttt,
    }
  }
  {}
%%% crefformat settings

\crefformat{figure}{#2图~#1#3}
\crefrangeformat{figure}{图~(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{figure}{图~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\crefformat{table}{#2表#1#3}
\crefrangeformat{table}{表(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{table}{表~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\crefformat{equation}{#2~(#1#3)}
\crefrangeformat{equation}{~(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{equation}{~(#2#1#3)}{ 和~(#2#1#3)}{，(#2#1#3)}{ 和~(#2#1#3)}
\ExplSyntaxOn
\prop_map_inline:Nn \l_cumcm_theorem_prop 
{
  \crefformat{#1}{##2#2~##1##3}
  \crefrangeformat{#1}{#2~(##3##1##4)\;\~{}\;(##5##2##6)}
  \crefmultiformat{#1}{#2~(##2##1##3)}{ 和~(##2##1##3)}{，(##2##1##3)}{ 和~(##2##1##3)}
}
\ExplSyntaxOff
\AtBeginEnvironment{thebibliography}{%
    \phantomsection
    \addcontentsline{toc}{section}{\refname}
    }

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

\lstset
{
  frame=tb,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  framerule=1pt,
  rulecolor=\color{gray!35},
  backgroundcolor=\color{gray!5},
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=3,
}
\renewcommand*{\baselinestretch}{1.38}
% 修改tabular 环境, 设置表格中的行间距为正文行间距.
\let\mcm@oldtabular\tabular
\let\mcm@endoldtabular\endtabular
\renewenvironment{tabular}%
	{\bgroup%
	\renewcommand{\arraystretch}{1.38}%
	\mcm@oldtabular}%
	{\mcm@endoldtabular\egroup}
% 每行缩进两个汉字
\setlength\parindent{2em}

\renewcommand\normalsize{%
	\@setfontsize\normalsize{12.05}{14.45}%
	\abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
	\abovedisplayshortskip \z@ \@plus3\p@
	\belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@}

\renewcommand*{\textfraction}{0.05}
% 有时如果多个浮动环境连续放在一起, \LaTeX{}
% 会将它们分在几个不同页，即使它们可在同一页放
% 得下. 我们可以通过修改 |\topfraction| 和 |\bottomfraction| 分别设置顶端和底端的浮
% 动环境的最大比例.
 \renewcommand*{\topfraction}{0.9}
 \renewcommand*{\bottomfraction}{0.8}
% 有时\LaTeX{}会把一个浮动环境单独放在一页,
% 我们要求这个环境至少要占据 85% 才能单独放在一页.
% 注意:  |\floatpagefraction| 的数值必须小于 |\topfraction|.
 \renewcommand*{\floatpagefraction}{0.85}

 \pdfstringdefDisableCommands{%
	\def\cftdotfill{ }%
}

\setcounter{secnumdepth}{3}
% 节标题格式, 居中, 使用\chinese命令修改计数器
\def\@seccntformat#1{\csname the#1\endcsname\ }
\renewcommand\thesection{\chinese{section}、}
\renewcommand\thesubsection{\arabic{section}\thinspace.\thinspace\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection\thinspace.\thinspace\arabic{subsubsection}}
\renewcommand\section{\@startsection{section}{1}{\z@}%
 	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\centering\normalfont\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\normalfont\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{-1em}%
	{\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
	 {3.25ex \@plus1ex \@minus .2ex}%
	 {-1em}%
	 {\normalfont\normalsize\bfseries}}
   \renewenvironment{abstract}{%
   \if@twocolumn
       \section*{\abstractname}%
     \else
      \begin{center}%
     {\zihao{4}\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
      \end{center}%
       \quotation
     \fi}
     {\if@twocolumn\else\endquotation\newpage\null\fi}
\renewenvironment{thebibliography}[1]
{\section*{\refname}%
\@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
\list{\@biblabel{\@arabic\c@enumiv}}%
{\settowidth\labelwidth{\@biblabel{#1}}%
\leftmargin\labelwidth
\advance\leftmargin\labelsep
\@openbib@code
\usecounter{enumiv}%
\let\p@enumiv\@empty
\renewcommand\theenumiv{\@arabic\c@enumiv}}%
\sloppy
\clubpenalty4000
\@clubpenalty \clubpenalty
\widowpenalty4000%
\sfcode`\.\@m}
{\def\@noitemerr
{\@latex@warning{Empty `thebibliography' environment}}%
\endlist}


\endinput
