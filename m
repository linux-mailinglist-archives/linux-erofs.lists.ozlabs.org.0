Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B50822C0A
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 12:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704281099;
	bh=0D41ArhtQIY4LGeCOZ9jpxc3wie8PyQjXXpReEsrjcU=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=kPr1ahv5ICJAUns72gm5XDCCozb+Z2b69pMUvYkQ05vxoBF4UfZYgsJwDtI76AlaR
	 hxZIS6ftKKXV/GhF/XR8Nx+YlVnsJ8eXmODaREQR57u2NQ12e6dZcUNLPNlA4ZJ4go
	 3828hVbmF2vMU13xbcQCbNfJNDyWmFtbE20gMOGBhs8vmEjCtrwSWr1AGVtu1QOQ1u
	 XJ0TLAyPCfxuEEBZiS7eLgpm+Cdo2gTH2qIzjlwYW/VHI6CTfH6VQNCSGVlHKZ1ZJz
	 V3590GlhHN+BB4qMPfKCNqyP2aunvpnjCPzs7Kppkt0INJaEpLO5KplUoPBoLr825v
	 f2R0doJSzba1g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4nSW4K9mz3cVY
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 22:24:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=118.143.206.90; helo=outboundhk.mxmail.xiaomi.com; envelope-from=wangshuo16@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Wed, 03 Jan 2024 22:24:55 AEDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4nSR2JFdz3cT3
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 22:24:54 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208,217";a="74895253"
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFJlcXVlc3QgZm9yIEFz?=
 =?gb2312?B?c2lzdGFuY2U6IERlY29tcHJlc3NpbmcgRVJPRlMgSW1hZ2Ugd2l0aG91dCBN?=
 =?gb2312?Q?ounting?=
Thread-Topic: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFJlcXVlc3QgZm9yIEFzc2lzdGFu?=
 =?gb2312?Q?ce:_Decompressing_EROFS_Image_without_Mounting?=
Thread-Index: AQHaPi0Wruvt67JPQ0WM1jFiaZyTSbDHYmKAgACK6pP//35HgIAAhmu9
Date: Wed, 3 Jan 2024 11:23:47 +0000
Message-ID: <b798af03769c42c3a811b74e6a2489cc@xiaomi.com>
References: <e751bfc68f524227ad8ad98faa8102af@xiaomi.com>
 <1616817c-7759-41f1-8c6b-568fb7357212@linux.alibaba.com>
 <5ee2a6ba360d40239d18845d0f21e31e@xiaomi.com>,<d049d7ac-4ae6-4fd0-96a4-7b0729fd3367@linux.alibaba.com>
In-Reply-To: <d049d7ac-4ae6-4fd0-96a4-7b0729fd3367@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.18]
Content-Type: multipart/alternative;
	boundary="_000_b798af03769c42c3a811b74e6a2489ccxiaomicom_"
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

--_000_b798af03769c42c3a811b74e6a2489ccxiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb25zLiBJIHdpbGwgdHJ5IHRvIHNlZWsgYXNzaXN0
YW5jZSBmcm9tIGNvbGxlYWd1ZXMgd2l0aGluIHRoZSBjb21wYW55LiBJIGFwcHJlY2lhdGUgeW91
ciBoZWxwLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBHYW8g
WGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCreiy83KsbzkOiAyMDI0xOox1MIz
yNUgMTk6MjE6MzkNCsrVvP7IyzogzfXLtjsgbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw0K
1vfM4jogUmU6ILTwuLQ6IFtFeHRlcm5hbCBNYWlsXVJlOiBSZXF1ZXN0IGZvciBBc3Npc3RhbmNl
OiBEZWNvbXByZXNzaW5nIEVST0ZTIEltYWdlIHdpdGhvdXQgTW91bnRpbmcNCg0KW83isr/Tyrz+
XSC0y9PKvP7AtNS009rQocPXuavLvs3isr+jrMfrvffJ97SmwO2ho8j0ttTTyrz+sLLIq9DUtObS
yaOsx+u9q9PKvP7XqreiuPhtaXNlY0B4aWFvbWkuY29tvfjQ0Le0wKENCg0KT24gMjAyNC8xLzMg
MTk6MDksIM31y7YgdmlhIExpbnV4LWVyb2ZzIHdyb3RlOg0KPiBIaSwNCj4NCj4NCj4gVGhhbmtz
IGZvciB5b3VyIHJlcGx5LCBhbmQgSSBoYXZlIHRyaWVkIHRoZSBvcHRpb24geW91IHN1Z2dlc3Rl
ZCBidXQgZmFpbGVkLkNvdWxkIHlvdSBoZWxwIG1lIHRvIHNvbHZlIGl0Pw0KPg0KPiBGb2xsb3dp
bmcgaXMgdGhlIHJlc3VsdCBvZiBleGVjdXRpbmcgdGhlIG9wdGlvbjoNCj4NCj4NCj4NCj4NCj4g
KEkgaGF2ZSBkb3dubG9hZGVkIHRoZSBzb3VyY2UgY29kZSBmcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9lcm9mcy9lcm9mcy11dGlscy90cmVlL2RldiA8aHR0cHM6Ly9naXRodWIuY29tL2Vyb2ZzL2Vy
b2ZzLXV0aWxzL3RyZWUvZGV2PiwgYW5kIG1ha2UgaW5zdGFsbCBvbiBteSBVYnVudHUyMC4wNCkN
Cg0KICAtIENvdWxkIHlvdSB1c2UgYSBuZXdlciBkaXN0cmlidXRpb24gaW5zdGVhZCBzdWNoIGFz
IERlYmlhbiAxMj8NCk90aGVyd2lzZSBpdCB3aWxsIGJlIG1vcmUgY29tcGxpY2F0ZWQsIGJlY2F1
c2UgbHo0L2x6bWEgd2VyZW4ndA0KYnVpbGQtaW4gYWNjb3JkaW5nIHRvIHRoZSBzbmFwc2hvdC4N
Cg0KICAtIEl0IHNob3VsZCBiZSAiZnNjay5lcm9mcyAtLWV4dHJhY3Q9bWlfZXh0IG1pX2V4dC5p
bWciDQoNCiAgLSBBcyBmb3IgWGlhb21pIENvcnAsIGlzIHRoZXJlIHNvbWUgb3RoZXIgY29sbGVh
Z3VlIHdoaWNoIGNhbg0KaGVscCB5b3UgcmVzb2x2ZSB0aGlzPw0KDQpUaGFua3MsDQpHYW8gWGlh
bmcNCiMvKioqKioqsb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQxc+io6y99s/e09q3
osvNuPjJz8PmtdjWt9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7yMvS1MjOus7Qzsq9
yrnTw6OosPzAqLWrsrvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJoreio6mxvtPKvP7W
0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7NqNaqt6K8/sjL
sqLJvrP9sb7Tyrz+o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNv
bmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUu
IEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAo
aW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3Vy
ZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4g
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9y
IGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==

--_000_b798af03769c42c3a811b74e6a2489ccxiaomicom_
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
<p><span style=3D"color:rgb(55,65,81); font-size:16px">Thank you for your s=
uggestions. I will try to seek assistance from colleagues within the compan=
y. I appreciate your help.</span><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Gao X=
iang &lt;hsiangkao@linux.alibaba.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2024=C4=EA1=D4=C23=C8=D5 19:21:39<br>
<b>=CA=D5=BC=FE=C8=CB:</b> =CD=F5=CB=B6; linux-erofs@lists.ozlabs.org<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: [External Mail]Re: Request for Assis=
tance: Decompressing EROFS Image without Mounting</font>
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

--_000_b798af03769c42c3a811b74e6a2489ccxiaomicom_--
