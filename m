Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB123391E
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jul 2020 21:36:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHgdS5CVpzDrBq
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 05:36:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1596137788;
	bh=LOAfChVMXlw8n++M2lJnG15YNzs/DNU+M3Ug/eIbfVY=;
	h=Subject:To:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ZfEuXxh1YGDAI2sAhCzhSyL6LSOb4CCIPLaakfqbnP0FLDvr3QLrI4NTCp/5P7qwD
	 jyRC+i7r9VJIe5SbjRIJRjRWv2BNRaD6MS8vN588MiCD98FK1o/QrqXGgxDdq+IGK0
	 zHCuxXbIRnrCtWnhnf2rIjfoFvx2nETe/CVSvGwoGHEVRP6vAe25j37pJM1SVvzBeH
	 j+4+Jr08nhWGOlvtjJ3rkc4xkXaLt7kurdBpMvdP32ZqFun7ZNFv/TL5cJ7osYlrbY
	 C/5PTqCNN4cxNgw+teh5WqZ7ihpw8C3bYMTqvcdHNOR2+8LMsIhPMfo2I2qD6yrf6L
	 dblbqZhZQIIEw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us-west-2.amazonses.com (client-ip=54.240.27.65;
 helo=a27-65.smtp-out.us-west-2.amazonses.com;
 envelope-from=01010173a13398af-096d8b03-c581-4a2f-a4c5-6d02f1b5bcd6-000000@us-west-2.amazonses.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=konnectglobalmarketing.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konnectglobalmarketing.com
 header.i=@konnectglobalmarketing.com header.a=rsa-sha256
 header.s=sknkt525wmvsd5qrslvt4aisaznnhvir header.b=kr0cCIbx; 
 dkim=pass (1024-bit key;
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv
 header.b=dyhbEHMU; dkim-atps=neutral
X-Greylist: delayed 398 seconds by postgrey-1.36 at bilbo;
 Fri, 31 Jul 2020 05:36:21 AEST
Received: from a27-65.smtp-out.us-west-2.amazonses.com
 (a27-65.smtp-out.us-west-2.amazonses.com [54.240.27.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHgdK4zDfzDqpd
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 Jul 2020 05:36:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
 t=1596137380;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
 bh=LOAfChVMXlw8n++M2lJnG15YNzs/DNU+M3Ug/eIbfVY=;
 b=kr0cCIbxLXYwlStIK3rNE4v/El/HR6Gur8tjz8+h+ML8d7YIC54QVAByOnYHrYWk
 COO0zgSqxY3K7gqJKBd565NPHGVgP8IxLmik+jlTHYEnTj163k9frec5r6AMrx5gdYy
 Qy0mXA/97nufJ3mOxFLKM3/ZGnGkRQqTZTdQfR+o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1596137380;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
 bh=LOAfChVMXlw8n++M2lJnG15YNzs/DNU+M3Ug/eIbfVY=;
 b=dyhbEHMUzeUt569AD4vvpJ7oajbszppkmuwCcalTqgjZ28JpmdXP/Dx45wwxaiuQ
 0aomqZNo5XDfoucjHcJcAFuf+gMwBoJRcQg93xcC1Sdy3vVGb752Qj3OTQp/Ggbt/GR
 Bt/iJZWn6vN5NbkZe4wKa4ZgQdMmpu1BUryIk6yI=
Subject: RE: Altium - Proposal
To: =?UTF-8?Q?=27linux-erofs=40lists=2Eozlabs=2Eorg=27?=
 <linux-erofs@lists.ozlabs.org>
Date: Thu, 30 Jul 2020 19:29:40 +0000
Mime-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_z-N8LisYGQXFC11tay9U6MEfHTJmeZSDzD6hmoXwrVR9uxWE"
References: <mail.eb086447-0a2b-4862-afcb-3efe258a551a@storage.wm.amazon.com> 
 <mail.eb086447-0a2b-4862-afcb-3efe258a551a@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdZmpqWZiZQqb0jSTv6SPPly1bIASw==
Thread-Topic: RE: Altium - Proposal
X-Wm-Sent-Timestamp: 1596137379
Message-ID: <01010173a13398af-096d8b03-c581-4a2f-a4c5-6d02f1b5bcd6-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.07.30-54.240.27.65
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
--=_z-N8LisYGQXFC11tay9U6MEfHTJmeZSDzD6hmoXwrVR9uxWE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


Did you get a chance to go through my previous email=3F=20


Kindly let me know your target audience Job Titles & Geography that you w=
ish to target, so that I can get back with the counts, pricing and all th=
e details for your review.

=C2=A0
Appreciate your response.

=C2=A0
Regards,

Kelsey Cooper - Marketing Executive

=C2=A0
=C2=A0
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

--=_z-N8LisYGQXFC11tay9U6MEfHTJmeZSDzD6hmoXwrVR9uxWE
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
WordSection1><p class=3DMsoNoSpacing><span style=3D'font-size:12.0pt;colo=
r:black;background:white;mso-fareast-language:EN-IN'>Hi,<o:p></o:p></span=
></p><p class=3DMsoNoSpacing><span style=3D'font-size:12.0pt;color:black;=
background:white;mso-fareast-language:EN-IN'><br>Did you get a chance to =
go through my previous email=3F <o:p></o:p></span></p><p class=3DMsoNoSpa=
cing><span style=3D'font-size:12.0pt;color:black;background:white;mso-far=
east-language:EN-IN'><br>Kindly let me know your target audience</span><s=
pan style=3D'font-size:12.0pt;color:black;background:white'> </span><b><s=
pan lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>=
Job Titles &amp; Geography</span></b><span lang=3DEN-IN style=3D'font-siz=
e:12.0pt;color:black;background:white'> </span><span style=3D'font-size:1=
2.0pt;color:black;background:white;mso-fareast-language:EN-IN'>that you w=
ish to target, so that I can get back with the <u>counts, pricing</u> and=
 all the details for your review.<o:p></o:p></span></p><p class=3DMsoNoSp=
acing><span style=3D'font-size:12.0pt;color:black;background:white;mso-fa=
reast-language:EN-IN'>&nbsp;<o:p></o:p></span></p><p class=3DMsoNoSpacing=
><span style=3D'font-size:12.0pt;color:black;background:white;mso-fareast=
-language:EN-IN'>Appreciate your response.<o:p></o:p></span></p><p class=3D=
MsoNoSpacing><span style=3D'font-size:12.0pt;color:black;background:white=
;mso-fareast-language:EN-IN'>&nbsp;<o:p></o:p></span></p><p class=3Dxmson=
ormal><b><i><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>Reg=
ards,<o:p></o:p></span></i></b></p><p class=3Dxmsonormal><b><i><span styl=
e=3D'font-size:12.0pt;color:black'>Kelsey Cooper </span></i></b><b><i><sp=
an lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>- Marketing Execut=
ive<o:p></o:p></span></i></b></p><div style=3D'mso-element:para-border-di=
v;border:none;border-bottom:solid windowtext 1.5pt;padding:0in 0in 1.0pt =
0in'><p class=3DMsoNormal style=3D'border:none;padding:0in'><span lang=3D=
EN-IN style=3D'font-size:12.0pt;color:black;background:white'><o:p>&nbsp;=
</o:p></span></p></div><p class=3DMsoNormal><span lang=3DEN-IN style=3D'f=
ont-size:12.0pt;color:black;background:white'><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-size:12.0pt;color:=
black;background:white'>Hi,</span></p><p class=3DMsoNormal><span lang=3DE=
N-IN style=3D'font-size:12.0pt;color:black;background:white'>&nbsp;</span=
></p><p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Would you like=
 to send in your Business Proposals/Newsletter to key decision Makers<spa=
n style=3D'color:black;background:white'> </span></span><span lang=3DEN-I=
N style=3D'font-size:12.0pt;color:black;background:white'>from companies =
currently using<b> </b></span><b><span style=3D'font-size:12.0pt;color:bl=
ack;background:white'>Altium Software</span></b><b><span lang=3DEN-IN sty=
le=3D'font-size:12.0pt;color:black;background:white'>=3F</span></b><b><sp=
an style=3D'font-size:12.0pt;color:black;background:white'><o:p></o:p></s=
pan></b></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-size:12=
=2E0pt;color:black'>&nbsp;</span></p><p class=3DMsoNormal><u><span lang=3D=
EN-IN style=3D'font-size:12.0pt;color:black'>Titles Like:</span></u><b><s=
pan lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>&nbsp;</span></b>=
<b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:wh=
ite;mso-fareast-language:EN-IN'> </span></b><span lang=3DEN-IN style=3D'f=
ont-size:12.0pt;color:black;background:white'>IT Decision Makers, C-level=
, Managers and other job titles as per your requirement. </span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;=
background:white'>&nbsp;</span></p><p class=3DMsoNoSpacing><span lang=3DE=
N-IN style=3D'font-size:12.0pt;color:black;background:white;mso-fareast-l=
anguage:EN-IN'>Kindly let me know the <b>Job Titles &amp; Geography</b> t=
hat you wish to target, so that I can get back with the <u>samples, count=
s </u>and more details for your review. </span></p><p class=3DMsoNormal><=
span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'=
>&nbsp;</span></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-s=
ize:12.0pt;color:black;background:white'>We cater other Industry contacts=
 such as: <b>Manufacturing,&nbsp;</b></span><b><span style=3D'font-size:1=
2.0pt;color:black;background:white'>Construction</span></b><b><span lang=3D=
EN-IN style=3D'font-size:12.0pt;color:black;background:white'>,&nbsp;</sp=
an></b><b><span style=3D'font-size:12.0pt;color:black;background:white'>E=
ducation</span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:=
black;background:white'>,&nbsp;</span></b><b><span style=3D'font-size:12.=
0pt;color:black;background:white'>Retail</span></b><b><span lang=3DEN-IN =
style=3D'font-size:12.0pt;color:black;background:white'>,&nbsp;</span></b=
><b><span style=3D'font-size:12.0pt;color:black;background:white'>Healthc=
are, Energy, Utilities &amp; Waste Treatment, Transportation, </span></b>=
<b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:wh=
ite'>etc. </span></b></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D=
'font-size:12.0pt;color:black;background:white'>&nbsp;</span></p><p class=
=3DMsoNormal style=3D'background:white'><span style=3D'font-size:12.0pt'>=
Looking forward to your response.</span></p><p class=3DMsoNormal><span la=
ng=3DEN-IN style=3D'font-size:12.0pt;mso-fareast-language:EN-IN'>&nbsp;</=
span></p><p class=3Dxmsonormal><b><i><span lang=3DEN-IN style=3D'font-siz=
e:12.0pt;color:black'>Regards,<o:p></o:p></span></i></b></p><p class=3Dxm=
sonormal><b><i><span style=3D'font-size:12.0pt;color:black'>Kelsey Cooper=
 </span></i></b><b><i><span lang=3DEN-IN style=3D'font-size:12.0pt;color:=
black'>- Marketing Executive<o:p></o:p></span></i></b></p><p class=3Dxmso=
normal><b><i><span lang=3DEN-IN style=3D'color:black'>&nbsp;</span></i></=
b><span style=3D'font-family:"Times New Roman",serif'><o:p></o:p></span><=
/p><p class=3Dxmsonormal><b><span lang=3DEN-IN style=3D'color:#BFBFBF'>St=
ay safe.</span></b><span lang=3DEN-AU><o:p></o:p></span></p><p class=3Dxm=
sonormal><span lang=3DEN-IN style=3D'font-size:8.0pt;color:#D9D9D9'>Reply=
 back &#8220;Pass&#8221; for no further emails.<o:p></o:p></span></p><p c=
lass=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
--=_z-N8LisYGQXFC11tay9U6MEfHTJmeZSDzD6hmoXwrVR9uxWE--
