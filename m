Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC13C2B54
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jul 2021 00:26:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GM76f57mDz307T
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jul 2021 08:26:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256 header.s=s1 header.b=ILPd7ohP;
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
 header.s=s1 header.b=ILPd7ohP; dkim-atps=neutral
Received: from wrqvqzqh.outbound-mail.sendgrid.net
 (wrqvqzqh.outbound-mail.sendgrid.net [149.72.78.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GM76R0ZMRz3005
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jul 2021 08:26:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fdc-k.or.ke; 
 h=content-transfer-encoding:content-type:from:mime-version:to:subject:list-unsubscribe;
 s=s1; bh=Jg6NXFo6fHFe6kxsLPY7QV9frx5J0hoxZ5r4fn4Oq4k=; b=ILPd7oh
 P0GE32ED3WY1pG6YkPN/jTkIqmaBCWe4ecEJmqpP8Y4wq12AcGvGMfdFRDX6F/wC
 70LUGn3KoAaosVWZRbfY5pIA+N+UPK30v+LqjamCNChWMDNI2dY7SGK7M8XWs3y7
 e5lvs8m0wlGQBmzCvpOYDHSZ5TpNnFrUugpI=
Received: by filter2916p1mdw1.sendgrid.net with SMTP id
 filter2916p1mdw1-15714-60E5A1B9-14
 2021-07-07 12:44:41.739773677 +0000 UTC m=+499529.660121133
Received: from MTc0MzAzNDc (unknown)
 by geopod-ismtpd-6-2 (SG) with HTTP id C8o7q6oJSUG7nhysnvVFag
 Wed, 07 Jul 2021 12:44:41.555 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
Date: Wed, 07 Jul 2021 12:45:02 +0000 (UTC)
From: "FDC -K" <workshops@fdc-k.or.ke>
Mime-Version: 1.0
To: linux-erofs@lists.ozlabs.org
Message-ID: <C8o7q6oJSUG7nhysnvVFag@geopod-ismtpd-6-2>
Subject: Invitation to Research Design,ODK,GIS,NVIVO and R Worksop Workshop
X-SG-EID: D/WhaQyL81n52MRUxySh/FGW0Tvj3TKiZPeU+9+BRFYmBybe84xpbjj9Y8q4xQesyPT1JjVvncNhMe
 bxd9efd9/CJNs46IYnMHSTRJUPlY4Za5raPnFb/ytkVYJZXKoCYfDg7Z2wyQpip8TMQg8srV3MI0YG
 AMm0u5P3RDwG8bdvOkNLifd6mRarxfX+fgdbF+ymyjPS8sN1kQieuuiPg51ot9/K6q4vZPd+D2dhTW
 Q=
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
        <title>Invitation to Research Design,ODK,GIS,NVIVO and R Worksop Wo=
rkshop</title>
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
                                      </head>
    <body style=3D"margin:0" class=3D"ui-sortable">
        <div data-section-wrapper=3D"1">
            <center>
                <table data-section=3D"1" style=3D"width: 600;" width=3D"60=
0" cellpadding=3D"0" cellspacing=3D"0">
                    <tbody>
                        <tr>
                            <td>
                                <div data-slot-container=3D"1" style=3D"min=
-height: 30px" class=3D"ui-sortable">
                                    <div data-slot=3D"text"><div data-empty=
=3D"true"><br /></div><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3D=
Ubf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7oND40403cvrmqyiguZMbJGF8k6R-2Bm=
7aDVZayNxMaraZM39qwanKHpYkOklLojxF7-2FexTGwgTHhlgCpxJcnBRiSR6vb-2FxlcGD1EDX=
b5Cn1H6RVuU6MK8jD20nmIzpKZkfH3-2Fm-2F0bwtXvtfc4BbjQbv5dQKshiXAykdkx1ZOmaph1=
kncZ6C1xI-2F6-2F7Zx3xGuuBnbUcnnvoQ9vS2VaQTcWzxP4I0MBOyfH0bl2sJyBDHjaSVMqMOk=
d5KL3CAf-2FdWIpzfb-2B2qMKTcYy-2FdsJqQHe4oiiI0M_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA=
9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqHOIKClrozUAdLzeW=
e4PAJEIiSCLroR1IQ242f1kUb-2BJeM1aOzuG7Q8k-2FZfnQ4MoabD4R1luRHNMM6raTPHx-2BZ=
qOieVt-2FQEy-2FXSEap-2BzBjRcZlXWl3RO0LQof0IQc5n4-2BQWoecVNMCA-2B-2FEf9XiQWP=
Ww-3D" rel=3D"noopener noreferrer" target=3D"_blank"><strong>Research Desig=
n,ODK mobile data collection,GIS data mapping,Data analysis using NVIVO and=
 R Workshops-July 26 to August 06,2021 for 10 Days</strong></a><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"0"><tbody><tr><td vali=
gn=3D"bottom" width=3D"708"><div data-empty=3D"true"><br /></div></td></tr>=
</tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" wid=
th=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"1049"><div data-empty=3D=
"true"><br /></div></td></tr></tbody></table><a href=3D"http://url9271.fdc-=
k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85OgCGYDWi7RfOUuK-2F8z2-2BFBhU-=
2FBlMoY2ezaYz-2FQUUhrxxvA4RDzD-2BqP8ry70debChY-2Fv-2BuesiFsL4xuetvTqVxh4m0G=
gBOP62r79jHLqWssfAZNNr1Y9BtkaCeu37OhPYDOkN09fdnN-2F2EkKgRmX87J8q2SBF3Hb-2BV=
mcayWz2uGPTe-2FmgeaBvj9FqExMUR9xU3GHBqFoiYHWZU7oFCpiADZU5FlOvjQlXN4umQPVZo2=
8VC48ATP9yDcdFh-2FMRIPgpHkHWm5SgnK-2F0lkeMPkQgKhLDvfm5MaQgcIz2zbXRCCW4pP5Dj=
LrtNLKMI3rTYriuQ-3D-3DRUzy_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6=
UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqDbmY3Wgv8EvSKzudkeZoL06nyDuLeTxFy9HL=
SlsfuoHE2-2FqlfYO7bKCH08JyK1hCN53Jq-2FIj-2FlMDagE2CiYYnXXdXuo6eIyP-2BAENNRx=
ffGw5CMQzmU0CpiylVb0q2nm5yRR0IPKO-2B6D4PgVgricfZk-3D" rel=3D"noopener noref=
errer" target=3D"_blank">=C2=A0Register for online attendance Workshop</a><=
br /><br /><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkp=
PwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7qRQEqER-2BE6o3hvNNn27PkNmAPry7CIhV-2FeADHC=
CiQUdTUktQF5lalsVfl11f2xLalw4OjyxN6nCwIDOTmumfHyJjqVBJLJhgr0nnb2Z65pq3nwt8Y=
YL8IVKeq3pKnpCV1mSAeWamsAuFIacPiomxAw0Yk0pQot2W9TVB85JBJEXrSsPtyD9IDYRh417r=
AsLJ-2Bw-2FlFBy8IsPb2M-2FTqanITbpx8Dz8G5NlQ0Ln9lzrWwPmPHCT6rUvhh0ZTMj-2BWXR=
Ce6TAZi6yCBHS6cLaFHV2j3uEYcvDTSt16BiPxfDDJJSQ-3D-3DUQMB_6pwKHJ8Ph1XTyv7ONZl=
OBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqI2t0EcQ=
8QHhEC5qz4WQA4rc0E-2FTso8s8B8pVtsVR1R04rx7j7kQzK6lQSDDIfUjcO7Y-2FkaajisRBDr=
gZ2OxnoqR-2B55RR4c5kUpnTmvRQ-2B66fGnl7JCzYy-2Fhn-2Bu4irbi6qQRT0LeECIxYQRKLC=
7rUZA-3D" rel=3D"noopener noreferrer" target=3D"_blank">Register Onsite att=
endance workshop</a><br /><br /><a href=3D"http://url9271.fdc-k.or.ke/ls/cl=
ick?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7p4w5du2SE-2FVjKzv96TC=
VTI4bgt-2FXY1v6u4m2lmOGd3ZFKQGOYg-2FmXD6yAyLCaTNCa0PcE-2F7lFWGhUsFGwizSvkJG=
XfIOo1lkEOF3Vzgy0eO-2FlOh7h8mBS4ibMQvjwTb4sBn8nrDijof9R4NaAySS2yEOdZug2DllJ=
PsL7T1Iu2b8Ix1Hu0rUn4DJ-2BFIXyJBIOoO7tgUFG02BXj1fGqGu62x8ADdD3Fs-2FgFhTwmSG=
xzUNpurK5hHtDDbdez6v37JCikA6V00CTzj0cnInbtnPPsV2Jk_6pwKHJ8Ph1XTyv7ONZlOBCAy=
k5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqFyOmF0IyDngR=
lJGzRLTNb5uLoC6UJeZZdsjUKa8nyLV-2FlfPNip7k7qr6w0PekX-2BNCtSIIbEq2EV3TkrWGoy=
5jcFO3uyY91YgYBiSoBm-2BCfD9ogk6Es7Z6tw1DR2Di4AZCn-2FQ0kFX01BS7q7ViMD0UM-3D"=
 rel=3D"noopener noreferrer" target=3D"_blank">=C2=A0Register as a group wo=
rkshop</a><br /><br /><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3D=
Ubf5evRrSkpPwdM3-2BNo85JZONGf8ucVQ1rVfuwwq63HP8sunoYpAUF7KTEyeSsZzvU7fvdY-2=
FXStg7i-2BT1EJujEELSaMdkSX5rjRuZnXMdBH2-2BIOHjrFZdDwbJTHzZFaq3EBOBBZkSqxsFf=
xVlf0DEQZ6ojIXNQRG3F4Wra4riTY-3DYf3x_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEK=
YTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqDxbMm79Eq6JdqHAA-2BgacQXTl=
UBJxcZxc2g72mkzi5xxKxEYLdHYI2p2BFiubGeIDMXAQwNzO4SkF6UaAs9spZKQN9ehqQHPCN3t=
4lAeI-2F1ak1JjdKbJPVSWlOg2Ma1oOLPrHrgrjI5ytHMdKICqL2s-3D" rel=3D"noopener n=
oreferrer" target=3D"_blank">Download PDF Calendar 2021 Workshops</a><br />=
=C2=A0<br /><strong>Onsite Centers: Hilton Hotel, Prideinn and Meridian Hot=
el,Kenya</strong><div data-empty=3D"true"><br /></div>OFFICIAL EMAIL ADDRES=
S: training@fdc-k.org<br /><br />Office Telephone: +254712260031<div data-e=
mpty=3D"true"><br /></div><strong>INTRODUCTION</strong><br />New developmen=
ts in data science offer a tremendous opportunity to improve decision-makin=
g. In the development world, there has been an increase in the number of da=
ta gathering initiative such as baseline surveys, Socio-Economic Surveys, D=
emographic and Health Surveys, Nutrition Surveys, Food Security Surveys, Pr=
ogram Evaluation Surveys, Employees, customers and vendor satisfaction surv=
eys, and opinion polls among others, all intended to provide data for decis=
ion making.<br />It is essential that these efforts go beyond merely genera=
ting new insights from data but also to systematically enhance individual h=
uman judgment in real development contexts. How can organizations better ma=
nage the process of converting the potential of data science to real develo=
pment outcomes This ten days hands-on course is tailored to put all these i=
mportant consideration into perspective. It is envisioned that upon complet=
ion, the participants will be empowered with the necessary skills to produc=
e accurate and cost effective data and reports that are useful and friendly=
 for decision making.<br />It will be conducted using ODK, GIS, NVIVO and R=
<br /><strong>DURATION</strong><br />2 Weeks<br /><strong>LEARNING OBJECTIV=
ES</strong><ul type=3D"disc"><li>Understand and appropriately use statistic=
al terms and concepts</li><li>Design and Implement universally acceptable S=
urveys</li><li>Convert data into various formats using appropriate software=
</li><li>Use mobile data gathering tools such as Open Data Kit (ODK)</li><l=
i>Use GIS software to plot and display data on basic maps</li><li>Qualitati=
ve data analysis using NVIVO</li><li>Analyze t data by applying appropriate=
 statistical techniques using R</li><li>Interpret the statistical analysis =
using R</li><li>Identify statistical techniques a best suited to data and q=
uestions</li><li>Strong foundation in fundamental statistical concepts</li>=
<li>Implement different statistical analysis in R and interpret the results=
</li><li>Build intuitive data visualizations</li><li>Carry out formalized h=
ypothesis testing</li><li>Implement linear modelling techniques such multip=
le regressions and GLMs</li><li>Implement advanced regression analysis and =
multivariate analysis</li><li>Write reports from survey data</li><li>Put st=
rategies to improve data demand and use in decision making</li></ul><strong=
>WHO SHOULD ATTEND?</strong><br />This is a general course targeting partic=
ipants with elementary knowledge of Statistics from Agriculture, Economics,=
 Food Security and Livelihoods, Nutrition, Education, Medical or public hea=
lth professionals among others who already have some statistical knowledge,=
 but wish to be conversant with the concepts and applications of statistica=
l modeling.<br /><strong>TOPICS TO BE COVERED</strong><br /><strong>Module1=
: Basic statistical terms and concepts</strong><ul type=3D"disc"><li>Introd=
uction to statistical concepts</li><li>Descriptive Statistics</li><li>Infer=
ential statistics</li></ul><strong>Module 2:Research Design</strong><ul typ=
e=3D"disc"><li>The role and purpose of research design</li><li>Types of res=
earch designs</li><li>The research process</li><li>Which method to choose?<=
/li><li>Exercise: Identify a project of choice and developing a research de=
sign</li></ul><strong>Module 3: Survey Planning, Implementation and Complet=
ion</strong><ul type=3D"disc"><li>Types of surveys</li><li>The survey proce=
ss</li><li>Survey design</li><li>Methods of survey sampling</li><li>Determi=
ning the Sample size</li><li>Planning a survey</li><li>Conducting the surve=
y</li><li>After the survey</li><li>Exercise: Planning for a survey based on=
 the research design selected</li></ul><strong>Module 4:Introduction</stron=
g><ul type=3D"disc"><li>Introduction to Mobile Data gathering</li><li>Benef=
its of Mobile Applications</li><li>Data and types of Data</li><li>Introduct=
ion to common mobile based data collection platforms</li><li>Managing devic=
es</li><li>Challenges of Data Collection</li><li>Data aggregation, storage =
and dissemination</li><li>Types of questions</li><li>Data types for each qu=
estion</li><li>Types of questionnaire or Form logic</li><li>Extended data t=
ypes geoid, image and multimedia</li></ul><strong>Module 5:Survey Authoring=
</strong><ul type=3D"disc"><li>Design forms using a web interface using:</l=
i><li>ODK Build</li><li>Koboforms</li><li>PurcForms</li><li>Hands-on Exerci=
se</li></ul><strong>Module 6:Preparing the mobile phone for data collection=
</strong><ul type=3D"disc"><li>Installing applications: ODK Collect</li><li=
>Using Google play</li><li>Manual install (.apk files)</li><li>Configuring =
the device (Mobile Phones)</li><li>Uploading the form into the mobile devic=
es</li><li>Hands-on Exercise</li></ul><strong>Module 7:Designing forms manu=
ally: Using XLS Forms</strong><ul type=3D"disc"><li>Introduction to XLS for=
ms syntax</li><li>New data types</li><li>Notes and dates</li><li>Multiple c=
hoice Questions</li><li>Multiple Language Support</li><li>Hints and Metadat=
a</li><li>Hands-on Exercise</li></ul><strong>Module 8:Advanced survey Autho=
ring</strong><ul type=3D"disc"><li>Conditional Survey Branching</li><li>Req=
uired questions</li><li>Constraining responses</li><li>Skip: Asking Relevan=
t questions</li><li>The specify other</li><li>Grouping questions</li><li>Sk=
ipping many questions at once (Skipping a section)</li><li>Repeating a set =
of questions</li><li>Special formatting</li><li>Making dynamic calculations=
</li></ul><strong>Module 9:Hosting survey data (Online)</strong><ul type=3D=
"disc"><li>ODK Aggregate</li><li>Formhub</li><li>ona.io</li><li>KoboToolbox=
</li><li>Uploading forms to the server</li><li>Module 10:Hosting Survey Dat=
a (Configuring a local server)</li><li>Configuring ODK Aggregate on a local=
 server</li><li>Downloading data</li><li>Manual download (ODK Briefcase)</l=
i><li>Using the online server interface</li></ul><strong>Module 11: GIS map=
ping of survey data using QGIS</strong><ul type=3D"disc"><li>Introduction t=
o GIS for Researchers and data scientists</li><li>Importing survey data int=
o a GIS</li><li>Mapping of survey data using QGIS</li><li>Exercise: QGIS ma=
pping exercise.</li></ul><strong>Module 12:Understanding Qualitative Resear=
ch</strong><ul type=3D"disc"><li>Qualitative Data</li><li>Types of Qualitat=
ive Data</li><li>Sources of Qualitative data</li><li>Qualitative vs Quantit=
ative</li><li>NVivo key terms</li><li>The NVivo Workspace</li></ul><strong>=
Module 13:Preliminaries of Qualitative data Analysis</strong><ul type=3D"di=
sc"><li>What is qualitative data analysis</li><li>Approaches in Qualitative=
 data analysis; deductive and inductive approach</li><li>Points of focus in=
 analysis of text data</li><li>Principles of Qualitative data analysis</li>=
<li>Process of Qualitative data analysis</li></ul><strong>Module 14:Introdu=
ction to NVIVO</strong><ul type=3D"disc"><li>NVIVO Key terms</li><li>NVIVO =
interface</li><li>NVIVO workspace</li><li>Use of NVIVO ribbons</li></ul><st=
rong>Module 15:NVIVO Projects</strong><ul type=3D"disc"><li>Creating new pr=
ojects</li><li>Creating a new project</li><li>Opening and Saving project</l=
i><li>Working with Qualitative data files</li><li>Importing Documents</li><=
li>Merging and exporting projects</li><li>Managing projects</li><li>Working=
 with different data sources</li></ul><strong>Module 16:Nodes in NVIVO</str=
ong><ul type=3D"disc"><li>Theme codes</li><li>Case nodes</li><li>Relationsh=
ips nodes</li><li>Node matrices</li><li>Type of Nodes,</li><li>Creating nod=
es</li><li>Browsing Nodes</li><li>Creating Memos</li><li>Memos, annotations=
 and links</li><li>Creating a linked memo</li></ul><strong>Module 17:Classe=
s and summaries</strong><ul type=3D"disc"><li>Source classifications</li><l=
i>Case classifications</li><li>Node classifications</li><li>Creating Attrib=
utes within NVivo</li><li>Importing Attributes from a Spreadsheet</li><li>G=
etting Results; Coding Query and Matrix Query</li></ul><strong>Module 18: C=
oding</strong><ul type=3D"disc"><li>Data-driven vs theory-driven coding</li=
><li>Analytic coding</li><li>Descriptive coding</li><li>Thematic coding</li=
><li>Tree coding</li></ul><strong>Module 19:Thematic Analytics in NVIVO</st=
rong><ul type=3D"disc"><li>Organize, store and retrieve data</li><li>Cluste=
r sources based on the words they contain</li><li>Text searches and word co=
unts through word frequency queries.</li><li>Examine themes and structure i=
n your content</li></ul><strong>Module 20:Queries using NVIVO</strong><ul t=
ype=3D"disc"><li>Queries for textual analysis</li><li>Queries for exploring=
 coding</li></ul><strong>Module 21: Building on the Analysis</strong><ul ty=
pe=3D"disc"><li>Content Analysis; Descriptive, interpretative</li><li>Narra=
tive Analysis</li><li>Discourse Analysis</li><li>Grounded Theory</li></ul><=
strong>Module 22: Qualitative Analysis Results Interpretation</strong><ul t=
ype=3D"disc"><li>Comparing analysis results with research questions</li><li=
>Summarizing finding under major categories</li><li>Drawing conclusions and=
 lessons learned</li></ul><strong>Module 23: Visualizing NVIVO project</str=
ong><ul type=3D"disc"><li>Display data in charts</li><li>Creating models an=
d graphs to visualize connections</li><li>Tree maps and cluster analysis di=
agrams</li><li>Display your data in charts</li><li>Create models and graphs=
 to visualize connections</li><li>Create reports and extracts</li></ul><str=
ong>Module 24: Triangulating results and Sources</strong><ul type=3D"disc">=
<li>Triangulating with quantitative data</li><li>Using different participat=
ory techniques to measure the same indicator</li><li>Comparing analysis fro=
m different data sources</li><li>Checking the consistency on respondent on =
similar topic</li></ul><strong>Module 25: Report Writing</strong><ul type=
=3D"disc"><li>Qualitative report format</li><li>Reporting qualitative resea=
rch</li><li>Reporting content</li><li>Interpretation</li></ul><strong>MODUL=
E 26:Basics of Applied Statistical Modelling using R</strong><ul type=3D"di=
sc"><li>Introduction to the Instructor and Course</li><li>Data & Code Used =
in the Course</li><li>Statistics in the Real World</li><li>Designing Studie=
s & Collecting Good Quality Data</li><li>Different Types of Data</li></ul><=
strong>MODULE 27: Essentials of the R Programming</strong><ul type=3D"disc"=
><li>Rationale for this section</li><li>Introduction to the R Statistical S=
oftware & R Studio</li><li>Different Data Structures in R</li><li>Reading i=
n Data from Different Sources</li><li>Indexing and Subletting of Data</li><=
li>Data Cleaning: Removing Missing Values</li><li>Exploratory Data Analysis=
 in R</li></ul><strong>MODULE 28: Statistical Tools</strong><ul type=3D"dis=
c"><li>Quantitative Data</li><li>Measures of Center</li><li>Measures of Var=
iation</li><li>Charting & Graphing Continuous Data</li><li>Charting & Graph=
ing Discrete Data</li><li>Deriving Insights from Qualitative/Nominal Data</=
li></ul><strong>MODULE 29: Probability Distributions</strong><ul type=3D"di=
sc"><li>Data Distribution: Normal Distribution</li><li>Checking For Normal =
Distribution</li><li>Standard Normal Distribution and Z-scores</li><li>Conf=
idence Interval-Theory</li><li>Confidence Interval-Computation in R</li></u=
l><strong>MODULE 30: Statistical Inference</strong><ul type=3D"disc"><li>Hy=
pothesis Testing</li><li>T-tests: Application in R</li><li>Non-Parametric A=
lternatives to T-Tests</li><li>One-way ANOVA</li><li>Non-parametric version=
 of One-way ANOVA</li><li>Two-way ANOVA</li><li>Power Test for Detecting Ef=
fect</li></ul><strong>MODULE 31: Relationship between Two Different Quantit=
ative Variables</strong><ul type=3D"disc"><li>Explore the Relationship Betw=
een Two Quantitative Variables</li><li>Correlation</li><li>Linear Regressio=
n-Theory</li><li>Linear Regression-Implementation in R</li><li>Conditions o=
f Linear Regression</li><li>Multi-collinearity</li><li>Linear Regression an=
d ANOVA</li><li>Linear Regression With Categorical Variables and Interactio=
n Terms</li><li>Analysis of Covariance (ANCOVA)</li><li>Selecting the Most =
Suitable Regression Model</li><li>Violation of Linear Regression Conditions=
: Transform Variables</li><li>Other Regression Techniques When Conditions o=
f OLS Are Not Met</li><li>Regression: Standardized Major Axis (SMA) Regress=
ion</li><li>Polynomial and Non-linear regression</li><li>Linear Mixed Effec=
t Models</li><li>Generalized Regression Model (GLM)</li><li>Logistic Regres=
sion in R</li><li>Poisson Regression in R</li><li>Goodness of fit testing</=
li></ul><strong>MODULE 32: Multivariate Analysis</strong><ul type=3D"disc">=
<li>Introduction Multivariate Analysis</li><li>Cluster Analysis/Unsupervise=
d Learning</li><li>Principal Component Analysis (PCA)</li><li>Linear Discri=
minant Analysis (LDA)</li><li>Correspondence Analysis</li><li>Similarity & =
Dissimilarity Across Sites</li><li>Non-metric multi-dimensional scaling (NM=
DS)</li><li>Multivariate Analysis of Variance (MANOVA)</li></ul><strong>Mod=
ule 33: Report writing for surveys, data dissemination, demand and use</str=
ong><ul type=3D"disc"><li>Writing a report from survey data</li><li>Communi=
cation and dissemination strategy</li><li>Context of Decision Making</li><l=
i>Improving data use in decision making</li><li>Culture Change and Change M=
anagement</li><li>Preparing a report for the survey, a communication and di=
ssemination plan and a demand and use strategy.</li><li>Presentations and j=
oint action planning</li></ul><strong>General Notes</strong><ul type=3D"dis=
c"><li>All our courses can be Tailor-made to participants needs</li><li>The=
 participant must be conversant with English</li><li>Presentations are well=
 guided, practical exercise, web based tutorials and group work. Our facili=
tators are expert with more than 10years of experience.</li><li>Upon comple=
tion of training the participant will be issued with Foscore development ce=
nter certificate (FDC-K)</li><li>Training will be done at Foscore developme=
nt center (FDC-K) center in Nairobi Kenya. We also offer more than five par=
ticipants training at requested location within Kenya, more than ten partic=
ipant within east Africa and more than twenty participant all over the worl=
d.</li><li>Course duration is flexible and the contents can be modified to =
fit any number of days.</li></ul><strong>OTHER UPCOMING WORKSHOPS (REGISTER=
 FOR THE COURSE AS INDIVIDUAL OR GROUP)</strong><br /><br /><ul type=3D"dis=
c"><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM=
3-2BNo85LEQbaHuERyzJbM2r6TTb7rc7xLEHSVGS3UTpippCVgRs05G1eOVAoA-2F8ZAMJubUtT=
PpwSbH1RD7meLAhaSmHercQa4drhKJAUJ9Te-2Bwf3ljC2NxmW5UbXiEyQ9MiuIjVSIrGmoVv1f=
ToC7iYN-2BKRtmDlLRhZiKV-2BvGox1lQi6W37fwz-2FLI6mPoGS9VVpLn34Y0jLd69T5Ey2wnD=
7GIZNLkLU-2B1L-2ByeHU8cA1i0-2FYN5BccdxncHqivoAxqQ5KJKYLCr66lILgv-2B1EYk90EU=
ExdA-3DY4v4_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrK=
ygPPFfkNAasf-2F6tJBxwCUqBVxA0q0sO6djCXfo9diYUp2Y9H0DmT-2BO-2FMNz0W8rqulxuKR=
dseu2vs2SXbzLAjEt2b9rIvXqgQwFMRG5BpUSlry0Ud4nm9veA39izBDbp-2B0Iy5vZJxsdmAV-=
2B5Veh7dLnfPTN1HvMD7NtC7b0eH1nqs-3D" rel=3D"noopener noreferrer" target=3D"=
_blank">Project Monitoring and Evaluation with Data Management and Analysis=
 Workshop from July 26,2021</a></li></ul><br /><ul type=3D"disc"><li><a hre=
f=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQba=
HuERyzJbM2r6TTb7pyjlqB8hF-2FVPslL9uIpyt-2FJ2Nli5OfOO9HwEiwGB-2BSmPSts21TTue=
3BFCMOPXjhQXbndrCibwUN7AtlPctOG8HR4yLrFA1E4NoB8GnZmOV2cDeav4Mdcp3ZXPoEVN922=
2oOLUnwS-2FwvvuIVFJWQukM8nVhVXXqtOdL0Lyyj5QUqXln54t5IG-2BO8UIdkIyAaV4-3Dgzb=
8_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAa=
sf-2F6tJBxwCUqCGZ6-2FnpX2ObW3Ti4gZKtRdFe0lWvcqg4-2FZz89BnSp5lp-2BpCahWgKO9I=
UvC2jkrXp5d9IRjeQP-2BzxsSgZnEmSsXkGtX6je0c80ggKDtjZfum3R-2FRB8qjJLoQyRS4LLK=
v1drR0WTqpCXbezokb-2B8FZMc-3D" rel=3D"noopener noreferrer" target=3D"_blank=
">GIS Data Collection, Analysis, Visualization and Mapping Workshop from 02=
 August,2021 for 10 Days</a></li></ul><div data-empty=3D"true"><br /></div>=
<ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwd=
M3-2BNo85LEQbaHuERyzJbM2r6TTb7rk874w1TV-2BH4Y4pOWnzyn5J-2BJsCg18hKEbShFioO-=
2Bn5oX-2BMxMFqM8gewPuNsr1VvhC7vNJ8uXnUpLFSYCU7qbL30kwiGEMLmevqYqeHzdlctjRQn=
kpBEQIG7yG2OrvtVcXHCCggBZt4X-2BIg8T7D8ez7ZOOYIukRoyRU-2FdGXI0KnIL-2F6kiZSKX=
2eW8dPTVx1h2HBaNF9bCKeusEO3dJ2krcVWv05qq8x9YOD9NWIYzxK00xjIWtSS6N4cAFrw47g0=
U-3DHh2j_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygP=
PFfkNAasf-2F6tJBxwCUqClcDF0k-2FnCATw9tgXBMn50KBlyIpNzYhwQoPOzS1dZmltdXygfX2=
ctdJelX1yHtTnfg-2FP7jt2-2BhEPHGQwdtxJlIjW7H4VHah2FpO3CL-2FRTQ-2B0-2FusMULUd=
BG9O5HkTa6YjARmQ5ekH2l7NbB7b1L-2FnU-3D" rel=3D"noopener noreferrer" target=
=3D"_blank">Strategic Communication Training For =C2=A0Managers And Executi=
ves Program Workshop from 02 August,2021 for 5 Days</a></li></ul><div data-=
empty=3D"true"><br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls=
/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7qlxNFZeg9nEGpZIar6=
NQ9CsfG8wwa21B1oPaieoXiCUXEfaOhob62W-2B1tVth8aBHyL2oguloar-2BtPiiqL1tgAAo-2=
F3l7DPlJiLZCWgDAE2rv1Lx1FaY-2B6TYYGLTDvLBCIvHTrM0jLvgTXMv-2BusmDVgySO39zzEZ=
x5egQ3jts0Xs9E9Jvm4ETebJTZWbPnZlRZ54z9tAiDrhLfBzPwdfkhAbayov_6pwKHJ8Ph1XTyv=
7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqJO=
GlJLROwTDRwcqG84aK-2BCT6SIF6PuVhLImCCHDIPDcOcBIuamEg-2BiW4rWn-2B7hhCrqFbTKC=
mESi3ov3Oq8d-2B6JJ-2Bv3c60chCOLXjgeqYEVNZhq5yIMOQ3HadtNkEtQVEmBcqA2-2F8dsBq=
SnXPFyv5tI-3D" rel=3D"noopener noreferrer" target=3D"_blank">Monitoring and=
 Evaluation for Governance Workshop from 09 August,2021 for 5 Days</a></li>=
</ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url9271=
.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7pFx=
EPeMyhzLlXSJIwm0f4rjAIV8HXDa4X7SdstIPszFwLmyLLllCTuK-2FYq0-2Fg08qtrpTAlhP27=
kM8NC7WJJCE5K6F1D0hBHSgXe82RQYg7BG9CPL5FB2LDm-2FJnVsKc9TRAoEDoo4W7LSyCKWts-=
2B0CjBxiaCzp7xYY-2Bvq7ekYv054YeMo1N7-2FnQYqs1x2ew-2FxE-3DoU62_6pwKHJ8Ph1XTy=
v7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqG=
QChczLWlArx8CpMtqlCUAsp2tiLfYPiAhbibV6rNmEVuXdrrihOJy-2B8RUvEZjVtYMU-2FIIRn=
ge6w1dslqIBiyKFCmI5V7HSOBwDB-2FE0zqjojKxsj1B96MKxgDF0QMxFAOVnuFIEhC7yapFv-2=
Fj-2BgnuE-3D" rel=3D"noopener noreferrer" target=3D"_blank">Training Course=
 on Microsoft Access Workshop from 09 August,2021 for 5 Days</a></li></ul><=
div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url9271.fdc-k=
.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7osCGbRT62=
NaE-2BBhP1kWphQ0LoRuHNohscutZlFPgEsrP2zTXdUxZi1IzDMyVmNtuc93yi-2BL5VFoSM1b7=
jvYWa3p9UEPD-2BwFwFlgpq8Se3RdH4h5VrL3ux9oh580UxLNoFWq-2BCX3BHqtSXI4pw1ySv6B=
HzRW5g3Q4-2Bi-2BGyWtDui5J2YYYTIFHj4hQZvj6hPrxEVPgMZrfiMGomPT-2F6TaxH09mVr_6=
pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-=
2F6tJBxwCUqK7rmGTjPor21bKmxuiB0ulhrECMuDZjCPzyvKIjQ6YfGuhlfZnajR4pVGNDut9lh=
AqHh0YWU6wr-2Ftfp1j7D8VJrPueJaLGqA2yc6IeUiBWgOyWhn8EiR8lf9HKhGRs9T0kor3-2F6=
fzeUjRqe9qHBPTI-3D" rel=3D"noopener noreferrer" target=3D"_blank">Grant man=
agement using Sun accounting system Workshop from 09 August,2021 for 10 Day=
s</a></li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http=
://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM=
2r6TTb7pPzxVZyfituJTzrg65CNlBxShjqprHYyQfLaH8BoPjB7V-2BgJN8SIpsgcl5BoIYbCqX=
GgFki904zdbkOh15O-2B3Sj9FrFYK1JRiiRtABysyQQtaPK-2FPHRRReVb9iSSlSITIGLbqnoIU=
HgS-2BUZGUC9KF3FXHk9SOfeisDlS-2Fi4W407ZXKuvVolPND17qtmupP1BFYgOz9I-2F5BK7GO=
Rj-2FmgsGw3MJr-2BfgmFwhEIol0eQ70MpyLSplvAAzMLxZsvx1WPH8T-2FGmotjExAm7pJ0D31=
9eS9ZjFZwXqjp03oP0DAbCnnw-3D-3DgzYI_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKY=
TQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqOUKe9sJZXv-2FKC8vs2nixH0Mog=
pc83R60SxvWEdtYMazx2fPGnRy6jrV8NagrOMsCgZIU67X5NlmaiLvPSDOHTqhMzBXVyBwllFDn=
ertXQAaXoUuhiyHHH6KcbRxGkPrUzKpm08w-2B4E08R3QE0w2XLs-3D" rel=3D"noopener no=
referrer" target=3D"_blank">Financial Management, ERP systems, Accounting, =
Capital budgeting, Presentation design, Management, and Negotiation Worksho=
p from 23 August,2021 for 5 Days</a></li></ul><div data-empty=3D"true"><a h=
ref=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQ=
baHuERyzJbM2r6TTb7pfjURjQvnA0VwWB16SC9PVoU2UNERhAqpYGZf8kL0QPIyPQqpEYrlDVsR=
-2FUedmvgn87BjGOsWLwmg-2BPVJrqpWWrA0ngpnssZ549AeyLkqpyyvEr-2FMbc2RzOoZgylOV=
EuyIMoqc2-2FulJRryx5zn-2BPaNsYLdFMJ4B27MErsLzyXXrmMxsYYd2ZffNJYc8UNTqALI6BT=
q9YUoi0LL9RDPEwKJy-2FiCLS2j-2BQHoN-2BuT6zhBpO5oFUC-2FOzXAphlWMsCEbG4-3DfTtx=
_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAas=
f-2F6tJBxwCUqE3xE97c24SwWSf5QYZlwyD-2F4MbZhxwDZvYzV6L4FjyNe8WP07i8HQxnjpvee=
EHFlvalQJUUvHjKqIierS7aubs-2FizAQk3VuRDh0FT4vzWtoy92uryeX1ix4mw4HnSH4fjVNWm=
uJNABxWaWCtuU-2BxWs-3D" rel=3D"noopener noreferrer" target=3D"_blank"><br /=
></a></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf=
5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7pfjURjQvnA0VwWB16SC9PVoU2UNERhAqpY=
GZf8kL0QPIyPQqpEYrlDVsR-2FUedmvgn87BjGOsWLwmg-2BPVJrqpWWrA0ngpnssZ549AeyLkq=
pyyvEr-2FMbc2RzOoZgylOVEuyIMoqc2-2FulJRryx5zn-2BPaNsYLdFMJ4B27MErsLzyXXrmMx=
sYYd2ZffNJYc8UNTqALI6BTq9YUoi0LL9RDPEwKJy-2FiCLS2j-2BQHoN-2BuT6zhBpO5oFUC-2=
FOzXAphlWMsCEbG4-3DO8z0_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZn=
z0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqPpNznEIP9Pp0cY9ql0CFIJOPKz6vna8VdLS4-2B=
ylsNNAJr-2B6b8EwJdjZDmO968YYFOTaFvMfvMNadea7qx4TfzzyDqJWdxSOO-2FqlRTJ6Csy1M=
NqKY79OOdgDq8Bi2l0tlDjeoDGdtqLeK53eoawTV6A-3D" rel=3D"noopener noreferrer" =
target=3D"_blank">Mobile Data Collection using ODK & KoboToolBox for Monito=
ring and Evaluation Workshop from 23 August,2021 for 5 Days</a></li></ul><d=
iv data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url9271.fdc-k.=
or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7rxm5WGk6h8=
z3WQNBEkuWHK7RXWhXYVXTUssIMVpJAM91nSlubxiIuy4e9xfYfNEKoOq1xLCuvfmxb4zudv3Q0=
epHsSsecdI0A46PqZBzKIlebxiGQTjzG3glw6Z7zz0O9fSq2F024Nk-2B6iGAY785n03VPe06RI=
M-2BwX3eUiaJkkF8xzurH9ovl1ZjWXmXpQCrg-3DTTsY_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C=
6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqLz44-2FHjIRBkJVdn3=
0X6KOIYb1Mt1APg2T8-2F2vNUZvHp1RVzyxbpzkLR57HFwF2r6YCycWcOofaXmvMp4SFUbuf-2F=
iI2WJrxq53nEj6Mur6kPQk6IOhaLoc-2FOGUQTZ0bO1wzBgdQGWqeVyTinNu9jt6I-3D" rel=
=3D"noopener noreferrer" target=3D"_blank">Leadership and Diplomacy Trainin=
g Workshop from 23 August,2021 for 5 Days</a></li></ul><div data-empty=3D"t=
rue"><br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=
=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7oQhFOLACQ-2BQcPIggU50O6ImAhq=
pHjOBRL-2FremUW-2FixAcaEdUOOiE6GGgZWE7RvNbYzewzISFRyrc-2F9sHU4izJS8HbLP8dL-=
2FtwMs7s-2BJPeTKGRTRAzH6Tv5VkPg3OllFkk5vbcFIzCFpWyC0kyA-2Bw5gQwUu6nhhfUI-2F=
7U1-2BPDsoJtZr8hnJo6qZiXpfqfZTUZfQv2trPsm7E3JvAwWQwYPgay4f_6pwKHJ8Ph1XTyv7O=
NZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCUqGOY4=
hYViNVgk-2FLPUefPaD9ct8C-2F9weVE-2BgI73rGMsGhFIP1OQZFKkIkOViW2JESFe1hvwj9ht=
YYtdwrV6G-2FlZz7Ca-2B-2BDsVCWybvdTVsa5Hiiolf7C0DxKhDwup6fc4JEJY7WPalSc-2BLV=
mlhtHwsoiI-3D" rel=3D"noopener noreferrer" target=3D"_blank">Monitoring and=
 Evaluation for Food Security and Nutrition Workshop from 30 August,2021 fo=
r 10 Days</a></li></ul><br /><ul><li><a href=3D"http://url9271.fdc-k.or.ke/=
ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7q2Jj7v3UVw3wMcCm=
nFqishF0KZzdL9NRI7IXtho8mkfTetj1QwvgrwMZDCWzqpV-2FOJLd0T5w4HeF6pCG7REYqCVgu=
iZZUt1vvmDvte1RY2o-2Be-2Fzq58aw-2FU2GnEkzCVOeACqBs-2BYHgt-2F6NKpAy6BR9QGxCR=
IsBQF4sI6gS2VygRvVOvYKtfQZ08HiZCgynqaB8Gttvq6AGsZK5LfSogKV79p052_6pwKHJ8Ph1=
XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwC=
UqGXliJtpB4MjhIlfaSHNPKfGK-2B0kPJURbNfwXmc4OjrLpAnW2nk6sii3qwYL551PjvMiiKzA=
-2Fi3hm7pH6Y9SCdTnuLdS9XjJbIrGU5Eu3ZGu2N7nciN2PdJ-2B7teIscDSSu-2FDk-2BCfLcF=
XTpNs8K91Oh0-3D" rel=3D"noopener noreferrer" target=3D"_blank">GIS and Data=
 Analysis for WASH (Water Sanitation and Hygiene) Programmes Workshop from =
30 August,2021 for 10 Days</a></li></ul><br /><ul><li><a href=3D"http://url=
9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb=
7qRG8pZdJ5sBi0jHIE-2BcULXsEh8sHIa2-2BZbBS28zR9Hq0Wjj7IouO-2B6dvuG4jLfGTZOQe=
61z97heLnwNPpuiHIgAZExlbvTfQH6I61rRSdm9IX64uxovi4ql9k-2FuAluol23SCIcfNp1Jcd=
250dEE1FwfP0QN8-2FMUHoAGEDLqYHQCVJ-2Fgw22PXiZGv2FeCF35wo-3DC9CC_6pwKHJ8Ph1X=
Tyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2F6tJBxwCU=
qLEG7HlhQYLlW2vO8AHY9SMnbEaeM-2FvhdFtjw-2FF6YCs9JgUob01h9vJ5GhuTmCghpu0Q0j0=
hE82IX3S8QFHXlFsGnd-2FDtXerAWllppXHeO1-2B-2BG54NF0IjuYAQyih5Qq6MY-2FpKqG8D1=
G7zq92ojVM01s-3D" rel=3D"noopener noreferrer" target=3D"_blank">Advanced Ma=
nagement Program Workshop from 30 August,2021 for 5 Days</a></li></ul><br /=
><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPw=
dM3-2BNo85LEQbaHuERyzJbM2r6TTb7r-2FmyR2RNJJvSneOpnSpSff7bOBTjY7ldOCrPI2rXXx=
na465BTcgObs0doXi68gEgR4UtuCGb0k0aVOPI-2FhKRHe5SVQDu5HCkXxoJvzHZNxxDGZ275Cz=
QzLc6Z1OdwQr4d7okr3itw-2F-2FzdU-2FsGWnMZuoQOUHD27mCk8xdlWCy7e9sL6jHNtFwcvlZ=
dR4NyPyqw-3DCwSf_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL=
8iqrKygPPFfkNAasf-2F6tJBxwCUqNVPckbn-2BkkMQmqsM3-2BcDwq2DdyxHLM-2B3MDKSYieu=
0BH6Ng-2BbS162lIFsh6Ju7CZlDLt-2FCxKeLFGBb9FcMxHrN-2BTCZM7QGcO8d6BqOasrpGQjC=
u1GM5FtvUI1lQgokozszDYH1-2B0I-2FyEmHCYZLMLhz0-3D" rel=3D"noopener noreferre=
r" target=3D"_blank">Grant Management and Fundraising Workshop from 30 Augu=
st,2021 for 10 Days</a></li></ul><br /><ul><li><a href=3D"http://url9271.fd=
c-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85LEQbaHuERyzJbM2r6TTb7qs1p8d=
UYwrGDisrndFHyeKoRHnpIzgAC-2F6jeJ5wmR-2Bgtc4Z0dTvZkEecwd6jxDtH7fsW2cx2WugZR=
iP4HNTQuFTMp3X4wqSOgwrb3z-2FYVsHFTXP0I7SYWjTC4dMuIbMXDkTd7h27H-2FgFdbCHeZYy=
qUq31-2FNa3iAn0fk0IAlONqrvf8hQymImtJDHQbRikqePHXLwqHTn58zU6TE0tX9X6qKd4p_6p=
wKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD9rGMm6UZnz0wXGyL8iqrKygPPFfkNAasf-2=
F6tJBxwCUqME8khgzbLn-2FzW3iUKnje-2FUTiondp2r4Ecc2Spo4P-2Bd-2BAtBRA43CMhoSd8=
uZ07m3bFTkb5A-2BlvGLdjl-2Fvktb6NptJFXGT89Vi-2Fus1N8vIroQza9YzapEEJ7V4GopUZm=
NuC4w4SyYzqUqs1ZHKjETPFU-3D" rel=3D"noopener noreferrer" target=3D"_blank">=
Gender Equity Achievement in Development Projects Workshop from 30 August,2=
021 for 5 Days</a></li></ul><br />Looking forward to your =C2=A0participati=
on,<br />=C2=A0<br />FDC Result Based skills Development,<br />Regards,<br =
/>FDC Training Team,<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 width=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"708"><div data-empty=
=3D"true"><br /></div></td></tr></tbody></table></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </div>
<img height=3D"1" width=3D"1" src=3D"https://mautic.fdc-k.or.ke/email/60e5a=
1b27d9d3588324248.gif" alt=3D"" />
If you'd like to unsubscribe and stop receiving these emails <a href=3D"htt=
p://url9271.fdc-k.or.ke/wf/unsubscribe?upn=3DoDb6ny51mUB6FExYn3rQhnEsRzMLZB=
2XMeq5leS37lAB-2BfhNUnV5YteSV-2BNC4hMm-2By-2FGgd-2FmnLPsqOZlIlkzlVCIYdxMIfx=
66oOrrc5XLcKUyAy8Fduc-2FCfBWq6VTqX4qmYKTAMHUId6B8-2B5pPfpVlJv7A-2Bu0Uu0Xwnm=
4x4l-2Fg07BVPma-2Blt96YQce-2BCXeBEWScg72-2BmGLUUoW3xSvjcqQBHYHz7UVhZSPo-2FV=
B5FMCQ-3D">click here</a>.
<img src=3D"http://url9271.fdc-k.or.ke/wf/open?upn=3DoDb6ny51mUB6FExYn3rQhn=
EsRzMLZB2XMeq5leS37lAB-2BfhNUnV5YteSV-2BNC4hMm-2By-2FGgd-2FmnLPsqOZlIlkzld8=
AX5P25Wov5R-2FV4FAVfqQAjQBUaW94X9nJjTtPhG8ZfuLQBkutk-2BX0IioAaXhhFb3qA6FF70=
qOSi2kKfooT4nfYT0c3yR-2BZuMacf-2FpSPZR4rx45Db-2B1JtWgp9adgjgZ97W8jNn8ZAkoBQ=
4oEefhGiGvDzblOAOfP9s4epyXWXF" alt=3D"" width=3D"1" height=3D"1" border=3D"=
0" style=3D"height:1px !important;width:1px !important;border-width:0 !impo=
rtant;margin-top:0 !important;margin-bottom:0 !important;margin-right:0 !im=
portant;margin-left:0 !important;padding-top:0 !important;padding-bottom:0 =
!important;padding-right:0 !important;padding-left:0 !important;"/>
</body></html>
