Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624286251B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Feb 2024 14:00:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Thn6F7505z3cDy
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 00:00:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=techxpo.org (client-ip=2a01:111:f403:2021::701; helo=ind01-bmx-obe.outbound.protection.outlook.com; envelope-from=iris.marsh@techxpo.org; receiver=lists.ozlabs.org)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2021::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Thn64228Nz3bws
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Feb 2024 23:59:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXlKmYPBrYw1QHpc/yQ/FON89ZZG+NLdRknua/Lgrhbe82byZkqSH4cywfi6bMGY+8N/47ESQMKaKhjuk+Ae4o6Q2rQ4Q8UuY/eOlROlZhjssdJwWL2UuAiwKqWFoSYgEe37O6MBxK+COA2hhsSTEnlOGziJHwgXWnf/V2uTwAGkxD4LYnV+dI9ehwM/md2vaGLV/rQXxm8Wo3Sp6KgbS/x8vRh6y0uAWyrBG94JDAySSVx3Nq2hHNEk5x/f4Mo4nPp4A1HWRjVU/uXs95LnlTsdxo9xErSdx5wyFk4pxWmkgRfE4AvvSzV1HRztYD3+fA0TBnax5XGDYj2/g4LJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iljhx02vs/UerTvwcaVdPWNu8BNCrqcdpvT/yJOl96A=;
 b=f1cUsNcHcINuCalWSwpYLO0aJX37p71WuZdGJik0zKIu2PbM5BALFPwbc4wfsH+6IR+U51HjKgbKRmOLVrUXsnC+PiZeujiuKxy2c7WY+129KSnP9oB6rQ16yMry5TE9f5bwl/2LieEcqW3U9h9HPNUTVU/qQmRmgykV06Z7pydL3CQXl2r+dpS4tms1RDOhnKaWj+fbyzLKw+csy1am7zu+chqbVbtnNinFA62Jxal2roE6PF/iJNgUsUtEtY4Dz8QhR/FNLnD7c5JU1F5VFwS8GJtDyM8WsPXzKIPsbgcf8EBV4R0UvtQgCqgoyi8EDiplobufL1HU75qwum/q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=techxpo.org; dmarc=pass action=none header.from=techxpo.org;
 dkim=pass header.d=techxpo.org; arc=none
Received: from PN0P287MB0277.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e4::14)
 by PN0P287MB2258.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Sat, 24 Feb
 2024 12:59:29 +0000
Received: from PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
 ([fe80::e4bd:b603:bb78:87a0]) by PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
 ([fe80::e4bd:b603:bb78:87a0%3]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 12:59:28 +0000
From: Iris Marsh <iris.marsh@techxpo.org>
To: Sign And Digital UK 2024 <linux-erofs@lists.ozlabs.org>
Subject: Lists - Sign And Digital UK 2024
Thread-Topic: Lists - Sign And Digital UK 2024
Thread-Index: AdpnIUqogeN7E2DDQ+ylXtZZ8Kvv3A==
Date: Sat, 24 Feb 2024 12:59:28 +0000
Message-ID:  <PN0P287MB0277910F7DA99EDD3CA1D19999542@PN0P287MB0277.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=techxpo.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0277:EE_|PN0P287MB2258:EE_
x-ms-office365-filtering-correlation-id: 8327bfcb-5233-4e30-b595-08dc35386fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  6jHirbEQCzLOLyaJ2MHhN6rh6HBnfYSdVrERJSG1unxa/WALEp1h/Zz+eW2uFUpVy7alXJlycIS+kAWyy4NxUAo1OBP5E2X7+6THMKbTkMHgmaBZF6WM2OkhPMxp10ia9EyeEn7l0zLnWaj9mVDfQm0LRQKFM59p1Tl26YRFQLmp/cGR4wpJOI6xbsCpb+3iL1C69a5j33w2LhVEJ+1cpQ1eVK4KsZ+iwGWA5BwU7yy4BPblN6WV9BO6CBxF/7weVXoSvcNm+cQmn3IdVHcP7xb5rTjGGfPjrkSDxAJHif7B/hQ7mVPu0DZTYGPO5hu63GgiJDmxsx1gTrko6iX14JkZhMADqq6RpPenKV0H5PLuKqRUW2PtIaMMP0T/uQN1IS0pfIHgNbOR+y5VU9BT4xCDsYHMWi0IsgnbXoh1t5kTZ1RAafazdU+FN7g6QDeq5n3ffpzzPWmFc4nrsPpc1edOQE3Q1Vpaex5aD1wUyLMv3Q/0VprzN8eC49NJV2Dp85DSA0/IHJeoGH7MvQfHg0u+gqfNzKUUIgU/zJUhm6GhsAe8ZRiMLnLIyE5fPOkPtXtp+z0FwSGXbBHRAuqc1NC5479nwuCkEvt5j2vzqiJ95aKbUvL32bAsgLT6q5qB
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0277.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?uEKbCqzI6zcV0DHVPVwY+TTa7QOzqebgZBH4BhUxtdsO5FOa8QXlrNSphRgx?=
 =?us-ascii?Q?DAQ26mR0JWJoFLw5z5A2rwDLvr5DZiynwHojvQtgDPpXhZudEPcAFNYNgg7w?=
 =?us-ascii?Q?S4kYTCXPBcdQ8UzxfDzsOWNAJ+MBCBO6nI1FU9kJTFz2lxmyfj0YNgxiae5n?=
 =?us-ascii?Q?CrhMPIPFuv1b9C4BGiPkiDaYLu7uNM3JgnypMq8fdz9K/hKe5z5JcUcwfZWe?=
 =?us-ascii?Q?pvPKn0DJqWz9G+/RRSH1L82jjcIYfPj92qmqGsupiu1c+3SHyP7j0LOosIim?=
 =?us-ascii?Q?ngygOQhg7W/hEPbDqcZyFxs7JnLEPMTs2N+8zJlqzvg2rKtcYl2EHInvRWBl?=
 =?us-ascii?Q?SKi8RerGpRI3+Ih4jLfP+3EF+XfJLUk9A/ZFtPxI3VE2+51lqIIeBvxh8VGo?=
 =?us-ascii?Q?dqffaha5QtE/8jtsN/x1WzrajHZ8YHnKLfs+w3TtegtpArcFH4pvUelhVazX?=
 =?us-ascii?Q?rBdgW3D1XJ2CrpBbpEzI2AqiobfLMvRb3PCqp8PW2HwbkwpcB3SsYSlyD6Ij?=
 =?us-ascii?Q?hW2z7670z2IpZS5Xlh5ek86lSjVRGOqtwbuOHMbq7mzln/8LOTHQybcVGTLi?=
 =?us-ascii?Q?jhYDB0LMBmPMFPkPdl3qyeyTQ72csRe0Pd1m9WWy8zNkN30GyzXExBItTSje?=
 =?us-ascii?Q?TypGhKwNYAaH5M58tlmoPr7FQYYhIaymW09F5LeGaBTlJAUpg2rBxfzphvNa?=
 =?us-ascii?Q?90CUsKfMj3a6alBpxJc+bvKdE+ylgukg40u9FPlBToxtQmiMBXBC3epqqVxn?=
 =?us-ascii?Q?EYc3Sc3KXS27KmWwmwEf8N+uytNzqy4dnd3zt38rNLxrjni4U5uSHkgYkQXd?=
 =?us-ascii?Q?1vUHtbWN0S2bf1FNux385At4VQ5UWmThqnYalJlbV+RRIztkNc7NHmrYfcVO?=
 =?us-ascii?Q?IRshoBFXWR5PuddgnO6U1OiT9igHKiO/19lZEuBt5pECsJ8diO0X9rF2RGxM?=
 =?us-ascii?Q?njJ6IYayZh1nZluHMCl3XFhp6nAPVS/So6lKdXLB5W+nGhoZGGx3mVPERfpo?=
 =?us-ascii?Q?i1eCQju7uI0m6p8GTvkaZrRd3kSlSLwFVVKdyjD9zI/iQFbcD4AWLXTKXO2g?=
 =?us-ascii?Q?fC8PN5Pq0VE2c1p4t7anl0LOVEDuR2AmmhNNC7ZOpZPybV6ckLH2vTuugdSX?=
 =?us-ascii?Q?Ea4neWYBGqqY9y+uDWSboMfHKzNRgzc+Np6t0ZVCBZlcjVKsKDZCSSMY2Pzd?=
 =?us-ascii?Q?Xa0jIY8EK8oWgww/Nf9TbOLUlcwzRiypkzqoyXy3ZS4LnWJHdb7Nk2CFu4m7?=
 =?us-ascii?Q?ZGFgtFoD6kbeW7vh6kSlExeMrcBK+I/4hEc1XsPjzMFjbyHXDLRlVohsXhhM?=
 =?us-ascii?Q?dikwA/19FI9qbKEZGGwjTzfHgAc8rIuhW5kqkr7JG4o8pw0HdeKXCnRtezUV?=
 =?us-ascii?Q?SYP32gF7Rz/LITnDaFClYAi96QkLeeRwSFXhSVx1GBI+8B/Zszi+A+JOwy3m?=
 =?us-ascii?Q?oCrpqWzKSkWwQv6JO+fl7JkMmEaK6Jgwn7Q0Eqm3g7T05bt+tj4IiobLskKu?=
 =?us-ascii?Q?nKlH2mXZszttP/hOIoIEz4Ne9Oqh4N6NxpJxynZg4Yt6yrP4Cd40ctqAoLUL?=
 =?us-ascii?Q?rNxdKYvmF2PkDyO2bCrF/4x+OANZATaHuHu1exYT?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0277910F7DA99EDD3CA1D19999542PN0P287MB0277INDP_"
MIME-Version: 1.0
X-OriginatorOrg: techxpo.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8327bfcb-5233-4e30-b595-08dc35386fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 12:59:28.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a84bdd94-8413-4b78-a8ff-80787d12c851
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uEfQOgWDrz8RmIpgxhmpwMzFWGVFi9C0UzdA4yr6A5Q9vqtXNTvQPA5TbGh86zGXjCkp8wEotvFa8tF6eh9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2258
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

--_000_PN0P287MB0277910F7DA99EDD3CA1D19999542PN0P287MB0277INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

We are pleased to inform you that Sign And Digital UK 2024 list is availabl=
e for you to obatain at unlimited usage.

If I can be of any further assistance, please, let me know. So, that I will=
 get back to you with the price and other details ASAP.

Awaiting your response.

Many thanks,

Iris Marsh- Demand Generation

Unsubscribe<mailto:iris.marsh@techxpo.org?subject=3DUnsubscribe%2017D7D34E%=
2DF1C0%2D4450%2DB883%2D2D6B86E072C9&body=3DPlease%20don%27t%20change%20the%=
20email%20content%20and%20send%20this%20email%20to%20unsubscribe.%0D%0A%0D%=
0Alinux%2Derofs@lists.ozlabs.org>

--_000_PN0P287MB0277910F7DA99EDD3CA1D19999542PN0P287MB0277INDP_
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
	line-height:105%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><a na=
me=3D"_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-fa=
mily:&quot;Times New Roman&quot;,serif;color:#1F497D">Hi there,<o:p></o:p><=
/span></a></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"><o:p=
>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D">We a=
re pleased to inform you that
<b>Sign And Digital UK 2024</b> list is available for you to obatain at unl=
imited usage.<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"><o:p=
>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D">If I=
 can be of any further assistance, please, let me know.
 So, that I will get back to you with the price and other details ASAP.<o:p=
></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"><o:p=
>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Awai=
ting your response.<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"><o:p=
>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Many=
 thanks,<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-GB" style=3D"font-si=
ze:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"><o:p=
>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;line-height:normal"><span=
 style=3D"mso-bookmark:_Hlk158255319"><span style=3D"font-size:12.0pt;font-=
family:&quot;Times New Roman&quot;,serif;color:#1F497D">Iris Marsh-
</span></span><span style=3D"mso-bookmark:_Hlk158255319"><span lang=3D"EN-G=
B" style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;=
color:#1F497D">Demand Generation</span></span><span lang=3D"EN-GB" style=3D=
"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F49=
7D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"mailto:iris.marsh@techxpo.org?subject=3DU=
nsubscribe%2017D7D34E%2DF1C0%2D4450%2DB883%2D2D6B86E072C9&amp;body=3DPlease=
%20don%27t%20change%20the%20email%20content%20and%20send%20this%20email%20t=
o%20unsubscribe.%0D%0A%0D%0Alinux%2Derofs@lists.ozlabs.org">Unsubscribe</a>=
<o:p></o:p></p>
</div>
</body>
</html>

--_000_PN0P287MB0277910F7DA99EDD3CA1D19999542PN0P287MB0277INDP_--
