Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7CD84EA02
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Feb 2024 22:01:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TW8YJ67XHz3bcJ
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Feb 2024 08:01:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=attendeetechexporegistration.com (client-ip=2a01:111:f403:2020::701; helo=ind01-max-obe.outbound.protection.outlook.com; envelope-from=helena.don@attendeetechexporegistration.com; receiver=lists.ozlabs.org)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2020::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TW8Y96SsKz2xQH
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Feb 2024 08:01:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjIe7zh27sMLSQgXdITodOBu6mtLSNV/F1V7F9wkyWhnPOMb8MalJ0l6ygG/K1x2Uo+vupXf7SXu5M5zXB3+5zeBQ4iC9Kpp9pv32UadSLq2tG/stO0j++I8VJkCd+bwfEkznIVVk8QdUNN0D/bK3OvvoPb13k8SCUXBFZkmXJJa7ccJzeTSW95BgbQe5ga2mCXjg5UG7n7hO0j4Pk1189bYcUH57JC34BLhkUzcGmZu3ohv7orNO2eV0KM3UzrLlbQub8dTEUjlX/esy59q6pBCvMacMF0EI4ROv8fpeb41SfI5vut6L6b1VzED3v6Sz4dKGbniV7LdMWeQVb0Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRJa45ei4ryetp5LKgD0kjJJfaSBfZIAaof32QlMtU0=;
 b=ZpEa2rhDqzDKTUgP4P4LuJc4EVjgA+KXxqNuNXfBQ8HK1m6dsg+oUV+4QwqDU/vojQvPtdSV7CI0SUh2t9JpwrrJReRSvXs9eL8uOQ5lhfJBJYYd8+agcXfD91pKq+nJElNr2z5gyQBB4i2/lGJww1KvJBj4phxya8m/+i6Opf5S+S9LcxUi7uezYmQOAFqZahtiE5Zj2Fy0cdI49geyRQRpGq8phJE/ep+A2r6atC4pKCbKYrsMfp02f/PzGfg85BPnHf4Rec8CDrdDQzroYafxAN29iv2/Nth2OloT/F8NJ+MqvjQXfGQODTm+S/WnIvbtV5KG213BNDqIDorT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=attendeetechexporegistration.com; dmarc=pass action=none
 header.from=attendeetechexporegistration.com; dkim=pass
 header.d=attendeetechexporegistration.com; arc=none
Received: from PN3P287MB1070.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:173::12)
 by MA0P287MB2199.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 21:01:08 +0000
Received: from PN3P287MB1070.INDP287.PROD.OUTLOOK.COM
 ([fe80::fda5:50a4:9b4e:83c7]) by PN3P287MB1070.INDP287.PROD.OUTLOOK.COM
 ([fe80::fda5:50a4:9b4e:83c7%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 21:01:08 +0000
From: Helena Don <helena.don@attendeetechexporegistration.com>
To: Sign And Digital UK 2024 <linux-erofs@lists.ozlabs.org>
Subject: Lists - Sign And Digital UK 2024
Thread-Topic: Lists - Sign And Digital UK 2024
Thread-Index: Adpa0e8Gcwlu/gDRSjK6PyHj+mLlxQ==
Date: Thu, 8 Feb 2024 21:01:08 +0000
Message-ID:  <PN3P287MB1070EBA2FFFAB198D7AAA481F2442@PN3P287MB1070.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=attendeetechexporegistration.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1070:EE_|MA0P287MB2199:EE_
x-ms-office365-filtering-correlation-id: 97c6f710-1f39-426c-099d-08dc28e912bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LIg2p6T3Pi+AldQvZ+05HWFKd53U2KUGByot1lYkZhIN1HXg8fdyii2zMB5tbHRdoMHg8mUZ02r0rEEufIhZLHMsa+Zs8SjnbgilYtP8lk68LfY6AQvq301XVWqsPTo2ML/shwl3wuN40sNy2IWZg72qT4Yf4ItbtnGCxaGwOexPx7A2Ppp/3Fjk7+sN9o86QVaXfiHrXgxVraKp199hgORpcpNVH2tipb+k+usFn468ZQYDrgbLXz+oiDMGJpF9lJEM+j7wHAOhHUDjekhsP6T/4PUprpFLLMGxWQkVdvoeM9DYXaOKrvle8f0EHqEhU5g6CtrmeC6SE1sg4vrH+pcI1GLumQGaqIyTvoPlwKpo/wpsqbh/nfGkil0vrAuuxjsuzxfOAF0SvGOfX8G0o6ewu7JcufGRm7HiNTqSSvXkS6yWyMGsYotbB3TYVC0lKfa5HxxanK/8/Uqq1xFUtK957C/RCrgg4+b2mu8qkoZRcgj0AzC4okqCSkhh0+9lxewVdCjqeqLRmXmSA2ZaOYkP0MEIIexjETLrCxfHoRkZ2/M6bnfC3NKe40I/W3NyLo8sqtNDXrKK0jyGcbWH0L10kUnSE7n43jsG/i0a1I5JFrpuu4HcR8ToaSFUoCoW
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1070.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(55016003)(558084003)(33656002)(86362001)(9686003)(38070700009)(478600001)(83380400001)(5660300002)(66946007)(8936002)(66476007)(6506007)(2906002)(316002)(52536014)(76116006)(8676002)(7696005)(38100700002)(66446008)(122000001)(66556008)(44832011)(71200400001)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?EFAi4+DiSJCA6ryr7JPYOs9clQH7CupPP97b/5wZRC76Wgi9SRNDq9s7or3c?=
 =?us-ascii?Q?VVG56RngPF0Tm3ZqCT/TRv9u8DMGmAEcax48VvAYnsMmKd1JIQJi5oJnLPa3?=
 =?us-ascii?Q?UIJvflmX9xkBl2yx+5LHQvUMksP6AVH5YWD6LJ779PXmg81gZF8got/oNYWv?=
 =?us-ascii?Q?g7em+iMYrq2bIkKToNTdSadA1wJs5UF1JFOMNGAvjbLbVawCuMf8zxbfdSxt?=
 =?us-ascii?Q?SFrc/6eBRb5YfN2AuioFCrwzyjqhjCHnygGy50IrBZXah87re9QnwlWzIMlt?=
 =?us-ascii?Q?9KBtJZ2o22QLMi6dKGNpJ48zYbl25Yq0EbTPIPzfHHD8Zb2lpksgRwBHS3Jt?=
 =?us-ascii?Q?uP3mofFTSxErzLZTn0rRUVJNCS+yTPn5pIXmqxjprr6eFAYhyGaJm9VJH9Jz?=
 =?us-ascii?Q?THJKNxh8obSQLtL+1oNnLd/N0A24OLutQk/sxlIuTtJjQh16gOxCHvCjV3FU?=
 =?us-ascii?Q?F2ll9udb5DgQBh7Q9PeUtnX2vgmafkfd+TqzsBBQAjV9deHlpFE9+a9KwA4u?=
 =?us-ascii?Q?aLTmnlTQBHm8lq+tssHg/SE9jR/c0KbiZgzeNLJEmN5LLwljQI9jWcwaRA9j?=
 =?us-ascii?Q?vmKlF+t8+tg/c2WNFz53YpnBEMaVpx2xweVVlzmwH30lZjFGNLXeykJAFXRd?=
 =?us-ascii?Q?SdOW+RqXYQvtkYyMnx0r7eyO8ODvBIgtNMQoclR5SndlMBdvQT0Wd9zeajtz?=
 =?us-ascii?Q?0hfkst3BSmooFAlI+Zpn8XGRz5qcGZ+J9kHx6hw3mHI/zmohCqqFgHppD7DH?=
 =?us-ascii?Q?qcH4g0tq3BYTZl/G7cEEH5H5Tu63uZAdyawEPeGUQSQtszpk0v0QNCiXGpHP?=
 =?us-ascii?Q?0dSMvrGNMMFUMX3YL0batdU8/EDAZEvlpXQVAZk67bxzTpWdAAoGDQVpOYYz?=
 =?us-ascii?Q?kFaGmucmDHxPSnwnC4u0NzlBRTDza6l5CjvJdM6/sRQQl7e3nfczkCXxzrsL?=
 =?us-ascii?Q?WeXacT+gG0MIwSNfpV1WFw6fjYnMGKN+fpoIJkQJ+yuw+/1te72OEsgB/3wz?=
 =?us-ascii?Q?4RhzafTGYDkVQuWanTVzp3uBjUWeoZg9TcKIS97LzKRfyZMEruif3vqj/BJR?=
 =?us-ascii?Q?C/bdpUfh2nmOdzbvVQ9KU9RVzXvfOSGUff8V7vf94AgwhiIsoy/6/IXOB3GT?=
 =?us-ascii?Q?eKSn5A43H125M9jqy0mXE/f6ECnTH3GzAb5plbfV+jbqkhespx4Zs1fpQwdb?=
 =?us-ascii?Q?s4Zhnpz8MInI+MBCEerzGyp8EsyC4VylvoSO1GVwqu77wqaXQBqxKIvdUlZP?=
 =?us-ascii?Q?E0wFwPH3NgC6qsXg8B7df1RqrCBiU/8PBObGl+uF6mSImkfa1whgwRehj3TL?=
 =?us-ascii?Q?5QBkWW2utZ1Kgs4UA9z7dhejQLEjz9354vrW+1x5IpV6PNi8SKFpWthgP9hg?=
 =?us-ascii?Q?8S8WFNwKAsFpvRy471pW0QRkvy3a/U/1/SV5TdGCPuQR/OmVV318DM11OO+k?=
 =?us-ascii?Q?HMIKcqr0UujacneuP67dPfd3tFNjJa2dmK4aHaLjLXCZBoNf8YoWrJTwSpEZ?=
 =?us-ascii?Q?rto3jUI1Pk2R8WV1VaClPRHsVUbhAhwyuY53ErmP4JyOQihcvFbqdpqt0WUt?=
 =?us-ascii?Q?xBhcw2fPYDe8cTKg0/pVoFjCmQ8Q6SkttbGiGE4N0aZQO1lXWzfg3SGK+kOr?=
 =?us-ascii?Q?P9YrAGzs9dG5aFJ5jFr8qo+rGNqTpaz4X9zN3VHT6HKfU07XOEBlu5GoPM4K?=
 =?us-ascii?Q?sljzu0e5Yfnz3SRQPQbByllxXQfeqh4QrFGHYPkT/oBFJo5Q?=
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB1070EBA2FFFAB198D7AAA481F2442PN3P287MB1070INDP_"
MIME-Version: 1.0
X-OriginatorOrg: attendeetechexporegistration.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1070.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c6f710-1f39-426c-099d-08dc28e912bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 21:01:08.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd07078c-50e9-47ca-8831-1e868d5e8384
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRczGVYL7voVdiSsaCWFHAAi1R0lO1dbQUxps3XkVmx6ZnadhhWV1DTYIDo8pnxg7nVDw/inGGFQb13JC1dtmxim7XiZtlm/4PrBgIShvdDj4/vnzUPQHGjpmAwZBHVzegN7KWDUeHrG4pKl3JcZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2199
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

--_000_PN3P287MB1070EBA2FFFAB198D7AAA481F2442PN3P287MB1070INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

This is to inform you that Sign And Digital UK 2024 Business list is availa=
ble for you to acquire at unlimited usage.

Please let me know if you would like to know the Counts, Value and other de=
tails.

Awaiting your response.

Warm Regards,
Helena Don- Demand Generation


--_000_PN3P287MB1070EBA2FFFAB198D7AAA481F2442PN3P287MB1070INDP_
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
<a name=3D"_Hlk156962497"><span lang=3D"EN-GB" style=3D"font-size:12.0pt;fo=
nt-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Hello,<o:p></o:p=
></span></a></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
><o:p>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
>This is to inform you that
<b>Sign And Digital UK 2024</b> Business list is available for you to acqui=
re at unlimited usage.<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
><o:p>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
>Please let me know if you would like to know the Counts, Value and other d=
etails.<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
><o:p>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
>Awaiting your response.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
><o:p>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-GB" style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F497D"=
>Warm Regards,<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span style=3D"mso-bookmark:_Hlk156962497"><span style=3D"font-size:12.0pt;=
font-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Helena Don-
</span></span><span style=3D"mso-bookmark:_Hlk156962497"><span lang=3D"EN-G=
B" style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;=
color:#1F497D">Demand Generation</span></span><span lang=3D"EN-GB" style=3D=
"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#1F49=
7D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PN3P287MB1070EBA2FFFAB198D7AAA481F2442PN3P287MB1070INDP_--
