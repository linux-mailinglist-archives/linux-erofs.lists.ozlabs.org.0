Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F281232044
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jul 2020 16:21:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BGwhS3M5jzDqst
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jul 2020 00:21:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1596032488;
	bh=G25y+SV312fy+qd1OTCRm/gzbRNXpMQJ/pt7Hh2Ihks=;
	h=Subject:To:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jwUrUEGKWqZ5apBuJ1Hqn2qfj74Ltd72PwJLA4NZlYlVDu51fPH0QcPY8J58FoQWD
	 8G/YXidIKae5i3n4eAUK3DuIaO9y59OGg1OPaeaq9LXxtQfmdMEraDmtp4K3CNzFlS
	 ubjk8TIfLfDC3QQII664fqXujJXNCSQHTk2efRMfgUe+gFh8T/lpJBmQt3QGVouhiV
	 UXZ11PjcSKWsx9zbU5ax7QwR1X7oaeP/VZP7S5nTSPb5DSVhWHyyffK/LTrWrYyWIQ
	 nMwHIX5MimZ2ah+tCX9dKIkw9O6z46XQ0AFEcJm9q/fnml5zAVL/jnkAzsouqcxhAG
	 Ia6sRDX8EqVOg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us-west-2.amazonses.com (client-ip=54.240.27.128;
 helo=a27-128.smtp-out.us-west-2.amazonses.com;
 envelope-from=010101739aecae31-9ea286ed-b4ed-4adb-ad67-789d2f6af463-000000@us-west-2.amazonses.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=konnectglobalmarketing.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konnectglobalmarketing.com
 header.i=@konnectglobalmarketing.com header.a=rsa-sha256
 header.s=sknkt525wmvsd5qrslvt4aisaznnhvir header.b=dHJpG7j7; 
 dkim=pass (1024-bit key;
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv
 header.b=GjORqMtS; dkim-atps=neutral
X-Greylist: delayed 400 seconds by postgrey-1.36 at bilbo;
 Thu, 30 Jul 2020 00:21:12 AEST
Received: from a27-128.smtp-out.us-west-2.amazonses.com
 (a27-128.smtp-out.us-west-2.amazonses.com [54.240.27.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BGwh86JzfzDqsH
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jul 2020 00:21:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
 t=1596032069;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
 bh=G25y+SV312fy+qd1OTCRm/gzbRNXpMQJ/pt7Hh2Ihks=;
 b=dHJpG7j7ADxVZSSHUipVsDwCOhNd0QsebDVwBOkIW7+MwOe1ijQ2gLaYvrNHlVXg
 Y9Nx39yluu2cweOIzMOKNzIWlQGnRJNnJ2X5vtU1ll4GzT4QUPPPQv9W4jeciQuYx0H
 /85cufBhNb592OitEdV+V3sF5zUChlL0iRRw9yCA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1596032069;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
 bh=G25y+SV312fy+qd1OTCRm/gzbRNXpMQJ/pt7Hh2Ihks=;
 b=GjORqMtSx7/IdDNTB0SGHJ8JDL9czxj/b6Uop1S/CwaAW8sgX4KphrNlsOgUYebE
 DPIH1jfi1eGU5xlCoUCN8Dnqbx6Mt8TAXp9JXWwiovEplI//SlZLoH4xaILOwTkDRGm
 YeRarqYkye9+53lYUwpI0LcMGqYMDuUcpDNatO2w=
Subject: Altium - Proposal
To: =?UTF-8?Q?linux-erofs=40lists=2Eozlabs=2Eorg?=
 <linux-erofs@lists.ozlabs.org>
Date: Wed, 29 Jul 2020 14:14:29 +0000
Mime-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_4ho8SGAsWaLxm5pGrkaxt-UsHNoSejsAy1X3K7f121QFfQWq"
References: <mail.497bf22a-7786-4d98-b1dd-762b7d8d7c82@storage.wm.amazon.com> 
 <mail.497bf22a-7786-4d98-b1dd-762b7d8d7c82@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdZlsKd16b/OurAaTOG5yBbnJD8p/w==
Thread-Topic: Altium - Proposal
X-Wm-Sent-Timestamp: 1596032068
Message-ID: <010101739aecae31-9ea286ed-b4ed-4adb-ad67-789d2f6af463-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.07.29-54.240.27.128
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
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
From: Kelsey Cooper via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: =?UTF-8?Q?Kelsey_Cooper?= <kelsey@konnectglobalmarketing.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_4ho8SGAsWaLxm5pGrkaxt-UsHNoSejsAy1X3K7f121QFfQWq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

=C2=A0
Would you like to send in your Business Proposals/Newsletter to key decis=
ion Makers from companies currently using Altium Software=3F

=C2=A0
Titles Like:=C2=A0 IT Decision Makers, C-level, Managers and other job ti=
tles as per your requirement.=20

=C2=A0
Kindly let me know the Job Titles & Geography that you wish to target, so=
 that I can get back with the samples, counts and more details for your r=
eview.=20

=C2=A0
We cater other Industry contacts such as: Manufacturing,=C2=A0Constructio=
n,=C2=A0Education,=C2=A0Retail,=C2=A0Healthcare, Energy, Utilities & Wast=
e Treatment, Transportation, etc.=20

=C2=A0
Looking forward to your response.

=C2=A0
Regards,

Kelsey Cooper - Marketing Executive

=C2=A0
Stay safe.

Reply back =E2=80=9CPass=E2=80=9D for no further emails.

=C2=A0

--=_4ho8SGAsWaLxm5pGrkaxt-UsHNoSejsAy1X3K7f121QFfQWq
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mi=
crosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:wo=
rd" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D=
"http://www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type"=
 CONTENT=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=
=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;}
p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing
=09{mso-style-priority:1;
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
=09{mso-style-name:x_msonormal;
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;}
=2EMsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;}
=2EMsoPapDefault
=09{mso-style-type:export-only;
=09margin-bottom:8.0pt;
=09line-height:107%;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US><div class=3D=
WordSection1><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-size:1=
2.0pt;color:black;background:white'>Hi,</span></p><p class=3DMsoNormal><s=
pan lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>=
&nbsp;</span></p><p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Wo=
uld you like to send in your Business Proposals/Newsletter to key decisio=
n Makers<span style=3D'color:black;background:white'> </span></span><span=
 lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>fro=
m companies currently using<b> </b></span><b><span style=3D'font-size:12.=
0pt;color:black;background:white'>Altium Software</span></b><b><span lang=
=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>=3F</spa=
n></b><b><span style=3D'font-size:12.0pt;color:black;background:white'><o=
:p></o:p></span></b></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D'=
font-size:12.0pt;color:black'>&nbsp;</span></p><p class=3DMsoNormal><u><s=
pan lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>Titles Like:</spa=
n></u><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>&nbsp;=
</span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;ba=
ckground:white;mso-fareast-language:EN-IN'> </span></b><span lang=3DEN-IN=
 style=3D'font-size:12.0pt;color:black;background:white'>IT Decision Make=
rs, C-level, Managers and other job titles as per your requirement. </spa=
n></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-size:12.0pt;c=
olor:black;background:white'>&nbsp;</span></p><p class=3DMsoNoSpacing><sp=
an lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white;ms=
o-fareast-language:EN-IN'>Kindly let me know the <b>Job Titles &amp; Geog=
raphy</b> that you wish to target, so that I can get back with the <u>sam=
ples, counts </u>and more details for your review. </span></p><p class=3D=
MsoNormal><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;backgr=
ound:white'>&nbsp;</span></p><p class=3DMsoNormal><span lang=3DEN-IN styl=
e=3D'font-size:12.0pt;color:black;background:white'>We cater other Indust=
ry contacts such as: <b>Manufacturing,&nbsp;</b></span><b><span style=3D'=
font-size:12.0pt;color:black;background:white'>Construction</span></b><b>=
<span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white=
'>,&nbsp;</span></b><b><span style=3D'font-size:12.0pt;color:black;backgr=
ound:white'>Education</span></b><b><span lang=3DEN-IN style=3D'font-size:=
12.0pt;color:black;background:white'>,&nbsp;</span></b><b><span style=3D'=
font-size:12.0pt;color:black;background:white'>Retail</span></b><b><span =
lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>,&nb=
sp;</span></b><b><span style=3D'font-size:12.0pt;color:black;background:w=
hite'>Healthcare, Energy, Utilities &amp; Waste Treatment, Transportation=
, </span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;=
background:white'>etc. </span></b></p><p class=3DMsoNormal><span lang=3DE=
N-IN style=3D'font-size:12.0pt;color:black;background:white'>&nbsp;</span=
></p><p class=3DMsoNormal style=3D'background:white'><span style=3D'font-=
size:12.0pt'>Looking forward to your response.</span></p><p class=3DMsoNo=
rmal><span lang=3DEN-IN style=3D'font-size:12.0pt;mso-fareast-language:EN=
-IN'>&nbsp;</span></p><p class=3Dxmsonormal><b><i><span lang=3DEN-IN styl=
e=3D'font-size:12.0pt;color:black'>Regards,<o:p></o:p></span></i></b></p>=
<p class=3Dxmsonormal><b><i><span style=3D'font-size:12.0pt;color:black'>=
Kelsey Cooper </span></i></b><b><i><span lang=3DEN-IN style=3D'font-size:=
12.0pt;color:black'>- Marketing Executive<o:p></o:p></span></i></b></p><p=
 class=3Dxmsonormal><b><i><span lang=3DEN-IN style=3D'color:black'>&nbsp;=
</span></i></b><span style=3D'font-family:"Times New Roman",serif'><o:p><=
/o:p></span></p><p class=3Dxmsonormal><b><span lang=3DEN-IN style=3D'colo=
r:#BFBFBF'>Stay safe.</span></b><span lang=3DEN-AU><o:p></o:p></span></p>=
<p class=3Dxmsonormal><span lang=3DEN-IN style=3D'font-size:8.0pt;color:#=
D9D9D9'>Reply back &#8220;Pass&#8221; for no further emails.<o:p></o:p></=
span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
--=_4ho8SGAsWaLxm5pGrkaxt-UsHNoSejsAy1X3K7f121QFfQWq--
