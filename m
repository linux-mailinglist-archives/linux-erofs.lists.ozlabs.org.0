Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450885B1EF
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 05:27:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tf5w31dw1z3bwj
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 15:26:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=techxpo.org (client-ip=2a01:111:f403:2020::701; helo=ind01-max-obe.outbound.protection.outlook.com; envelope-from=iris.marsh@techxpo.org; receiver=lists.ozlabs.org)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2020::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tf5vy1LbPz3br5
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 15:26:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY0JuHyGakyZXAQ/4kObij0LZty7YNFxg+D1WSqxQrQp3KlcFhKLOjzRdNOHc5o+LZVvgArsdI+KbtiqzAHGoSJniAi5XQKoqLLvSpNbVGmxGES0OU0DDIazCu2w6p2JkQiIoBMtzSV+q+nXCOKyN5ZDdUON69lgyLavU73B4z6sZAHu9nzNAtqd23+At4tl8uyrQbSvshSuR2l+TlVkmod8AO7fcWHp6QvCfuXzPd9Eo3r5IVLGmZJhcmqSEZCMuvueBLucakdqc+0BVO3eLSKaHCpyLi7t3U/e1e1CV+zgQW1z8OFM3K1/xiUlhLZw96x18CO5Mx3roNQU2GqGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7uTXtGkNd8AKUH+bOrhfTSX5UF/hUJOo6A+UtJ88lY=;
 b=cScxUerXOZEEWXckEJ0S8BLPcIlPEt69SU/gt+MZl3qao2ePrMj4aNowHk04FHTTs/99lxoYO2Ph/519hsOOUADMFs6kc+yMJ+BmK1cVNc/nWg6ZrHEY8UxrzSvBDREiYwr+Vlqm1788kMNzpdhmaSQWJWeMOZE14ATy6o8X8dm+h8F5KwuAg7x19X3G/V63LXby0/Oma9H3psmClF5AL/heUXF1vTfujTKnBzWHhRKgOAVqi4MkhnzSxTI0kA1AS5OYQC2ZX0qdbOrmrQGxq1o3KouXiORP3l0Wb2fb1ZPyy7XH/gpN8tJHqm+4RZr+u7awsgZNeONxAKIM0sXGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=techxpo.org; dmarc=pass action=none header.from=techxpo.org;
 dkim=pass header.d=techxpo.org; arc=none
Received: from PN0P287MB0277.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e4::14)
 by MA0P287MB3136.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 04:26:30 +0000
Received: from PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
 ([fe80::e4bd:b603:bb78:87a0]) by PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
 ([fe80::e4bd:b603:bb78:87a0%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 04:26:30 +0000
From: Iris Marsh <iris.marsh@techxpo.org>
To: Sign And Digital UK 2024 <linux-erofs@lists.ozlabs.org>
Subject: Lists - Sign And Digital UK 2024
Thread-Topic: Lists - Sign And Digital UK 2024
Thread-Index: AdpjtOvwd9wsk6W6SUeu4SYfm248wQ==
Date: Tue, 20 Feb 2024 04:26:30 +0000
Message-ID:  <PN0P287MB0277F88A7D45C69738DFAC0D99502@PN0P287MB0277.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=techxpo.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0277:EE_|MA0P287MB3136:EE_
x-ms-office365-filtering-correlation-id: 79a6626c-26d8-4969-c75b-08dc31cc1cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  VCvGzreBO7Ej+rskw824lsPwTRY4hlyMTPRBDLiRrVEgvkBey9FFBJN39Q2vUyE4AGZbNCVst1/Xo4o+DgcvjdoobzhVMIZXRIkuic0GMzo7/baeat2NdRMQXg3MdzQ1PDRwxki7qg9chL/HcrWEPuib+RtBdq4ZH8IpV6e5gmAxogX8K/p0P4DGGXpIg/7AUZnboF1Y+stvUw8xjg39FsNilQax4iSCzJgujKuDzUw+oM+987RTKICghtC4UQpHrMfnfnLJf2R+FNB0elkI51BaNW/ELVhbzQ6JyICuBkN87bwu83Vaf/L1TpoLmJXgjKi6uAmiDxtjowWTPi2sd6p4Y+tTvmN/wFk9YkTyHAHfXcsI74GsqbhrNlmTVrWbCw4OhRO9//NaydsIqxJImenkgJOvwJqCPWre0WjAn4smwW1KRPHUs1cCbDHvvCNXFRqCTCC39GZiGksjgwKqh2JQnbi8VkE87nGcaa1nSlN8Cztt5nwYCj0GsMFgXKmZW4gKbY1XkjAtHhcbijYh2PgVBBOiN1tG2+ChGWmXEip9ED5XOHw+74Gorxr7V8MAq32SdiyogSkIXh+fkK0T5WzgVjIJTT9XtXIUWI46PCCj4r5RqJyMsWWEVw0kZEWw
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0277.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?Zh8wbmnTViGVl75PR6/uCT+aLaXd9NyEe58sThkYRpbBPY9IsZIlA7U/mgpp?=
 =?us-ascii?Q?ocsKqko/1YJll6k5BrOm6fqntLK/FkrUVy4VV8wh067SMxupbgxVKIzaxyvB?=
 =?us-ascii?Q?kFPtgkT/yYVoPJbd2ABc262ikBIawFJ5AAQhqpTnQbp2zB2PRHVgBNdi+5vo?=
 =?us-ascii?Q?pAoAO4bDHt9+xgUEDgU/g45ADn5t68dPMW4WOsE4UMTr3FHTRd9K4gUKDr2b?=
 =?us-ascii?Q?zSyW/SP8B3rqrSByq7DATV42dzliu4VYgatKKKqQfLkLmHhu5SoFyXVRRYit?=
 =?us-ascii?Q?XwACXRnTJBDWT3Baydb7en1WBXUykfCaBVKmDmUgcbLGfMtjJ60J1kg9rVtw?=
 =?us-ascii?Q?ItKEZK3NpZ91pC17kWTDYX3VfdCCPKphMD4tzPLc20J7W009t6L8AXQsxGtK?=
 =?us-ascii?Q?mppf5eSfkCFQhVcAPM1YyjqoHHjzbWD4yxrtbh6JOsHSEw8Am4f8KgXESZ27?=
 =?us-ascii?Q?CiPUab/EbC1vFxkUVD57eY94zC6Rm0Kcb/ra4gbA0kQgY+u1gicxwHJcJFYo?=
 =?us-ascii?Q?UlTBQBX3oQ9H1+RLylpDDuHrk6lyk+Y7kOCTrAet0moUCsuIfan206ihMn4l?=
 =?us-ascii?Q?cJdSnvTo90SBhE8i7CBCK1PCqt4B72LOHvclqrDD2AwvcqjJ+Tdi6MjoV2qS?=
 =?us-ascii?Q?quGKunhcZkJUhVQZC13EFogHFHBUM30WfVBxY5yujk76B2Cbgr86yjcJEXGR?=
 =?us-ascii?Q?hnwxphEvBVkH0BiQcUNncP2WM+WHCVOuAU9x4ca/6xdZTvxHg2WdUS9kkv0a?=
 =?us-ascii?Q?nRD6fXfQQKomudWydXZv3hYrvA6UzC8hZjTRvx6NmbaIuFt0dEp8cXSRJJpU?=
 =?us-ascii?Q?cncJCP5Fw4kPBlboEiUuJ58ydRXRj2f8SwkksBjTtZ2Vn3WVdOHtfR/KKDxJ?=
 =?us-ascii?Q?UOcfo6Z2Lx4XSLxS7+vhtfM3upqV5v1p8TJ1O+J9ArbpXt3G6iMmPQ2oud7+?=
 =?us-ascii?Q?YjXPcnLAW1miUGzz/l2l7FpB+3XORD0w3OyGBZesWRVUBETie39oGIUyspIW?=
 =?us-ascii?Q?mIylDoiIQpsp5QfXZspufdgL9bf+JsN/pma10VCdv56WeejXKTk+toE8tAed?=
 =?us-ascii?Q?oBaGOpYQlv1VjhceEb1reIDWvXEMceg2RgcVycXkkep3gK4FSUO03VYjOK6x?=
 =?us-ascii?Q?QGC6FcnRALv7Yky5tMEMoruxFRG57BQ4XdIL9M+rs8WVd57zlsHmGBtqNOtt?=
 =?us-ascii?Q?rZm993SaqtZJnf+NmhEuVw9BcKe8FHBfN+KJ3snwubb6z72YuN4+iqkoy8lt?=
 =?us-ascii?Q?oovPud9Owr1HCwLnzBciXqJQkTzm4AMMQXa0K9gwXM2Qv2CiwIQy1dBqv4Gl?=
 =?us-ascii?Q?qTr3tkYo82IqK5OVnLQoJ6t7DS1TBBT8K6Oa49PgjW9tLR166ebjFaSuCR1f?=
 =?us-ascii?Q?nWKS6Ci3mZhP7KEMeQ7W/O8Xmj68qEihZsTNQdlDQoo6sx1h6Ahlt57gbxBv?=
 =?us-ascii?Q?kp9zdS8wHKxHvCA8Z6pDFehxi6XFackWWmIm6mnuTyKqXbHwczCWmYX6DSXL?=
 =?us-ascii?Q?Jnu8m2s5eGh1ep5KeVi6S2ykqyRXnjtpPa6z7LK74Q56W30ZHGxQUvptK/my?=
 =?us-ascii?Q?ax73WeZ6tCwN56mJ4+0QTmSgh7BMyz5iIXfDYYJVW7LuyonHmO2pykKEGAdg?=
 =?us-ascii?Q?kuNweOY1yTKukI7cVkIm66ovbLom+quXx+GNWjPzhRH0?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0277F88A7D45C69738DFAC0D99502PN0P287MB0277INDP_"
MIME-Version: 1.0
X-OriginatorOrg: techxpo.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0277.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a6626c-26d8-4969-c75b-08dc31cc1cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 04:26:30.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a84bdd94-8413-4b78-a8ff-80787d12c851
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TemsNPUc3/aasa0VOYf7B8y/s64DSuXp20uETRz9qaIbZd5ZSGSZjPAYkP+h3pF5O15pC5Gpdgfy/uxeng9TMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB3136
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

--_000_PN0P287MB0277F88A7D45C69738DFAC0D99502PN0P287MB0277INDP_
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


--_000_PN0P287MB0277F88A7D45C69738DFAC0D99502PN0P287MB0277INDP_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
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
</div>
</body>
</html>

--_000_PN0P287MB0277F88A7D45C69738DFAC0D99502PN0P287MB0277INDP_--
