Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC53D9DA5
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 08:29:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gb0xd4Z8pz3bWC
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 16:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256 header.s=s2 header.b=E53ycq2Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=em9210.fdc-k.or.ke (client-ip=149.72.78.64;
 helo=wrqvqzqh.outbound-mail.sendgrid.net;
 envelope-from=bounces+17430347-3d43-linux-erofs=lists.ozlabs.org@em9210.fdc-k.or.ke;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256
 header.s=s2 header.b=E53ycq2Z; dkim-atps=neutral
Received: from wrqvqzqh.outbound-mail.sendgrid.net
 (wrqvqzqh.outbound-mail.sendgrid.net [149.72.78.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gb0xW6Cfbz300Q
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jul 2021 16:29:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fdc-k.or.ke;
 h=content-transfer-encoding:content-type:from:mime-version:subject:to:
 list-unsubscribe;
 s=s2; bh=EAddxoTx9NATTCkc6QuGdCC/+YL2GXHkf9AhKPpuPRU=;
 b=E53ycq2ZsC2L/UfJfwE7TWuqiaLk97A+2J0DQhZkssTVo4BDgkqVpBfwdxEVIsu5ukK9
 HCUn24IIj+JqKjlXlvwrLAiGEAmmmAIpBBc40M0eK7Ik8wRPbm7CJij8Zedb9PnoeKhSxo
 qVfoKC+Mxbu4UbxBumz5uHMPviASKpR+Y=
Received: by filterdrecv-canary-54cfbb59b9-8pvxw with SMTP id
 filterdrecv-canary-54cfbb59b9-8pvxw-1-61024AAC-C
 2021-07-29 06:29:00.196639355 +0000 UTC m=+216254.168712083
Received: from MTc0MzAzNDc (unknown) by ismtpd0165p1mdw1.sendgrid.net (SG)
 with HTTP id YzDJMPmVTBGdPOXRzLyILg
 Thu, 29 Jul 2021 06:29:00.131 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=iso-8859-1
Date: Thu, 29 Jul 2021 06:29:32 +0000 (UTC)
From: "FDC-K .ORG" <workshops@fdc-k.or.ke>
Mime-Version: 1.0
Message-ID: <YzDJMPmVTBGdPOXRzLyILg@ismtpd0165p1mdw1.sendgrid.net>
Subject: Invitation to Grant management using Sun accounting system Workshop
 Sep 27 2021
X-SG-EID: =?us-ascii?Q?UEMqp3YVKKtUL01h4vS23ewQT=2FZe5x+tb1E7zy1tWm3=2FInm3qe8Nv6tqu+uGKn?=
 =?us-ascii?Q?tFqbxECCnXcuZFSvQjCVqbD+5hcVIJcDJsU4yqT?=
 =?us-ascii?Q?lQcAPyd41MZ5aCb8rgqsVNhAi6dUzoS+hq9PNYc?=
 =?us-ascii?Q?G6Yi4+cpefsyMLNgvQ3jMNngCLc13MwwwPHeevJ?=
 =?us-ascii?Q?cKsXhQdpyGYs4OXne0dOd2EJrQ09tTQod45bjKF?=
 =?us-ascii?Q?tLuKeUrp7n83FXKPiEMhU3fZPFJ339NtwxN6ov2?=
 =?us-ascii?Q?ca848WQPAMgF=2FXrTm1nkA=3D=3D?=
To: linux-erofs@lists.ozlabs.org
X-Entity-ID: lgZohGoWIjvYsKzlUpYsxA==
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE html><html xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"" clas=
s=3D" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation=
 postmessage websqldatabase indexeddb hashchange history draganddrop websoc=
kets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshado=
w textshadow opacity cssanimations csscolumns cssgradients cssreflections c=
sstransforms csstransforms3d csstransitions fontface generatedcontent video=
 audio localstorage sessionstorage webworkers no-applicationcache svg inlin=
esvg smil svgclippaths js csstransforms csstransforms3d csstransitions resp=
onsejs "><head>
        <title>Invitation to Grant management using Sun accounting system  =
Workshop Sep 27 2021</title>
        <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-sc=
ale=3D1.0" />
        <style type=3D"text/css" media=3D"only screen and (max-width: 480px=
)">
            /* Mobile styles */
            @media only screen and (max-width: 480px) {
                [class=3D"w320"] {
                    width: 320px !important;
                }
                [class=3D"mobile-block"] {
                    width: 100% !important;
                    display: block !important;
                }
            }
        </style>
                                      </head><body style=3D"margin:0" class=
=3D"ui-sortable" data-new-gr-c-s-check-loaded=3D"14.1024.0" data-gr-ext-ins=
talled=3D"">
        <div data-section-wrapper=3D"1">
            <center>
                <table data-section=3D"1" style=3D"width: 600;" width=3D"60=
0" cellspacing=3D"0" cellpadding=3D"0">
                    <tbody>
                        <tr>
                            <td>
                                <div data-slot-container=3D"1" style=3D"min=
-height: 30px" class=3D"ui-sortable">
                                    <div data-slot=3D"text"><a href=3D"http=
s://fdc-k.org/trainings/1086/Grant-Management-using-Sun-Accounting-System-C=
ourse/Business-and-Governance/4561" rel=3D"noopener noreferrer" target=3D"_=
blank">Grant management using Sun accounting system</a><span style=3D"font-=
size: 14px;"><a href=3D"https://fdc-k.org/trainings/1086/Grant-Management-u=
sing-Sun-Accounting-System-Course/Business-and-Governance/4561" rel=3D"noop=
ener noreferrer" target=3D"_blank"><span style=3D"font-family: Tahoma,Genev=
a,sans-serif;">=A0Workshop from September 27 to 08 October 2021 for 10 Days=
</span></a><span style=3D"font-size: 14px;"><span style=3D"font-family: Tah=
oma,Geneva,sans-serif;"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" width=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"708"><div data=
-empty=3D"true"><br /></div></td></tr></tbody></table><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" width=3D"0"><tbody><tr><td valign=3D"bot=
tom" width=3D"708"><div data-empty=3D"true"><br /></div></td></tr></tbody><=
/table><a href=3D"https://fdc-k.org/online-courses/register/1086/3838/Grant=
-Management-using-Sun-Accounting-System-Course/4473/capacity-building-cours=
es" rel=3D"noopener noreferrer" target=3D"_blank">=A0Register for online at=
tendance Workshop</a><div data-empty=3D"true"><br /></div><a href=3D"https:=
//fdc-k.org/trainings/register/1086/3838/Grant-Management-using-Sun-Account=
ing-System-Course/4473/capacity-building-courses" rel=3D"noopener noreferre=
r" target=3D"_blank">Register Onsite attendance workshop</a><div data-empty=
=3D"true"><br /></div><a href=3D"https://fdc-k.org/trainings/group/1086/383=
8/1/Grant-Management-using-Sun-Accounting-System-Course/4473/capacity-build=
ing-courses" rel=3D"noopener noreferrer" target=3D"_blank">=A0Register as a=
 group workshop</a><div data-empty=3D"true"><br /></div><a href=3D"https://=
fdc-k.org/calendar/FDC-training-calender" rel=3D"noopener noreferrer" targe=
t=3D"_blank">Download Our Calendar 2021/2022</a><div data-empty=3D"true"><b=
r /></div><a href=3D"https://drive.google.com/file/d/1j54b_IzkRIz9-m55x2AEU=
w9eM3jV3VpE/view?usp=3Dsharing" rel=3D"noopener noreferrer" target=3D"_blan=
k">Download &amp; Fill Admission Form</a><div data-empty=3D"true"><br /></d=
iv><strong>Official Email: training@fdc-k.org</strong><div data-empty=3D"tr=
ue"><br /></div><strong>Official Tel: +254 712 260 031</strong><div data-em=
pty=3D"true"><br /></div><strong>Visit Our Website: <a href=3D"https://fdc-=
k.org/" rel=3D"noopener noreferrer" target=3D"_blank"><strong>Foscore Devel=
opment Center</strong></a></strong><div data-empty=3D"true"><br /></div><st=
rong>Onsite Centers:=A0</strong><strong>Hilton Hotel =A0and Meridian Hotel,=
 Nairobi Kenya</strong><br /><strong><br /></strong><strong>Introduction</s=
trong><br />This course is designed to enable those involved with grant man=
agement to become efficient and effective in the acquisition and utilizatio=
n of funds for development purposes, using appropriate techniques and appli=
cation of accounting and finance principles.<br /><strong>Duration</strong>=
<br />10 days<br /><strong>Who should attend?</strong><br />Finance Directo=
rs, Finance Managers, Procurement Directors, Procurement managers, Procurem=
ent officers, Administrators, Project officers, Budget Accountants, Auditor=
s, Chief Accountants, Credit Controllers<br /><strong>Course Objective:</st=
rong><br /><ul type=3D"disc"><li>Identify and assess the critical terms and=
 conditions of grant aid for donor-funded projects</li><li>Ensure complianc=
e with donor terms and conditions</li><li>Providing supporting documents</l=
i><li>procurement of goods and services; and meeting financial reporting re=
quirements</li><li>Use a grant schedule to managing multiple-funded program=
mes</li><li>Prepare a donor financial report to match with a project narrat=
ive report.</li><li>Describe the four phases in the grant management cycle<=
/li><li>Clarify key responsibilities and routines needed for successful gra=
nt management</li><li>Describe the impact of foreign exchange on grant mana=
gement</li><li>Identify the requirements for closing off a donor grant.</li=
><li>Use of sun system and Excel in management of grant</li></ul><strong>Co=
urse content</strong><br /><ul type=3D"disc"><li>Key challenges in grant ma=
nagement</li><li>The grant management life cycle</li><li>Responsibilities a=
nd routines in grant management</li><li>The flow of donor funds</li><li>Ass=
essing the terms and conditions in grant agreements</li><li>How grant agree=
ments impact on accounting and procurement systems</li><li>Complying with d=
onor reporting requirements</li><li>Managing multiple-donor funded projects=
</li><li>Managing key relationships for successful grant management</li><li=
>Advance sun system in grant management</li><li>Advanced excel formulas and=
 functions for grant management</li><li>Excel chart in depth for grant pres=
entation</li></ul><br /><strong>General Notes</strong><ul type=3D"disc"><li=
>All our courses can be Tailor-made to participants needs</li><li>The parti=
cipant must be conversant with English</li><li>Presentations are well guide=
d, practical exercises, web-based tutorials, and group work. Our facilitato=
rs are experts with more than 10years of experience.</li><li>Upon completio=
n of training, the participant will be issued with a Foscore development ce=
nter certificate (FDC-K)</li><li>Training will be done at the Foscore devel=
opment center (FDC-K) center in Nairobi Kenya. We also offer more than five=
 participants training at the requested location within Kenya, more than te=
n participants within east Africa, and more than twenty participants all ov=
er the world.</li><li>Course duration is flexible and the contents can be m=
odified to fit any number of days.</li></ul><strong>VIEW OTHER UPCOMING SEP=
TEMBER 2021 =A0WORKSHOPS (REGISTER FOR THE COURSE AS AN INDIVIDUAL OR GROUP=
)</strong><div data-empty=3D"true"><br /></div><ul type=3D"disc"><li><a hre=
f=3D"https://fdc-k.org/trainings/1509/Procurement-logistics-and-Supply-Chai=
n-Management-course-/Business-and-Governance/4561" rel=3D"noopener noreferr=
er" target=3D"_blank">Procurement logistics and Supply Chain Management Wor=
kshop-Sep 06 to Sep17,2021 for 10 Days</a></li></ul><div data-empty=3D"true=
"><br /></div><ul type=3D"disc"><li><a href=3D"https://fdc-k.org/trainings/=
496/Developing-organization--Balanced-Scorecard-course/Business-and-Governa=
nce/4561" rel=3D"noopener noreferrer" target=3D"_blank">Developing organiza=
tion Balanced Scorecard workshop from Sep 06, 2021 for 5 Days</a></li></ul>=
<br /><ul><li><a href=3D"https://fdc-k.org/trainings/3130/Executive-Leaders=
hip-&-Management-Program-Course/Business-and-Governance/4561" rel=3D"noopen=
er noreferrer" target=3D"_blank">Executive Leadership &amp; Management Prog=
ram Workshop from Sep 06, 2021 for 5 Days</a><br /><br /></li><li><a href=
=3D"https://fdc-k.org/trainings/1945/Research-DesignODK-Mobile-Data-Collect=
ionGIS-Mapping-Data-Analysis-using-NVIVO-and-STATA-Course/Research-and-Data=
-Analysis/4561" rel=3D"noopener noreferrer" target=3D"_blank">Research Desi=
gn, ODK mobile data collection, GIS mapping, Data analysis using NVIVO and =
STATA Workshop from 13 Sep 2021 for 10 Days</a></li></ul><div data-empty=3D=
"true"><br /></div><ul type=3D"disc"><li><a href=3D"https://fdc-k.org/train=
ings/2498/Research-DesignODK-Mobile-Data-CollectionGIS-MappingData-analysis=
-using-NVIVO-and-R-course/Research-and-Data-Analysis/4561" rel=3D"noopener =
noreferrer" target=3D"_blank">Research Design, ODK mobile data collection, =
GIS mapping, and Data analysis using NVIVO and R Workshop from 13 Sep 2021 =
for 10 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul type=3D"d=
isc"><li><a href=3D"https://fdc-k.org/trainings/508/Advanced-Excel-Formulas=
-and-Functions-course-/Business-and-Governance/4561" rel=3D"noopener norefe=
rrer" target=3D"_blank">Advanced Excel Formulas and Functions Workshop from=
 13 Sep 2021 for 5 Days</a></li></ul><div data-empty=3D"true"><br /></div><=
ul type=3D"disc"><li><a href=3D"https://fdc-k.org/trainings/3098/Public-Sec=
tor-Management-course/Business-and-Governance/4561" rel=3D"noopener norefer=
rer" target=3D"_blank">Public Sector Management Workshop from 13 Sep 2021 f=
or 10 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul type=3D"di=
sc"><li><a href=3D"https://fdc-k.org/trainings/509/Electronic-Document-&-Re=
cords-Management-course/Business-and-Governance/4561" rel=3D"noopener noref=
errer" target=3D"_blank">Electronic Document &amp; Records Management Works=
hop from 13 Sep 2021 for 5 Days</a></li></ul><div data-empty=3D"true"><br /=
></div><ul type=3D"disc"><li><a href=3D"https://fdc-k.org/trainings/1091/Pr=
oject-Monitoring-and-Evaluation-with-Data-Management-and-Analysis-course/Mo=
nitoring-and-Evaluation/4561" rel=3D"noopener noreferrer" target=3D"_blank"=
>Project Monitoring and Evaluation with Data Management and Analysis =A0Wor=
kshops from Sep 20 ,2021, for 10 Days</a></li></ul><div data-empty=3D"true"=
><br /></div><ul type=3D"disc"><li><a href=3D"https://fdc-k.org/trainings/1=
971/Remote-Sensing-and-GIS-for-Public-Health-and-Epidemiology-Course/GIS/45=
61" rel=3D"noopener noreferrer" target=3D"_blank">Remote Sensing and GIS fo=
r Public Health and Epidemiology Workshop from 20 Sep 2021 for 10 Days</a><=
/li></ul><div data-empty=3D"true"><br /></div><ul type=3D"disc"><li><a href=
=3D"https://fdc-k.org/trainings/685/GIS-for-Monitoring-and-Evaluation-Cours=
e/GIS/4561" rel=3D"noopener noreferrer" target=3D"_blank">GIS for Monitorin=
g and Evaluation Workshop from 20 Sep 2021 for 5 Days</a></li></ul><div dat=
a-empty=3D"true"><br /></div><ul><li><a href=3D"https://fdc-k.org/trainings=
/2706/Strategic-Communication-Training-For--Managers-And-Executives-Program=
-Course/Business-and-Governance/4561" rel=3D"noopener noreferrer" target=3D=
"_blank">Strategic Communication Training For =A0Managers And Executives Pr=
ogram =A0Workshop from 20 Sep 2021 for 10 Days</a></li></ul><div data-empty=
=3D"true"><br /></div><ul type=3D"disc"><li><a href=3D"https://fdc-k.org/tr=
ainings/2966/GIS-Data-Collection-Analysis-Visualization-and-Mapping-Course/=
GIS/4561" rel=3D"noopener noreferrer" target=3D"_blank">GIS Data Collection=
, Analysis, Visualization and Mapping Workshop from 20 Sep 2021 for 10 Days=
</a></li></ul><div data-empty=3D"true"><br /></div><ul type=3D"disc"><li><a=
 href=3D"https://fdc-k.org/trainings/531/Monitoring-and-Evaluation-for-Gove=
rnance-course/Monitoring-and-Evaluation/4561" rel=3D"noopener noreferrer" t=
arget=3D"_blank">Monitoring and Evaluation for Governance Workshop from 27 =
Sep 2021 for 10 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul =
type=3D"disc"><li><a href=3D"https://fdc-k.org/trainings/2345/Office-ICT-Ba=
sic-Skills-Training-Course/Mobile-Technology/4561" rel=3D"noopener noreferr=
er" target=3D"_blank">Office ICT Basic Skills Training =A0Workshop from 27 =
Sep 2021 for 10 Days</a></li></ul><br /><ul><li><a href=3D"https://fdc-k.or=
g/trainings/2312/Research-Design-ODK-Mobile-Data-Collection-GIS-Mapping-Dat=
a-Analysis-using-NVIVO-and-SPSS-Course/Research-and-Data-Analysis/4561" rel=
=3D"noopener noreferrer" target=3D"_blank">Research Design, ODK Mobile Data=
 Collection, GIS Mapping, Data Analysis using NVIVO and SPSS Workshop 27 Se=
p 2021 for 10 Days</a><br /><br /></li><li><a href=3D"https://fdc-k.org/tra=
inings/1086/Grant-Management-using-Sun-Accounting-System-Course/Business-an=
d-Governance/4561" rel=3D"noopener noreferrer" target=3D"_blank">Grant mana=
gement using Sun accounting system Workshop from 27 Sep 2021 for 10 Days</a=
></li></ul><br /><a href=3D"https://fdc-k.org/trainings/1086/Grant-Manageme=
nt-using-Sun-Accounting-System-Course/Business-and-Governance/4561" rel=3D"=
noopener noreferrer" target=3D"_blank"></a><ul><li><a href=3D"https://fdc-k=
.org/trainings/491/Transformational-Leadership-and-Governance-Course/Busine=
ss-and-Governance/4561" rel=3D"noopener noreferrer" target=3D"_blank">Trans=
formational Leadership and Governance =A0Workshop from 27 Sep 2021 for 10 D=
ays</a></li></ul><br /><br /><br /><ul><li><a href=3D"https://fdc-k.org/tra=
inings/2710/Inventory-Control-And-Warehouse-Management-Course/Business-and-=
Governance/4561" rel=3D"noopener noreferrer" target=3D"_blank">Inventory Co=
ntrol And Warehouse Management Workshop from 27 Sep 2021 for 5 Days</a></li=
></ul><div data-empty=3D"true"><br /></div>FDC Result Based skills Developm=
ent,<br />Regards,<br />FDC Training Team,<br /><a href=3D"https://drive.go=
ogle.com/file/d/1t0YT9wvR8jKK991_VA-A4_DEm8DfcTuw/view?usp=3Dsharing" rel=
=3D"noopener noreferrer" target=3D"_blank">Get Our Calendar=A0</a></span></=
span></span></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </div>
<img height=3D"1" width=3D"1" src=3D"https://mautic.fdc-k.co.ke/email/61024=
aa93c845589157009.gif" alt=3D"" />If you'd like to unsubscribe and stop rec=
eiving these emails <a href=3D"http://url9271.fdc-k.or.ke/wf/unsubscribe?up=
n=3DoDb6ny51mUB6FExYn3rQhnEsRzMLZB2XMeq5leS37lAnPoWX4a8WXzlIQ0mi6oYYKegIiOU=
I3cuGqWQ2FoAEa2TUdk6aLcJmoZ45T2JUXy11ZEKhXbBufeI-2BUre70qT4zMhPBWmoRXFPKmGD=
W-2FwH4RwYlm-2F-2F5lhYCrGny9mqWrlDvjUMvkTesDTRJXW-2BSlbv5QFVfUUXnhtJuAo1Mta=
yAGRphfShilEfmhBtJSf8AStB6yiYHBQbRNQl6cjf6fpI"> click here </a>.<img src=3D=
"http://url9271.fdc-k.or.ke/wf/open?upn=3DoDb6ny51mUB6FExYn3rQhnEsRzMLZB2XM=
eq5leS37lAnPoWX4a8WXzlIQ0mi6oYYKegIiOUI3cuGqWQ2FoAEaxyAsHurvCZezOvVYmJ2Qn9f=
MIwlOuER2iwlf1OIC-2BR5PE3FdR81WyWTHDfJTTHzOmi6D-2F0Ed1wIW8g5-2BTGHkCv7tWewu=
GJ-2FACPkr9W-2FbnsS2WV1xijG85C2D40NV0WYY7Bov7i3U2u42O4TRFLN9R8fgJImQXEBJ7LK=
njR3OrBP" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"height:1p=
x !important;width:1px !important;border-width:0 !important;margin-top:0 !i=
mportant;margin-bottom:0 !important;margin-right:0 !important;margin-left:0=
 !important;padding-top:0 !important;padding-bottom:0 !important;padding-ri=
ght:0 !important;padding-left:0 !important;"/></body></html>
