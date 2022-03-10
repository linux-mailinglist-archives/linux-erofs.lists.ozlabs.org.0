Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1834D418F
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 08:08:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDgBj4p8Cz3069
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 18:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646896093;
	bh=MRHUJ3g1Wh8xZ6Bq7E2M/HXtJE+LRy5j7K+Z5Peha6o=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=HEEoYm36hlnY1XXtmyjI89LIZyCy3orfsCdQtzruxzcAfMDU0VNukPuN8FegYp/FS
	 igEFYD0INX4UCd4eqyafU5M4SY44pK7JLBuGzSIurTg+8hRHQi+XryxnYk5yB9G6sS
	 OcLxsRxeVXhpk2AcEkNXQl/TY8IX1QxmDWYTq1t+M+RAQrccTFoeGPLtuH1gXkmGY9
	 xGKPTPQ6VTnrmGUZs9B2HOCpXSoT7lmKrHJ4ysifVRoE/Hwgu0FbwZIWfeKD3u/5nO
	 BtbyGMpe0ISTQxDfaoD5zueFbbqUe3zmK0u6bMwyE97HD/Mb8job+dyYY4UZsYZaNu
	 fU78gUWdsp+ew==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xiaomi.com (client-ip=207.226.244.123;
 helo=outboundhk.mxmail.xiaomi.com; envelope-from=liujinbao1@xiaomi.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 63 seconds by postgrey-1.36 at boromir;
 Thu, 10 Mar 2022 18:08:08 AEDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com
 [207.226.244.123])
 by lists.ozlabs.org (Postfix) with ESMTP id 4KDgBc3BFQz2xVY
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 18:08:08 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; d="scan'208,217";a="19451328"
Received: from hk-mbx02.mioffice.cn (HELO xiaomi.com) ([10.56.8.122])
 by outboundhk.mxmail.xiaomi.com with ESMTP; 10 Mar 2022 15:06:50 +0800
Received: from yz-mbx01.mioffice.cn (10.237.88.121) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 10 Mar
 2022 15:06:50 +0800
Received: from BJ-MBX07.mioffice.cn (10.237.8.127) by yz-mbx01.mioffice.cn
 (10.237.88.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 10 Mar
 2022 15:06:49 +0800
Received: from BJ-MBX07.mioffice.cn ([fe80::2d2b:d6a2:8b41:e96e]) by
 BJ-MBX07.mioffice.cn ([fe80::2d2b:d6a2:8b41:e96e%8]) with mapi id
 15.02.0986.015; Thu, 10 Mar 2022 15:06:49 +0800
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: [erofs-utils] Report two resource leak issues and submit patches
Thread-Topic: [erofs-utils] Report two resource leak issues and submit patches
Thread-Index: Adg0TWmgukvGHhC/T3KBMmcRTCf68g==
Date: Thu, 10 Mar 2022 07:06:49 +0000
Message-ID: <7edd65f3347a4105b54cac65140ae06a@xiaomi.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: multipart/alternative;
 boundary="_000_7edd65f3347a4105b54cac65140ae06axiaomicom_"
MIME-Version: 1.0
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
From: =?utf-8?b?5YiY6YeR5a6dIHZpYSBMaW51eC1lcm9mcw==?=
 <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb2312?B?wfW98LGm?= <liujinbao1@xiaomi.com>
Cc: =?gb2312?B?Smlhbmh1YTEgSGFvILrCvai7qg==?= <haojianhua1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_7edd65f3347a4105b54cac65140ae06axiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8sDQpUaGVyZSBhcmUgdHdvIHJlc291cmNlIGxlYWsgcHJvYmxlbXMgYW5kIHBhdGNoZXMg
aGVyZS4NClByb2JsZW0gMTogUmVzb3VyY2UgbGVha2FnZQ0KRmlsZTogZXJvZnMtdXRpbHMvbGli
L3hhdHRyLmMNCkZ1bmN0aW9uOiBlcm9mc19nZXRfc2VsYWJlbF94YXR0cg0KU3RhdGVtZW50OiBy
ZXQgPSBhc3ByaW50ZigmZnNwYXRoLCAiLyVzIiwgZXJvZnNfZnNwYXRoKHNyY3BhdGgpKTsNCmlm
IChyZXQgPD0gMCkNCnJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KQW5hbHlzaXM6IFdoZW4gdGhl
IGFzcHJpbnRmIGZ1bmN0aW9uIGZhaWxzLCBpdCByZXR1cm5zIC0xLCBzbyB0aGUganVkZ21lbnQg
Y29uZGl0aW9uIHNob3VsZCBiZSByZXQ8MC4gUmV0dXJuIHdoZW4gcmV0PTAsIHRoZSBzdG9yYWdl
IHBvaW50ZWQgdG8gYnkgZnNwYXRoIHdpbGwgYmUgbGVha2VkDQpQYXRjaDogaWYgKHJldCA8IDAp
DQoNClByb2JsZW0gMjogUmVzb3VyY2UgbGVha2FnZQ0KRmlsZTogZXJvZnMtdXRpbHMvbGliL2lu
b2RlLmMNCkZ1bmN0aW9uOiBlcm9mc19kcm9pZF9pbm9kZV9mc2NvbmZpZw0KU3RhdGVtZW50OiBp
ZiAoYXNwcmludGYoJmRlY29yYXRlZCwgIiVzLyVzIiwgY2ZnLm1vdW50X3BvaW50LCBlcm9mc19m
c3BhdGgocGF0aCkpIDw9IDApDQpyZXR1cm4gLUVOT01FTTsNCkFuYWx5c2lzOiBXaGVuIHRoZSBh
c3ByaW50ZiBmdW5jdGlvbiBmYWlscywgaXQgcmV0dXJucyAtMSwgc28gdGhlIGp1ZGdtZW50IGNv
bmRpdGlvbiBzaG91bGQgYmUgcmV0PDAuIFJldHVybiB3aGVuIGFzcHJpbnRmKCZkZWNvcmF0ZWQs
ICIlcy8lcyIsIGNmZy5tb3VudF9wb2ludCwgZXJvZnNfZnNwYXRoKHBhdGgpKSA9IDAsIHRoZSBz
dG9yYWdlIHBvaW50ZWQgdG8gYnkgZGVjb3JhdGVkIHdpbGwgYmUgbGVha2VkDQpQYXRjaDogaWYg
KGFzcHJpbnRmKCZkZWNvcmF0ZWQsICIlcy8lcyIsIGNmZy5tb3VudF9wb2ludCwgZXJvZnNfZnNw
YXRoKHBhdGgpKSA8IDApDQoNClRoYW5rIHlvdSENCkppbmJhbyBMaXUNCg0KDQoNCiMvKioqKioq
sb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQxc+io6y99s/e09q3osvNuPjJz8PmtdjW
t9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7yMvS1MjOus7Qzsq9yrnTw6OosPzAqLWr
srvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJoreio6mxvtPKvP7W0LXE0MXPoqGjyOe5
+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+
o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBl
cnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2Yg
dGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBi
dXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0
aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVk
IHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVk
aWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==

--_000_7edd65f3347a4105b54cac65140ae06axiaomicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.jlqj4b
	{mso-style-name:jlqj4b;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:=B5=C8=CF=DF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">H=
ello, <o:p></o:p></span></b></p>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><b><span lang=3D"EN-US"=
 style=3D"font-size:12.0pt">There are two resource leak problems and patche=
s here.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Problem 1</span></b>=
<span lang=3D"EN-US" style=3D"font-size:12.0pt">: Resource leakage<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">File</span></b><span=
 lang=3D"EN-US" style=3D"font-size:12.0pt">: erofs-utils/lib/xattr.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Function</span></b><=
span lang=3D"EN-US" style=3D"font-size:12.0pt">: erofs_get_selabel_xattr<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Statement</span></b>=
<span lang=3D"EN-US" style=3D"font-size:12.0pt">: ret =3D asprintf(&amp;fsp=
ath, &quot;/%s&quot;, erofs_fspath(srcpath));<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:84.0pt;mso-para-margin-left:8.0=
gd"><span lang=3D"EN-US" style=3D"font-size:12.0pt">if (ret &lt;=3D 0)<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:105.0pt;mso-para-margin-left:10=
.0gd"><span lang=3D"EN-US" style=3D"font-size:12.0pt">return ERR_PTR(-ENOME=
M);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Analysis</span></b><=
span lang=3D"EN-US" style=3D"font-size:12.0pt">:
</span><span class=3D"jlqj4b"><span lang=3D"EN" style=3D"font-size:12.0pt">=
When the asprintf function fails, it returns -1</span></span><span lang=3D"=
EN-US" style=3D"font-size:12.0pt">, so the judgment condition should be ret=
&lt;0. Return when ret=3D0, the storage pointed
 to by fspath will be leaked<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Patch</span></b><spa=
n lang=3D"EN-US" style=3D"font-size:12.0pt">: if (ret &lt; 0)<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><span lang=3D"EN-US" style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Problem 2</span></b>=
<span lang=3D"EN-US" style=3D"font-size:12.0pt">: Resource leakage<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">File</span></b><span=
 lang=3D"EN-US" style=3D"font-size:12.0pt">: erofs-utils/lib/inode.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Function</span></b><=
span lang=3D"EN-US" style=3D"font-size:12.0pt">: erofs_droid_inode_fsconfig=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Statement</span></b>=
<span lang=3D"EN-US" style=3D"font-size:12.0pt">: if (asprintf(&amp;decorat=
ed, &quot;%s/%s&quot;, cfg.mount_point, erofs_fspath(path))
 &lt;=3D 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:105.0pt;mso-para-margin-left:10=
.0gd"><span lang=3D"EN-US" style=3D"font-size:12.0pt">return -ENOMEM;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Analysis</span></b><=
span lang=3D"EN-US" style=3D"font-size:12.0pt">:
</span><span class=3D"jlqj4b"><span lang=3D"EN" style=3D"font-size:12.0pt">=
When the asprintf function fails, it returns -1</span></span><span lang=3D"=
EN-US" style=3D"font-size:12.0pt">, so the judgment condition should be ret=
&lt;0. Return when asprintf(&amp;decorated, &quot;%s/%s&quot;,
 cfg.mount_point, erofs_fspath(path)) =3D 0, the storage pointed to by deco=
rated will be leaked<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;mso-para-margin-left:2.0=
gd"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt">Patch</span></b><spa=
n lang=3D"EN-US" style=3D"font-size:12.0pt">: if (asprintf(&amp;decorated, =
&quot;%s/%s&quot;, cfg.mount_point, erofs_fspath(path)) &lt;
 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">Thank you!<o:p></o:p></span>=
</b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">Jinbao Liu<o:p></o:p></span>=
</b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address
 is listed above. Any use of the information contained herein in any way (i=
ncluding, but not limited to, total or partial disclosure, reproduction, or=
 dissemination) by persons other than the intended recipient(s) is prohibit=
ed. If you receive this e-mail in
 error, please notify the sender by phone or email immediately and delete i=
t!******/#
</body>
</html>

--_000_7edd65f3347a4105b54cac65140ae06axiaomicom_--
