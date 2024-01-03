Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12C822D5D
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 13:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704285871;
	bh=bj54TpmxgEHPaSBWeSblcfH/Z6qZJA5GzkhKNBG0x/8=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=h/AlV1SHprXLCnw1+udN+gyYYT5YIVrIfCTV1VlLNRbYkyqBCJvjEBv5WrRVWpMtH
	 rPrMRKyEU1oDHnn9uXqajN4HIl6vJOoZSKscH+tEnGa/CWrVDPbeNuw4yBX6UhqXxi
	 6sqz2UNQqreCKiuhblFh0bfm+ICvN3LBldb/cxVpP/4gW69qLwosss34C5pEcX1BQX
	 St1ewtLAo1MAGplYejkzlgt6+yGTNvJO4/XGsVer5ntzAx8xIV5My2C8rtccPEFMQy
	 E6QEDDV0FKuFyMnbBc+4qFw8SjD8EXtZJJr1cLtRF1dUj7IsAYFCmTHqZYk7cesmCX
	 l/78aXxbz4Zgw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4qDH55Bbz3cTH
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 23:44:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=wangshuo16@xiaomi.com; receiver=lists.ozlabs.org)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4qDB0SQ0z3cGY
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 23:44:23 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208,217";a="100482604"
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: Re: [External Mail]Re: Request for Assistance: Decompressing EROFS
 Image without Mounting
Thread-Topic: [External Mail]Re: Request for Assistance: Decompressing EROFS
 Image without Mounting
Thread-Index: AQHaPkKT6ZWgsQR/kEqu8efuvQVYfQ==
Date: Wed, 3 Jan 2024 12:44:21 +0000
Message-ID: <OS3P286MB0755903C1870DAAAE9C6DFAAF060A@OS3P286MB0755.JPNP286.PROD.OUTLOOK.COM>
References: <e751bfc68f524227ad8ad98faa8102af@xiaomi.com>
 <1616817c-7759-41f1-8c6b-568fb7357212@linux.alibaba.com>
 <5ee2a6ba360d40239d18845d0f21e31e@xiaomi.com>,<d049d7ac-4ae6-4fd0-96a4-7b0729fd3367@linux.alibaba.com>,<b798af03769c42c3a811b74e6a2489cc@xiaomi.com>
In-Reply-To: <b798af03769c42c3a811b74e6a2489cc@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: multipart/alternative;
	boundary="_000_OS3P286MB0755903C1870DAAAE9C6DFAAF060AOS3P286MB0755JPNP_"
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
From: =?utf-8?b?546L56GVIHZpYSBMaW51eC1lcm9mcw==?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb2312?B?zfXLtg==?= <wangshuo16@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_OS3P286MB0755903C1870DAAAE9C6DFAAF060AOS3P286MB0755JPNP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhlIGlzc3VlIGhhcyBiZWVuIHJlc29sdmVkOyBpdCB3YXMgZHVlIHRvIGEgbGFjayBvZiBzdXBw
b3J0IGZvciB0aGUgbHo0IGxpYnJhcnkgb24gbXkgY29tcHV0ZXIuIFRoZSBzb3VyY2UgIGNvZGUg
b2YgbWFzdGVyIGJyYW5jaCBoYXMgbm8gcHJvYmxlbS4gVGhhbmtzIHRvIHlvdXIgYXNzaXN0YW5j
ZSwgYW5kIHRoYW5rcyBoZWxwIGZyb20gaHVhbmdqaWFuYW5AeGlhb21pLmNvbQ0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogzfXLtiA8d2FuZ3NodW8xNkB4aWFvbWku
Y29tPg0Kt6LLzcqxvOQ6IFdlZG5lc2RheSwgSmFudWFyeSAzLCAyMDI0IDc6MjM6NDcgUE0NCsrV
vP7IyzogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+OyBsaW51eC1lcm9m
c0BsaXN0cy5vemxhYnMub3JnIDxsaW51eC1lcm9mc0BsaXN0cy5vemxhYnMub3JnPg0K1vfM4jog
tPC4tDogtPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFJlcXVlc3QgZm9yIEFzc2lzdGFuY2U6IERl
Y29tcHJlc3NpbmcgRVJPRlMgSW1hZ2Ugd2l0aG91dCBNb3VudGluZw0KDQoNClRoYW5rIHlvdSBm
b3IgeW91ciBzdWdnZXN0aW9ucy4gSSB3aWxsIHRyeSB0byBzZWVrIGFzc2lzdGFuY2UgZnJvbSBj
b2xsZWFndWVzIHdpdGhpbiB0aGUgY29tcGFueS4gSSBhcHByZWNpYXRlIHlvdXIgaGVscC4NCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogR2FvIFhpYW5nIDxoc2lh
bmdrYW9AbGludXguYWxpYmFiYS5jb20+DQq3osvNyrG85DogMjAyNMTqMdTCM8jVIDE5OjIxOjM5
DQrK1bz+yMs6IM31y7Y7IGxpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmcNCtb3zOI6IFJlOiC0
8Li0OiBbRXh0ZXJuYWwgTWFpbF1SZTogUmVxdWVzdCBmb3IgQXNzaXN0YW5jZTogRGVjb21wcmVz
c2luZyBFUk9GUyBJbWFnZSB3aXRob3V0IE1vdW50aW5nDQoNClvN4rK/08q8/l0gtMvTyrz+wLTU
tNPa0KHD17mry77N4rK/o6zH6733yfe0psDtoaPI9LbU08q8/rCyyKvQ1LTm0smjrMfrvavTyrz+
16q3orj4bWlzZWNAeGlhb21pLmNvbb340NC3tMChDQoNCk9uIDIwMjQvMS8zIDE5OjA5LCDN9cu2
IHZpYSBMaW51eC1lcm9mcyB3cm90ZToNCj4gSGksDQo+DQo+DQo+IFRoYW5rcyBmb3IgeW91ciBy
ZXBseSwgYW5kIEkgaGF2ZSB0cmllZCB0aGUgb3B0aW9uIHlvdSBzdWdnZXN0ZWQgYnV0IGZhaWxl
ZC5Db3VsZCB5b3UgaGVscCBtZSB0byBzb2x2ZSBpdD8NCj4NCj4gRm9sbG93aW5nIGlzIHRoZSBy
ZXN1bHQgb2YgZXhlY3V0aW5nIHRoZSBvcHRpb246DQo+DQo+DQo+DQo+DQo+IChJIGhhdmUgZG93
bmxvYWRlZCB0aGUgc291cmNlIGNvZGUgZnJvbSBodHRwczovL2dpdGh1Yi5jb20vZXJvZnMvZXJv
ZnMtdXRpbHMvdHJlZS9kZXYgPGh0dHBzOi8vZ2l0aHViLmNvbS9lcm9mcy9lcm9mcy11dGlscy90
cmVlL2Rldj4sIGFuZCBtYWtlIGluc3RhbGwgb24gbXkgVWJ1bnR1MjAuMDQpDQoNCiAgLSBDb3Vs
ZCB5b3UgdXNlIGEgbmV3ZXIgZGlzdHJpYnV0aW9uIGluc3RlYWQgc3VjaCBhcyBEZWJpYW4gMTI/
DQpPdGhlcndpc2UgaXQgd2lsbCBiZSBtb3JlIGNvbXBsaWNhdGVkLCBiZWNhdXNlIGx6NC9sem1h
IHdlcmVuJ3QNCmJ1aWxkLWluIGFjY29yZGluZyB0byB0aGUgc25hcHNob3QuDQoNCiAgLSBJdCBz
aG91bGQgYmUgImZzY2suZXJvZnMgLS1leHRyYWN0PW1pX2V4dCBtaV9leHQuaW1nIg0KDQogIC0g
QXMgZm9yIFhpYW9taSBDb3JwLCBpcyB0aGVyZSBzb21lIG90aGVyIGNvbGxlYWd1ZSB3aGljaCBj
YW4NCmhlbHAgeW91IHJlc29sdmUgdGhpcz8NCg0KVGhhbmtzLA0KR2FvIFhpYW5nDQojLyoqKioq
KrG+08q8/rywxuS4vbz+uqzT0NChw9e5q8u+tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY
1rfW0MHQs/a1xLj2yMu78si61+mho7371rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1
q7K7z97T2sirsr+78rK/t9a12NC5wrahori01sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jn
ufvE+rTtytXBy7G+08q8/qOsx+vE+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8
/qOhIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBw
ZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9m
IHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywg
YnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVj
dGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1l
ZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=

--_000_OS3P286MB0755903C1870DAAAE9C6DFAAF060AOS3P286MB0755JPNP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">The issue has been resolved; it was due to a lack of suppo=
rt for the lz4 library on my computer. The source &nbsp;code<span style=3D"=
font-size: inherit;">&nbsp;of master branch has no problem. Thanks to your =
assistance, and thanks help from&nbsp;</span><span style=3D"font-size: inhe=
rit;">huangjianan@xiaomi.com</span></div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div dir=3D"ltr"></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> =CD=F5=
=CB=B6 &lt;wangshuo16@xiaomi.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Wednesday, January 3, 2024 7:23:47 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Gao Xiang &lt;hsiangkao@linux.alibaba.com&gt;; l=
inux-erofs@lists.ozlabs.org &lt;linux-erofs@lists.ozlabs.org&gt;<br>
<b>=D6=F7=CC=E2:</b> =B4=F0=B8=B4: =B4=F0=B8=B4: [External Mail]Re: Request=
 for Assistance: Decompressing EROFS Image without Mounting</font>
<div>&nbsp;</div>
</div>
<style>
<!--
.x_EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span style=3D"color:rgb(55,65,81); font-size:16px">Thank you for your s=
uggestions. I will try to seek assistance from colleagues within the compan=
y. I appreciate your help.</span><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Gao=
 Xiang &lt;hsiangkao@linux.alibaba.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2024=C4=EA1=D4=C23=C8=D5 19:21:39<br>
<b>=CA=D5=BC=FE=C8=CB:</b> =CD=F5=CB=B6; linux-erofs@lists.ozlabs.org<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: [External Mail]Re: Request for Assis=
tance: Decompressing EROFS Image without Mounting</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"x_PlainText">[=CD=E2=B2=BF=D3=CA=BC=FE] =B4=CB=D3=CA=BC=FE=C0=
=B4=D4=B4=D3=DA=D0=A1=C3=D7=B9=AB=CB=BE=CD=E2=B2=BF=A3=AC=C7=EB=BD=F7=C9=F7=
=B4=A6=C0=ED=A1=A3=C8=F4=B6=D4=D3=CA=BC=FE=B0=B2=C8=AB=D0=D4=B4=E6=D2=C9=A3=
=AC=C7=EB=BD=AB=D3=CA=BC=FE=D7=AA=B7=A2=B8=F8misec@xiaomi.com=BD=F8=D0=D0=
=B7=B4=C0=A1<br>
<br>
On 2024/1/3 19:09, =CD=F5=CB=B6 via Linux-erofs wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt; Thanks for your reply, and I have tried the option you suggested but f=
ailed.Could you help me to solve it?<br>
&gt;<br>
&gt; Following is the result of executing the option:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; (I have downloaded the source code from <a href=3D"https://github.com/=
erofs/erofs-utils/tree/dev">
https://github.com/erofs/erofs-utils/tree/dev</a> &lt;<a href=3D"https://gi=
thub.com/erofs/erofs-utils/tree/dev">https://github.com/erofs/erofs-utils/t=
ree/dev</a>&gt;, and make install on my Ubuntu20.04)<br>
<br>
&nbsp; - Could you use a newer distribution instead such as Debian 12?<br>
Otherwise it will be more complicated, because lz4/lzma weren't<br>
build-in according to the snapshot.<br>
<br>
&nbsp; - It should be &quot;fsck.erofs --extract=3Dmi_ext mi_ext.img&quot;<=
br>
<br>
&nbsp; - As for Xiaomi Corp, is there some other colleague which can<br>
help you resolve this?<br>
<br>
Thanks,<br>
Gao Xiang<br>
</div>
</span></font></div>
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

--_000_OS3P286MB0755903C1870DAAAE9C6DFAAF060AOS3P286MB0755JPNP_--
