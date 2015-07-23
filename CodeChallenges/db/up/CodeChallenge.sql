USE [master]
GO

ALTER DATABASE [CodeChallenge] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CodeChallenge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

USE [CodeChallenge]
GO

/****** Object:  Table [dbo].[Challenge]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Challenge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL DEFAULT (getutcdate()),
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Problem]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Problem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChallengeId] [int] NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
	[SampleInput] [nvarchar](max) NULL,
	[SampleOutput] [nvarchar](max) NULL,
	[Input] [nvarchar](max) NULL,
	[Output] [nvarchar](max) NULL,
	[Attachment] [nvarchar](max) NULL,
	[Order] [int] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime2](7) NULL DEFAULT (getutcdate()),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[Version] [int] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Solving]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solving](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ProblemId] [int] NULL,
	[FirstOpenTime] [datetime2](7) NULL DEFAULT (getutcdate()),
	[LastOpenTime] [datetime2](7) NULL DEFAULT (getutcdate()),
	[Result] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Submission]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Submission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SolvingId] [int] NULL,
	[Time] [datetime2](7) NULL DEFAULT (getutcdate()),
	[Content] [nvarchar](max) NULL,
	[Result] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[FullName] [nvarchar](200) NULL,
	[Company] [nvarchar](200) NULL,
	[Email] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL DEFAULT ((0)),
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL DEFAULT ((0)),
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 7/23/15 10:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Challenge] ON 

GO
INSERT [dbo].[Challenge] ([Id], [Name], [CreateDate], [StartTime], [EndTime], [Description]) VALUES (6, N'Sample challenge', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2014-03-27 23:00:00.0000000' AS DateTime2), CAST(N'2014-03-29 12:00:00.0000000' AS DateTime2), N'<p>This is a sample challenge only to help you get familiar with Code Challenge format.</p><p>Please be aware that this result will not be counted.</p><p>Happy coding :)</p><p></p>')
GO
INSERT [dbo].[Challenge] ([Id], [Name], [CreateDate], [StartTime], [EndTime], [Description]) VALUES (7, N'First code challenge', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2014-03-27 12:00:00.0000000' AS DateTime2), CAST(N'2014-03-31 00:00:00.0000000' AS DateTime2), N'<p>Welcome to the first Code Challenge.</p><p>We have 5 problems to solve below. Be quick to get BIG PRIZE.</p><p>Happy coding :)</p>')
GO
SET IDENTITY_INSERT [dbo].[Challenge] OFF
GO
SET IDENTITY_INSERT [dbo].[Problem] ON 

GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (10, 7, N'Sum square difference', N'Problem 1 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">The sum of the squares of the first ten natural numbers is,</p><div style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;text-align:center;">1<sup>2</sup><span class="Apple-converted-space">&nbsp;</span>+ 2<sup>2</sup><span class="Apple-converted-space">&nbsp;</span>+ ... + 10<sup>2</sup><span class="Apple-converted-space">&nbsp;</span>= 385</div><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">The square of the sum of the first ten natural numbers is,</p><div style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;text-align:center;">(1 + 2 + ... + 10)<sup>2</sup><span class="Apple-converted-space">&nbsp;</span>= 55<sup>2</sup><span class="Apple-converted-space">&nbsp;</span>= 3025</div><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025<span class="Apple-converted-space">&nbsp;</span><img alt="−" border="0" height="3" src="https://projecteuler.net/images/symbol_minus.gif" style="border:0px;vertical-align:middle;" width="9" /><span class="Apple-converted-space">&nbsp;</span>385 = 2640.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.</p>', NULL, NULL, NULL, N'25164150', NULL, 1, CAST(N'2014-03-28 09:56:58.8545695' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (11, 7, N'10001st prime', N'Problem 2 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">What is the 10 001st prime number?</p>', NULL, NULL, NULL, N'104743', NULL, 2, CAST(N'2014-03-28 09:57:29.2989272' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (12, 7, N'Number letter counts', N'Problem 3 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?</p><br style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;" /><p class="info" style="position:relative;cursor:help;font-size:16px;color:#000000;font-family:''Trebuchet MS'', sans-serif;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;"><strong>NOTE:</strong><span class="Apple-converted-space">&nbsp;</span>Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.</p>', NULL, NULL, NULL, N'21124', NULL, 3, CAST(N'2014-03-28 09:57:58.7539466' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (13, 7, N'Names scores', N'Problem 4 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">Using<span class="Apple-converted-space">&nbsp;</span><a href="https://projecteuler.net/project/names.txt" style="text-decoration:none;color:#777777;">names.txt</a><span class="Apple-converted-space">&nbsp;</span>(right click and ''Save Link/Target As...''), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938<span class="Apple-converted-space">&nbsp;</span><img alt="×" border="0" height="9" src="https://projecteuler.net/images/symbol_times.gif" style="border:0px;vertical-align:middle;" width="9" /><span class="Apple-converted-space">&nbsp;</span>53 = 49714.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">What is the total of all the name scores in the file?</p>', NULL, NULL, NULL, N'871198282', NULL, 4, CAST(N'2014-03-28 09:58:39.2133761' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (14, 7, N'Large sum', N'Problem 5 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.</p><div style="color:#000000;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;font-family:''courier new'';font-size:10pt;text-align:center;">37107287533902102798797998220837590246510135740250<br />46376937677490009712648124896970078050417018260538<br />74324986199524741059474233309513058123726617309629<br />91942213363574161572522430563301811072406154908250<br />23067588207539346171171980310421047513778063246676<br />89261670696623633820136378418383684178734361726757<br />28112879812849979408065481931592621691275889832738<br />44274228917432520321923589422876796487670272189318<br />47451445736001306439091167216856844588711603153276<br />70386486105843025439939619828917593665686757934951<br />62176457141856560629502157223196586755079324193331<br />64906352462741904929101432445813822663347944758178<br />92575867718337217661963751590579239728245598838407<br />58203565325359399008402633568948830189458628227828<br />80181199384826282014278194139940567587151170094390<br />35398664372827112653829987240784473053190104293586<br />86515506006295864861532075273371959191420517255829<br />71693888707715466499115593487603532921714970056938<br />54370070576826684624621495650076471787294438377604<br />53282654108756828443191190634694037855217779295145<br />36123272525000296071075082563815656710885258350721<br />45876576172410976447339110607218265236877223636045<br />17423706905851860660448207621209813287860733969412<br />81142660418086830619328460811191061556940512689692<br />51934325451728388641918047049293215058642563049483<br />62467221648435076201727918039944693004732956340691<br />15732444386908125794514089057706229429197107928209<br />55037687525678773091862540744969844508330393682126<br />18336384825330154686196124348767681297534375946515<br />80386287592878490201521685554828717201219257766954<br />78182833757993103614740356856449095527097864797581<br />16726320100436897842553539920931837441497806860984<br />48403098129077791799088218795327364475675590848030<br />87086987551392711854517078544161852424320693150332<br />59959406895756536782107074926966537676326235447210<br />69793950679652694742597709739166693763042633987085<br />41052684708299085211399427365734116182760315001271<br />65378607361501080857009149939512557028198746004375<br />35829035317434717326932123578154982629742552737307<br />94953759765105305946966067683156574377167401875275<br />88902802571733229619176668713819931811048770190271<br />25267680276078003013678680992525463401061632866526<br />36270218540497705585629946580636237993140746255962<br />24074486908231174977792365466257246923322810917141<br />91430288197103288597806669760892938638285025333403<br />34413065578016127815921815005561868836468420090470<br />23053081172816430487623791969842487255036638784583<br />11487696932154902810424020138335124462181441773470<br />63783299490636259666498587618221225225512486764533<br />67720186971698544312419572409913959008952310058822<br />95548255300263520781532296796249481641953868218774<br />76085327132285723110424803456124867697064507995236<br />37774242535411291684276865538926205024910326572967<br />23701913275725675285653248258265463092207058596522<br />29798860272258331913126375147341994889534765745501<br />18495701454879288984856827726077713721403798879715<br />38298203783031473527721580348144513491373226651381<br />34829543829199918180278916522431027392251122869539<br />40957953066405232632538044100059654939159879593635<br />29746152185502371307642255121183693803580388584903<br />41698116222072977186158236678424689157993532961922<br />62467957194401269043877107275048102390895523597457<br />23189706772547915061505504953922979530901129967519<br />86188088225875314529584099251203829009407770775672<br />11306739708304724483816533873502340845647058077308<br />82959174767140363198008187129011875491310547126581<br />97623331044818386269515456334926366572897563400500<br />42846280183517070527831839425882145521227251250327<br />55121603546981200581762165212827652751691296897789<br />32238195734329339946437501907836945765883352399886<br />75506164965184775180738168837861091527357929701337<br />62177842752192623401942399639168044983993173312731<br />32924185707147349566916674687634660915035914677504<br />99518671430235219628894890102423325116913619626622<br />73267460800591547471830798392868535206946944540724<br />76841822524674417161514036427982273348055556214818<br />97142617910342598647204516893989422179826088076852<br />87783646182799346313767754307809363333018982642090<br />10848802521674670883215120185883543223812876952786<br />71329612474782464538636993009049310363619763878039<br />62184073572399794223406235393808339651327408011116<br />66627891981488087797941876876144230030984490851411<br />60661826293682836764744779239180335110989069790714<br />85786944089552990653640447425576083659976645795096<br />66024396409905389607120198219976047599490197230297<br />64913982680032973156037120041377903785566085089252<br />16730939319872750275468906903707539413042652315011<br />94809377245048795150954100921645863754710598436791<br />78639167021187492431995700641917969777599028300699<br />15368713711936614952811305876380278410754449733078<br />40789923115535562561142322423255033685442488917353<br />44889911501440648020369068063960672322193204149535<br />41503128880339536053299340368006977710650566631954<br />81234880673210146739058568557934581403627822703280<br />82616570773948327592232845941706525094512325230608<br />22918802058777319719839450180888072429661980811197<br />77158542502016545090413245809786882778948721859617<br />72107838435069186155435662884062257473692284509516<br />20849603980134001723930671666823555245252804609722<br />53503534226472524250874054075591789781264330331690</div>', NULL, NULL, NULL, N'5537376230', NULL, 5, CAST(N'2014-03-28 09:59:28.9657379' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (15, 6, N'1 + 10 = ?', N'Problem 1 ', N'<p>1 + 1 = 2</p><p>What is the result of 1 + 10? </p>', NULL, NULL, NULL, N'11', NULL, 1, CAST(N'2014-03-28 10:01:05.8371438' AS DateTime2))
GO
INSERT [dbo].[Problem] ([Id], [ChallengeId], [Title], [Description], [Content], [SampleInput], [SampleOutput], [Input], [Output], [Attachment], [Order], [CreateDate]) VALUES (16, 6, N'Multiples of 3 and 5', N'Problem 2 ', N'<p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.</p><p style="color:#000000;font-family:''Trebuchet MS'', sans-serif;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:normal;orphans:auto;text-align:start;text-indent:0px;text-transform:none;white-space:normal;widows:auto;word-spacing:0px;-webkit-text-stroke-width:0px;">Find the sum of all the multiples of 3 or 5 below 1000.</p>', NULL, NULL, NULL, N'233168', NULL, 2, CAST(N'2014-03-28 10:01:36.7812241' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Problem] OFF
GO
SET IDENTITY_INSERT [dbo].[Settings] ON 

GO
INSERT [dbo].[Settings] ([Id], [Key], [Value], [Version]) VALUES (0, N'TimeZone', N'SE Asia Standard Time', NULL)
GO
SET IDENTITY_INSERT [dbo].[Settings] OFF
GO
SET IDENTITY_INSERT [dbo].[Solving] ON 

GO
INSERT [dbo].[Solving] ([Id], [UserId], [ProblemId], [FirstOpenTime], [LastOpenTime], [Result]) VALUES (6, 8, 10, CAST(N'2014-03-28 15:52:46.7663264' AS DateTime2), CAST(N'2014-03-28 15:53:39.6995852' AS DateTime2), 1)
GO
INSERT [dbo].[Solving] ([Id], [UserId], [ProblemId], [FirstOpenTime], [LastOpenTime], [Result]) VALUES (7, 8, 11, CAST(N'2014-03-28 16:04:39.2707454' AS DateTime2), CAST(N'2014-03-28 16:11:50.8816442' AS DateTime2), 1)
GO
SET IDENTITY_INSERT [dbo].[Solving] OFF
GO
SET IDENTITY_INSERT [dbo].[Submission] ON 

GO
INSERT [dbo].[Submission] ([Id], [SolvingId], [Time], [Content], [Result]) VALUES (13, 6, CAST(N'2014-03-28 15:52:58.4380980' AS DateTime2), N'342', 0)
GO
INSERT [dbo].[Submission] ([Id], [SolvingId], [Time], [Content], [Result]) VALUES (14, 6, CAST(N'2014-03-28 15:53:39.6214119' AS DateTime2), N'25164150', 1)
GO
INSERT [dbo].[Submission] ([Id], [SolvingId], [Time], [Content], [Result]) VALUES (15, 7, CAST(N'2014-03-28 16:04:42.5364393' AS DateTime2), N'432432', 0)
GO
INSERT [dbo].[Submission] ([Id], [SolvingId], [Time], [Content], [Result]) VALUES (16, 7, CAST(N'2014-03-28 16:10:05.8137183' AS DateTime2), N'104743', 1)
GO
SET IDENTITY_INSERT [dbo].[Submission] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

GO
INSERT [dbo].[UserProfile] ([UserId], [UserName], [FullName], [Company], [Email]) VALUES (1, N'admin', NULL, NULL, NULL)
GO
INSERT [dbo].[UserProfile] ([UserId], [UserName], [FullName], [Company], [Email]) VALUES (8, N'test1', N'Test User 1', N'Planday', N'test@test.com')
GO
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2014-03-19 05:32:00.163' AS DateTime), NULL, 1, NULL, 0, N'AOKD+28Gxqk2EYrKUL+6vV7xOcDohuSIclp3ACn2WbiN4WwuuRGHpB+0G9BHt7YKZw==', CAST(N'2014-03-19 05:32:00.163' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(N'2014-03-20 07:48:23.117' AS DateTime), NULL, 1, NULL, 0, N'AD0iGJhnGreN5QMENW8Zkl9+U2qmuFXzH7qrQHmKwsZ80pogt7PYvvvVSgVo08gBJQ==', CAST(N'2014-03-20 07:48:23.117' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(N'2014-03-20 08:11:40.823' AS DateTime), NULL, 1, NULL, 0, N'AK04zzAiwssas7biFoBtKWbtTPyb82SX3XOd2WGp7+gJf4oQ1y1GFSVu7BqT2U7ThQ==', CAST(N'2014-03-20 08:11:40.823' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(N'2014-03-20 08:14:33.900' AS DateTime), NULL, 1, NULL, 0, N'AACKh7RgYq7uXOsc9riuRVFG0j4uT1C5ywVkrTkSfAVamCh75Kb43SjnMUFKizk2PA==', CAST(N'2014-03-20 08:14:33.900' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(N'2014-03-20 08:15:16.350' AS DateTime), NULL, 1, NULL, 0, N'AJyDweX16D+rFq3tXJQhi7nodtG5tlmrhliwGaxn3n+BxUQZhzaKsI8SKPrZ5EG1uA==', CAST(N'2014-03-20 08:15:16.350' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(N'2014-03-20 08:21:39.157' AS DateTime), NULL, 1, NULL, 0, N'ANIPkUR38dn7AU088O/lkaGhJ1bPzgSWysoQX6ZWwfy93w7xKjAxgHuyjLo2ztMjpQ==', CAST(N'2014-03-20 08:21:39.157' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(N'2014-03-20 08:26:24.980' AS DateTime), NULL, 1, NULL, 0, N'AIFAQDxvtbxdWYfMPjCqhgaAny/YXUUOy3ZLdQN51tqqRnRfCrZ7Z7Tvxt/s6fjKdw==', CAST(N'2014-03-20 08:26:24.980' AS DateTime), N'', NULL, NULL)
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(N'2014-03-26 10:13:40.940' AS DateTime), NULL, 1, NULL, 0, N'AAqrApnp2KVNzUDRO3ff+qJOevqH1hbayAMa7eJSQRInmShfhGD4eQOsfZnEUf0Nxg==', CAST(N'2014-03-26 10:13:40.940' AS DateTime), N'', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[webpages_Roles] ON 

GO
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (1, N'Administrator')
GO
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (2, N'Contestant')
GO
SET IDENTITY_INSERT [dbo].[webpages_Roles] OFF
GO
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (1, 1)
GO
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (8, 2)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160AA28A32E]    Script Date: 7/23/15 10:52:24 AM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Problem]  WITH CHECK ADD  CONSTRAINT [FK_Problem_Challenge] FOREIGN KEY([ChallengeId])
REFERENCES [dbo].[Challenge] ([Id])
GO
ALTER TABLE [dbo].[Problem] CHECK CONSTRAINT [FK_Problem_Challenge]
GO
ALTER TABLE [dbo].[Solving]  WITH CHECK ADD  CONSTRAINT [FK_Solving_Problem] FOREIGN KEY([ProblemId])
REFERENCES [dbo].[Problem] ([Id])
GO
ALTER TABLE [dbo].[Solving] CHECK CONSTRAINT [FK_Solving_Problem]
GO
ALTER TABLE [dbo].[Solving]  WITH CHECK ADD  CONSTRAINT [FK_Solving_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[Solving] CHECK CONSTRAINT [FK_Solving_UserProfile]
GO
ALTER TABLE [dbo].[Submission]  WITH CHECK ADD  CONSTRAINT [FK_Submission_Solving] FOREIGN KEY([SolvingId])
REFERENCES [dbo].[Solving] ([Id])
GO
ALTER TABLE [dbo].[Submission] CHECK CONSTRAINT [FK_Submission_Solving]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
USE [master]
GO
ALTER DATABASE [CodeChallenge] SET  READ_WRITE 
GO
