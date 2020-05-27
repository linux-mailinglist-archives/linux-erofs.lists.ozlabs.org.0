Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58491E4BC5
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 19:22:49 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XHhk10hjzDqSM
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 03:22:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1590600166;
	bh=0qZaL49/wQG4KQJUYLoBgXsiv1+uQdTgYXJgUR3yfKA=;
	h=Subject:To:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=UfFXDFGEbh+BjeybtR1+QuUjTm43oE9daWIihbNkAyKocMA7BC2qb9ySo6NLV7qRn
	 hY2AOe1KmDtD9/5Y+yyuSo6lhoSywCqthn84V090cRVt9OnBYqOBco/vAI8DD2g0vs
	 Y5y105sshNHb8GfuhPWX9O+9qs2wXjQ18reB9dvG+rjgehYFSq3xX5D3zNnyzdXNtV
	 9+UHnJQ6d4Sq4L0QweC9W4CAWDPF1N+oTDnmaNutcXZqA4J461VVkN9qQuZjziDTVv
	 kBmVBixbtFgSC7U9Q7s5QAWBWT3vbZybg4tW3cg9hnT67MXXXeEuQPFgasm64Qs8Nh
	 uuU2wf8BoUUbw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us-west-2.amazonses.com (client-ip=54.240.27.104;
 helo=a27-104.smtp-out.us-west-2.amazonses.com;
 envelope-from=0101017257219cc1-d536fa61-99a2-4a75-bd7a-372f7a6a9034-000000@us-west-2.amazonses.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=konnectglobalmarketing.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konnectglobalmarketing.com
 header.i=@konnectglobalmarketing.com header.a=rsa-sha256
 header.s=sknkt525wmvsd5qrslvt4aisaznnhvir header.b=SZnAWzTk; 
 dkim=pass (1024-bit key;
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv
 header.b=W+kX32M3; dkim-atps=neutral
X-Greylist: delayed 435 seconds by postgrey-1.36 at bilbo;
 Thu, 28 May 2020 03:22:39 AEST
Received: from a27-104.smtp-out.us-west-2.amazonses.com
 (a27-104.smtp-out.us-west-2.amazonses.com [54.240.27.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XHhb0GltzDqH5
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 May 2020 03:22:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
 t=1590599720;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
 bh=0qZaL49/wQG4KQJUYLoBgXsiv1+uQdTgYXJgUR3yfKA=;
 b=SZnAWzTkCsc6+YZh3RCUF9VkMrnnjTE9H77dfqeLYuiy11/LY9b9vaIFnn18K4Gh
 Ed0zD158La+FOwsJSWIBxbMXUhpE5uX8A/+YngTa0wQSXdawrWcWl/8wPu9fXESJKWj
 3p9G4jpHeJyRnJkS9061TbLLHAeoEzC6bbpOCpBc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1590599720;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
 bh=0qZaL49/wQG4KQJUYLoBgXsiv1+uQdTgYXJgUR3yfKA=;
 b=W+kX32M37qtWCVUk/m6ZIt8JRecyPKq5BVdeJtGS2FEUttgxfa2VREQdmXAczunN
 d+xLeEjWRtYPgXALagD7XFpIHu5rUm0LrF/xZLdND/J5NSIjEyDO82kYrsiMYPm/lWV
 1rtTDUdHxIAR8SYfgpIu5ZBLbUjeaQyGr33SsrsQ=
Subject: Proposal
To: =?UTF-8?Q?linux-erofs=40lists=2Eozlabs=2Eorg?=
 <linux-erofs@lists.ozlabs.org>
Date: Wed, 27 May 2020 17:15:20 +0000
Mime-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_D0GPaX1t6+lAG0I9Clw4aK68743thaIfnSXl1i0oE4XNpAXf"
References: <mail.adaf45a7-a3c5-4638-b8f5-7a8fca14d603@storage.wm.amazon.com> 
 <mail.adaf45a7-a3c5-4638-b8f5-7a8fca14d603@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdY0R0jKLta4JZ8sS9ewbPwvIKjF8A==
Thread-Topic: Proposal
Message-ID: <0101017257219cc1-d536fa61-99a2-4a75-bd7a-372f7a6a9034-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.05.27-54.240.27.104
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
--=_D0GPaX1t6+lAG0I9Clw4aK68743thaIfnSXl1i0oE4XNpAXf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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

--=_D0GPaX1t6+lAG0I9Clw4aK68743thaIfnSXl1i0oE4XNpAXf
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
=09{mso-style-type:export-only;}
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
WordSection1><p class=3DMsoNormal style=3D'background:white'><span style=3D=
'font-size:12.0pt;color:black'>Hi,</span><span lang=3DIT><o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'background:white'><span lang=3DIT><o:=
p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'background:white'>=
<span style=3D'font-size:12.0pt;color:black'>Would you like to connect wi=
th key decision makers from<b> </b>the below sectors<b>;<o:p></o:p></b></=
span></p><p class=3DMsoNormal style=3D'background:white'><b><span style=3D=
'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></b></p><p class=3D=
MsoNormal style=3D'background:white'><b><span lang=3DEN-IN style=3D'font-=
size:12.0pt;color:black;background:white'>Manufacturing, </span></b><b><s=
pan style=3D'font-size:12.0pt;color:black;background:white'>Construction<=
/span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black;bac=
kground:white'>, </span></b><b><span style=3D'font-size:12.0pt;color:blac=
k;background:white'>Education</span></b><b><span lang=3DEN-IN style=3D'fo=
nt-size:12.0pt;color:black;background:white'>, </span></b><b><span style=3D=
'font-size:12.0pt;color:black;background:white'>Retail</span></b><b><span=
 lang=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white'>, <=
/span></b><b><span style=3D'font-size:12.0pt;color:black;background:white=
'>Healthcare, Energy, Utilities &amp; Waste Treatment, Transportation, Ba=
nking &amp; Finance,</span></b><span style=3D'font-size:10.5pt;font-famil=
y:"Arial",sans-serif;color:#797D86;background:white'> </span><b><span sty=
le=3D'font-size:12.0pt;color:black;background:white'>Media &amp; Internet=
, Hospitality, </span></b><b><span lang=3DEN-IN style=3D'font-size:12.0pt=
;color:black;background:white'>etc. <o:p></o:p></span></b></p><p class=3D=
MsoNormal style=3D'background:white'><span style=3D'font-size:12.0pt;colo=
r:black'>&nbsp;</span><span lang=3DIT><o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'background:white'><span style=3D'font-size:12.0pt;color:=
black'>You can contact them via direct&nbsp;<u>business emails or phone n=
umbers</u>&nbsp;for your sales and marketing initiatives. <o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'background:white'><span style=3D'fon=
t-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorm=
al style=3D'background:white'><span style=3D'font-size:12.0pt;color:black=
'>We can also provide you contacts </span><span style=3D'font-size:12.0pt=
;color:black;background:white;mso-fareast-language:EN-IN'>from companies =
currently using <b>Altium</b></span><b><span lang=3DEN-IN style=3D'font-s=
ize:12.0pt;color:black;background:white;mso-fareast-language:EN-IN'><o:p>=
</o:p></span></b></p><p class=3DMsoNormal style=3D'background:white'><b><=
span style=3D'font-size:12.0pt;color:black;background:white;mso-fareast-l=
anguage:EN-IN'>Software.</span></b><b><span lang=3DEN-IN style=3D'font-si=
ze:12.0pt;color:black;background:white;mso-fareast-language:EN-IN'><o:p><=
/o:p></span></b></p><p class=3DMsoNormal style=3D'background:white'><span=
 lang=3DIT><o:p>&nbsp;</o:p></span></p><p class=3DMsoNoSpacing><span lang=
=3DEN-IN style=3D'font-size:12.0pt;color:black;background:white;mso-farea=
st-language:EN-IN'>Kindly let me know the <b>Sectors,</b> <b>Job Titles &=
amp; Geography</b> that you wish to target, so that I can get back with t=
he <u>samples, counts </u>and more details for your review. <o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'background:white'><span lang=3DIT>=
<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'background:whit=
e'><span style=3D'font-size:12.0pt'>Looking forward to your response.<o:p=
></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-IN style=3D'font-s=
ize:12.0pt;mso-fareast-language:EN-IN'><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNormal><b><i><span lang=3DEN-IN style=3D'font-size:12.0pt;color:b=
lack;background:white;mso-fareast-language:EN-IN'>Thanks,</span></i></b><=
i><span lang=3DEN-IN><o:p></o:p></span></i></p><p class=3DMsoNormal><b><i=
><span lang=3DEN-IN style=3D'font-size:12.0pt;color:black'>Hailey Jones -=
 Marketing Executive</span></i></b><i><span lang=3DEN-IN><o:p></o:p></spa=
n></i></p><p class=3Dxmsonormal><b><i><span lang=3DEN-IN style=3D'font-fa=
mily:"Calibri",sans-serif;color:black'>&nbsp;</span></i></b><span style=3D=
'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p></o:p></span></p=
><p class=3Dxmsonormal><b><span lang=3DEN-IN style=3D'font-family:"Calibr=
i",sans-serif;color:#A6A6A6'>Stay safe.</span></b><span style=3D'font-siz=
e:11.0pt;font-family:"Calibri",sans-serif'><o:p></o:p></span></p><p class=
=3Dxmsonormal><span lang=3DEN-IN style=3D'font-size:8.0pt;font-family:"Ca=
libri",sans-serif;color:gray'>Reply back &#8220;Pass&#8221; for no furthe=
r emails.</span><span style=3D'font-size:11.0pt;font-family:"Calibri",san=
s-serif'><o:p></o:p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p>=
</div></body></html>
--=_D0GPaX1t6+lAG0I9Clw4aK68743thaIfnSXl1i0oE4XNpAXf--
