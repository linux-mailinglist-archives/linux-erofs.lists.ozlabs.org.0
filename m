Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88685ECFE
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 00:31:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TgCG01kKmz3cRN
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 10:31:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=attendeetechexpometricsanalyzer.com (client-ip=2a01:111:f403:2021::701; helo=ind01-bmx-obe.outbound.protection.outlook.com; envelope-from=cally.mood@attendeetechexpometricsanalyzer.com; receiver=lists.ozlabs.org)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2021::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TgCFw41kBz3c4V
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Feb 2024 10:31:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZzACGdbWE0S6uW84ZrVnHFISc/9JKJF+x8ReBj+JOAJqQd/dqNVb8vdKLbLG3XNY0K93kHJLlqs4YqMMwp0u0da/jKpoRhsk+D+42VIagfqW6dcoIWr1iIbueR8b0gE9cqkbmWhsUNcQFFYtjH0sfFjWXjB+r+qRSUU4zL1Rya3N1r9tPdctc6DJkMxPiDFt+yd1sFT5Em8fwMNEn3gje1GQpRMSat4nlF10u4pLYFtJvbKEjoEWdbjG7GyX/CGrxRFhVp/FByEKT2Dg/Glx7CqOmBzPsclxz41gbaVZ+buCV6Ke6nIvRFAx5gmIDMp654q8GJJUNXjMsn0Pcy1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIJn5X0Qn8mGSLKgc/PWQNsZM4kwE9cIuzBZKOolEtg=;
 b=dGy0O4p8zL7CDsjvJlDVuRvPx4F5KGp3Q0IQNuSwJ0HkJtyRqtbEav/KrV3IYEV+8E5k02bFuuFASAaZUdCLs5Ix47asbDSZ9StZUkv9DfTiRYmGfjY2xfUEEQJzzl6yBZpFPp3XDvS83/IP4jzBC5y48PClfAlF6kCR4qByZcO6XC1s/l4+/qx+8z/4YTPS05UVwQufEZc/xPWHFG/0eomkVuEp3gdAypsG/isNlHS88qQh/9jEb8eODIN35cskssQ8QKxJrKAhJ7Rrp2l2T0A9EkZZpf2DSAEmKN284nmUuXS2Xp56L1Qxro3nuPeLQ/SYhoH56ld9pt/paTa+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=attendeetechexpometricsanalyzer.com; dmarc=pass action=none
 header.from=attendeetechexpometricsanalyzer.com; dkim=pass
 header.d=attendeetechexpometricsanalyzer.com; arc=none
Received: from PN3P287MB1398.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a3::11)
 by MA0P287MB1207.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 23:30:51 +0000
Received: from PN3P287MB1398.INDP287.PROD.OUTLOOK.COM
 ([fe80::eb88:21d5:b03a:21df]) by PN3P287MB1398.INDP287.PROD.OUTLOOK.COM
 ([fe80::eb88:21d5:b03a:21df%4]) with mapi id 15.20.7316.023; Wed, 21 Feb 2024
 23:30:51 +0000
From: Cally Mood <cally.mood@attendeetechexpometricsanalyzer.com>
To: Sign And Digital UK 2024 <linux-erofs@lists.ozlabs.org>
Subject: Lists - Sign And Digital UK 2024
Thread-Topic: Lists - Sign And Digital UK 2024
Thread-Index: AdplHf/Y1GDqajXATtGbFJscZsWIVw==
Date: Wed, 21 Feb 2024 23:30:51 +0000
Message-ID:  <PN3P287MB139898D3C715B50CC77690E99E572@PN3P287MB1398.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=attendeetechexpometricsanalyzer.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1398:EE_|MA0P287MB1207:EE_
x-ms-office365-filtering-correlation-id: 8d01a179-53e7-4b2c-df29-08dc33352423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XLsJG7Sz5BcGMa1Ehb0ODr5Ck9VdbTr34N5pWRrDavg/oGFT+xUHInIWUv6qowQ+JrMWbs6ezqMfh7pdQWPfPmaWeGWmTCwXwGFK6kSvNPrlwycJEO1BEM0qwDLB+4Z3OweEGDYJssirRpMAfSJ6m9NcoQhWsdAZy36d3WXKqjRv2Uj9wmIWlV3ld2RoosT9mewV/tiH4gfBy2XTM/GiI29WmnREyBrS3zr3eYsu2oE+y4KILr01dBXpWqTDtK+NQzh5rLoS3Sa9GiSX+FrEFJnGM0kfIKLyrYCtm0BFPLh+74E/dTJIs8L2Ph/Luah3VQJsMIM3YnzbThzCG2xVpKGlDaqbGMkiAd3U4lxgjX64lUyXypl0++SM5l3me6bmLL1ivOJiVmIiN7GEJmkF0sSsk55WRQvvNRn4iC4PEQs6lbSRc+9FSkleTLJmG5KOpxP5jPAaHWd/RYq7BQ9wbsvI6yaNLk/CX+oL2nNtIit1usciw5frVCP4Vzc41dWOwO7w0Luq/QnTyp2B3U3JW7RAP9VWgomdOSINjy0rnCSUg7X2rkxCtmOiwGVGUP3LvCW94sH9PAUFZeH5c7SwiE1gnGLrXUbdjbPHjd1svZr3/He3zDH4ySDWxsY1FlVX
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1398.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?Vjj0sMA3KKt03ZsucZtY4dJoxAZY5uLPmxdpq10qZJi7LEE1klnqabNLAMN6?=
 =?us-ascii?Q?5bynGM3CDgTy8LB3feKUHSPJnNwS2UnlUsDNKittxp9U85A/tRNaWOT7Jrml?=
 =?us-ascii?Q?Sw3gg47htKXEHqPVOt89E6ofdfexlAPL05MAtQJ24NgJlgRsF1t9g4163FYV?=
 =?us-ascii?Q?GxoOl5/bmYE7ZR0egI6yUObzQWvqACf5nXSmxFp9rZQ4v6R4p2IVpggFF67Q?=
 =?us-ascii?Q?yOB2//kCpotLY5Th1XFP03ji/9kGqUpOu3DXrYxICOvjc5ZopVVnGVDcMvct?=
 =?us-ascii?Q?zP8LzB3o3e5M2Q1TLgQYBoD5nVxd2aByNwf20pLkG27qD9khO3Uky//ExeB4?=
 =?us-ascii?Q?qHzv6r7ECYRnGyXXYy594YnVx4pT3snTjbloIH85JFBDqO5LnbYM0WY071S/?=
 =?us-ascii?Q?7MCnmAWUKphz16MTlVRbk+Seguw9TSRDxBXlvYqxVWeWtBTxiJbSjOxoIH2v?=
 =?us-ascii?Q?f9+RmkKpaaguRiTxLQ2z5Sfatu2edQGJWCGqBtmtK1+PAi89Q0m8xFrsUaWl?=
 =?us-ascii?Q?EraZ9xuaOmjCcNlERktzuTobYj3l3q2utH4zgfY5MZ8ksKLDiFALF1PasYvj?=
 =?us-ascii?Q?gczgYDEbiwBQcAgCQ1cx0aJTHUr6qRIekT5F1jfIXrsYPFGWvIgetaaYopA1?=
 =?us-ascii?Q?B0choT4VUU57vy3oZWJPbtgpydXHr58DbsGx2bgjeoOHbJvYHzWMDnreNeW0?=
 =?us-ascii?Q?abXUfgHYIoxmkct+KKFS8lLtcrs33N8CdQE3e3FqrDQYIb1rvCgLcIGBwtWT?=
 =?us-ascii?Q?h4NqOkVlJ/rdX9pkQ+vSvsrc4KjKg0y7ul8+yIHC0V6wlERUsLVqEVQvJyTQ?=
 =?us-ascii?Q?8dMia55unc4YklbLx782IBuA3LE7rLlKHqXYJkPAbKf1vV1F0nq4byB6slU1?=
 =?us-ascii?Q?kxdvVehG7ChSxMWXat6DZAvAWXmnTjF37o64qEraEOr+tTFNqk8UkgfLoSUX?=
 =?us-ascii?Q?+MIQFfYE19/UOvmi3lH9FrHLDJ63sOJ2jOzkOQGqxYK4Chw8l5YI8oxr3hCl?=
 =?us-ascii?Q?6ngxYBBbPDq5o8TOcm/ud2kdHFmpZX09z0R2A7KUNm8tN8HNX75caYF3Zf3G?=
 =?us-ascii?Q?tJYA0+IrY8/cLUNXsw7nvwqqyQVWbiTlQ3FATWFb6bm6fv54OSJHCrVBxDAw?=
 =?us-ascii?Q?pTW9wEKASh0JtNan8pBYdbOAS+kWfrxblJT0ZoFcC46k12uE5AAjjdVbxLLg?=
 =?us-ascii?Q?6bMTGn2A1YsxSCkyxYOhNIyzb75PpmpDbPuZyCq7SDkSPvs+hM/6kPnGpQG5?=
 =?us-ascii?Q?wN6380Dqe4F+fpeDNDQg789bGsxBABA6kN7al2MqKt9YJmvAZmuNl1Br3reu?=
 =?us-ascii?Q?vEJAcVbM6v+PX13X5HeocQ2fzU9O8YE5LPWgQ+NJbh7v+fQ2HqpUQ5BlljvC?=
 =?us-ascii?Q?vn1mZnJoA52ZS+pEA3cw2YA2HBuloLFwOhWrtgAZpXfDy/F7TPRK+i2uKRZM?=
 =?us-ascii?Q?5Sbf4yrQemMmaLsHAM2tD9Lcwl0/TVXF3B2fc0ekzS9zp9qI5kdffRPEjO9a?=
 =?us-ascii?Q?9IJ39Hbl8X6V9rtdjRdguR6HSunqAG/i3MY4AZPc67X01vVMywjQohmh4tuH?=
 =?us-ascii?Q?Ul+2rV/e0TKCvNVQeV8hXLP9nxVdFuNV5VRK0i8zetW/B/9s75+8LXIBEp8Z?=
 =?us-ascii?Q?oHTlcCSzvjlActYHYmzN0qGpy8yHf3xHHDyo95hsZ3zbFmN2j+N92BVSinnS?=
 =?us-ascii?Q?W041Rrx/S1vPWYHsRCGlbDNX9IlOWdLpfn+voJPva0pIRFEK?=
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB139898D3C715B50CC77690E99E572PN3P287MB1398INDP_"
MIME-Version: 1.0
X-OriginatorOrg: attendeetechexpometricsanalyzer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1398.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d01a179-53e7-4b2c-df29-08dc33352423
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:30:51.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a657c127-39df-47cd-9412-cc7c046416e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhbiEHeTIWsWiyLmQFogw6mrng8t2EXHJQJVoTX0qYrB15E/6qJykuZx6HPT1vKcbRpBCoGusN3/y6BTZeaPiMPSk3i8OqiNnuCyxrOoEfo07BN1qBY1AvXUrKzIBcbPD8SrRdxwlWkRM6eOh2kgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1207
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_PN3P287MB139898D3C715B50CC77690E99E572PN3P287MB1398INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Hope you doing well

This is to inform you that buyers-list of Sign And Digital UK 2024 is avail=
able-for-purchase with the total at 5786 contacts at unlimited-usage.

Please let me know if you are interested. Accordingly, I will get back to y=
ou with the cost and other details.

Awaiting your response!

Kind Regards,
Cally Mood - Demand Generation


--_000_PN3P287MB139898D3C715B50CC77690E99E572PN3P287MB1398INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Hope you doing well<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">This is to inform you that buyers-list of =
Sign And Digital UK 2024 is available-for-purchase with the total at 5786 c=
ontacts at unlimited-usage.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Please let me know if you are interested. =
Accordingly, I will get back to you with the cost and other details.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Awaiting your response!
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Kind Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Cally Mood - Demand Generation<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PN3P287MB139898D3C715B50CC77690E99E572PN3P287MB1398INDP_--
