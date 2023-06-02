Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A571FA0E
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 08:26:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXY1X39Hyz3dy2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 16:26:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1685687200;
	bh=H7zkLsTEL6j4vYi65L+IykAiyYxtWkZQOQoutosMEYo=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B8qv+LEDG6pi17y57TjqWs6mfe2cXkxtRvyZ5gE8n1ImNHt2EN94s7p3dFWWkdttj
	 xT7N8eX9M42tKvvIgQu/ay0aBuHOBoeRAWa9FmLQbgNzsUQpxPpRsqMjzeiJGYr8j8
	 9dVQpJlhaEEvtyGD9a6xmmZy5dHeTnTykvqxiQOlJP1eHfAolVpZy1KoerNC0tPm5F
	 tNwtXwl2k141uP0Pi5IfE5GQEubkdPbG/ly/gQ0NeBIdR3W59AGdimmvWYPiJId6/f
	 W5hSvtGhOnEtvzIs6eixpUUh0FGiXOcf6ReWAaekBPKbFxIj8kpjwUf/mji1kYYGsj
	 RUXFz9hgDQ3vA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=118.143.206.88; helo=outboundhk.mxmail.xiaomi.com; envelope-from=sunshijie@xiaomi.com; receiver=<UNKNOWN>)
X-Greylist: delayed 63 seconds by postgrey-1.36 at boromir; Fri, 02 Jun 2023 16:26:36 AEST
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXY1S1JZGz3dwj
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 16:26:35 +1000 (AEST)
X-IronPort-AV: E=Sophos;i="6.00,212,1681142400"; 
   d="scan'208,217";a="56761103"
Received: from hk-mbx11.mioffice.cn (HELO xiaomi.com) ([10.56.21.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 02 Jun 2023 14:25:23 +0800
Received: from BJ-MBX15.mioffice.cn (10.237.8.135) by HK-MBX11.mioffice.cn
 (10.56.21.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 2 Jun 2023
 14:25:23 +0800
Received: from BJ-MBX18.mioffice.cn (10.237.8.138) by BJ-MBX15.mioffice.cn
 (10.237.8.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 2 Jun 2023
 14:25:22 +0800
Received: from BJ-MBX18.mioffice.cn ([fe80::8b9f:c563:88ae:ed07]) by
 BJ-MBX18.mioffice.cn ([fe80::8b9f:c563:88ae:ed07%16]) with mapi id
 15.02.0986.041; Fri, 2 Jun 2023 14:25:22 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "huyue2@coolpad.com"
	<huyue2@coolpad.com>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSF0gZXJvZnMtdXRpbHM6?=
 =?gb2312?B?IGxpbWl0IHBjbHVzdGVyc2l6ZSBpbiB6X2Vyb2ZzX2ZpeHVwX2RlZHVwZWRf?=
 =?gb2312?Q?fragment()?=
Thread-Topic: [External Mail]Re: [PATCH] erofs-utils: limit pclustersize in
 z_erofs_fixup_deduped_fragment()
Thread-Index: AQHZlRi2KYUIdrHTbkm5gko3GVwMUa93C6GC
Date: Fri, 2 Jun 2023 06:25:22 +0000
Message-ID: <87fa68fdcb644600a23a25c041d6e1b6@xiaomi.com>
References: <20230602052039.615632-1-asai@sijam.com>,<9712ed04-a5ae-4c1f-7275-405e2e92f083@linux.alibaba.com>
In-Reply-To: <9712ed04-a5ae-4c1f-7275-405e2e92f083@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: multipart/alternative;
	boundary="_000_87fa68fdcb644600a23a25c041d6e1b6xiaomicom_"
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
From: =?utf-8?b?5a2Z5aOr5p2wIHZpYSBMaW51eC1lcm9mcw==?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb2312?B?y+/Kv73c?= <sunshijie@xiaomi.com>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_87fa68fdcb644600a23a25c041d6e1b6xiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

usO1xKOst8ezo7jQ0LsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7I
yzogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+DQq3osvNyrG85DogMjAy
M8TqNtTCMsjVIDE0OjA4OjMzDQrK1bz+yMs6IGh1eXVlMkBjb29scGFkLmNvbQ0Ks63LzTogbGlu
dXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZzsgTm9ib3J1IEFzYWk7IEdhbyBYaWFuZzsgQ2hhbyBZ
dTsgy+/Kv73cDQrW98ziOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIXSBlcm9mcy11dGlsczog
bGltaXQgcGNsdXN0ZXJzaXplIGluIHpfZXJvZnNfZml4dXBfZGVkdXBlZF9mcmFnbWVudCgpDQoN
ClvN4rK/08q8/l0gtMvTyrz+wLTUtNPa0KHD17mry77N4rK/o6zH6733yfe0psDtoaPI9LbU08q8
/rCyyKvQ1LTm0smjrMfrvavTyrz+16q3orj4bWlzZWNAeGlhb21pLmNvbb340NC3tMChDQoNCkhp
IFl1ZSwNCg0KT24gMjAyMy82LzIgMTM6MjAsIE5vYm9ydSBBc2FpIHdyb3RlOg0KPiBUaGUgdmFy
aWFibGUgJ2N0eC0+cGNsdXN0ZXJzaXplJyBjb3VsZCBiZSBsYXJnZXIgdGhhbiBtYXggcGNsdXN0
ZXJzaXplLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBOb2JvcnUgQXNhaSA8YXNhaUBzaWphbS5jb20+
DQoNClBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHBhdGNoLg0KK0NjIFNoaWppZSBTdW4uDQoN
ClRoYW5rcywNCkdhbyBYaWFuZw0KDQo+IC0tLQ0KPiAgIGxpYi9jb21wcmVzcy5jIHwgNSArKyst
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9saWIvY29tcHJlc3MuYyBiL2xpYi9jb21wcmVzcy5jDQo+IGluZGV4
IDJlMWRmYjMuLmU5NDMwNTYgMTAwNjQ0DQo+IC0tLSBhL2xpYi9jb21wcmVzcy5jDQo+ICsrKyBi
L2xpYi9jb21wcmVzcy5jDQo+IEBAIC0zNTksOCArMzU5LDkgQEAgc3RhdGljIGJvb2wgel9lcm9m
c19maXh1cF9kZWR1cGVkX2ZyYWdtZW50KHN0cnVjdCB6X2Vyb2ZzX3ZsZV9jb21wcmVzc19jdHgg
KmN0eCwNCj4NCj4gICAgICAgLyogdHJ5IHRvIGZpeCBhZ2FpbiBpZiBpdCBnZXRzIGxhcmdlciAo
c2hvdWxkIGJlIHJhcmUpICovDQo+ICAgICAgIGlmIChpbm9kZS0+ZnJhZ21lbnRfc2l6ZSA8IG5l
d3NpemUpIHsNCj4gLSAgICAgICAgICAgICBjdHgtPnBjbHVzdGVyc2l6ZSA9IHJvdW5kdXAobmV3
c2l6ZSAtIGlub2RlLT5mcmFnbWVudF9zaXplLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlcm9mc19ibGtzaXooKSk7DQo+ICsgICAgICAgICAgICAgY3R4LT5w
Y2x1c3RlcnNpemUgPSBtaW4oel9lcm9mc19nZXRfbWF4X3BjbHVzdGVyYmxrcyhpbm9kZSkgKiBl
cm9mc19ibGtzaXooKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
b3VuZHVwKG5ld3NpemUgLSBpbm9kZS0+ZnJhZ21lbnRfc2l6ZSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyb2ZzX2Jsa3NpeigpKSk7DQo+ICAgICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQo+DQojLyoqKioqKrG+08q8/rywxuS4
vbz+uqzT0NChw9e5q8u+tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW0MHQs/a1xLj2
yMu78si61+mho7371rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sirsr+7
8rK/t9a12NC5wrahori01sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jnufvE+rTtytXBy7G+
08q8/qOsx+vE+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qOhIFRoaXMgZS1t
YWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24g
ZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50
aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1h
dGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1p
dGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlz
c2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQo
cykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQg
ZGVsZXRlIGl0ISoqKioqKi8jDQo=

--_000_87fa68fdcb644600a23a25c041d6e1b6xiaomicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span>=BA=C3=B5=C4=A3=AC=B7=C7=B3=A3=B8=D0=D0=BB</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Gao X=
iang &lt;hsiangkao@linux.alibaba.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2023=C4=EA6=D4=C22=C8=D5 14:08:33<br>
<b>=CA=D5=BC=FE=C8=CB:</b> huyue2@coolpad.com<br>
<b>=B3=AD=CB=CD:</b> linux-erofs@lists.ozlabs.org; Noboru Asai; Gao Xiang; =
Chao Yu; =CB=EF=CA=BF=BD=DC<br>
<b>=D6=F7=CC=E2:</b> [External Mail]Re: [PATCH] erofs-utils: limit pcluster=
size in z_erofs_fixup_deduped_fragment()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">[=CD=E2=B2=BF=D3=CA=BC=FE] =B4=CB=D3=CA=BC=FE=C0=
=B4=D4=B4=D3=DA=D0=A1=C3=D7=B9=AB=CB=BE=CD=E2=B2=BF=A3=AC=C7=EB=BD=F7=C9=F7=
=B4=A6=C0=ED=A1=A3=C8=F4=B6=D4=D3=CA=BC=FE=B0=B2=C8=AB=D0=D4=B4=E6=D2=C9=A3=
=AC=C7=EB=BD=AB=D3=CA=BC=FE=D7=AA=B7=A2=B8=F8misec@xiaomi.com=BD=F8=D0=D0=
=B7=B4=C0=A1<br>
<br>
Hi Yue,<br>
<br>
On 2023/6/2 13:20, Noboru Asai wrote:<br>
&gt; The variable 'ctx-&gt;pclustersize' could be larger than max pclusters=
ize.<br>
&gt;<br>
&gt; Signed-off-by: Noboru Asai &lt;asai@sijam.com&gt;<br>
<br>
Please take a look at this patch.<br>
&#43;Cc Shijie Sun.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; lib/compress.c | 5 &#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/compress.c b/lib/compress.c<br>
&gt; index 2e1dfb3..e943056 100644<br>
&gt; --- a/lib/compress.c<br>
&gt; &#43;&#43;&#43; b/lib/compress.c<br>
&gt; @@ -359,8 &#43;359,9 @@ static bool z_erofs_fixup_deduped_fragment(str=
uct z_erofs_vle_compress_ctx *ctx,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* try to fix again if it gets lar=
ger (should be rare) */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (inode-&gt;fragment_size &lt; n=
ewsize) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctx-&gt;pclustersize =3D roundup(newsize - inode-&gt;fragment_size,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; erofs_blksiz());<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;pclustersize =3D min(z_erofs_get_max_pclusterblks(inode) * =
erofs_blksiz(),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; roundup(newsize - inode-&gt;fragment_size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; erofs_blksiz()));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
</div>
</span></font>#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=
=D0=D0=A1=C3=D7=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=
=D3=DA=B7=A2=CB=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=
=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=
=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=
=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=
=A1=A2=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=
=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=
=C1=A2=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=
=A2=C9=BE=B3=FD=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments con=
tain confidential information from XIAOMI, which is intended only for the p=
erson or
 entity whose address is listed above. Any use of the information contained=
 herein in any way (including, but not limited to, total or partial disclos=
ure, reproduction, or dissemination) by persons other than the intended rec=
ipient(s) is prohibited. If you
 receive this e-mail in error, please notify the sender by phone or email i=
mmediately and delete it!******/#
</body>
</html>

--_000_87fa68fdcb644600a23a25c041d6e1b6xiaomicom_--
