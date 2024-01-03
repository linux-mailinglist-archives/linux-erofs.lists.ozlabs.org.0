Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 431A5822B1E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 11:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704276810;
	bh=Cdfb+XkYdP0Gog/FSqb3Q15H1cvotuhNUoD+zO7MUpU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ieYf20L3OypznGEwgRXvaqXSNutn9T/izYes6a7Qm94JNTo5Cc+6JCj0gNBYDBVg7
	 0Sp6SXo1Jz4ixPRWLajhRnDVfIWejpOGJJYJLJtq0pMH+egkKJ9Hww5taCedhvBNdS
	 aiUshJQnWsqlOcUNarCKx1Mq6azb+Ks2tOqJ5QeA5k8KWbISsJpdB5WlF3/KpQDq9i
	 Ehxc6063iqBsj2bt4cDMQaR+nPXsu56M/M5/70AW8W4kJGp0CirR2uuOBlmZ80kJ9M
	 d7pct4/DVXlAD/Ux4iYpTRhtIPKVmumAIZTATYK7XT3ZygI/kqMFIXqHuwao6UZeV/
	 70Zz/xO0HsHYg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4lt16s2mz3bhc
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 21:13:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=wangshuo16@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Wed, 03 Jan 2024 21:13:20 AEDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4lsr4fsXz30f5
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 21:13:20 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208,217";a="100470309"
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Request for Assistance: Decompressing EROFS Image without Mounting
Thread-Topic: Request for Assistance: Decompressing EROFS Image without
 Mounting
Thread-Index: AQHaPi0Wruvt67JPQ0WM1jFiaZyTSQ==
Date: Wed, 3 Jan 2024 10:12:10 +0000
Message-ID: <e751bfc68f524227ad8ad98faa8102af@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.20]
Content-Type: multipart/alternative;
	boundary="_000_e751bfc68f524227ad8ad98faa8102afxiaomicom_"
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

--_000_e751bfc68f524227ad8ad98faa8102afxiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBkZXZlbG9lcnMsDQoNCg0KSSBob3BlIHRoaXMgZW1haWwgZmluZHMgeW91IHdlbGwuIE15
IG5hbWUgaXMgd2FuZyBzaHVvLCBhbmQgSSBhbSByZWFjaGluZyBvdXQgdG8gc2VlayB5b3VyIGV4
cGVydGlzZSByZWdhcmRpbmcgZGVjb21wcmVzc2luZyBhbiBFUk9GUyAoRW5oYW5jZWQgUmVhZC1P
bmx5IEZpbGUgU3lzdGVtKSBpbWFnZSB3aXRob3V0IHRoZSBuZWVkIGZvciBtb3VudGluZy4gSSBo
YXZlIGNvbWUgYWNyb3NzIGEgdW5pcXVlIHNpdHVhdGlvbiB3aGVyZSBJIGRvIG5vdCBoYXZlIHBl
cm1pc3Npb24gdG8gY3JlYXRlIGEgbG9vcCBkZXZpY2UgZm9yIG1vdW50aW5nIHRoZSBpbWFnZSwg
YW5kIEkgYW0gZXhwbG9yaW5nIGFsdGVybmF0aXZlIG1ldGhvZHMgdG8gYWNjZXNzIGl0cyBjb250
ZW50Lg0KDQoNCkkgdW5kZXJzdGFuZCB0aGF0IHRoZSB0eXBpY2FsIGFwcHJvYWNoIGludm9sdmVz
IG1vdW50aW5nIHRoZSBFUk9GUyBpbWFnZSB0byBvYnRhaW4gaXRzIGNvbnRlbnRzLiBIb3dldmVy
LCBkdWUgdG8gc3BlY2lmaWMgY29uc3RyYWludHMgaW4gbXkgZW52aXJvbm1lbnQsIHRoaXMgYXBw
cm9hY2ggaXMgbm90IGZlYXNpYmxlIGZvciBtZS4gVGhlcmVmb3JlLCBJIGFtIHJlYWNoaW5nIG91
dCB0byB5b3UgdG8gaW5xdWlyZSBpZiB0aGVyZSBhcmUgYWx0ZXJuYXRpdmUgbWV0aG9kcyBvciB0
b29scyBhdmFpbGFibGUgdGhhdCB3b3VsZCBhbGxvdyBtZSB0byBkZWNvbXByZXNzIHRoZSBFUk9G
UyBpbWFnZSBkaXJlY3RseSB3aXRob3V0IHRoZSBuZWNlc3NpdHkgb2YgbW91bnRpbmcgaXQuDQoN
Cg0KWW91ciBleHBlcnRpc2UgaW4gdGhpcyBhcmVhIHdvdWxkIGJlIGltbWVuc2VseSB2YWx1YWJs
ZSwgYW5kIGFueSBndWlkYW5jZSBvciByZWNvbW1lbmRhdGlvbnMgeW91IGNhbiBwcm92aWRlIHdp
bGwgYmUgaGlnaGx5IGFwcHJlY2lhdGVkLiBJZiB0aGVyZSBhcmUgc3BlY2lmaWMgdG9vbHMsIHNj
cmlwdHMsIG9yIHRlY2huaXF1ZXMgdGhhdCB5b3UgY291bGQgc3VnZ2VzdCwgaXQgd291bGQgZ3Jl
YXRseSBhc3Npc3QgbWUgaW4gb3ZlcmNvbWluZyB0aGUgY2hhbGxlbmdlcyBJIGN1cnJlbnRseSBm
YWNlLg0KDQoNCkkgYW0gZ3JhdGVmdWwgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbiBp
biB0aGlzIG1hdHRlci4gVGhhbmsgeW91IGZvciB5b3VyIGRlZGljYXRpb24gdG8gdGhlIGRldmVs
b3BlciBjb21tdW5pdHksIGFuZCBJIGxvb2sgZm9yd2FyZCB0byBoZWFyaW5nIGZyb20geW91IHNv
b24uDQoNCg0KQmVzdCByZWdhcmRzLA0KDQoNCndhbmcgc2h1bw0KDQp3YW5nc2h1bzE2QHhpYW9t
aS5jb20NCg0KIy8qKioqKiqxvtPKvP68sMbkuL28/rqs09DQocPXuavLvrXEsaPD3NDFz6KjrL32
z97T2reiy824+MnPw+a12Na31tDB0LP2tcS49sjLu/LIutfpoaO9+9a5yM66zsbky/vIy9LUyM66
ztDOyr3KudPDo6iw/MCotauyu8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4tNbGoaK78smit6KjqbG+
08q8/tbQtcTQxc+ioaPI57n7xPq07crVwcuxvtPKvP6jrMfrxPrBory0tee7sLvy08q8/s2o1qq3
orz+yMuyosm+s/2xvtPKvP6joSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRh
aW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRl
ZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBh
Ym92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkg
d2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNj
bG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIg
dGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNl
aXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhv
bmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K

--_000_e751bfc68f524227ad8ad98faa8102afxiaomicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><font color=3D"#1c2127" face=3D"-apple-system, BlinkMacSystemFont, Segoe=
 UI, Roboto, Oxygen, Ubuntu, Cantarell, Open Sans, Helvetica Neue, blueprin=
t-icons-16, sans-serif"><span style=3D"font-size: 14px;"></p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
Dear develoers,</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
I hope this email finds you well. My name is wang&nbsp;shuo, and I am reach=
ing out to seek your expertise regarding decompressing an EROFS (Enhanced R=
ead-Only File System) image without the need for mounting. I have come acro=
ss a unique situation where I do not
 have permission to create a loop device for mounting the image, and I am e=
xploring alternative methods to access its content.</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
I understand that the typical approach involves mounting the EROFS image to=
 obtain its contents. However, due to specific constraints in my environmen=
t, this approach is not feasible for me. Therefore, I am reaching out to yo=
u to inquire if there are alternative
 methods or tools available that would allow me to decompress the EROFS ima=
ge directly without the necessity of mounting it.</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
Your expertise in this area would be immensely valuable, and any guidance o=
r recommendations you can provide will be highly appreciated. If there are =
specific tools, scripts, or techniques that you could suggest, it would gre=
atly assist me in overcoming the
 challenges I currently face.</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
I am grateful for your time and consideration in this matter. Thank you for=
 your dedication to the developer community, and I look forward to hearing =
from you soon.</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
Best regards,</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
<br>
</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
wang&nbsp;shuo</p>
<p style=3D"border: 0px solid rgb(217, 217, 227); box-sizing: border-box; -=
-tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --t=
w-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scal=
e-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --t=
w-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gr=
adient-via-position: ; --tw-gradient-to-">
wangshuo16@xiaomi.com</p>
</span></font>
<p></p>
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

--_000_e751bfc68f524227ad8ad98faa8102afxiaomicom_--
