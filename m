Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F583B692
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jan 2024 02:34:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TL3Jr1tqyz3bT8
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jan 2024 12:34:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=attendeetechexpodataanalysis.com (client-ip=2a01:111:f403:2020::600; helo=ind01-max-obe.outbound.protection.outlook.com; envelope-from=beth.dale@attendeetechexpodataanalysis.com; receiver=lists.ozlabs.org)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2020::600])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TL3Jj3bsJz309c
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jan 2024 12:34:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPJvyXvaoeA75X/fb7WsilhLGGTsT+Tvvp69qSs1cZoYkxhZEU/3oQ6e6XWVLESsbajy9fDExToV0OmJASt5IfYNagJj+mHi7sqhSY9rbe51FoLi1gUjWpsVMy5CQ1mMOVrCz+/Ea28uwTqZHZJrtfOsjtMG2bQ790WxesPfOBnJe7407fPPiOTSf9hny5J+uzBJy9HgR2t8u+Ck6YyJcCMULFPkB3Vrni0GcgVHqeZcCa21cCqDSgoP/TaBJelpnxS2hOm1Wu/yfg/+T3avgl6lwGgZhxSx3ftzOl9bZHslKT23mc5nBy8VE4aXcLvKSYC2onssS0pu9QYRzmtBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtDX+Kmm80wnyB5U37B2DL/ra3jVgIOhG22hTa+/0IY=;
 b=eM5kw78G/mlZVy1iIAktCsU8GrHegU86lElPZUzjCJPEF+9OyUKQ6KxNMY/Fi51tAEreWyVxJLyH/O1YWxvF4XcfdWsTyL2WVAq7XVJ3gqpfrLO/tsNd04gLlTKyKNQ0OC2rViodfQGcoUNXf3hvY47sZfWZU3X0YmAqlAdwhAqkuhMrNe5gYrNs3PxLA6JazN1MOqi/2JabmlkMCmlKZ+KVhPsVagHwkMzP7QlYx17LSNuOF7JdTwpowqeewvyCreYGnasW7BWpWcj/a64g7aGc9NJFGgetEazBJDkvRIacm8/181szVb1SCCEhj0ltYIWs4m0sLOSCzrv17hSpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=attendeetechexpodataanalysis.com; dmarc=pass action=none
 header.from=attendeetechexpodataanalysis.com; dkim=pass
 header.d=attendeetechexpodataanalysis.com; arc=none
Received: from PN2P287MB2062.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c2::10)
 by PN0P287MB2343.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 01:33:48 +0000
Received: from PN2P287MB2062.INDP287.PROD.OUTLOOK.COM
 ([fe80::c1f:f784:5845:4ee1]) by PN2P287MB2062.INDP287.PROD.OUTLOOK.COM
 ([fe80::c1f:f784:5845:4ee1%5]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 01:33:48 +0000
From: Beth Dale <beth.dale@attendeetechexpodataanalysis.com>
To: Sign And Digital UK 2024 <linux-erofs@lists.ozlabs.org>
Subject: Lists - Sign And Digital UK 2024
Thread-Topic: Lists - Sign And Digital UK 2024
Thread-Index: AdpPLoo2hlLnhIDfScWKaavw3ZzOnw==
Date: Thu, 25 Jan 2024 01:33:48 +0000
Message-ID:  <PN2P287MB206234CE90421DFF2D2B35FA987A2@PN2P287MB2062.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=attendeetechexpodataanalysis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB2062:EE_|PN0P287MB2343:EE_
x-ms-office365-filtering-correlation-id: 3f35a516-2bee-4ddc-0fdb-08dc1d45adb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pDCAOxxYjhpfkMgM2Mz1ZSuGwVGNA7EIqZbanaaO6hdxtFtyoY9g4TUqx3g7CjvjJ1DKcaahMLnAoUrI5lpsU/VGS10a0oGPRZcYDc175nPJ7GUg1IOxDjlTr8ZhmcwJ8lKdIQ2jrwBsfYASaHEdgJysPsRR0zp6v6pFGKMTUcNdbNKdfSLTN2N2xC0LJ2DwhFzfu29QojLbJKYQ0+jlPC3mvbH35H1FQQT8ThpcEkvHphXqxTCW7IyJIP7IHuIAYjzp0UpMuvr2bj0c/NVapmgfaZ7POOMxPxKQi7QpApr0+T84OybrW9dITvQ6su6L5mAH0fKJAYHpzrPCmT4SzDL9UiOrchfYYm99CnD9tfT2IITq4FysOWdkhhTZMxeoAVaEdPPz56f/hobktkUU7F8+UzF8LcZPqmJoEhs88Tf1/Ti5a5w3yh9cuE/pVsCWg5vtkbq3TCZ/dLZsS3KHPs84wGt18HTWUtIuxMCHqi4gxjr6lkpvlJIWJkTDPry3UGSIlxYTlrlToy9yfSOXTs4LtiTU379UM+I5ls4tWrp2DG732sS5D9zC+W0wKRmMg6WWIwO/bCBa2uMCrlznbtQweGrqYL8AXuzkmAeyOhvvKmFVu4/SyxKYMIzFALME
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB2062.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39850400004)(346002)(34096005)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(83380400001)(66476007)(66946007)(6506007)(2906002)(71200400001)(9326002)(8936002)(44832011)(8676002)(64756008)(41300700001)(52536014)(4744005)(5660300002)(66556008)(478600001)(7696005)(6916009)(122000001)(66446008)(76116006)(316002)(9686003)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?pwHzE71Hp70Es/1Im3VVxRr4psifO9OLhBphp6S3cWca4CyQQkO5oXdtKSoe?=
 =?us-ascii?Q?bA01TwXD60KXv8QwHOHUmx0xo8HO8OfEC9ayc7MlUUCIO9NQUKVRalRwd1zU?=
 =?us-ascii?Q?H95UC2cBul+B1egraFlmLfhK8NKPFedxBJyGxWdEW9+AA4PsvugBxS9bRza4?=
 =?us-ascii?Q?NxSYmjK4arDZYv3qwJjoo0qrObXWz4mkfkP9+63j7JNHeyyRPGDSadjEMJ1F?=
 =?us-ascii?Q?o5DJztaTkGfjQvggSeVJNWYDjyLH9i1VQw52A15qHNi16QZDIYDk4inuAhOx?=
 =?us-ascii?Q?bPOrq69P1n7n3NYDgEJUFDyyYaNsZ9H9uP1ENf/OiryYRCIycc/ho/ytYg/N?=
 =?us-ascii?Q?rpkY5o06Qn2wDayuqajf8ow9+toNVaWFlky2eCl5UZ2RamZjh612OBBTaftR?=
 =?us-ascii?Q?7kdYEF3Uioi8wfgFkaeaA+q4ALHPTJ8w1vBXjdiMLEJ+rs+1NFDJXn2LBkly?=
 =?us-ascii?Q?TE+zMtBIoFLe7JN7UhiGrRSzmpCDT/lKdMp5z9yq4Jz/jv6j/QJdVhTmpeeb?=
 =?us-ascii?Q?EWWzK6BkotLW3/2VvC0P14bbhG9aGEuZ/1I3rzsQ3fj1TzeVAX1jeo/Rwxlw?=
 =?us-ascii?Q?DY94E288DaceEKtDG/kcmYevbrdrU0Iv6TcnN1mlwRdp7H3TsrkMjrgltStJ?=
 =?us-ascii?Q?kbdZk/cNaTalF/jA98cFXZ9b4Brgo/6tmzBcwYIscuWcXnlBEeTcMt0CxmGE?=
 =?us-ascii?Q?G65hJJt5AQKQdveAbIK3iO4stnUlBqOnDbJs5UuwOdzoeTXjSsfhEe8uDzmE?=
 =?us-ascii?Q?tLIHegpSgfSyXH/ppywpRBOR5gNnOyYhMID6B7sEVkiFVPTiFlAc1QwV1S5R?=
 =?us-ascii?Q?zPbJ7niufXQbOpsEvL9HT5hdZDEcsxf0kimo3hdrSaJRxpbMkV/vJCXYd4GW?=
 =?us-ascii?Q?olCW4JBcXL+BZ4o6pVWVT4cYZaAMAtP3xeRQcAN6alQEbZFqmWKwNRk1TQeC?=
 =?us-ascii?Q?NDsSjJY4cQz04dpiKpBS5jkqn0KELQB8ZmphVl2gd9UpXyNDFUO6FHYp+25U?=
 =?us-ascii?Q?k9lsRiZHtb3d53nGa96m4MWuoitps8aEazerYRXwRWERkImQV7Ua7sbX6pnA?=
 =?us-ascii?Q?fdlZ+vLi1E9uTEeGUNhFM5y9blXxMmmtfgDvoMph8Rmb8ouTzmK4vDyW1Q/p?=
 =?us-ascii?Q?UPqz1nRomnZVPC8tbe5DR/Hp5CDj64Z1xuI7bLngXZtMFgqHRdi/JhB2pdn2?=
 =?us-ascii?Q?TsZPkdYdIpDEO3D2ZV72FZI9TfRLmKdrdvx6SzyVlnZH8tZmMhzwXM8cozIH?=
 =?us-ascii?Q?8zJIuh9JAX2VCiWQkD5VyppaVbGpXIAs5DMW/0lCiC7wLbbd0H484s0TE1FR?=
 =?us-ascii?Q?+EQg3/rQuoQeAJwWCCzhy6NY7b+erQMNQbeIqGpSnzQHUtLfhYKnHTUn/FWY?=
 =?us-ascii?Q?rNGkBdBEkngHGqR6mx+pmhjwZrNcMgYkyklJ4QtjrjvkTUslxRn1eQHrEOu0?=
 =?us-ascii?Q?ABAADzKH7W0G0CihvwZyErfODtLGkyQwalbOpEtcPzdZQkLEAGo4yMv3vAL3?=
 =?us-ascii?Q?u9GcYogmnH0GhFaWjKE5RqxsptQ0ePRESGWbSCUY1DPPsx7CTdE/n9xEGYIQ?=
 =?us-ascii?Q?x8C2Z14xhEmmX+sqLZzVw6SdyjU3PqyDujeYgp8LkMkiDZziFio+p8y17Rnt?=
 =?us-ascii?Q?P9Zw0MjoIP/lDkzsLTooyWvJ7HP9DNER9/Q5lZVj3BQfMKjxJVHyLD3UMWGV?=
 =?us-ascii?Q?JWsWjoZpyzOsaG/ruHsOOhN3ahuqEpiX/tO9rco42k9pWbXc?=
Content-Type: multipart/alternative;
	boundary="_000_PN2P287MB206234CE90421DFF2D2B35FA987A2PN2P287MB2062INDP_"
MIME-Version: 1.0
X-OriginatorOrg: attendeetechexpodataanalysis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB2062.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f35a516-2bee-4ddc-0fdb-08dc1d45adb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 01:33:48.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c799728-f86e-418b-a72a-e5d96b7f6288
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrkhxutFDnokl5E0YCmv939pvkTxxd9ZrK6+zoK23f4VpUbjZVpnSL4GWFdCZJf4j8I7G30ImWFhcbUPsRvMm3YNARSamN1LCFKDHQsj5S3wFbM/5zDZ3ecM6pYOWKBPyTrE9pQm4ta27TmgVV1QCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2343
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

--_000_PN2P287MB206234CE90421DFF2D2B35FA987A2PN2P287MB2062INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to reach you out to inform you that Sign And Digital UK 2024 =
list is available for you to acquire purchase with total 5,786 Contacts at =
unlimited usage.

If I can be of any further assistance, please, let me know. So, that I will=
 get back to you with the price and other details ASAP.

Looking forward to hearing from you.

Kind Regards,
Beth Dale - Demand Generation

--_000_PN2P287MB206234CE90421DFF2D2B35FA987A2PN2P287MB2062INDP_
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
Roman&quot;,serif;color:#1F497D">I just wanted to reach you out to inform y=
ou that
<b>Sign And Digital UK 2024</b> list is available for you to acquire purcha=
se with total
<b>5,786</b> Contacts at unlimited usage.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">If I can be of any further assistance, ple=
ase, let me know. So, that I will get back to you with the price and other =
details ASAP.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Looking forward to hearing from you.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0cm;margin-bottom:.0001pt;lin=
e-height:normal">
<span lang=3D"EN-GB" style=3D"font-size:12.0pt;font-family:&quot;Times New =
Roman&quot;,serif;color:#1F497D">Kind Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;line-height:106%;fon=
t-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Beth Dale -
</span><span lang=3D"EN-GB" style=3D"font-size:12.0pt;line-height:106%;font=
-family:&quot;Times New Roman&quot;,serif;color:#1F497D">Demand Generation<=
/span><o:p></o:p></p>
</div>
</body>
</html>

--_000_PN2P287MB206234CE90421DFF2D2B35FA987A2PN2P287MB2062INDP_--
