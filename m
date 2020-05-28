Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F231E67AD
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 18:47:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Xts01lLvzDqY3
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2020 02:47:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1590684420;
	bh=HXdOE7m/beJLpJmWHS9Docasd1lmDd0ab8SVy7LYYO4=;
	h=Subject:To:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Ffjo4iSUwKTFtRI25EgzuQyLLTwHTuT6eWGKXtkDWTRrAXDSdZ/y6b7/MbUR/dgYt
	 1M9J8ZcCjCBlId9NSbWH54ocoKvoni5mAFYnRcPgd6leJsyirFSSPvmNk6zWVJn8FX
	 akQ4TXe/PnNP0PNf23bNIcEe9CiUB0DmG69CA6DJgve1MAliwhzXj9kYYHNk8oqKeN
	 ++v6eQ8yTMdxguP/BWqJ9NjcLfiFN+9dd9umt1SA7sTTCNdfx62f9xUDSWq0XUVsMJ
	 MGk6JUn0f5AAtozcHWK/2nwaYaB7YqeKhYiEPnnst9aWvOi16F/99LId3PwvB5s8ZQ
	 8D0deu8s2XtPA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us-west-2.amazonses.com (client-ip=54.240.26.16;
 helo=a26-16.smtp-out.us-west-2.amazonses.com;
 envelope-from=010101725c2a424e-e9164abf-5b75-41a2-a7a6-83d7f1554c88-000000@us-west-2.amazonses.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=konnectglobalmarketing.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konnectglobalmarketing.com
 header.i=@konnectglobalmarketing.com header.a=rsa-sha256
 header.s=sknkt525wmvsd5qrslvt4aisaznnhvir header.b=F2DzqehW; 
 dkim=pass (1024-bit key;
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv
 header.b=dKuO9rKX; dkim-atps=neutral
X-Greylist: delayed 236 seconds by postgrey-1.36 at bilbo;
 Fri, 29 May 2020 02:46:53 AEST
Received: from a26-16.smtp-out.us-west-2.amazonses.com
 (a26-16.smtp-out.us-west-2.amazonses.com [54.240.26.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Xtrs1ZJCzDqKh
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2020 02:46:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
 t=1590684172;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
 bh=HXdOE7m/beJLpJmWHS9Docasd1lmDd0ab8SVy7LYYO4=;
 b=F2DzqehWArwVCCDqybKlgs2ypysit9roKM1dact7ogfuJR9VUsHiEtI9KkV1P+Ua
 eL6GXhNr9Ir5RHHfJkFSyMepmeFne4a6kA6ldPQcdUWFz501bZUO7CBOnD1E7VtrZhJ
 Niv0OJ44HeIN7Mu1t6HY4Wh1NXPIJRB2/5ZZYIZs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1590684172;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
 bh=HXdOE7m/beJLpJmWHS9Docasd1lmDd0ab8SVy7LYYO4=;
 b=dKuO9rKX6MmmX+ox3BztexKe2NznQ0iPFuXwPWHxqjPeGYasKsS1s6POfhi3EpNj
 MGxnWn7L3eRiw/Q7muAaIlS74D5BbcHsSXhqFdz3Mhg7n9Yj62QYWJIxGJbO+W+OMQh
 Niz5W9JJDtA+GeHuKFHDvqlVk1X4ycQxwMpHpIxg=
Subject: RE: Proposal
To: =?UTF-8?Q?linux-erofs=40lists=2Eozlabs=2Eorg?=
 <linux-erofs@lists.ozlabs.org>
Date: Thu, 28 May 2020 16:42:52 +0000
Mime-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_cE-PKwD32g1ZfZojaKU-64xxH3WNehq5yPvRLBlPFpEG0uBn"
References: <mail.3c2fabf7-d436-4d4e-93cc-1a7bfd1bc44f@storage.wm.amazon.com> 
 <mail.3c2fabf7-d436-4d4e-93cc-1a7bfd1bc44f@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdY1CRwzuv4vIjxQT4WNFpjtvgOlzw==
Thread-Topic: RE: Proposal
Message-ID: <010101725c2a424e-e9164abf-5b75-41a2-a7a6-83d7f1554c88-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.05.28-54.240.26.16
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
From: Hailey Jones via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: =?UTF-8?Q?Hailey_Jones?= <hailey@konnectglobalmarketing.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_cE-PKwD32g1ZfZojaKU-64xxH3WNehq5yPvRLBlPFpEG0uBn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


Did you get a chance to go through my previous email=3F=20


Kindly let me know your target audience (Sectors, Job Titles & Geography)=
 that you wish to target, so that I can get back with the counts, samples=
 and pricing details for your review.=20

=C2=A0
Appreciate your response.

=C2=A0
Thanks,

Hailey Jones - Marketing Executive

=C2=A0
=C2=A0
Hi,

=C2=A0
Would you like to connect with key decision makers from the below sectors=
;

=C2=A0
Manufacturing, Construction, Education, Retail, Healthcare, Energy, Utili=
ties & Waste Treatment, Transportation, Banking & Finance, Media & Intern=
et, Hospitality, etc.=20

=C2=A0
You can contact them via direct=C2=A0business emails or phone numbers=C2=A0=
for your sales and marketing initiatives.=20

=C2=A0
We can also provide you contacts from companies currently using Altium

Software.

=C2=A0
Kindly let me know the Sectors, Job Titles & Geography that you wish to t=
arget, so that I can get back with the samples, counts and more details f=
or your review.=20

=C2=A0
Looking forward to your response.

=C2=A0
Thanks,

Hailey Jones - Marketing Executive

=C2=A0
Stay safe.

Reply back =E2=80=9CPass=E2=80=9D for no further emails.

=C2=A0

--=_cE-PKwD32g1ZfZojaKU-64xxH3WNehq5yPvRLBlPFpEG0uBn
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
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
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
WordSection1><p class=3DMsoNormal><span style=3D'font-size:12.0pt;color:b=
lack;background:white;mso-fareast-language:EN-IN'>Hi,</span></p><p class=3D=
MsoNormal><span style=3D'font-size:12.0pt;color:black;background:white;ms=
o-fareast-language:EN-IN'><br>Did you get a chance to go through my previ=
ous email=3F </span></p><p class=3DMsoNormal><span style=3D'font-size:12.=
0pt;color:black;background:white;mso-fareast-language:EN-IN'><br>Kindly l=
et me know your target audience (</span><b><span lang=3DEN-IN style=3D'fo=
nt-size:12.0pt;color:black;background:white;mso-fareast-language:EN-IN'>S=
ectors,</span></b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:blac=
k;background:white;mso-fareast-language:EN-IN'> <b>Job Titles &amp; Geogr=
aphy</b>) </span><span style=3D'font-size:12.0pt;color:black;background:w=
hite;mso-fareast-language:EN-IN'>that you wish to target, so that I can g=
et back with the <u>counts, samples and pricing</u> details for your revi=
ew. </span></p><p class=3DMsoNormal><span style=3D'font-size:12.0pt;color=
:black;background:white;mso-fareast-language:EN-IN'>&nbsp;</span></p><p c=
lass=3DMsoNormal><span style=3D'font-size:12.0pt;color:black;background:w=
hite;mso-fareast-language:EN-IN'>Appreciate your response.</span></p><p c=
lass=3DMsoNormal><span style=3D'font-size:12.0pt;color:black;background:w=
hite;mso-fareast-language:EN-IN'>&nbsp;</span></p><p class=3DMsoNormal><b=
><i><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:w=
hite;mso-fareast-language:EN-IN'>Thanks,</span></i></b><i><span lang=3DEN=
-IN><o:p></o:p></span></i></p><p class=3DMsoNormal><b><i><span lang=3DEN-=
IN style=3D'font-size:12.0pt;color:black'>Hailey Jones - Marketing Execut=
ive</span></i></b><i><span lang=3DEN-IN><o:p></o:p></span></i></p><div st=
yle=3D'mso-element:para-border-div;border:none;border-bottom:solid window=
text 1.5pt;padding:0in 0in 1.0pt 0in;background:white'><p class=3DMsoNorm=
al style=3D'background:white;border:none;padding:0in'><span style=3D'font=
-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></p></div><p class=3DMs=
oNormal style=3D'background:white'><span style=3D'font-size:12.0pt;color:=
black'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'backgrou=
nd:white'><span style=3D'font-size:12.0pt;color:black'>Hi,</span><span la=
ng=3DIT><o:p></o:p></span></p><p class=3DMsoNormal style=3D'background:wh=
ite'><span lang=3DIT><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal sty=
le=3D'background:white'><span style=3D'font-size:12.0pt;color:black'>Woul=
d you like to connect with key decision makers from<b> </b>the below sect=
ors<b>;<o:p></o:p></b></span></p><p class=3DMsoNormal style=3D'background=
:white'><b><span style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p>=
</span></b></p><p class=3DMsoNormal style=3D'background:white'><b><span l=
ang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>Manuf=
acturing, </span></b><b><span style=3D'font-size:12.0pt;color:black;backg=
round:white'>Construction</span></b><b><span lang=3DEN-IN style=3D'font-s=
ize:12.0pt;color:black;background:white'>, </span></b><b><span style=3D'f=
ont-size:12.0pt;color:black;background:white'>Education</span></b><b><spa=
n lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>, =
</span></b><b><span style=3D'font-size:12.0pt;color:black;background:whit=
e'>Retail</span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color=
:black;background:white'>, </span></b><b><span style=3D'font-size:12.0pt;=
color:black;background:white'>Healthcare, Energy, Utilities &amp; Waste T=
reatment, Transportation, Banking &amp; Finance,</span></b><span style=3D=
'font-size:10.5pt;font-family:"Arial",sans-serif;color:#797D86;background=
:white'> </span><b><span style=3D'font-size:12.0pt;color:black;background=
:white'>Media &amp; Internet, Hospitality, </span></b><b><span lang=3DEN-=
IN style=3D'font-size:12.0pt;color:black;background:white'>etc. <o:p></o:=
p></span></b></p><p class=3DMsoNormal style=3D'background:white'><span st=
yle=3D'font-size:12.0pt;color:black'>&nbsp;</span><span lang=3DIT><o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'background:white'><span styl=
e=3D'font-size:12.0pt;color:black'>You can contact them via direct&nbsp;<=
u>business emails or phone numbers</u>&nbsp;for your sales and marketing =
initiatives. <o:p></o:p></span></p><p class=3DMsoNormal style=3D'backgrou=
nd:white'><span style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p><=
/span></p><p class=3DMsoNormal style=3D'background:white'><span style=3D'=
font-size:12.0pt;color:black'>We can also provide you contacts </span><sp=
an style=3D'font-size:12.0pt;color:black;background:white;mso-fareast-lan=
guage:EN-IN'>from companies currently using <b>Altium</b></span><b><span =
lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white;mso-f=
areast-language:EN-IN'><o:p></o:p></span></b></p><p class=3DMsoNormal sty=
le=3D'background:white'><b><span style=3D'font-size:12.0pt;color:black;ba=
ckground:white;mso-fareast-language:EN-IN'>Software.</span></b><b><span l=
ang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white;mso-fa=
reast-language:EN-IN'><o:p></o:p></span></b></p><p class=3DMsoNormal styl=
e=3D'background:white'><span lang=3DIT><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNoSpacing><span lang=3DEN-IN style=3D'font-size:12.0pt;color:blac=
k;background:white;mso-fareast-language:EN-IN'>Kindly let me know the <b>=
Sectors,</b> <b>Job Titles &amp; Geography</b> that you wish to target, s=
o that I can get back with the <u>samples, counts </u>and more details fo=
r your review. <o:p></o:p></span></p><p class=3DMsoNormal style=3D'backgr=
ound:white'><span lang=3DIT><o:p>&nbsp;</o:p></span></p><p class=3DMsoNor=
mal style=3D'background:white'><span style=3D'font-size:12.0pt'>Looking f=
orward to your response.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-IN style=3D'font-size:12.0pt;mso-fareast-language:EN-IN'><o:p>&=
nbsp;</o:p></span></p><p class=3DMsoNormal><b><i><span lang=3DEN-IN style=
=3D'font-size:12.0pt;color:black;background:white;mso-fareast-language:EN=
-IN'>Thanks,</span></i></b><i><span lang=3DEN-IN><o:p></o:p></span></i></=
p><p class=3DMsoNormal><b><i><span lang=3DEN-IN style=3D'font-size:12.0pt=
;color:black'>Hailey Jones - Marketing Executive</span></i></b><i><span l=
ang=3DEN-IN><o:p></o:p></span></i></p><p class=3Dxmsonormal><b><i><span l=
ang=3DEN-IN style=3D'font-family:"Calibri",sans-serif;color:black'>&nbsp;=
</span></i></b><span style=3D'font-size:11.0pt;font-family:"Calibri",sans=
-serif'><o:p></o:p></span></p><p class=3Dxmsonormal><b><span lang=3DEN-IN=
 style=3D'font-family:"Calibri",sans-serif;color:#A6A6A6'>Stay safe.</spa=
n></b><span style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><=
o:p></o:p></span></p><p class=3Dxmsonormal><span lang=3DEN-IN style=3D'fo=
nt-size:8.0pt;font-family:"Calibri",sans-serif;color:gray'>Reply back &#8=
220;Pass&#8221; for no further emails.</span><span style=3D'font-size:11.=
0pt;font-family:"Calibri",sans-serif'><o:p></o:p></span></p><p class=3DMs=
oNormal><o:p>&nbsp;</o:p></p></div></body></html>
--=_cE-PKwD32g1ZfZojaKU-64xxH3WNehq5yPvRLBlPFpEG0uBn--
