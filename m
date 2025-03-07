Return-Path: <linux-erofs+bounces-15-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C54A55F8A
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Mar 2025 05:36:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8D4X4MSbz30VR;
	Fri,  7 Mar 2025 15:35:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.68.5.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741322156;
	cv=none; b=oqBA7Nhdt9uyrrOGFPjckIpr9asbPMQtVvDgh0MF//4QeNOAMPB7WHxDa0EF7wxwMTrLOSQd5SIBsIBpIgXx9m8+syVshqBDtoFFgAGuxP/HlFZnbqZbhzh2SDWXnX41F96rdPjWoPyOW8N8Ism3+M1qHf/p8+xDASrDfT1E6JUO4rJOfbuo8OgrLuam4CbMfxlcSwIiCGC43n1GCXcvsvTsLfEhzbFtZDabpPDg2DMa7PU1wnjw0rlPlcbCRXlFtiep6H+XHAwhAdzFKTDRdpj4dx0fKrmkrEwf3kYMfNANxKNI+59oooiy7nrCBx82Ou+r73AQdpJORK3b5vDSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741322156; c=relaxed/relaxed;
	bh=nvi6cP44DaBhaSjE9uVjOhxGmU3fLpxfa5BHeBh3/64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=diElPr4PJBxqU5xRdM/gtzAc7ZRRv5c8/3U9L10Yus/8/22HUSKCbepTdAxjAfNtYKexdxYltogOwQUEGvHPPLNFnbV2obkSrt0sVnucF9OrGoO9ypAuOWOh68U7zO347l1WcTZFytJQt2/6NxIYgXuNLdz3UCAve1eVZBB+QOTD3ONMrKk1QBRcTLroVH4/4AcJBmRjVTPkOsyEREx4w3ScCGv4cAECMWqG7ro1OxzNfCq5UntBDpqbYHQUhj4q7IkizgLuOoTaYqQSqc4Dy3HxVrzLku9yhmGLPoK7TM+2Fw6TlJYYErcds9n2A+mcCtgF3VG3VtTwmbXSh7MKhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wesman.com; spf=permerror (client-ip=209.68.5.130; helo=rajja.pair.com; envelope-from=antanu.das@wesman.com; receiver=lists.ozlabs.org) smtp.mailfrom=wesman.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wesman.com
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Invalid domain found (use FQDN): legacy-mail2.pair.net~all) smtp.mailfrom=wesman.com (client-ip=209.68.5.130; helo=rajja.pair.com; envelope-from=antanu.das@wesman.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 543 seconds by postgrey-1.37 at boromir; Fri, 07 Mar 2025 15:35:54 AEDT
Received: from rajja.pair.com (rajja.pair.com [209.68.5.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8D4V6L7lz3089
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 15:35:54 +1100 (AEDT)
Received: from rajja.pair.com (localhost [127.0.0.1])
	by rajja.pair.com (Postfix) with ESMTP id 93909A72DA
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 23:26:39 -0500 (EST)
Received: from 192-3-176-136-host.colocrossing.com (unknown [192.3.176.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by rajja.pair.com (Postfix) with ESMTPSA id 7C177A7276
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 23:26:39 -0500 (EST)
From: lists.ozlabs.org <antanu.das@wesman.com>
To: linux-erofs@lists.ozlabs.org
Subject: linux-erofs@lists.ozlabs.org update notice
Date: 7 Mar 2025 04:26:38 -0800
Message-ID: <20250307042638.30E0F0D6D41C983A@wesman.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: mailmunge 3.11 on 209.68.5.130
X-Spam-Status: No, score=4.1 required=5.0 tests=DATE_IN_FUTURE_06_12,
	GOOG_REDIR_HTML_ONLY,HTML_FONT_LOW_CONTRAST,HTML_FONT_SIZE_LARGE,
	HTML_MESSAGE,MIME_HTML_ONLY,PDS_FRNOM_TODOM_DBL_URL,SPF_HELO_NONE,
	T_PDS_FROM_NAME_TO_DOMAIN,T_SPF_PERMERROR,URI_PHISH autolearn=disabled
	version=4.0.0
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;">
<table width=3D"100%" id=3D"m_-4962726213219328166m_-5753286071546678704m_3=
312316680735832057m_-4834360944162416423gmail-table13" style=3D"color: rgb(=
34, 34, 34); text-transform: none; letter-spacing: normal; font-family: ari=
al, verdana, sans-serif; font-size: small; font-style: normal; font-weight:=
 400; word-spacing: 0px; white-space: normal; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;" cellspacing=3D"0"><tbody id=3D"m_-496272621321932=
8166m_-5753286071546678704m_3312316680735832057m_-4834360944162416423gmail-=
yui_3_16_0_ym19_1_1463322283375_9641"><tr id=3D"m_-4962726213219328166m_-57=
53286071546678704m_3312316680735832057m_-4834360944162416423gmail-yui_3_16_=
0_ym19_1_1463322283375_9640">
<td height=3D"110" id=3D"m_-4962726213219328166m_-5753286071546678704m_3312=
316680735832057m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_=
9639" style=3D"margin: 0px; line-height: 1.666;" bgcolor=3D"#045fb4"><br><t=
able width=3D"80%" align=3D"center" id=3D"m_-4962726213219328166m_-57532860=
71546678704m_3312316680735832057m_-4834360944162416423gmail-table14"><tbody=
 id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-=
4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9711">
<tr id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057=
m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9710"><td id=3D=
"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-483436=
0944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9709" style=3D"margin: 0=
px; line-height: 1.666;"><font color=3D"#ffffff" size=3D"6">lists.ozlabs.or=
g messages</font></td></tr></tbody></table></td></tr>
<tr id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057=
m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9705"><td id=3D=
"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-483436=
0944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9704" style=3D"margin: 0=
px; line-height: 1.666;" bgcolor=3D"#f8f8f8"><br clear=3D"none"><br clear=
=3D"none">
&nbsp;<table width=3D"91%" align=3D"center" id=3D"m_-4962726213219328166m_-=
5753286071546678704m_3312316680735832057m_-4834360944162416423gmail-table15=
"><tbody id=3D"m_-4962726213219328166m_-5753286071546678704m_33123166807358=
32057m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9702"><tr =
id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-4=
834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9701">
<td id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057=
m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9700" style=3D"=
margin: 0px; line-height: 1.666;"><b><font face=3D"calibri" size=3D"4">Dear=
 linux-erofs,</font></b><p id=3D"m_-4962726213219328166m_-57532860715466787=
04m_3312316680735832057m_-4834360944162416423gmail-yui_3_16_0_ym19_1_146332=
2283375_9699"><b>We recently updated your email account with new features i=
ncluding fast mail delivery with our new login interface</b>
<b>.&nbsp;This requires you to login and complete your update to enjoy our =
services.</b></p><p><br></p></td></tr></tbody></table></td></tr><tr><td hei=
ght=3D"15" style=3D"margin: 0px; line-height: 1.666;" bgcolor=3D"#f8f8f8"><=
br clear=3D"none">&nbsp;</td></tr><tr id=3D"m_-4962726213219328166m_-575328=
6071546678704m_3312316680735832057m_-4834360944162416423gmail-yui_3_16_0_ym=
19_1_1463322283375_9697">
<td id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057=
m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9696" style=3D"=
margin: 0px; line-height: 1.666;" bgcolor=3D"#f8f8f8"><table width=3D"80%" =
height=3D"60" align=3D"center" id=3D"m_-4962726213219328166m_-5753286071546=
678704m_3312316680735832057m_-4834360944162416423gmail-table16" bgcolor=3D"=
#045fb4">
<tbody id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832=
057m_-4834360944162416423gmail-yiv4829141425yui_3_16_0_ym19_1_1463322283375=
_9694"><tr id=3D"m_-4962726213219328166m_-5753286071546678704m_331231668073=
5832057m_-4834360944162416423gmail-yiv4829141425yui_3_16_0_ym19_1_146332228=
3375_9693"><td id=3D"m_-4962726213219328166m_-5753286071546678704m_33123166=
80735832057m_-4834360944162416423gmail-yiv4829141425yui_3_16_0_ym19_1_14633=
22283375_9692" style=3D"margin: 0px; line-height: 1.666;">
<div align=3D"center" id=3D"m_-4962726213219328166m_-5753286071546678704m_3=
312316680735832057m_-4834360944162416423gmail-yiv4829141425yui_3_16_0_ym19_=
1_1463322283375_9691"><font color=3D"#ffffff" size=3D"5">&nbsp;<a style=3D"=
color: rgb(17, 85, 204);" href=3D"https://dub.sh/ArcEKfM?mail=3Dlinux-erofs=
@lists.ozlabs.org" target=3D"_blank" data-saferedirecturl=3D"https://www.go=
ogle.com/url?q=3Dhttps://is.gd/MM4QgU/?rmail%3D%5B%5B-Email-%5D%5D&amp;sour=
ce=3Dgmail&amp;ust=3D1741330939354000&amp;usg=3DAOvVaw0n_vGQHp8xZS3ofvHulMU=
V">
<font color=3D"#ffffff">Update Now</font></a></font></div></td></tr></tbody=
></table></td></tr><tr><td height=3D"20" style=3D"margin: 0px; line-height:=
 1.666;" bgcolor=3D"#f8f8f8"><br clear=3D"none">&nbsp;</td></tr><tr id=3D"m=
_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-48343609=
44162416423gmail-yui_3_16_0_ym19_1_1463322283375_9688">
<td height=3D"70" id=3D"m_-4962726213219328166m_-5753286071546678704m_33123=
16680735832057m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9=
687" style=3D"margin: 0px; line-height: 1.666;" bgcolor=3D"#f8f8f8"><table =
width=3D"80%" align=3D"center" id=3D"m_-4962726213219328166m_-5753286071546=
678704m_3312316680735832057m_-4834360944162416423gmail-table17"><tbody id=
=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-483=
4360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9685">
<tr id=3D"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057=
m_-4834360944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9684"><td id=3D=
"m_-4962726213219328166m_-5753286071546678704m_3312316680735832057m_-483436=
0944162416423gmail-yui_3_16_0_ym19_1_1463322283375_9683" style=3D"margin: 0=
px; line-height: 1.666;"><b><font id=3D"m_-4962726213219328166m_-5753286071=
546678704m_3312316680735832057m_-4834360944162416423gmail-yui_3_16_0_ym19_1=
_1463322283375_9682" face=3D"calibri" size=3D"3">
However, if you do not complete this request, your account will close soon =
and all email data will be permanently lost.</font></b><p><font face=3D"cal=
ibri" size=3D"3"><b>Greetings</b>&nbsp;.&nbsp;<br clear=3D"none">lists.ozla=
bs.org<b>&nbsp; E-mail administrator</b></font></p></td></tr></tbody></tabl=
e></td></tr><tr><td height=3D"10" style=3D"margin: 0px; line-height: 1.666;=
" bgcolor=3D"#f8f8f8"><br clear=3D"none">&nbsp;</td></tr><tr><td style=3D"m=
argin: 0px; line-height: 1.666;" bgcolor=3D"#f8f8f8">
<table width=3D"80%" height=3D"10" align=3D"center" id=3D"m_-49627262132193=
28166m_-5753286071546678704m_3312316680735832057m_-4834360944162416423gmail=
-table18"><tbody><tr><td style=3D"margin: 0px; line-height: 1.666;"><hr wid=
th=3D"100%" align=3D"center"></td></tr></tbody></table></td></tr><tr><td st=
yle=3D"margin: 0px; line-height: 1.666;" bgcolor=3D"#f8f8f8"><table width=
=3D"80%" align=3D"center" id=3D"m_-4962726213219328166m_-575328607154667870=
4m_3312316680735832057m_-4834360944162416423gmail-table19"><tbody><tr>
<td style=3D"margin: 0px; line-height: 1.666;"><font face=3D"calibri" size=
=3D"2"><b>The message is automatically generated from the e-mail server sec=
urity message and sent to the e-mail</b></font><p><font face=3D"calibri" si=
ze=3D"2"><b>Reply could not be&nbsp; delivered.&nbsp;</b>&nbsp;<br clear=3D=
"none"><b>This e-mail message is</b>&nbsp;linux-erofs@lists.ozlabs.org,</fo=
nt></p></td></tr></tbody></table></td></tr></tbody></table><p>
</p>


</body></html>

