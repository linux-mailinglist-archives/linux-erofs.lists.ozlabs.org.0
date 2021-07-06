Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F33BD7CA
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 15:27:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GK3J14bbNz3022
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 23:27:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256 header.s=s1 header.b=l2/6xxyQ;
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
 header.s=s1 header.b=l2/6xxyQ; dkim-atps=neutral
Received: from wrqvqzqh.outbound-mail.sendgrid.net
 (wrqvqzqh.outbound-mail.sendgrid.net [149.72.78.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GK3Hy1qSwz2yLd
 for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jul 2021 23:27:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fdc-k.or.ke; 
 h=content-transfer-encoding:content-type:from:mime-version:to:subject:list-unsubscribe;
 s=s1; bh=+IuF3gSUKbnkz6Lci/7a6lNEhHx9omi5tPI9xBfjXwU=; b=l2/6xxy
 QHEPRxnm6XOuEg+mHH/CPtQ+Lnwgd288dOnFXUkLDWLgF1yikil7lq1ei47L0srA
 DhmJ7W2hagLCjVGkhkuz9cxEnGPytO/T3bii/0k+APYokO4mHRsUKW2oxuh+PDkS
 93nW+SS8hP0mX7tEcBghJfONgb2wfYtXrTzk=
Received: by filter2882p1mdw1.sendgrid.net with SMTP id
 filter2882p1mdw1-21685-60E45813-2
 2021-07-06 13:18:11.66172867 +0000 UTC m=+414236.751211750
Received: from MTc0MzAzNDc (unknown)
 by geopod-ismtpd-6-2 (SG) with HTTP id JwTu9LX-T_Kzk1rAV6BI7Q
 Tue, 06 Jul 2021 13:18:10.887 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
Date: Tue, 06 Jul 2021 13:18:56 +0000 (UTC)
From: "FDC -K" <workshops@fdc-k.or.ke>
Mime-Version: 1.0
To: linux-erofs@lists.ozlabs.org
Message-ID: <JwTu9LX-T_Kzk1rAV6BI7Q@geopod-ismtpd-6-2>
Subject: Invitation to Research Design,ODK,GIS,NVIVO and R Worksop Workshop
X-SG-EID: D/WhaQyL81n52MRUxySh/FGW0Tvj3TKiZPeU+9+BRFaM/jKoBWyfke9Mlob4b5KfhRS1vwRADEDQkR
 H8mcEaevuefKBcxUHE1MUEpPcOpQ4YhxGX9b0imXBKpg88GkTOqxZ5EEasr2ZGlzTWRpzlzfOG9Mjy
 lmaoGKiPZYNx5vPvy0Kj+jHmkvY2Uy+jySADU1HUblizUoV9Xv49uoNpKdHqdkZadLwReqeJXN0qKq
 U=
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
Ubf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6SHC7KEVTOlmVDfTSomTMWsmiATGf5kl=
yn24-2BvolCTboD9G4TTMLH77p2VnvDDl34r0YfquFsmVDmdZ-2BzM2eZ22VRNXr-2BdgUnnqRV=
-2BQo6MEd2bCthfp6A-2FvKYFtyURto3f4mTOBOO1GuLvYmo0RUtf24oo38JX7tI-2BvnoEmhw6=
BnBpvIGSBlC8DR-2F3JfbLcbdh-2Fqea5Wb8cUFubmsOzLdMxSI23E-2Bdv3cSkZiFqcCn90FD4=
NE9d52vBkBFLwK6U6QxPmZvyTWm4oa3-2BUChIyR7zzZ0ISk70swR-2B0DgPHTIfJ2tUMCNiotD=
OFxcdr-2FTjm9KmHH4rzkQFvCcigySGrnJIoJWKezNf-2FLJuPrCNE3cvpTQKp6wh3GJYLJZS3Q=
4WAbKBqcoEH4kKamPFJiiouiLmBu-2BV5bvikxWGcSLOTu6CzZ0gYrgHuWGJAdte99AeuLc-3Dv=
D17_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAq=
WDatV-2BKDt-2BnSEFKJ-2BfZebJBMGAWbN8AkGd5ncLWs0ClaSbvFXBijH72crwQgGsSEIOR7v=
Sg-2FQekjqV0jZ9kdclvwTxLJAPs60rherNqIVP6PWi3UhG-2B-2FvQ9GlKR4Uo-2B-2BAEkuY3=
ml9xluPLgSnML9YbPOGcYGJA6nQH2pR0-3D" rel=3D"noopener noreferrer" target=3D"=
_blank"><strong>Research Design,ODK mobile data collection,GIS data mapping=
,Data analysis using NVIVO and R Workshops-July 26 to August 06,2021 for 10=
 Days</strong></a><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" w=
idth=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"708"><div data-empty=
=3D"true"><br /></div></td></tr></tbody></table><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" width=3D"0"><tbody><tr><td valign=3D"bottom" w=
idth=3D"1049"><div data-empty=3D"true"><br /></div></td></tr></tbody></tabl=
e><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BN=
o85Ax5S5a7tfns4DfJaFCSo6SC6b02D0tvJWek-2Foh87eZu-2FAAIb-2BbNG3GgY0WH18N9goL=
NhyWzc4XwPU8r2okkcDGqAIQOfKt3hjRBRyVA1fWndh1-2BXEUFTkrK7HCvbTCtXTn04ElrnIGU=
teUe4BaQZdh1cUGI0C8NPmWH702kkJwZ60WhTm-2F6ms-2BUO9ZWG3-2FaapdutfzW3OA0kfjwf=
Nh36vUrVeveZepDJaxXhpy4Nkg-2Bb9dxKefH-2Bx8VHhRbFsDZO8tKjqZcs3t5w8TSgrsHIKPV=
LFbhgG6DJZxE48s8Onpts1rAK0vZaXtuJRUa7PpWUtFhBD4XJZOywHceLpf7UHOfQARs5zsAGz3=
tHITV8x65X6Vpupk-2BVNw-2FRs-2B5u7BoSc3aY1KxKj2mQR1tdfjZ-2FC0NWNaJXKeLVPtcSd=
kUYBCewEnvOQYA9Yk7vix2uw24Bt4enagG58jHHK2-2FF765rkk-3Dgj2k_6pwKHJ8Ph1XTyv7O=
NZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ=
ySudP3UZbhckOYwVR-2Fduck52ICdFOit3u5TtSsbAA-2FKsJ6hQr-2BpQNyCiJ3kdYi8CF-2Fm=
l2ZDpgLsBVODB5T92F24kXElwfTjK52-2Bnt-2FUoGkCygmRwnQ60-2FUIAaExYRwiKAQaidO4B=
Dbo90ZZ2q-2B1TYE-3D" rel=3D"noopener noreferrer" target=3D"_blank">=C2=A0Re=
gister for online attendance Workshop</a><br /><br /><a href=3D"http://url9=
271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6=
SxN7LqfMEy2fAm4Yyfc8isVfiFdMMo-2B-2FtBdbypay4ItqW52BL-2B-2FUtemCH4gG5sx3jDg=
VcJ4NUWniL7n6yk9meaQQI-2FV-2FHubRJpSSHgfBwS0h6geT20g-2BccaTYCXyKd92DAIBGQh5=
fOMyBW-2BKg7hupS7AqQ-2BRhWoy-2BfObtIntL0Cmur7-2BakK-2B-2BN0ZEcgzH5GdxITrqOw=
cqJKRTCc69a-2FTLPsKaeUuw8iifqE-2F2zsBr4tZ4aHLSK-2FaJw5uEvm8D9SncR-2BPMu4yND=
fkToViXYwxxHqcQWDNiEb4UfeK4HIs257f1HhNdxUt4wJbw3sw4ROOsPlcugEtpiqsHnDv7wKfI=
3L3DHeq-2FX8I5DsxjbN3Zm-2FZvcbk2XpDHd-2FcI9ZXXlr9HPKQ1j9HtfAYhL5oxx9Ga99gZ-=
2Bbb-2Foctsq9vl11ZrdKJ9Tw-2Bsl7e43bwN5MiH97ZM-3Dj64n_6pwKHJ8Ph1XTyv7ONZlOBC=
Ayk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ72g-2F=
knu0lL9h6-2F17cAh4I4lJMER3-2BRCQgdp-2BOFKh-2F0n2FaTHgzAzBcwb0gBL3Yjulq6GEq7=
H4NacnbAgI7uzHzhVXkttqCrNqjLdO-2FBcuKHAHj-2FsYIBPsd7Xsce6RmXMssFXPk6svusdcD=
H4gAv0JQ-3D" rel=3D"noopener noreferrer" target=3D"_blank">Register Onsite =
attendance workshop</a><br /><br /><a href=3D"http://url9271.fdc-k.or.ke/ls=
/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6SkpQJnb4cxlBg-2FR7=
jVR4fBxg7eNiQiqQTxUCoPI0wv5i8vPM9zZ9ayYorQwQNdE-2FMFFI7AZN0-2FjxtRCtuuq4qKM=
wsm-2Bms9-2BIiDeomtv0oj5X1Cl2UChv6LD3dIJfbcnQETOMZyjpRsbTAM9bnUpBCgM1xyLxzn=
eYyxBsT7Z3mShAQIMrPcsOMKh1Te5lFlDDPnE9mkhQOb4tUFnlwesym9GIcYJ2yNJNTPmkz6CDK=
HDbtjf2nPge6BD4hurKEQntDGmRyM6UWXKzX71oqG6ZO-2FabS8jc-2BhTzEg00RLAoIeDtvLXg=
df31Dpe-2F8zJYY-2Fm-2Ffl4KVoj05W92yhp5T3uITkQhk3je0jMenWwoCIZ0jeLU6h27G38Xl=
VaApWaMKnwrdL8KICk-2BpBDZjR6hB0VqxWRgDdpkLEPdKHv-2F6HLzZRboTjKCDQBHG0gALpo7=
pfq5U-3DNr7v_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZ=
uKzSszYAqWDatV-2BKDt-2BnSEFKJ7QO1K05WQKh9OBKWrFHptQTwynLMQ-2FxNC4gGOkWi2ucA=
gWvNuhzoP7DHl25Uq6HZ9XEhD8GY8GrmYQDIgFYHRTakf8PIZY-2FHm69gf6lyAbz7qbEFiJbmG=
-2Fm9b9XUcP-2FjPeoRZDa-2BnlR2OKG9K4tDqg-3D" rel=3D"noopener noreferrer" tar=
get=3D"_blank">=C2=A0Register as a group workshop</a><br /><br /><a href=3D=
"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tf=
ns4DfJaFCSo6Q7dsVRgarJPQrjWUnDHTBbZBlXRbcOxEdjYMREnuMh1cSuvLpTQCBeSRyUaQTZj=
2IfrV3DuMQ-2BQ3hPv1-2Fo7jI4Vn4Ljpnag56b46n1mWxVb3oEpYx9m4UYxPbKy7ewSNgHktxB=
kmTJqiR0mgUbtRG4El7MwHRYxCtVzUuLwClnhpYBHFi8Oo-2B3uoixaOutxl7h6AfcDaflcenSO=
aI8Y8nXYGxZjDLmD665Jsnq1hYRWTXCnr-2F3T5zzHRhxUjwygKbo2Gx0oGeJ-2BqyRdzb0ZqAZ=
OZK49ZxM-2BYXVMl2iYcLDBmqSrDRQulCEOGSDucZzYihRsoBlj4Fq4LU2M7cXsPQ4yzIO1g9FT=
SRYyFHaVLv7DWuM-2BN3iXYuF3G62G4ejZg-2Bx6EUUiXrVBvAdkZ1waJd-2Ff23XFRaAJXMoPb=
Sk5MTUTyP575N5zEsEqUR1c8xHu-2Fc-3DT5oL_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdC=
EKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ4QGXiv2z2w2U56eCmtCh=
4CbDy-2BG1d8iNtBf2-2F4xytmH0A2uphshXcFqPwOiAJ6em89ulJO20rfE4w7BzDR-2BAgHJl1=
s4eDJLuUFS2ZCnshQ8-2FdiPgla1AYNv5jx5VGaL1X5mYL-2BlPJRNfdr9FQhL93U-3D" rel=
=3D"noopener noreferrer" target=3D"_blank">Download PDF Calendar 2021 Works=
hops</a><br />=C2=A0<br /><strong>Onsite Centers: Hilton Hotel, Prideinn an=
d Meridian Hotel,Kenya</strong><div data-empty=3D"true"><br /></div>OFFICIA=
L EMAIL ADDRESS: training@fdc-k.org<br /><br />Office Telephone: +254712260=
031<div data-empty=3D"true"><br /></div><strong>INTRODUCTION</strong><br />=
New developments in data science offer a tremendous opportunity to improve =
decision-making. In the development world, there has been an increase in th=
e number of data gathering initiative such as baseline surveys, Socio-Econo=
mic Surveys, Demographic and Health Surveys, Nutrition Surveys, Food Securi=
ty Surveys, Program Evaluation Surveys, Employees, customers and vendor sat=
isfaction surveys, and opinion polls among others, all intended to provide =
data for decision making.<br />It is essential that these efforts go beyond=
 merely generating new insights from data but also to systematically enhanc=
e individual human judgment in real development contexts. How can organizat=
ions better manage the process of converting the potential of data science =
to real development outcomes This ten days hands-on course is tailored to p=
ut all these important consideration into perspective. It is envisioned tha=
t upon completion, the participants will be empowered with the necessary sk=
ills to produce accurate and cost effective data and reports that are usefu=
l and friendly for decision making.<br />It will be conducted using ODK, GI=
S, NVIVO and R<br /><strong>DURATION</strong><br />2 Weeks<br /><strong>LEA=
RNING OBJECTIVES</strong><ul type=3D"disc"><li>Understand and appropriately=
 use statistical terms and concepts</li><li>Design and Implement universall=
y acceptable Surveys</li><li>Convert data into various formats using approp=
riate software</li><li>Use mobile data gathering tools such as Open Data Ki=
t (ODK)</li><li>Use GIS software to plot and display data on basic maps</li=
><li>Qualitative data analysis using NVIVO</li><li>Analyze t data by applyi=
ng appropriate statistical techniques using R</li><li>Interpret the statist=
ical analysis using R</li><li>Identify statistical techniques a best suited=
 to data and questions</li><li>Strong foundation in fundamental statistical=
 concepts</li><li>Implement different statistical analysis in R and interpr=
et the results</li><li>Build intuitive data visualizations</li><li>Carry ou=
t formalized hypothesis testing</li><li>Implement linear modelling techniqu=
es such multiple regressions and GLMs</li><li>Implement advanced regression=
 analysis and multivariate analysis</li><li>Write reports from survey data<=
/li><li>Put strategies to improve data demand and use in decision making</l=
i></ul><strong>WHO SHOULD ATTEND?</strong><br />This is a general course ta=
rgeting participants with elementary knowledge of Statistics from Agricultu=
re, Economics, Food Security and Livelihoods, Nutrition, Education, Medical=
 or public health professionals among others who already have some statisti=
cal knowledge, but wish to be conversant with the concepts and applications=
 of statistical modeling.<br /><strong>TOPICS TO BE COVERED</strong><br /><=
strong>Module1: Basic statistical terms and concepts</strong><ul type=3D"di=
sc"><li>Introduction to statistical concepts</li><li>Descriptive Statistics=
</li><li>Inferential statistics</li></ul><strong>Module 2:Research Design</=
strong><ul type=3D"disc"><li>The role and purpose of research design</li><l=
i>Types of research designs</li><li>The research process</li><li>Which meth=
od to choose?</li><li>Exercise: Identify a project of choice and developing=
 a research design</li></ul><strong>Module 3: Survey Planning, Implementati=
on and Completion</strong><ul type=3D"disc"><li>Types of surveys</li><li>Th=
e survey process</li><li>Survey design</li><li>Methods of survey sampling</=
li><li>Determining the Sample size</li><li>Planning a survey</li><li>Conduc=
ting the survey</li><li>After the survey</li><li>Exercise: Planning for a s=
urvey based on the research design selected</li></ul><strong>Module 4:Intro=
duction</strong><ul type=3D"disc"><li>Introduction to Mobile Data gathering=
</li><li>Benefits of Mobile Applications</li><li>Data and types of Data</li=
><li>Introduction to common mobile based data collection platforms</li><li>=
Managing devices</li><li>Challenges of Data Collection</li><li>Data aggrega=
tion, storage and dissemination</li><li>Types of questions</li><li>Data typ=
es for each question</li><li>Types of questionnaire or Form logic</li><li>E=
xtended data types geoid, image and multimedia</li></ul><strong>Module 5:Su=
rvey Authoring</strong><ul type=3D"disc"><li>Design forms using a web inter=
face using:</li><li>ODK Build</li><li>Koboforms</li><li>PurcForms</li><li>H=
ands-on Exercise</li></ul><strong>Module 6:Preparing the mobile phone for d=
ata collection</strong><ul type=3D"disc"><li>Installing applications: ODK C=
ollect</li><li>Using Google play</li><li>Manual install (.apk files)</li><l=
i>Configuring the device (Mobile Phones)</li><li>Uploading the form into th=
e mobile devices</li><li>Hands-on Exercise</li></ul><strong>Module 7:Design=
ing forms manually: Using XLS Forms</strong><ul type=3D"disc"><li>Introduct=
ion to XLS forms syntax</li><li>New data types</li><li>Notes and dates</li>=
<li>Multiple choice Questions</li><li>Multiple Language Support</li><li>Hin=
ts and Metadata</li><li>Hands-on Exercise</li></ul><strong>Module 8:Advance=
d survey Authoring</strong><ul type=3D"disc"><li>Conditional Survey Branchi=
ng</li><li>Required questions</li><li>Constraining responses</li><li>Skip: =
Asking Relevant questions</li><li>The specify other</li><li>Grouping questi=
ons</li><li>Skipping many questions at once (Skipping a section)</li><li>Re=
peating a set of questions</li><li>Special formatting</li><li>Making dynami=
c calculations</li></ul><strong>Module 9:Hosting survey data (Online)</stro=
ng><ul type=3D"disc"><li>ODK Aggregate</li><li>Formhub</li><li>ona.io</li><=
li>KoboToolbox</li><li>Uploading forms to the server</li><li>Module 10:Host=
ing Survey Data (Configuring a local server)</li><li>Configuring ODK Aggreg=
ate on a local server</li><li>Downloading data</li><li>Manual download (ODK=
 Briefcase)</li><li>Using the online server interface</li></ul><strong>Modu=
le 11: GIS mapping of survey data using QGIS</strong><ul type=3D"disc"><li>=
Introduction to GIS for Researchers and data scientists</li><li>Importing s=
urvey data into a GIS</li><li>Mapping of survey data using QGIS</li><li>Exe=
rcise: QGIS mapping exercise.</li></ul><strong>Module 12:Understanding Qual=
itative Research</strong><ul type=3D"disc"><li>Qualitative Data</li><li>Typ=
es of Qualitative Data</li><li>Sources of Qualitative data</li><li>Qualitat=
ive vs Quantitative</li><li>NVivo key terms</li><li>The NVivo Workspace</li=
></ul><strong>Module 13:Preliminaries of Qualitative data Analysis</strong>=
<ul type=3D"disc"><li>What is qualitative data analysis</li><li>Approaches =
in Qualitative data analysis; deductive and inductive approach</li><li>Poin=
ts of focus in analysis of text data</li><li>Principles of Qualitative data=
 analysis</li><li>Process of Qualitative data analysis</li></ul><strong>Mod=
ule 14:Introduction to NVIVO</strong><ul type=3D"disc"><li>NVIVO Key terms<=
/li><li>NVIVO interface</li><li>NVIVO workspace</li><li>Use of NVIVO ribbon=
s</li></ul><strong>Module 15:NVIVO Projects</strong><ul type=3D"disc"><li>C=
reating new projects</li><li>Creating a new project</li><li>Opening and Sav=
ing project</li><li>Working with Qualitative data files</li><li>Importing D=
ocuments</li><li>Merging and exporting projects</li><li>Managing projects</=
li><li>Working with different data sources</li></ul><strong>Module 16:Nodes=
 in NVIVO</strong><ul type=3D"disc"><li>Theme codes</li><li>Case nodes</li>=
<li>Relationships nodes</li><li>Node matrices</li><li>Type of Nodes,</li><l=
i>Creating nodes</li><li>Browsing Nodes</li><li>Creating Memos</li><li>Memo=
s, annotations and links</li><li>Creating a linked memo</li></ul><strong>Mo=
dule 17:Classes and summaries</strong><ul type=3D"disc"><li>Source classifi=
cations</li><li>Case classifications</li><li>Node classifications</li><li>C=
reating Attributes within NVivo</li><li>Importing Attributes from a Spreads=
heet</li><li>Getting Results; Coding Query and Matrix Query</li></ul><stron=
g>Module 18: Coding</strong><ul type=3D"disc"><li>Data-driven vs theory-dri=
ven coding</li><li>Analytic coding</li><li>Descriptive coding</li><li>Thema=
tic coding</li><li>Tree coding</li></ul><strong>Module 19:Thematic Analytic=
s in NVIVO</strong><ul type=3D"disc"><li>Organize, store and retrieve data<=
/li><li>Cluster sources based on the words they contain</li><li>Text search=
es and word counts through word frequency queries.</li><li>Examine themes a=
nd structure in your content</li></ul><strong>Module 20:Queries using NVIVO=
</strong><ul type=3D"disc"><li>Queries for textual analysis</li><li>Queries=
 for exploring coding</li></ul><strong>Module 21: Building on the Analysis<=
/strong><ul type=3D"disc"><li>Content Analysis; Descriptive, interpretative=
</li><li>Narrative Analysis</li><li>Discourse Analysis</li><li>Grounded The=
ory</li></ul><strong>Module 22: Qualitative Analysis Results Interpretation=
</strong><ul type=3D"disc"><li>Comparing analysis results with research que=
stions</li><li>Summarizing finding under major categories</li><li>Drawing c=
onclusions and lessons learned</li></ul><strong>Module 23: Visualizing NVIV=
O project</strong><ul type=3D"disc"><li>Display data in charts</li><li>Crea=
ting models and graphs to visualize connections</li><li>Tree maps and clust=
er analysis diagrams</li><li>Display your data in charts</li><li>Create mod=
els and graphs to visualize connections</li><li>Create reports and extracts=
</li></ul><strong>Module 24: Triangulating results and Sources</strong><ul =
type=3D"disc"><li>Triangulating with quantitative data</li><li>Using differ=
ent participatory techniques to measure the same indicator</li><li>Comparin=
g analysis from different data sources</li><li>Checking the consistency on =
respondent on similar topic</li></ul><strong>Module 25: Report Writing</str=
ong><ul type=3D"disc"><li>Qualitative report format</li><li>Reporting quali=
tative research</li><li>Reporting content</li><li>Interpretation</li></ul><=
strong>MODULE 26:Basics of Applied Statistical Modelling using R</strong><u=
l type=3D"disc"><li>Introduction to the Instructor and Course</li><li>Data =
&amp; Code Used in the Course</li><li>Statistics in the Real World</li><li>=
Designing Studies &amp; Collecting Good Quality Data</li><li>Different Type=
s of Data</li></ul><strong>MODULE 27: Essentials of the R Programming</stro=
ng><ul type=3D"disc"><li>Rationale for this section</li><li>Introduction to=
 the R Statistical Software &amp; R Studio</li><li>Different Data Structure=
s in R</li><li>Reading in Data from Different Sources</li><li>Indexing and =
Subletting of Data</li><li>Data Cleaning: Removing Missing Values</li><li>E=
xploratory Data Analysis in R</li></ul><strong>MODULE 28: Statistical Tools=
</strong><ul type=3D"disc"><li>Quantitative Data</li><li>Measures of Center=
</li><li>Measures of Variation</li><li>Charting &amp; Graphing Continuous D=
ata</li><li>Charting &amp; Graphing Discrete Data</li><li>Deriving Insights=
 from Qualitative/Nominal Data</li></ul><strong>MODULE 29: Probability Dist=
ributions</strong><ul type=3D"disc"><li>Data Distribution: Normal Distribut=
ion</li><li>Checking For Normal Distribution</li><li>Standard Normal Distri=
bution and Z-scores</li><li>Confidence Interval-Theory</li><li>Confidence I=
nterval-Computation in R</li></ul><strong>MODULE 30: Statistical Inference<=
/strong><ul type=3D"disc"><li>Hypothesis Testing</li><li>T-tests: Applicati=
on in R</li><li>Non-Parametric Alternatives to T-Tests</li><li>One-way ANOV=
A</li><li>Non-parametric version of One-way ANOVA</li><li>Two-way ANOVA</li=
><li>Power Test for Detecting Effect</li></ul><strong>MODULE 31: Relationsh=
ip between Two Different Quantitative Variables</strong><ul type=3D"disc"><=
li>Explore the Relationship Between Two Quantitative Variables</li><li>Corr=
elation</li><li>Linear Regression-Theory</li><li>Linear Regression-Implemen=
tation in R</li><li>Conditions of Linear Regression</li><li>Multi-collinear=
ity</li><li>Linear Regression and ANOVA</li><li>Linear Regression With Cate=
gorical Variables and Interaction Terms</li><li>Analysis of Covariance (ANC=
OVA)</li><li>Selecting the Most Suitable Regression Model</li><li>Violation=
 of Linear Regression Conditions: Transform Variables</li><li>Other Regress=
ion Techniques When Conditions of OLS Are Not Met</li><li>Regression: Stand=
ardized Major Axis (SMA) Regression</li><li>Polynomial and Non-linear regre=
ssion</li><li>Linear Mixed Effect Models</li><li>Generalized Regression Mod=
el (GLM)</li><li>Logistic Regression in R</li><li>Poisson Regression in R</=
li><li>Goodness of fit testing</li></ul><strong>MODULE 32: Multivariate Ana=
lysis</strong><ul type=3D"disc"><li>Introduction Multivariate Analysis</li>=
<li>Cluster Analysis/Unsupervised Learning</li><li>Principal Component Anal=
ysis (PCA)</li><li>Linear Discriminant Analysis (LDA)</li><li>Correspondenc=
e Analysis</li><li>Similarity &amp; Dissimilarity Across Sites</li><li>Non-=
metric multi-dimensional scaling (NMDS)</li><li>Multivariate Analysis of Va=
riance (MANOVA)</li></ul><strong>Module 33: Report writing for surveys, dat=
a dissemination, demand and use</strong><ul type=3D"disc"><li>Writing a rep=
ort from survey data</li><li>Communication and dissemination strategy</li><=
li>Context of Decision Making</li><li>Improving data use in decision making=
</li><li>Culture Change and Change Management</li><li>Preparing a report fo=
r the survey, a communication and dissemination plan and a demand and use s=
trategy.</li><li>Presentations and joint action planning</li></ul><strong>G=
eneral Notes</strong><ul type=3D"disc"><li>All our courses can be Tailor-ma=
de to participants needs</li><li>The participant must be conversant with En=
glish</li><li>Presentations are well guided, practical exercise, web based =
tutorials and group work. Our facilitators are expert with more than 10year=
s of experience.</li><li>Upon completion of training the participant will b=
e issued with Foscore development center certificate (FDC-K)</li><li>Traini=
ng will be done at Foscore development center (FDC-K) center in Nairobi Ken=
ya. We also offer more than five participants training at requested locatio=
n within Kenya, more than ten participant within east Africa and more than =
twenty participant all over the world.</li><li>Course duration is flexible =
and the contents can be modified to fit any number of days.</li></ul><stron=
g>OTHER UPCOMING WORKSHOPS (REGISTER FOR THE COURSE AS INDIVIDUAL OR GROUP)=
</strong><br /><br /><ul type=3D"disc"><li><a href=3D"http://url9271.fdc-k.=
or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6T8xRRw7PEG=
FyiJ8F0Yrga11xushHcj4MzBWazw-2Fokrw5Ltzwz5U5kRJ1O819uEK-2BC8H9M-2FKQH9fvGQS=
sCKXVIsZqkK-2F5iqb6JU9nWEnCoO5q1YSqcko-2BDTIQyJx5-2B2N-2Btc7qH4Wi7pT4f1l-2B=
Lb3wqAFv4SBadpowW7l8006EQoe0ABCJ3FEgioXa7A1aRhCaI7cKOz-2Br2FLYgpitiNvAAsaws=
p64fdulySJ2dUl5CHT34L8JoUNnTazdPWXHKg49Zn3M5zo5SKqi7qhC32NxO9R0-2F8ah39Udjj=
9M9EL4skN6jmgrV-2Brit-2Bi-2BLVSle1A4nHkL-2FxqB8XZF0ncdqnVdG7SD9NrcghY1CIlMj=
mux8AVkG7-2FC1JBuStmPllQxI77N5bsf5nafgpMZOANTWKkYEquBpaDEzQUn9dtFZIXSZydUQv=
y2bTpqS8yTJ9WOFJ1qI-3D3LeB_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOB=
NaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJyqStrINH-2FE-2FCtcj54Wj758UanaBc=
CjcxZ0e4cIhll0fEBJ0ff1xLJEFTVjYbRlRc6cFMS9e-2FPbYrJ9FpdbBVZO-2F9J0-2FJyUcLz=
zBC8eCT-2BeH4BKteGA5wNwtfy-2Bs21FfPMG4vKw-2BPSdqgMbT3ddSmwM-3D" rel=3D"noop=
ener noreferrer" target=3D"_blank">Project Monitoring and Evaluation with D=
ata Management and Analysis Workshop from July 26,2021</a></li></ul><br /><=
ul type=3D"disc"><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DU=
bf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6TVekRjS4ShP5XpebuX443A3bDFCCBsdv=
DhNd-2FUUD0jKaNVUeyWWNy8ms-2Fir6O4CzSupeX9AnkXIxF0ZebskAQx-2FIbN32w-2Fj8LHU=
D236XMZlgZCfPyaWSk62LZ2OJJRW-2BNB6zIGUfR7oBo-2B3KG0fqlPtc1TkgIGYp-2FWvlwJfq=
-2FoFlK0SUrZeIVraDVPH8xwj6-2B5O8NPjxPwK5t-2BiDh0SwBRO74kCWMEaN9gt5vub1Oa9Po=
XwSccvCJBkx242Lprmic089zywa4xsy54Zny2slg3uEcQ0VJIstI5owNvve1Qkl6UigtO-2Fktj=
LSMqs9-2FwVbGpDyqN9iX0wLilUHT1aXt-2BRLP8Sc-2FXbuEEvPHR8Ugy-2FXqOp18W-2B1jZO=
-2F9GJGpq6lk-2B9vf4UoDYr4y7E77I2UhFS6Cs89tiAYlydApcwWxaBHkyGDeQJYnbFxo1fA14=
O-2F8-3DpQfW_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZ=
uKzSszYAqWDatV-2BKDt-2BnSEFKJ8MBu347vC59Ja7TfWPIWKUOdZR4fnS-2BXdhwqc49-2Fek=
6rotdXVPlIQBNUyPaVjCamHZYbBQqlfcbRpVwML4l-2BSUsBgErEFopb2u6sy4RikzOmwP-2FxI=
2MJgxVlbatgB8cao-2BOPYe8UYQpRMvw72TqzeU-3D" rel=3D"noopener noreferrer" tar=
get=3D"_blank">GIS Data Collection, Analysis, Visualization and Mapping Wor=
kshop from 02 August,2021 for 10 Days</a></li></ul><div data-empty=3D"true"=
><br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DU=
bf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6TyRyXXdaMF47OVEL2fds4tBc6qFY2EeG=
8ljyv630fc0WM0y35z-2BhMGuN84ZESG4mM4SgbZYwUxdj-2FIPqtHXVGD6Hiv2u3ACe6-2FesP=
LDKu25Y1Pf-2B11Bf4ZrVmtEXUZ3gdZMoBagveKTu50-2FXJvg-2FTxbePCFI8DbcYcp2oSsPVc=
1irYOGOluqm-2BD3dPGqHbV8fAdgX2meE1Qsp6kDjHVqHF3hRLzukCTQMnv1nf4v9-2FYDObJq-=
2FHzXGwuyb6O1j8GnbEeXOTA6PJX5DpA4Yibq2zoeUHvSkbu3xxywDGHaefMJDhLeD8uHkgL2O1=
3pMHJbtn0JLKys8kkVIi2-2BVOXx60klds8GVtvtN7yNMP1JezlTysUE6v5UhttVD8jgOyyEstm=
75cW-2BfBke-2BwXP92zxQz4tzfj1l8MpLgYdZmIXTCzTf7o5v9nxmU-2FqiKDOZM0xs-3DOtR3=
_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDa=
tV-2BKDt-2BnSEFKJ1eUP5dST2zgk9twzvPt1HamioasyxiY7bvCUXdw3qD09GlN9kN3BzITP1x=
jAY7C5y7iupL9SjYSAIp6xkqiotbrnG-2FKephySV8hXNa3PNd8jecRgLIndeKBggzN-2BQdHCQ=
JN9m1SAe07OKsl7ax2Omc-3D" rel=3D"noopener noreferrer" target=3D"_blank">Str=
ategic Communication Training For =C2=A0Managers And Executives Program Wor=
kshop from 02 August,2021 for 5 Days</a></li></ul><div data-empty=3D"true">=
<br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUb=
f5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6R5RpjhD9Ybbf7Bk8n1LDm1lJmMXRcsMQs=
trvvZ0REBTz9sUhTJST6uJTBnHiDfHo9xFfzanRD4707lalaj2qlLIo6DRpLF9kmoARwk4MzZLV=
nGa2z6zkKAWzK1Ncb5seS38l1EW-2F279mkxlXbY-2BCVIwghZ-2BB5WYiEgO7BkfApLoo4Qjpe=
mJU65dgl3zxKKEiceWEa-2B-2FoG0EYP7VYs9CuJ6gBrzqdbJIQlOMxsQm9k1tamU-2Bbp9pnQl=
EN2DtdoIls2RkFXkDRtaXrXYtl9YPIDoYZrxJSgx5HgupTgm2f6h5zuMtj1X5opo6rAvXf-2BlE=
Kog2HWzPnnFLnSmPzwk1AzFJ-2BznZGXo4Vos97O0h7hFboHNzbEiqTivZ6TD-2BwciG4-2BCur=
pJAXTEfhB43KIGZAMuguHEP5TP9U-2B08WHTcMXkcBOP-2FuoKk4pUxsgPgc612uM-3DfDkp_6p=
wKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-=
2BKDt-2BnSEFKJ77iYA9aByoILkngXSq0qBhi6pTvyJRxO-2FlKQaa6YL0UEUwDmjQeXwIb99Ge=
rp8U0e1jWpPOSJr9hpmtUmn6yGVvNiG-2BYHkznit1SD0TxyDbR9lNEb-2Bbx3alFVfOEoECuFc=
1hLIU3xSqgOU0-2Bikqe4w-3D" rel=3D"noopener noreferrer" target=3D"_blank">Mo=
nitoring and Evaluation for Governance Workshop from 09 August,2021 for 5 D=
ays</a></li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"ht=
tp://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4=
DfJaFCSo6QppIA6juC0zsbLdG3wwWaObDomaWNsOJqOorV9k-2FiQij-2BmSrktgYm-2FZz-2BV=
lJxq3dPLx5mHTFNbkGD5NkJNvVhoJHhPZMDzA1wWU8H6YyzHtHIBfWdrWVlMc0H47ef9Q-2FByl=
0qtpErlk8TMmh9yooEHWiOXcETVzCiO7QCRsDYLVGPZ8rP6y7P2iVCn0tFJKvTQ0PJ-2BJ-2FlY=
U2dVchgYM-2F4OqNWqyctIJINzJT70mBtGcfRWkvmqPftDCfSnZkRGZbrwQApEbExB0aYxXmjTF=
1vTfVUGGhanvltxr-2FG8J14GvfCv0IrWBU68xdAIDnVo6p1T55pWar3wVUyTJBYRKF7zE6Y30G=
u7KJiyj7CG9YpVz94nJjwsbRRRb4YOgf4c0RlRwLGY5KMiGhxF8x6ZT0EStvddZ4bZ2JA3daSVu=
uCtCQK9MbMXuzBuKxxIpSDOVmE-3DEgJl_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQ=
D-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ7pxzMZ7fBZjWRQuQ3Qi1pnNvJ=
8Kt3DDL-2FCwAcpiPKnBojC1S6PFj5FCDiN5YlXL3GnwzXUwyLk0iC2OYFq-2FklIcpImtCQtyr=
nLk5xxcjXaY6uP4Ar-2BR1W-2B7ZTYQ8hW-2F7tm5I0x-2FZOh2cjad-2BsgyoBw-3D" rel=3D=
"noopener noreferrer" target=3D"_blank">Training Course on Microsoft Access=
 Workshop from 09 August,2021 for 5 Days</a></li></ul><div data-empty=3D"tr=
ue"><br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=
=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6QwCyu5jTKHzc13Lg4xRm1dNusz8i=
OD4nD4f6p-2BKhCwSpeR4Smn1hlYQ9OZoABC12AG4oPnbYA9zz9iXOlauaLSmD1noWx2YMAnTjT=
m3tcSk3G-2F8mwybaXwchPx7n46-2BfVXdomQ-2Bfl40xXdPG2Uoe11cGaZMrBeYLqaBSvR2tR8=
RIYeIdv0nJcg35Xu1FBFKauvikRZ0x9A2TyUCQ1Rvjr6tSLQJfKtlHtYo5bdeM9SpycrzsGhYUK=
p9hPWOuVgoTbMGlz-2FCeXrrdV2Qt7ZPA-2ByJ2P6Pqb-2FiN-2Fun4MMCrXPkHU2XyCU3mchDX=
yQFl4vPloDmeu-2Br5uun-2FLvmZoYnxT5CRMe0U2AlbXp-2BNf-2BhLmIwEVmzqAx2KD1g4-2B=
oqVDPKiFqjliV4-2BTlthXzoZtiu5xCeJBgIaoXUueWn-2FlmT9JQbkzliE1LJgkBfnGNr19rxk=
U-3DGzi-_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzS=
szYAqWDatV-2BKDt-2BnSEFKJ3UN8Bqr7AoG3r82meny1NN7qpRV-2BKuIrh41lwG8e9AZU6sQL=
0yc59Gzn9h3SFBqhfcJJEcB7hbSZzMZLbr5RZf-2F9iD-2B6uxemwy15ZgWLSByWeXgdCUT1PI4=
IqLSo6Hnr3O1ZLiw9hcduAwBny7RcVY-3D" rel=3D"noopener noreferrer" target=3D"_=
blank">Grant management using Sun accounting system Workshop from 09 August=
,2021 for 10 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul><li=
><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo=
85Ax5S5a7tfns4DfJaFCSo6REiDtqL236lI088JmEf8ctSoBALLWWXpVKIEfz0o8eOHsN16hq0F=
cMWpdxJhGAGCUH7CJWrIRPk3z3u4vnXs-2Bocqv60IDcFXP3z3WIDimLEIWn-2F1F-2BXMg-2BW=
NhlStMg-2FLNE7ZMA6wamCDdENdMUSIzHqzmIB3yAR704aIRbNuLwNBA5Aga-2Fy4MZk8r8Wixi=
buGX679lD24u4EUxNXtXu5ELtp3MlvhEPN6vcPBH8jXyK1UN-2FkV1YOC0J9HVbEimDn41FyxE3=
XM04XoUKrGYgqGId-2B-2FcXbi1aGrFprH4BBHCB2he86V0-2B8uHpptUIkYtAVSNpz9mQBgHHJ=
Eux-2BFY3klCWbJIUV6isSgLKdP3sLZKkU88128-2ByBptucjlGC5GHtJL1wjatWh39kq3Xab-2=
FDx5dz5qhwTQh-2F3-2Bo9rXR4w8MROHTeTV90IYvir17dQgeZns-3DxDI7_6pwKHJ8Ph1XTyv7=
ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFK=
J10Lq6zcaC2qziCGWWQiAcXBwh554oO2seqFIGQs5aREizvAqHUJifrnP7OZTkoobBsXlIDvSJF=
VVdcc2RvF69rLxT6I-2BpEE0CvjZ-2B4xVq3iAB-2Bqmu-2BLTYXk5b0jVnrEOXffRmTw3ZT5cU=
Nlg9i8-2FNE-3D" rel=3D"noopener noreferrer" target=3D"_blank">Financial Man=
agement, ERP systems, Accounting, Capital budgeting, Presentation design, M=
anagement, and Negotiation Workshop from 23 August,2021 for 5 Days</a></li>=
</ul><div data-empty=3D"true"><a href=3D"http://url9271.fdc-k.or.ke/ls/clic=
k?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6QOzxTuJ6RVz2myzFpGWLWbV=
Gqqtf1CcEe8vs5Zpqy8wF2ctuOMqvsGFKsNfU21l6Y-2FrDqqSOGjF9jv3KsqmEhDPUNgTXW1Aw=
5TbkOD-2BK8jIo5T2b-2Bo8Ma-2FGDB8z9KIasWuLC6iX7V-2B3SHywe42x95KMjlVL-2Fbmngh=
YieEgIOwayqt1vGnWfvSh9PUxSPOdpgAQtDvUaUmDWXOK-2Btzo3YaXbRo0GaWUnzm0uFGvJZJh=
GzhtLAUd7cgD-2F2u34bq6YbmI4N1tQkGqhhRuON9dIMHzI2FkR08aSLh2bZ5eqqQMXWdL0RB2O=
eWtMoqRmUgwgzDEwb2Cm3g2ILLv3U0C-2BUyQLI6xFcvGbCuexIC0-2FpX1-2Fz7NzrF8E0cxhL=
gt1mW5RsPUL8kQpgHuXCMEuRsYQPSgJzGwBpkxB5y25Nut4sCqp19-2FB9bUj6zEBAxdCXHeUHc=
-3D5B_j_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSs=
zYAqWDatV-2BKDt-2BnSEFKJxV9qWplAl9cu7Nyp3n9SSCZEIb7Yc-2Fd37g4ehWi7GhJ4j8ghl=
layLPvb-2B7l9fDkY5qUE4wKF0SE9kj6YzGL0euz7JD-2BKEmEoEgloZd3jPCSzcWjZvuBoo8-2=
BXohxBIHpJsIcxFEzt1qFXE-2FyeEzBn9I-3D" rel=3D"noopener noreferrer" target=
=3D"_blank"><br /></a></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/l=
s/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6QOzxTuJ6RVz2myzFp=
GWLWbVGqqtf1CcEe8vs5Zpqy8wF2ctuOMqvsGFKsNfU21l6Y-2FrDqqSOGjF9jv3KsqmEhDPUNg=
TXW1Aw5TbkOD-2BK8jIo5T2b-2Bo8Ma-2FGDB8z9KIasWuLC6iX7V-2B3SHywe42x95KMjlVL-2=
FbmnghYieEgIOwayqt1vGnWfvSh9PUxSPOdpgAQtDvUaUmDWXOK-2Btzo3YaXbRo0GaWUnzm0uF=
GvJZJhGzhtLAUd7cgD-2F2u34bq6YbmI4N1tQkGqhhRuON9dIMHzI2FkR08aSLh2bZ5eqqQMXWd=
L0RB2OeWtMoqRmUgwgzDEwb2Cm3g2ILLv3U0C-2BUyQLI6xFcvGbCuexIC0-2FpX1-2Fz7NzrF8=
E0cxhLgt1mW5RsPUL8kQpgHuXCMEuRsYQPSgJzGwBpkxB5y25Nut4sCqp19-2FB9bUj6zEBAxdC=
XHeUHc-3DjatJ_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCd=
ZuKzSszYAqWDatV-2BKDt-2BnSEFKJ7Mo4QqnvclMSgcreuZwFX9QMohtW8gj-2Bm-2B2Y0Xqhy=
uMA-2FQBLNiQfrgK34L1xA8S-2FKtcUPTPnPg3Ib6P1ZmGRCgYqccWzUmZkwG9Dw-2F2TrS7k8a=
-2BHxUrWOjSKOYUMWzCLwPEkAaynqW5RHMNuZq-2FjQc-3D" rel=3D"noopener noreferrer=
" target=3D"_blank">Mobile Data Collection using ODK &amp; KoboToolBox for =
Monitoring and Evaluation Workshop from 23 August,2021 for 5 Days</a></li><=
/ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url9271.=
fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6Q90c=
zkJDPQUhE47rAGjvzshg1FLYZGPS0ngql7ioRkzH4oSeYjt7DVZf-2BFDre-2FBYOySZZa4c67n=
06BHGcqNM-2FxjaQ6kSlGyKv-2FhzpersD9fZMQdwnuLHec3R-2BI9kU3C1am5ZMr1LRFy-2BKg=
n34XeVC-2BkIj9wH-2Bor-2Boc4hIyVg9zpcwk8d8FYXpqtvFxRhCGeszDnGb9PitSM-2B-2BCj=
yskhRAAvjEHjLVKClxPTAm9MWhwB24PhyJ7lMsCOXZJRKcjITUI2w7Ahuhdo8VXIoxpahRON0X6=
s-2FGsmXFup8d8ow-2BrFkpbV0h-2FIinOFjUdnsgYLNr-2BFrMyKLGj-2Ff0X-2FmhKorkRChN=
SpyRmUQrwNqq6t0IyaAwUPsgT7yIFZc1ZqGzEpj5L64BzctbIytYx34DPnv9i84HFia4m8wp2b1=
qn04ZJeeUJTlYa-2Bxj4nMl8nH-2FzqSI-3DUf55_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJG=
dCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJxv4hlTdU3vc6kLev-2=
BSJQP-2FMb6LCo7qMpsa8o12dxKO0vGaf67z2tb162CS0ZBRsQzXmmEGaJLn-2FsGmfliba8XCY=
yxjArvoyB18-2B4cfzkBe5N34OK9q4ninqZFaIZb9qPVvNZDT2GLhS-2BdClwIWKqGU-3D" rel=
=3D"noopener noreferrer" target=3D"_blank">Leadership and Diplomacy Trainin=
g Workshop from 23 August,2021 for 5 Days</a></li></ul><div data-empty=3D"t=
rue"><br /></div><ul><li><a href=3D"http://url9271.fdc-k.or.ke/ls/click?upn=
=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6Q4L1k8NY6RN9OZO3hTvfQCC0jhR5=
revtj-2F1ZI1KjOYyavxAbF9snvqHdeUriyHI482XPCi-2B4zG-2FNu2AmwOe6GdhyY-2BKAZTx=
ZZ9Vf08inr6C3oBcPU-2FJ4NK-2BvQQCofAa3B9XpNcRXChMa3Awj6T5m72xDbuuyF23TlCx-2F=
dlXIX9-2BzuSoqaOy0qLp8yW40GvRj4MAFX08B3LiF0NQXx8N0RKrEvaWKikLMUP1qoQpWTEyyq=
WFxBrYXX5iPUT6M2Xe5zEJysDFJ8sFa-2BvY9betcB7QypHkvJ5RCLqZQImFx0he8nFm5Fq0oOm=
uT4NbEv5SiJB2YO-2F-2Bxgie5JUi0nrL0zUpzSLsweYl-2FlJycEDPStEUZkKc2oQRCDbLwwdx=
h-2Bi2GU4MIcSjHdzyWlbWaOitYO5foVrhJZcJ2pqpdy-2BBzQLi3scsQYcTSbkNgXVKypsCYg-=
3DzkiI_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSsz=
YAqWDatV-2BKDt-2BnSEFKJ5Af-2Fj7pyez5S2giKlJj-2Fpw1kARhsVovCS5cO5L82eqkceqvS=
AFL-2FQbP2BgHI-2BL71l4XClznTAJd71H1FyYdyun-2Bo-2FHJe-2FYlFLoFO0AZ-2BEqi9JbC=
1w-2FrtuWj2ztHLqpjUcz0xrW2SQkA9ttihdaHgJY-3D" rel=3D"noopener noreferrer" t=
arget=3D"_blank">Monitoring and Evaluation for Food Security and Nutrition =
Workshop from 30 August,2021 for 10 Days</a></li></ul><br /><ul><li><a href=
=3D"http://url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a=
7tfns4DfJaFCSo6QtRAVhY5qOPG4ryR7ElgHMQitBoP1uIKR1Ra04bUoSCFUOpa3Kca33ec1nO1=
e3CGRJN8rTvNd-2BLOAHkl19QGzBLmnsIjjLFEzrQDxutzzlXqBdH-2FKurMZ1DwQzZ-2BIIOuQ=
4Oujf9PvOwfcn2fxunYecuXIYOf0-2BWpSosEOt1mMag13J5QtxN8mEiqsCXqk-2BnZzHsIpE2O=
k0zXIOQNhw92tx-2BCyNdies90GiyaBttMxIUFUBVZ9vzNr4YTDccNJM7-2FtTejtKPSDNUKGsJ=
-2FhjwlLxWAvGacKHEk9Lhm-2FaetILKSfVZkIImsFNee73gagIcxSeeHW-2Btkrr-2BFBrUV6A=
60zlo-2FQCCUE9Mn2oiB74Sq-2BngKo8fjh99jzn5dkGVf1kE8FonyXI08j9n-2FxfScpIQ7zXu=
4x165mDjcRYK5hnAvb4zRuEGL9sSolMDTwMUINB-2Fxw-3D6OIc_6pwKHJ8Ph1XTyv7ONZlOBCA=
yk5EA9C6LJGdCEKYTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ-2BBp0n=
ldVjSaYEpR7-2Ba6conPLbpM-2BbQY7ciYbiqtzP3lAB5xmFgRjsgspqPii7KeWzt7YCYgMTxuT=
3ELIsVjLrUUJlFEq5jvUgq7xGsQ5vnHggIri5UBDFDcAMiwEWMCZyHCgA1NLNI1JO-2FtKkBn1g=
4-3D" rel=3D"noopener noreferrer" target=3D"_blank">GIS and Data Analysis f=
or WASH (Water Sanitation and Hygiene) Programmes Workshop from 30 August,2=
021 for 10 Days</a></li></ul><br /><ul><li><a href=3D"http://url9271.fdc-k.=
or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6SG3QpFCkVp=
3Q6KaVmN3rdjaA6kGoWM0wSNKjdB8E46QVhREXn9qvLUXhEXmWiv46ajVRJe3lz4lgyezRB2OBj=
fodQ49FQamTQzlqKRTiajTpyX6wUVWHSIXP-2FaeHtP3tRrZM3cDlWqQCGP-2B-2FkVg-2F-2FD=
N9L6-2FFLLZidpTXDAKj8a1XdYdGiUpJVKKfYr69BBZI-2Bj-2FhJ5hVbHtd6NcgR3lCbGuqrd7=
BAXNdlrGUzWAicx0qJUn47irK1c2avhtjOZJw0QHJS43rIpf-2BITeUlC4F21DsCpCr0ez-2Bnw=
CUPibqj5XjNBIfCqz8ZLwZwdUkJlQwKZAl7e8KhGgqRYnJLQ20rF2AGVgUP73GUP-2FHVETBzdx=
mEEpjEncEavOGid8GOJvgW-2FVrdMP0iNAB7o-2Bw0NavUgbdkqXEM-2Fc3fqNw4xCqkAK6r8Os=
XpESet6-2FkwSJWaHJM-3DuG6U_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOB=
NaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJzlxgDcZywiWsycvaUJwpNSi3XL6-2BJB=
tQYz-2FuEfWUftb3oKDTvYK7YTovPhBd7pmAo6RtoHNcOg2pigMmlUgriHlqByLcl4KxaniEumx=
4poNFG-2FZl7Bqc0L55maO4WuktZdZcfGeDL3a8Oe4qU1vP6Q-3D" rel=3D"noopener noref=
errer" target=3D"_blank">Advanced Management Program Workshop from 30 Augus=
t,2021 for 5 Days</a></li></ul><br /><ul><li><a href=3D"http://url9271.fdc-=
k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaFCSo6RR44jNig=
7YcIsqpJl1RxdWov-2B5LUEfHLgOgZehZRuRgNRcZbmY7-2B9RFz9DluXp2hkD8kD6c1J8Xg3Xn=
9YVkI1P5IIqBF-2Ffps5-2FyE5QBYqHG-2FX7Kb20Ho1Lake9ybPX1VY-2FSvY6TFlnfNBYB8OT=
uRAbWhxCkUJPMBbAmFgW6Q6J2SQAnqXY4BZLLEBMGUH-2BUZhLusSg8Itcxktc0zscjaNGpHJIR=
g0Pc0XmRDZhT6t03cX4SnpmDZzWOst2pA9CQoAnKnEFKqNGYs-2FB7Rf5qmlYSccKwvwCfqKO1B=
FETuiJp6kqgLqLlVtVntxdvD7ennbeInBkFdiQkpqfX5wjNv1NSW3SGk867LRUIQe1F8EMBL1Sq=
LevayGmUvpBzM4-2BYGlFJ-2FWH8ji-2FWcTxohTYl-2By1hA5yPz-2B86HmrKsArNjdaRzymkW=
JZBxzZIeyI6UnxZaA-3Dxix2_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD-2FEOBNa=
VJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ1Mvk7vYHDnl4TJT2EIfl-2BRno1eZTQmAW=
qsolNZjg-2BD44VGW16-2FH6iD0aZ8uyxpbv2lixzdxyTFIyxC4c5O9-2BMCGAhV4ClAh3df-2F=
P4fVjkCpAxXcFiXBFcxilqYM3-2BSCb9DsJKt1btJh6Lq3kXw-2BSwY-3D" rel=3D"noopener=
 noreferrer" target=3D"_blank">Grant Management and Fundraising Workshop fr=
om 30 August,2021 for 10 Days</a></li></ul><br /><ul><li><a href=3D"http://=
url9271.fdc-k.or.ke/ls/click?upn=3DUbf5evRrSkpPwdM3-2BNo85Ax5S5a7tfns4DfJaF=
CSo6QyGxjAGbZWFS5R9yPsK-2BSZ19Ehou9icvo7MvLuTwooDOynEfbsTsGj2ZTgDMbDmCySKyh=
Xizlg059GJY13CYC4OQZ-2B3UNxr3hOSrRX-2BESuYNWnex32hNX7wabn-2FY1figGQYnGBBhW-=
2BlfAlV-2FfO0MMFvjYXTMafuiOJRmmzfrP7B8dxasFTp2ngiLEwH5m3akwuhhIarwTsofm-2F2=
rlQqmEfK9dHlKw58LKQbTDxfUAFWGV11KW-2F6RMyeb3R5D1hmcIpfAc3Jxs18uTir-2Fp9Y-2B=
XLBb4LlVNjCXWLbxjhAX-2BJGztGzMpt2E6iofyAZ2n2YtULTzsnb5Uf0nArqNM7x-2BWEI3mTh=
oCVDiHtP08ajrKAuHiQUanIUMDbvy6pe73xiRtiUQ2Zt7G3JpaouWbPZHIrR8-2BacnHFHAv3NJ=
QuB50bOkbbl9f5tNQgcT8iHBWGtOo-3DwXS4_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEK=
YTQD-2FEOBNaVJNGEQ4yYCdZuKzSszYAqWDatV-2BKDt-2BnSEFKJ-2FVw-2BHYPla37g-2FY1F=
qUj20H5NElRDKuvMQovHby5aIma80-2B2Lpgj-2BqQ2PIBvlOBR-2B689kB5prUe8IpVsMQZghA=
eEHbZD0Dtz0j6rxcA0atdGgW0ylpBZ9KTxBmAEIRhu-2B-2BjmwL9nXfErUdTT7Ra99zk-3D" r=
el=3D"noopener noreferrer" target=3D"_blank">Gender Equity Achievement in D=
evelopment Projects Workshop from 30 August,2021 for 5 Days</a></li></ul><b=
r />Looking forward to your =C2=A0participation,<br />=C2=A0<br />FDC Resul=
t Based skills Development,<br />Regards,<br />FDC Training Team,<table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"0"><tbody><tr><td va=
lign=3D"bottom" width=3D"708"><div data-empty=3D"true"><br /></div></td></t=
r></tbody></table></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </div>
<img height=3D"1" width=3D"1" src=3D"https://mautic.fdc-k.or.ke/email/60e45=
80a81869980514815.gif" alt=3D"" />
If you'd like to unsubscribe and stop receiving these emails <a href=3D"htt=
p://url9271.fdc-k.or.ke/wf/unsubscribe?upn=3DoDb6ny51mUB6FExYn3rQhnEsRzMLZB=
2XMeq5leS37lC-2FsyiaYGbG9JlnhFF5MFStUJaAdbUq-2Br9bgjNyB3V2B4F-2F4OHEQ7u0LOk=
zrrOtwqneoOquH8mLnekWUA2tsmsAu5zEYHnMbcTrQN7t2oHtJ08czuaIEqWRGR8UKP0qZYNxXy=
o3mj0dGXW79nSmgBr9ob55Z6Ep2kM2lh0sr1sojFyFLUaqazD549YbokWnjmg-3D">click her=
e</a>.
<img src=3D"http://url9271.fdc-k.or.ke/wf/open?upn=3DoDb6ny51mUB6FExYn3rQhn=
EsRzMLZB2XMeq5leS37lC-2FsyiaYGbG9JlnhFF5MFStUJaAdbUq-2Br9bgjNyB3V2ByGl10-2B=
J3nfSvzNuOswWbW8GxsS-2Bnh9GhsRrkszoSIO4TKGTPC-2BkLa4KskhhgMvL-2FaZTAqwmAQaa=
AimU5Nr0XhblLZwXWDru9Blds-2BOomuS24RP6106LGo1zAIy35qYZsDRMVytQzYlNPFi-2FdwI=
V525j-2BQn2EHymDe192iJQHuZl" alt=3D"" width=3D"1" height=3D"1" border=3D"0"=
 style=3D"height:1px !important;width:1px !important;border-width:0 !import=
ant;margin-top:0 !important;margin-bottom:0 !important;margin-right:0 !impo=
rtant;margin-left:0 !important;padding-top:0 !important;padding-bottom:0 !i=
mportant;padding-right:0 !important;padding-left:0 !important;"/>
</body></html>
