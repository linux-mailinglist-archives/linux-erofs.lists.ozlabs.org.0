Return-Path: <linux-erofs+bounces-1388-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1671C6370F
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 11:11:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d93SD3vxbz2yw7;
	Mon, 17 Nov 2025 21:11:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d200::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763374300;
	cv=pass; b=NUF+UMAMxOsGvm5/N4tuPftXJLof5nX1ZOUNipyDll2OIUsswgS/floZ4IkwAZXO8udAkzG4HURH+dj4vvx/LCqxSxgz89XJFsikpFjglhsSzB9lH4H59LVGD2l9ZXQQT1O1BAYwCtgDCqnzzmutRs6Q3qKnGxtMfA/ug+Lav1zpKDM7Vf/UyC+WomG9oTbTcCtZ/TJFg7AfpZIRP5WOMJKRggHUjoKigwt7iLegUk09x2E3/fuRsv9jN4hLPMzzCdLgbziyI6QOlaeCXaLAQkUSsHBvukfVvm2phdaMLFZpGv/X+ldNIOgoP+73GN+yAUWmSA38ix6HpLHhiS4Gvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763374300; c=relaxed/relaxed;
	bh=64RYkOs6d2tMwAqBS8XYEJW2qeHY5v8BtzYmdoBTxdY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ly01qke9RgtQ2NgUySNVQmpsNYSl0QhRKL3bJzQUmZKSM09ULZxdx6GSUUV7hRUVAb9kVnH13MAZLj5zqxKubmwScx6sLtGL9bCkt67h5jfn2g8RyeUjvlAemLhfm9APKpISsz+2vMIXPzTXx+umt0NLYg0NeJdOSaWhXg+yOBs30LHH7pTRDaBOxdfaCBOCSZtzZIQq7wz8sS9QEmo6Jk6UxcHVWnIU0wTuZb+jxDoygWP+ogq8JHxAC9HwGtyr9k55w7swdQCJFUwZO0qYRSavB5kZNk6KD6MwdTU3uljSRSmxKKw2mXFHHhv0qNlzgvRAx0KFI0oXrs/GkPWzRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uXVx4gy3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d200::; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=freya.doria76@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uXVx4gy3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d200::; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=freya.doria76@outlook.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d200::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d93S94zRGz2yvM
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 21:11:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdvPTvbCYBnqBkw/21wW+CdPjX1CBjVsJRHyYl4YlU+VbsIF+CDw/EWVIlAAwuPyKwW6SEXCUDTfNvIf8wCvDyRc4x992H/C4LG/RK0+MIikhxIuKmo5XqSgwIY7D8odGOmPLYib9VIkYJOuX0a8kT/eN3ptJRT8rWqB/xfpY+tsmV/j1YTzhlo19iQdcD7fS3Q3SSnHE2YMfBE3JyGbliFH/lztRI71+zsbiXkVpnUAZDcawru+OxKx6RaOFS2Ghqget5C0Raypk9WJOH2ohChKTfN6mEj9GamfRlXGm51/6wmxX9m98ksxysaHhvsG/Ubz9so1hIm0u5Wv/NQFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64RYkOs6d2tMwAqBS8XYEJW2qeHY5v8BtzYmdoBTxdY=;
 b=Vg8JfwneKxFl3ua1j9jda4CYPcSYWQ3w8PXZqTa9RlqH2JUov0Ei35SSo2PfyKpBGrZ7xHE6A1gkwtjRZ2K5+UuYldK3cyPxoyOMCAvZ62gLHLFx4ViztDoJe3MAuFNAvxzRk1OD5YS9BbJN52KkOxAQ4oWqerjA2K8u216LKBvtUXjxhuUERjB/nPjJC42gLXPurOZJsMIx/zp3Ymf5sRfpVYaNU0pM7zN7i+JovMuNiJU3zV4bqVhAfmvdrqTlDgQk9pWxRWtbFij1aWrCB+3SzRArDxoW+20CUjZEBEz+PoVK0kGSnDIx6ZlUGgpJGW8GLVxg3QHQFQ1qNLh36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64RYkOs6d2tMwAqBS8XYEJW2qeHY5v8BtzYmdoBTxdY=;
 b=uXVx4gy3ou1pO98LdeSMFm/uRS7bT2uJUdQvsD5KK4SuQnim5Qxv09+WHR0yVPhbpTdIxgIUE34B7Nw8nlB+oyHjxMXNokVGcPgn/y7hlll9nJ5hV4oABhtwEmqTNzytBboBZB1G1fXtln0MJ2KVf1IBGRol51oZbEOY32J7MuT2XCtOhx7qX/QkAE0Hwa+o2jjgbRN/R2RNhi81nCIvpH2nBpnOT/GBBb9I63MvHYS9q8VFiI0wksTbOoJchaobcXTOwrfqB3zvPb/zO52YfDCWBLFtfkhpS9EL/ECNpiNHMzvEFySNuXOgJ1qhr5ssju1pd2NImjbXgnea/5tdVg==
Received: from DU0P195MB1626.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a6::7) by
 AS2P195MB2323.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:590::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Mon, 17 Nov 2025 10:11:13 +0000
Received: from DU0P195MB1626.EURP195.PROD.OUTLOOK.COM
 ([fe80::a90d:995d:dcbb:14f9]) by DU0P195MB1626.EURP195.PROD.OUTLOOK.COM
 ([fe80::a90d:995d:dcbb:14f9%7]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 10:11:13 +0000
From: Freya Doria <freya.doria76@outlook.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Reminder: Your Response Needed 
Thread-Topic: Reminder: Your Response Needed 
Thread-Index: AdxXqa6bZtrT9kS0SI+TLznOfI4gdw==
Disposition-Notification-To: Freya Doria <freya.doria76@outlook.com>
Date: Mon, 17 Nov 2025 10:11:13 +0000
Message-ID:
 <DU0P195MB1626BF6C17FC7DD8519EC886EBC9A@DU0P195MB1626.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P195MB1626:EE_|AS2P195MB2323:EE_
x-ms-office365-filtering-correlation-id: c647b845-a54c-4b9d-eef6-08de25c1a345
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|10092599007|8062599012|13091999003|19110799012|8060799015|15080799012|39105399006|3412199025|440099028|40105399003|19111999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yNnke9iqwxlOda1xSVBF67dNbK1DSWVPKJUZFH2ed6zQW/aSjN/AhxpB19LE?=
 =?us-ascii?Q?FN0+48jewjGWLt1v4tu4ts7SzKFUUo5IHzIb6X7Ua/QttSEy986ltXruRe0w?=
 =?us-ascii?Q?RpEBS5CyOlphA4II6EphWqq3snSdo61ExEgjumOXqOf3FGQG/fQZBK40GV/x?=
 =?us-ascii?Q?lftcUVwucbpU2qrfO0QA5RkWfGVieomgoAQNvXlD9z5TlOTp+wplk+kqEaL/?=
 =?us-ascii?Q?IXypB2e4ZLhrns3zyNO/hYy5r2euiEKDPaGc6sIwmVL2M18si0B3fg0FvQ9E?=
 =?us-ascii?Q?keAlvrQ0ZdcXP9WLQE5VLiav6W/tvxeW92G46QRlBIArX9wFjia9npMyrANq?=
 =?us-ascii?Q?iQ7s0p8MnKrvl4T6TU7/CjVEo4aPdiBb+Hrnu4i0Khn8tVKwRs9B9Gi+tr/J?=
 =?us-ascii?Q?3hiClVmZGbtBlc8WuC8NZspBYEsSKGywFYZ5XyOd9IgTYvRl7dcBLapf9oJA?=
 =?us-ascii?Q?aUbOWYfJ15kRF7QG3nIu/iRbeHfw7rUcuVISUbxIGp4l40851Zo01rUAwYhY?=
 =?us-ascii?Q?tXSvu11tZp+38R2XPjTjaLQehw1WSujqRUmA0+ddW2z45NhWj8/yiPSv7GEn?=
 =?us-ascii?Q?ayvpYvA07axtQmuFNTO0YP3DgWibFRFQUr1bETWvZ5NsByDlmVWv98n/shfX?=
 =?us-ascii?Q?gf2HDFx5wIzp8Z7DSdsewdWdpKTpItyD+1gl2Nimkt74H150T29+l5sNjVLd?=
 =?us-ascii?Q?k4lk1/WAzgUcDsLc3LZSqqCkEprrnUT6GllC6LWehMdZNnG1aqkcEtG+Ra4e?=
 =?us-ascii?Q?/Fi7j5NNuEtVnlCwcnHTaRoKxk5lz6w9GSbswIG3WS9N0DHWPj5+I8KNWloy?=
 =?us-ascii?Q?ORMTvYFbofSbmHkLPXrrjnedFyOoruCGt1N1X58YD7gmQX5mtVvZKv3Adrsn?=
 =?us-ascii?Q?4Zzwc+vuWujJWPCjItN7ztyM+HbCBFd5Wd/Q3xWjAZTz9QAZGv4pRM5xN68R?=
 =?us-ascii?Q?SqSqlZxTD/mWDoxwdpjDG+9ABzmwZFnMH8t6WOVSW2V+ldE4H1ZYp28c3D7G?=
 =?us-ascii?Q?DBRtvCgXPewAOXtQdkAdfs7yo2UQPPDnPRVvXBFLW8gJPHaK/bf8OvlbMnwr?=
 =?us-ascii?Q?qd01dfFmRNXeLRX9BP8GhDOa2dY5TCiF0kcpzGE5B5khQYvg4oHpGGoXz5Vu?=
 =?us-ascii?Q?vPbnp/QeuWzhsndVrIgmpdIhgrCYPDZwiL7VAazq7EXem1mzaxsFCvIB9s/w?=
 =?us-ascii?Q?F+QLLsxFKTBxQISswUcS9KEZCZTxe7uRxfnpukWsD+qZ6DWCu0woo87eZT5A?=
 =?us-ascii?Q?xzhJm8IiZTaPUh2IECpeiz2HAuuvrwWHta2F/7Bk2w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tyzRrncZ3flC1lT8MEOtVGh1z76tsnIcutB5cPS5KIkInbDtPzBUFC0fdprC?=
 =?us-ascii?Q?Ee7wmi9oXlfIX16JxqALoHfyBS0zslF2KeKKZ8EtW5PerWeAxgfqxQScVrhh?=
 =?us-ascii?Q?AJlsD14tI6CCH2BqfqmBnltue1B67pZti5ToJ/JSNPdK9FYZ0HJ2EdmUZybI?=
 =?us-ascii?Q?C3d3aH0GUynMAYiUvx3VQUczxhGcZIJUrBcikr4tZT/u0On3uMtg/gv/wnmY?=
 =?us-ascii?Q?qD1yThTYvf5buOkgbokau7B8T0C69lSMYGfGACz2VFVQtYq0b54ZDQyXR+0T?=
 =?us-ascii?Q?bzg7Z63UJ2ZsExxmb/VyjOdxXULc/NRDvmt08ra3Dl9M1cw+v5IHF9eD/vOx?=
 =?us-ascii?Q?3tbnGmXXUx/DlCCk+ErkuyMwx83Dkzm97YF+7rbY+0ef5OG7s+xX0tqI6p2p?=
 =?us-ascii?Q?3JhbxVhmdlFG2HyURRccOVW2d1488o0WYtsgEvA1FVdtLSDB0NGbA6b+Hn33?=
 =?us-ascii?Q?3+08K179RPOzaQbtsYzWRzmzIuHUCUvoWYDq56eAY15nsnAf083OOvk/s438?=
 =?us-ascii?Q?ndnI0NOmyiBbf3xrX7dhF3Ip8YTocqEM7CrrkzMLjyr+EQZole6zq2gsCSCJ?=
 =?us-ascii?Q?LJ+yqaMqJzZ/rsCnyBbFMXtbfXHNovs+GI/V+j2ObZ4CCYrJxJ7dxgJ8CGWD?=
 =?us-ascii?Q?RekQNQnwrPwCztYhdO1bPjd2meHm7zSNP+E/TZDCVovmHhQl+wV6Kou2Aalx?=
 =?us-ascii?Q?nAMbRhl1WG+ZSgkmUT3IIdcvj0hLyTVLGrACYCV0xWDBsGTwLRmmzeTt+0Gg?=
 =?us-ascii?Q?2AyjnYXS6A0scUtnJHSJLkQJCRfIi2XyMB4+eQXKkdRlSB5JVWhlgBjB9QNd?=
 =?us-ascii?Q?9rXgvYZ9QfMQbUq5P5b1wimDazveDXX9udpcEjVpKeZ7fsbnnnCnOAlAg0td?=
 =?us-ascii?Q?5Ch5FnsSVJ4M3XFNhEPhLX5SY66c0H8r5FxZi5LPtCKCaXZMlAmS9XuDUekA?=
 =?us-ascii?Q?qSuDC6GyuwQ1UIPmWq+VknPFZmpZizIyduPGB9kR0lINOfkVdBYGqQoalUJL?=
 =?us-ascii?Q?wBdpQXn5nXIg9w3reByE8WCpM19IrgMly5SqGBdVGMJuVJxXvadq/8gcDIqe?=
 =?us-ascii?Q?DLS7WVRscaQyZx/L0M0ZMfAFcyIUtN5F73a/KKPkPSoYXe6JFM4PL4W2yGzL?=
 =?us-ascii?Q?sG8Ax+ZSjJqW75v810nBdqG6CnCNN5+K9pEOLxV92A3ysfNqT2mtCC6NASU2?=
 =?us-ascii?Q?KSNQ7mrxcBbTRGaVYQp7tQ4HBIbFNFXKucLuHA2ZhTC1CrTH7cso4MGHQNo?=
 =?us-ascii?Q?=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DU0P195MB1626BF6C17FC7DD8519EC886EBC9ADU0P195MB1626EURP_"
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P195MB1626.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c647b845-a54c-4b9d-eef6-08de25c1a345
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 10:11:13.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2323
X-Spam-Status: No, score=0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GB_FREEMAIL_DISPTO,
	HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--_000_DU0P195MB1626BF6C17FC7DD8519EC886EBC9ADU0P195MB1626EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings Linuxerofs,

I hope you're doing well. A friend of mine is giving away her late husband'=
s Yamaha piano to an instrument lover. It's a special piece with a lot of m=
eaning, and she'd be so happy if it went to someone who truly appreciates m=
usic.

Please let me know if you're interested or know someone who might be.

Thank you for considering this, any help or advice is appreciated.

Regards,
Freya

--_000_DU0P195MB1626BF6C17FC7DD8519EC886EBC9ADU0P195MB1626EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"MS Exchange Server version 16.0.19328.2=
0190">
<title></title>
</head>
<body>
<!-- Converted from text/rtf format -->
<p><font face=3D"Aptos">Greetings Linuxerofs,</font> </p>
<p><font face=3D"Aptos">I hope you're doing well. A friend of mine is givin=
g away her late husband&#8217;s Yamaha piano to an instrument lover. It&#82=
17;s a special piece with a lot of meaning, and she&#8217;d be so happy if =
it went to someone who truly appreciates music.</font></p>
<p><font face=3D"Aptos">Please let me know if you&#8217;re interested or kn=
ow someone who might be.</font>
</p>
<p><font face=3D"Aptos">Thank you for considering this, any help or advice =
is appreciated.</font>
</p>
<p><font face=3D"Aptos">Regards,</font> <br>
<font face=3D"Aptos">Freya</font> </p>
</body>
</html>

--_000_DU0P195MB1626BF6C17FC7DD8519EC886EBC9ADU0P195MB1626EURP_--

