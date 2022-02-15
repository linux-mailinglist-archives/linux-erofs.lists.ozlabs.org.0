Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DA4B61D6
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Feb 2022 04:46:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JyRq32lbzz3cBq
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Feb 2022 14:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=aS2jgeuM;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=Ww4jJPSl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bounces.elasticemail.net (client-ip=96.45.68.78;
 helo=f78.mxout.mta4.net;
 envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=bounces.elasticemail.net
 header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api
 header.b=aS2jgeuM; dkim=pass (1024-bit key;
 unprotected) header.d=elasticemail.com header.i=@elasticemail.com
 header.a=rsa-sha256 header.s=api header.b=Ww4jJPSl; 
 dkim-atps=neutral
X-Greylist: delayed 83 seconds by postgrey-1.36 at boromir;
 Tue, 15 Feb 2022 14:46:51 AEDT
Received: from f78.mxout.mta4.net (f78.mxout.mta4.net [96.45.68.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JyRpz3WSRz2x9L
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Feb 2022 14:46:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
 c=relaxed/simple; t=1644896559;
 h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
 bh=LDZFQRdQDCIDHKzZTAhqYcIYX/ivX+InN+0W9+jWxGY=;
 b=aS2jgeuMACstAcwzgODRz1itRDfawlEQmPH+1LSKqfLbtNkZwHfpRVtyJw/1GLCciODX45mo8Z6
 wnMnWGlBpgi2YO4B8RiPQV9iD7bhDVjudYMMC5SP4dlJprP5Ku46M1Smz6NbltK9E8UVpUfuOsF6h
 nMX28q0UFfIKdhvfQg8=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
 c=relaxed/simple; t=1644896559;
 h=from:date:subject:reply-to:to:list-unsubscribe;
 bh=LDZFQRdQDCIDHKzZTAhqYcIYX/ivX+InN+0W9+jWxGY=;
 b=Ww4jJPSlfec/CCOcveAbbHkt3yx037T7EqcGkMXwVASODzYj249AJpJPCAmDBIwsjLHDSSu/h1+
 0wB7uSTD2rG/5HdzaAjee9XPdO7EjDK+c5spweHFBH4dAaUhE+R8V0RK8b79BdEiqQR4yoOwiPYln
 qE5S5CXte83C8XJMEow=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Tue, 15 Feb 2022 03:42:39 +0000
Subject: INVITATION TO ATTEND A WORKSHOP ON STRATEGIC LEADERSHIP AND STRATEGIC
 MANAGEMENT FOR EXECUTIVES PROGRAM APRIL 4TH-15TH 2022
Message-Id: <4ug2z9jawlxn.yC3ozCfZXJYJR6AOqAm4FQ2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: yC3ozCfZXJYJR6AOqAm4FQ2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=-eZCfHUGG8T/vIf2mQPAFW3/g/RVD2KoD/XWKzQ=="
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
Reply-To: workshops@skillsforafrica.or.ke
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfHUGG8T/vIf2mQPAFW3/g/RVD2KoD/XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9UFMyUVcxalliTHNaQnVXNmp1Zlk1enFibTk0MVZpZVRKSzNyMmFxcXNOSG5hcnBlTjlX
RjJiOFJwWUVkNUVlOVJLZmdhcUtPOWRFQzcyYzUtc1FoNHdUdG04Y0VtZnpDN1FUV25ia3Fx
NGZqaGdiZFczR0pwN2EwOTNWS0xCSVllR1BFQXB4dndRNkRZcXlRRXpib2x6QTE+DQpTVFJB
VEVHSUMgTEVBREVSU0hJUCBBTkQgU1RSQVRFR0lDIE1BTkFHRU1FTlQgRk9SIEVYRUNVVElW
RVMgDQpQUk9HUkFNIEFQUklMIDRUSC0xNVRIIDIwMjINCg0KPGh0dHBzOi8vMTMzSUsudHJr
LmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1JX0lHSk05S0tCTUZhemxmZ1Ju
UFlGMGhQMVZJZ1gyYldiUVc3V1pYTk5yQ2NxZ1NrWkRsNUp2ajhYOENvZEhoSjBmckFWNWpK
RC1xeGw4ZGhERHIzazdTRGNyTUFqdFpnNjFwaEdJMkxpaXVxWUMyNzdDQy1mc2xtR2pnejBs
SHFWNmx5SHktNThWM3paNmNObWVDV1FtVE94WTZqTU9nY28tVTV0V0sxMThVMD4NClJlZ2lz
dGVyIGZvciBvbmxpbmUgd29ya3Nob3AgDQphdHRlbmRhbmNlIA0KwqANCg0KPGh0dHBzOi8v
MTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1JX0lHSk05S0tC
TUZhemxmZ1JuUFlGMGhQMVZJZ1gyYldiUVc3V1pYTk5xaHRUMFJLMDV1SFB2OGRFZlJHLUJX
RWFjYlYtTlJQM3ZaLTFsMHlYWVhlS1BPaS1kQV9jQTBfOFJOMjFaWHkwNXVpbUxHUzBlajE5
X3Y4ZEtCRUNfa3NtazN4U2FpZmRLV3lFekM1eW5SVmtwNHRBU24yd1JjYldTSkw0TndOcExM
MD4NClJlZ2lzdGVyIHRvIGF0dGVuZCB0aGUgDQp3b3Jrc2hvcA0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPUlfSUdKTTlLS0JNRmF6
bGZnUm5QWUYwaFAxVklnWDJiV2JRVzdXWlhOTnFodFQwUkswNXVIUHY4ZEVmUkctQldFYWNi
Vi1OUlAzdlotMWwweVhZWGVEQ1Yyd1RLMWRoRnNKZzlBYjcxY0NhYUVqZDk3emdEcTMxNk9x
aVZkZXBwQ3NBOXQ0SnFWeGdnRWlua19xNDJ2SUFXcmZwRmVQakVYOGc4a3pyWkNtcjMwPg0K
wqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xp
Y2s/ZD1QUzJRVzFqWWJMc1pCdVc2anVmWTV6cWJtOTQxVmllVEpLM3IyYXFxc05FRmU2Zjd2
MFg4cFZTalFtRDhIRmxRTUQ4aVFCOVNRMm1uY3A5czJ6RmlObV9wQUdveHdzb2JxSXg5cmJh
elNrd2wxZ2E0b3NTRkJrRThPM1E4bk04U1c3Y203d0xiSElwV2FkQnNVR2I0ZEw4MT4NCkNh
bGVuZGFyIGZvciAyMDIyIA0KV29ya3Nob3BzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsu
ZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVBTMlFXMWpZYkxzWkJ1VzZqdWZZ
NXpxYm05NDFWaWVUSkszcjJhcXFzTkhkZ3B2RW95Rm5oblJWQjBLbTlqdGZEMzR5SWFrZkVW
bFh4TEpwVDB6eDdVTTk2WGdJVUVVb3hfNGxDbEM5bkZzd3pJUlFReDI2aWtZaUlEbC1WVkFJ
YVBhenhnalVWWjNxYXU5UFRoRi12LVExPg0KQ29udGFjdCANCnVzDQrCoA0KDQo8aHR0cHM6
Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVJBbnlmOExY
MmZBaG1ldVJQSkRsREE1OGd6cHRFdmJZZmlIZ1diSjRXeVB0MEJkMWdab3ZxSmxpalVaSFAz
elQ0VzREZ0JUaTdFMXVfYS01SlFMZ1lxMXF0RkZfRXJ4OXNBcmJMVFhRUE1rVVV1OWZtbVRs
cEZQdmRzam5sODBwR3V4SkRjV2FGbzZUSzVYUHVlVVlTNlUxPg0KV2hhdGFwcA0KwqANClZF
TlVFOiBISUxJVE9OIEhPVEVMLCBOQUlST0JJLCANCktFTllBDQpPZmZpY2UgVGVsZXBob25l
OiArMjU0LTcwMi0yNDktNDQ5DQpSZWdpc3RlciBhcyBhIGdyb3VwIG9mIDUgb3IgbW9yZSBw
YXJ0aWNpcGFudHMgYW5kIGdldCAyNSUgZGlzY291bnQgDQpvbiB0aGUgY291cnNlIGZlZS4g
DQpTZW5kIHVzIGFuIGVtYWlsOiANCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwu
Y29tL3RyYWNraW5nL2NsaWNrP2Q9S0NGYjVLaHprbF9VNGR4V0hpNlc4Z3RDZHhSWmVndmhk
dC1hOFBkTEVxcU9ZWjZIaHJ3Y3dOdVBDU2dGeHJOd2hKQUFQb0JGWFVEZmk0MG1CTUV6VUJy
YVlOTFV2UHptVWNKNlZWZV9LdV9zZ1VXdzBVQmszbVh6SzM4bHlmVndyY29ZWDhWdmJUdjV0
VUFGTUJ4R3pySTRtbXJyaTVGQ3pvbWtQUHJEaFd5Ylc4aHkyLTEtbkxOTmxscFNNWWZvUlRH
MTZSdXVEOHM3MGY0ZFluNy1Ga2sxPg0KdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZ8Kg
b3IgY2FsbCArMjU0LTcwMi0yNDktNDQ5DQrCoA0KSU5UUk9EVUNUSU9ODQpTdWNjZXNzIG9y
IGZhaWx1cmUgaW4gYnVzaW5lc3MgaXMgZGVjaWRlZCBieSBzdHJhdGVneSwgdGhlIGFiaWxp
dHkgDQp0byBpbXBsZW1lbnQgaXQgYW5kIGxlYWRlcnNoaXAgcXVhbGl0aWVzLiBTdHJhdGVn
aWMgZGVjaXNpb25zIGFsd2F5cyBhaW0gdG8gDQpzZWN1cmUgdGhlIGxvbmdlci10ZXJtLCBm
dXR1cmUgdmlhYmlsaXR5IG9mIGEgY29tcGFueSBvciBjb21wYW55IGFyZWEuIFRoZXkgc2hv
dyANCnRoZSB3YXkgZm9yd2FyZCwgYW5kIGluIGRvaW5nIHNvIG11c3QgYmUgZmxleGlibGUg
ZW5vdWdoIHRvIGFsbG93IGFkYXB0YXRpb24gdG8gDQpjaGFuZ2luZyBjb25kaXRpb25zLiBJ
biBhZGRpdGlvbiwgdGhleSBkZWZpbmUgdGhlIHJvYWRtYXAgb24gd2hpY2ggYSBjb21wYW55
IA0KbXVzdCB0cmF2ZWwgdG8gYWNoaWV2ZSBpdHMgb2JqZWN0aXZlcy4gSWYgdGhlIHN0cmF0
ZWd5IGlzIHVuY2xlYXIsIG9yIHRoZSANCnJvYWRtYXAgbm90IHByYWN0aWNhbCwgc3VjY2Vz
cyBpcyBub3QgYWNoaWV2YWJsZSDigJMgYW5kIHRoZSByZXN1bHQgaXMgb2Z0ZW4gDQpvcGVy
YXRpdmUgYWN0aXZpdGllcyB3aGVyZSB0aGUgY29tcGFueSBhcyBhIHdob2xlIHN0YWxscyBv
ciBnb2VzIGluIGNpcmNsZXMuIA0KU3RyYXRlZ3kgZXhwZXJ0aXNlIGF0IGV4ZWN1dGl2ZSBs
ZXZlbCwgdGhlcmVmb3JlLCBkZXRlcm1pbmVzIHdoZXRoZXIgY29tbWl0bWVudCANCnRvIHRo
ZSBkYWlseSBidXNpbmVzcyBpcyByZXdhcmRlZCB3aXRoIGdvb2QgcmVzdWx0cyDigJMgcmVz
dWx0cyB0aGF0IHRoZSBjb21wYW55IA0KaXMgcHJvdWQgb2YgYW5kIHRoYXQgbW90aXZhdGVz
IHN0YWZmIHRvIGZ1cnRoZXIgdG9wIHBlcmZvcm1hbmNlLiBOb25ldGhlbGVzcywgDQpldmVu
IHRoZSBiZXN0IHN0cmF0ZWd5IGFuZCB0aGUgbW9zdCBpbnRlbGxpZ2VudCBndWlkZWxpbmVz
IHdvbuKAmXQgaGVscCBpZiANCm1pc3Rha2VzIGFyZSBtYWRlIGR1cmluZyBpbXBsZW1lbnRh
dGlvbi4gVGhhdOKAmXMgd2h5IGdvb2Qgc3RyYXRlZ2llcyBhcmUgYWx3YXlzIA0KbWFkZSBi
eSBsZWFkZXJzIHdpdGggYSBzb2xpZCBsZWFkZXJzaGlwIHNraWxsLiBXaGV0aGVyLCBhbmQg
dG8gd2hhdCBkZWdyZWUsIA0KdGhlaXIgc3RhZmYgaXMgbW90aXZhdGVkIHRvIGFjaGlldmUg
c3RyYXRlZ2ljIG9iamVjdGl2ZXMgZGVwZW5kcyBvbiBob3cgdGhleSANCmNvbmR1Y3QgdGhl
bXNlbHZlcyBhcyBsZWFkZXJzLiBDbGVhciBvYmplY3RpdmVzLCBzZW5zaWJsZSBndWlkZWxp
bmVzIGFuZCB0aGUgDQpyaWdodCBtYW5hZ2VtZW50IGNvbmR1Y3QgY3JlYXRlcyB0aGUgZnJl
ZWRvbSBhIGNvbXBhbnkgbmVlZHMgZm9yIGNvbnRyb2xsZWQgDQplbnRyZXByZW5ldXJzaGlw
LiBUaGlzIGluIHR1cm4gY3JlYXRlcyB0aGUgcHJlcmVxdWlzaXRlcyBmb3Igc3VzdGFpbmFi
bGUgdG9wIA0KcGVyZm9ybWFuY2UgYW5kIGZpcnN0LWNsYXNzIHJlc3VsdHMgdGhhdCB3aWxs
IHNlY3VyZSB0aGUgZnV0dXJlIG9mIHlvdXIgDQpjb21wYW55Lg0KU3RyYXRlZ2ljIA0KTWFu
YWdlbWVudCBmb3IgRXhlY3V0aXZlczogVGhlIA0Kc3VjY2VzcyBvZiBhIGNvbXBhbnkgYW5k
IGl0cyBidXNpbmVzcyB1bml0cyBkZXBlbmRzIG9uIGEgZmV3IHN0cmF0ZWdpYyANCmRlY2lz
aW9ucy4gVGhpcyBwcm9ncmFtIG9mZmVycyB5b3UgdGhlIGxhdGVzdCBrbm93bGVkZ2UgYW5k
IGFuIGludGVncmF0ZWQgDQphcHByb2FjaCB0byBzdHJhdGVnaWMgbWFuYWdlbWVudC4gWW91
IHdpbGwgbGVhcm4gZnJvbSBtYW55IHJlYWwtd29ybGQgZXhhbXBsZXMsIA0KaGF2ZSBhbiBl
eGNoYW5nZSBvZiBleHBlcmllbmNlcywgZ2V0IG5ldyBpZGVhcywgYW5kIGxlYXJuIHRoZSB0
b29scyB5b3UgbmVlZCBmb3IgDQpzdWNjZXNzZnVsIHN0cmF0ZWdpYyBtYW5hZ2VtZW50Lg0K
U3RyYXRlZ3kgDQrigJMgYW5kIA0Kbm90IGVmZm9ydCBhbmQgZGlsaWdlbmNlIGluIHRoZSBk
YWlseSBidXNpbmVzcyDigJMgZGV0ZXJtaW5lcyBzdWNjZXNzIG9yIGZhaWx1cmUgDQpvZiB5
b3VyIGNvbXBhbnksIHlvdXIgZGl2aXNpb24gb3IgdGhlIGJ1c2luZXNzIHVuaXQgeW91IGxl
YWQuIEluIHRoaXMgY291cnNlLCB3ZSANCnNob3cgeW91IHdoYXTigJlzIGltcG9ydGFudCBp
biBuYXZpZ2F0aW5nIGFuZCBkZXZlbG9waW5nIHN0cmF0ZWd5IGluIHRoZSBkaXJlY3Rpb24g
DQpvZiBzdWNjZXNzIGFuZCBzdXN0YWluYWJpbGl0eS4NCkhvdyANCnlvdSBiZW5lZml0DQpU
aGlzIGNvdXJzZSB3aWxsIGdpdmUgeW91IGRldGFpbGVkIGtub3dsZWRnZSBhYm91dCBzdHJh
dGVneSB3aXRoIA0KdGhlIGdvYWwgb2YgYmV0dGVyIHVuZGVyc3RhbmRpbmcgdGhlIHByaW5j
aXBsZXMsIHRvb2xzIGFuZCBtZXRob2RzIG9mIHN0cmF0ZWdpYyANCm1hbmFnZW1lbnQgYW5k
IHN0cmF0ZWd5IGRldmVsb3BtZW50IGFuZCBob3cgdGhleSBpbnRlcnJlbGF0ZSB0byB0aGUg
d2hvbGUuIFlvdSANCndpbGwgcmVjZWl2ZSB0aGUgbGF0ZXN0IGtub3ctaG93IGFib3V0IGRl
dmVsb3BpbmcgaW5ub3ZhdGl2ZSwgY29tcGV0aXRpdmUgDQpzdHJhdGVnaWVzLiBZb3Ugd2ls
bCBsZWFybiBob3cgdG8gcG9zaXRpb24geW91ciBidXNpbmVzcyBpbiBhIGNvbXBldGl0aXZl
IA0KZW52aXJvbm1lbnQgYW5kIGhvdyB0byBsYXVuY2ggcHJvZ3JhbXMgdGhhdCB3aWxsIG9w
dGltaXplIHlvdXIgY29tcGFueeKAmXMgdmFsdWUsIA0KcHJvZml0YWJpbGl0eSBhbmQgcGVy
Zm9ybWFuY2UuIFlvdSB3aWxsIGNyaXRpY2FsbHkgYW5hbHl6ZSB5b3VyIG93biBzdHJhdGVn
aWMgDQpjb25jZXB0cyBhbmQgd2lsbCByZXR1cm4gdG8geW91IGpvYiByZWFkeSB0byBnaXZl
IG5ldyBpbXBldHVzIHRvIGNyZWF0aW5nIGFuIA0KaW5ub3ZhdGl2ZSBmdXR1cmUgZm9yIHlv
dXIgY29tcGFueS4gTWV0aG9kcywgY29uY2VwdHMsIGluc3RydW1lbnRzIGFuZCBlZmZlY3Rp
dmUgDQp0b29scyB0byBndWlkaW5nIHlvdXIgY29tcGFueSBhcmUgZXhwbGFpbmVkIHVzaW5n
IG51bWVyb3VzIA0KZXhhbXBsZXMuDQpXaG8gDQpzaG91bGQgYXR0ZW5kDQpFeGVjdXRpdmVz
IA0KYW5kIGV4cGVyaWVuY2VkIG1hbmFnZXJzLCB3aG8gd2FudCB0byBkZWVwZW4gdGhlaXIg
a25vd2xlZGdlIG9mIGhvdyB0byBlbnN1cmUgDQpmdXR1cmUgY29tcGFueSBzdWNjZXNzLCBs
ZWFybiB0aGUgbGF0ZXN0IHByaW5jaXBsZXMgYmVoaW5kIHN0cmF0ZWdpYyBtYW5hZ2VtZW50
IA0KYW5kIGVmZmVjdGl2ZSBsZWFkZXJzaGlwLiBUaGVzZSBpbmNsdWRlOkdlbmVyYWwgDQpt
YW5hZ2VycywgaGVhZHMgb2YgYnVzaW5lc3MgdW5pdHMgYW5kIHByb2ZpdCBjZW50ZXJzLCAN
CkMtbGV2ZWwgDQpleGVjdXRpdmVzLCANCkhlYWRzIA0Kb2YgbGFyZ2VyIGRpdmlzaW9ucyBh
bmQgZGVwYXJ0bWVudHMsIA0KTWVtYmVycyANCm9mIHRoZSBtYW5hZ2VtZW50IGJvYXJkIGFu
ZCBib2FyZCBvZiBkaXJlY3RvcnMsIA0KVGhvc2UgDQpyZXNwb25zaWJsZSBmb3IgYnVzaW5l
c3MgdW5pdHMsIHN1YnNpZGlhcmllcyBhbmQgaW1wb3J0YW50IHByb2plY3RzLCANCk1hbmFn
ZXJzIA0Kd2hvIGFyZSBzb29uIHRvIG1vdmUgdXAgdG8gYSBDRU8gb3IgZXhlY3V0aXZlcG9z
aXRpb24sIA0KRGVjaXNpb24tbWFrZXJzIA0KZnJvbSBtYW5hZ2VtZW50IGJvYXJkcywgYm9h
cmQgbWVtYmVycywgbWVtYmVycyBvZiBzdXBlcnZpc29yeSBib2FyZHMsIA0KTWlkLWxldmVs
IA0KdG8gc2VuaW9yLWxldmVsIGV4ZWN1dGl2ZXMgcmVzcG9uc2libGUgZm9yIHN0cmF0ZWdp
YyBwbGFubmluZywgaW1wbGVtZW50YXRpb24sIA0KYW5kIGJ1c2luZXNzIGRldmVsb3BtZW50
LCANCkV4ZWN1dGl2ZXMgDQp3aG8gdGVzdCBzdHJhdGVneSBwcm9wb3NhbHMgZm9yIHRoZWly
IHBsYXVzaWJpbGl0eSwgDQpFeGVjdXRpdmVzIA0Kb2YgY29tcGFuaWVzLCBkaXZpc2lvbnMg
b3IgYnVzaW5lc3MgdW5pdHMgaW4gY2hhcmdlIG9mIGltcGxlbWVudGluZyANCnN0cmF0ZWdp
ZXMsIA0KRXhlY3V0aXZlcywgDQptYW5hZ2VycywgY29uc3VsdGFudHMgYW5kIHNwZWNpYWxp
c3RzIHdobyBjb25kdWN0IHN0cmF0ZWdpYyBhbmFseXNpcywgbGVhZCANCnN0cmF0ZWd5IG1l
ZXRpbmdzIG9yIGRyYWZ0IHN0cmF0ZWdpYyBjb25jZXB0cw0KRFVSQVRJT04NCjEwIERheXMN
CkNPVVJTRSANCkNPTlRFTlQNClN0cmF0ZWdpYyANCk1hbmFnZW1lbnQgYXMgTmF2aWdhdGlv
biBUb29sIGZvciB0aGUgRnV0dXJlDQpFeGVjdXRpdmVzIG11c3Qgc3RlZXIgYSBjb21wYW55
IGR1cmluZyB0dXJidWxlbnQgdGltZXMgYXMgd2VsbC4gDQpTdWNjZXNzIGNhbiBiZSBkZWZp
bmVkIGluIG1hbnkgd2F5cyDigJMgYnkgY29ycG9yYXRlIHZhbHVlLCBjYXNoIGZsb3csIHNo
YXJlaG9sZGVyIA0KdmFsdWUsIHByb2ZpdGFiaWxpdHksIGN1c3RvbWVyIHZhbHVlLCBtYXJr
ZXQgc2hhcmUsIGN1c3RvbWVyIHNhdGlzZmFjdGlvbiwgDQpwZXJmb3JtYW5jZSBjdWx0dXJl
IGFuZCB0cnVzdC4gU3VjY2Vzc2Z1bCBzdHJhdGVnaWMgbWFuYWdlbWVudCBzZWVrcyB0byBz
ZWN1cmUgYSANCmJhbGFuY2UgYmV0d2VlbiBzaG9ydC10ZXJtIHJlc3VsdHMtb3B0aW1pemF0
aW9uIGFuZCBsb25nLXRlcm0gc3VjY2Vzcy4gVGhlIG1haW4gDQpmb2N1cyBpcyBwcmltYXJp
bHkgdGhpcyDigJMgc3VzdGFpbmFibGUgcHJvZml0YWJpbGl0eSB0aGFua3MgdG8gaGlnaCBj
dXN0b21lciANCnZhbHVlLg0KVmlhYmlsaXR5IGFuZCBhY2hpZXZpbmcgaGVhbHRoeSBwcm9m
aXQgDQogIGRldmVsb3BtZW50DQpIb3cgZG8geW91IGV4ZWN1dGUgYSBzdHJhdGVneSANCiAg
cHJvY2Vzcz8NCkhhbmRsaW5nIGNvbXBsZXhpdHkgYXMgYSBwcmFjdGljYWwgdGVzdCBmb3Ig
c3VjY2Vzc2Z1bCANCiAgbWFuYWdlbWVudA0KSG93IGdsb2JhbGl6YXRpb24gYW5kIGRpZ2l0
YWxpemF0aW9uIGFyZSBpbmZsdWVuY2luZyBzdHJhdGVneSBhbmQgDQogIG1hbmFnZW1lbnQN
ClN0cmF0ZWdpYyANCk9iamVjdGl2ZXMgYW5kIERpcmVjdGlvbnMNCk5vIHN0cmF0ZWd5IHdp
dGhvdXQgb2JqZWN0aXZlcyBvciBzdHJhdGVnaWMgZ3VpZGVsaW5lcy4gQXMgDQppbnRlcmZh
Y2UgYmV0d2VlbiBpZGVhbCByZXN1bHRzIGFuZCBmZWFzaWJpbGl0eSwgc3RyYXRlZ2ljIGd1
aWRlbGluZXMgZGVmaW5lIHRoZSANCnN0cmF0ZWdpYyBjb3JyaWRvciB0aHJvdWdoIHdoaWNo
IGNvbXBhbnkgZGV2ZWxvcG1lbnQgc2hvdWxkIHRha2UgcGxhY2UuIEhlcmUgeW91IA0KbmVl
ZCB0byBwYXZlIHRoZSB3YXkgYW5kIGFjdGl2ZWx5IHNoYXBlIHRoZSBmdXR1cmUuDQpJbnZl
bnRpbmcgdGhlIGZ1dHVyZSDigJMgdGhlIGltcG9ydGFuY2Ugb2YgdmlzaW9uIGluIHRoZSBz
dHJhdGVnaWMgDQogIG1hbmFnZW1lbnQgcHJvY2Vzcw0KSG93IGRvIHlvdSB0dXJuIHlvdXIg
dmlzaW9uIGludG8gYSBjb25jcmV0ZSANCiAgc3RyYXRlZ3k/DQpIb3cgdG8gZGVyaXZlIG1v
dGl2YXRpbmcgZ29hbHMgZnJvbSB5b3VyIA0KICB2aXNpb24NCsKgDQpNb2Rlcm4gU3RyYXRl
Z3kgVG9vbHMgZm9yIFVuZGVyc3RhbmRpbmcgeW91ciBTdHJhdGVnaWMgDQpTaXR1YXRpb24N
ClN0cmF0ZWdpYyBkZWNpc2lvbnMgYXJlIG1hZGUgYmFzZWQgb24gYW5hbHlzZXMsIHN0dWRp
ZXMgYW5kIA0KYXNzZXNzbWVudHMuIElmIHRoZXNlIGFyZSB3cm9uZywgb3Igd3JvbmdseSBp
bnRlcnByZXRlZCwgdGhlbiBieSBuZWNlc3NpdHkgdGhlIA0KZGVjaXNpb25zIG1hZGUgZnJv
bSB0aGVtIGFyZSBhbHNvIHdyb25nLiBUaGF04oCZcyB3aHkgYSBjb21wZXRlbnQgdXNlIG9m
IHN0cmF0ZWdpYyANCm1hbmFnZW1lbnQgdG9vbHMgaXMgc28gaW1wb3J0YW50LiBXZSB3aWxs
IHNob3cgeW91IGhvdyB0byB1c2UgdGhlc2UgdG9vbHMgYW5kIA0Kd2hhdCBwaXRmYWxscyB5
b3UgbmVlZCB0byBhdm9pZC4NCkluZm9ybWF0aW9uIGFzIGJhc2lzIGZvciBzdHJhdGVnaWMg
ZGVjaXNpb25zIOKAkyB3aGF04oCZcyByZWFsbHkgDQogIGltcG9ydGFudD8NCkEgbG9vayB0
byB0aGUgZnV0dXJlIOKAkyBhbHdheXMgYSBsb29rIGF0IG15IG93biBleHBlcnRpc2UgYW5k
IA0KICByZXNvdXJjZXMNCkFuYWx5c2lzIHRvb2xzIOKAkyB3aGF04oCZcyBvdXQgdGhlcmUs
IHdoYXTigJlzIG5ldywgYW5kIGhvdyBkbyBJIA0KICBlbXBsb3kgdGhlbSBleHBlcnRseT8N
CsKgDQpUaGUgDQpTcGVjdHJ1bSBvZiBTdHJhdGVnaWMgT3B0aW9ucw0KVGhlIHNwZWN0cnVt
IG9mIHBvc3NpYmxlIHN0cmF0ZWdpYyBvcHRpb25zIGlzIHdpZGUg4oCTIGRvIHdlIGV4cGFu
ZCwgDQpyZXRhaW4sIGRpZmZlcmVudGlhdGUsIHNwZWNpYWxpemUsIG1vdmUgaW50byBhIG5p
Y2hlLCB3b3JrIGZvciBjb3N0IGxlYWRlcnNoaXAsIA0KZW5oYW5jZSBvdXIgdmFsdWUtYWRk
ZWQgY2hhaW4sIGZvcm0gYWxsaWFuY2VzLCBjcmVhdGUgcGxhdGZvcm0gc3RyYXRlZ2llcywg
DQpwdXJjaGFzZSwgcHVyc3VlIGEgbWVyZ2VyLCBkaXNpbnZlc3QsIGZvY3VzIG9uIHZpcnR1
YWxpdHksIGludGVybmF0aW9uYWxpemUg4oCTIA0KY291bnRsZXNzIG9wdGlvbnMgYXJlIGF2
YWlsYWJsZSB0byB5b3UuIEVhY2ggb25lIG9mIHRoZW0gaXMgZGV0ZXJtaW5lZCBieSANCnNw
ZWNpZmljIHJ1bGVzIGFuZCBoYXZlIHRvIGJlIHdlbGwgdGhvdWdodC10aHJvdWdoLg0KU3Ry
YXRlZ2ljIHRoaW5raW5nIG1lYW5zIHRoaW5raW5nIGluIGFsdGVybmF0aXZlIA0KICBzY2Vu
YXJpb3MNClJlYWxpc3RpYyBlc3RpbWF0aW9uIG9mIHJpc2tzIGFuZCBpbnZlc3RtZW50IA0K
ICBuZWVkcw0KQnVzaW5lc3MgZGV2ZWxvcG1lbnQgYW5kIA0KICBpbm5vdmF0aW9uDQrCoA0K
U3RyYXRlZ2ljIA0KRGVjaXNpb25zDQpTdHJhdGVnaWMgZGVjaXNpb25zIGRldGVybWluZSB0
aGUgZGlyZWN0aW9uIGEgY29tcGFueSB3aWxsIGRldmVsb3AuIA0KVGhleSBzZXQgb2JqZWN0
aXZlcyBhbmQgcGF2ZSB0aGUgd2F5IGZvciBmdXR1cmUgDQpzdWNjZXNzLg0KV2hhdCBkaWZm
ZXJlbnRpYXRlcyBhIGdvb2QgZnJvbSBhIGJhZCANCiAgc3RyYXRlZ3k/DQpTdWNjZXNzZnVs
IHN0cmF0ZWd5IGRldmVsb3BtZW50DQpUaGUgZGVjaXNpb24tbWFraW5nIHByb2Nlc3MgYW5k
IHR5cGljYWwgDQogIHBpdGZhbGxzDQpQbGF1c2liaWxpdHkgY2hlY2tzDQrCoA0KU3RyYXRl
Z3kgDQpJbXBsZW1lbnRhdGlvbg0KVGhlIGxhcmdlciwgdGhlIG1vcmUgdW53aWVsZHkg4oCT
IHVuZm9ydHVuYXRlbHksIHRoaXMgaXMgdGhlIGNhc2UgDQp3aXRoIG51bWVyb3VzIGNvbXBh
bmllcy4gSG93ZXZlciwgbWFueSBzbWFsbGVyIG9yZ2FuaXphdGlvbnMgYWxzbyBzdHJ1Z2ds
ZSB0byANCmltcGxlbWVudCB3aGF0IGhhcyBiZWVuIGRlY2lkZWQgaW4gdGhlaXIgZXZlcnlk
YXkgYnVzaW5lc3MuIEhlcmUgbWFuYWdlbWVudCBpcyANCmNhbGxlZCB1cG9uLiBIb3cgY2Fu
IG5ldyBzdHJhdGVnaWVzLCBuZXcgY29uY2VwdHMgYW5kIG5ldyBpZGVhcyBhY3R1YWxseSBi
ZSANCnJlYWxpemVkPw0KSG93IGRvIHlvdSBjb252ZXJ0IHN0cmF0ZWdpZXMgc2tpbGxmdWxs
eSBpbnRvIGNvbmNyZXRlIA0KICBwcm9qZWN0cz8NClRoZSBtb3N0IGNvbW1vbiBtaXN0YWtl
cyBpbiBpbXBsZW1lbnRpbmcgDQogIHN0cmF0ZWd5DQrCoA0KTGVhZGVyc2hpcCANCmFuZCBS
ZXN1bHQtT3JpZW50YXRpb24NCkluc3BpcmluZyBvdGhlcnMgdG8gYWNoaWV2ZSBvYmplY3Rp
dmVzIGFzIGEgdGVhbS4gQ29tbXVuaWNhdGluZyANCnlvdXIgdmlzaW9uLCBkZXJpdmluZyBh
bWJpdGlvdXMgb2JqZWN0aXZlcyBmcm9tIGl0IGFuZCBlbnN1cmluZyB0aGF0IHRoZSBmaXJl
IG9mIA0KZW50aHVzaWFzbSBpbiB5b3VyIGRhaWx5IHdvcmsgZG9lcyBub3QgZ28gb3V0LiBH
aXZpbmcgbmV3IGltcHVsc2UuIENvbnZpbmNpbmcsIA0Kc3VwcG9ydGluZyBhbmQgaWYgbmVj
ZXNzYXJ5IGRvaW5nIGl0IHlvdXJzZWxmLiBUbyBiZSBhIG5vcm1hbCBwZXJzb24gYW5kIGEg
cm9sZSANCm1vZGVsLiBOZXZlciBsb3Npbmcgc2lnaHQgb2Ygd2hhdOKAmXMgaW1wb3J0YW50
IOKAkyByZXN1bHRzLiBXZSBzaG93IHlvdSBob3cgdG8gDQpzaGFycGVuIGFuZCBkZXZlbG9w
IHlvdXIgbGVhZGVyc2hpcCBza2lsbHMgZXZlbiANCmZ1cnRoZXIuDQpFZmZlY3RpdmUgbGVh
ZGVyc2hpcCDigJMgd2hhdCBkbyB5b3UgbmVlZCB0byBhY2hpZXZlIA0KICB0aGlzPw0KTW9k
ZXJuIGxlYWRlcnNoaXAgYXBwcm9hY2hlcyBhbmQgbGVhZGVyc2hpcCANCiAgc3R5bGVzDQpQ
ZXJmb3JtYW5jZSBhbmQgbW90aXZhdGlvbg0KVHJ1c3QgYXMgYW4gZWxlbWVudCBvZiBjb3Jw
b3JhdGUgDQogIGN1bHR1cmUNCsKgDQpDaGFuZ2UgDQphbmQgQ29tbXVuaWNhdGlvbg0KV2hl
biB5b3UgaGF2ZSB0byBpbXBsZW1lbnQgbmV3IHN0cmF0ZWdpZXMgYW5kIGNvbmNlcHRzLCB5
b3Ugd2lsbCANCnVzdWFsbHkgaGF2ZSB0byBjaGFuZ2UgdGhlIGF0dGl0dWRlcywgYmVoYXZp
b3IgYW5kIGhhYml0cyBvZiBlbXBsb3llZXMgYW5kIA0KY29sbGVhZ3Vlcy4gV2UgYWxsIGtu
b3cgdGhhdCB0aGlzIGlzIGEgZGlmZmljdWx0IHRhc2suIFN1Y2Nlc3NmdWwgY2hhbmdlIA0K
bWFuYWdlbWVudCBiZWdpbnMgd2l0aCB0aGUgcmlnaHQgbWFuYWdlbWVudCBjb25kdWN0IGFu
ZCB0YXJnZXRlZCBjb21tdW5pY2F0aW9uLiANClVzaW5nIG51bWVyb3VzIGV4YW1wbGVzLCB3
ZSB3aWxsIGRlbW9uc3RyYXRlIHdoYXQgeW91IG5lZWQgdG8gZG8gaW4gdGhlc2UgDQpzaXR1
YXRpb25zLg0KSG93IGRvIHlvdSBjb21tdW5pY2F0ZSANCiAgc3RyYXRlZ2llcz8NCkFnaWxp
dHkgYW5kIGRpZ2l0YWxpemF0aW9uIGF0IGV4ZWN1dGl2ZSANCiAgbGV2ZWwNClN1Y2Nlc3Nm
dWwgdHJhbnNmb3JtYXRpb24g4oCTIGFwcHJvYWNoZXMgYW5kIA0KICBtZXRob2RzDQrCoA0K
QW4gDQpJbnRlZ3JhdGVkIEFwcHJvYWNoIHRvIFN0cmF0ZWdpYyBNYW5hZ2VtZW50DQpPbmUg
c3RyYXRlZ3kgZmFkIHF1aWNrbHkgZm9sbG93cyBhbm90aGVyLiBPbmUgc3RyYXRlZ2ljIHBy
b2plY3QgDQpmb2xsb3dzIHRoZSBuZXh0IG9uZSwgd2hlbiB0aGUgZmlyc3QgcHJvamVjdCBo
YXMgcmVhbGx5IGp1c3Qgc3RhcnRlZCBhbmQgaXMgbm90IA0KY29tcGxldGVkIGJ5IGEgbG9u
ZyBzaG90LiBBcmVu4oCZdCB3ZSBkb2luZyB0b28gbXVjaCBvZiBhIGdvb2QgdGhpbmcgaGVy
ZT8gV2hhdCANCmFyZSDCq211c3QgaGF2ZXPCuyB3aGF0IGFyZSDCq25pY2UgdG8gaGF2ZXPC
uz8gV2hhdOKAmXMgaW1wb3J0YW50IGhlcmUgaXMgdGhlIHJpZ2h0IA0KZG9zYWdlIG9mIHRo
ZSBuZXcuIE1vZGVybiBtYW5hZ2VtZW50IHRoZW9yeSBhbmQgcmVhbC13b3JsZCBtYW5hZ2Vt
ZW50IGV4cGVyaWVuY2UgDQpvZmZlciBhIGxvdCBvZiBpbnNpZ2h0LiBJbiB0aGlzIHNlbWlu
YXIsIHdlIHdpbGwgc2hvdyB5b3Ugd2hhdCBoYXMgcHJvdmVuIGl0c2VsZiANCmluIHJlYWwg
YnVzaW5lc3Mgc2l0dWF0aW9ucy4NCkN1cnJlbnQgc3RyYXRlZ2ljIG1hbmFnZW1lbnQgY29u
Y2VwdHMgYW5kIA0KICB0b29scw0KU3RyYXRlZ2ljIHByaW5jaXBsZXMNCldoYXQgY2hhcmFj
dGVyaXplcyBnb29kIA0KICBzdHJhdGVnaWVzDQrCoA0KQ2xhcmlmeWluZyANCnlvdXIgU3Ry
YXRlZ2ljIFBvc2l0aW9uIGFuZCB0aGUgTmVlZCBmb3IgU3RyYXRlZ2ljIEFjdGlvbg0KQ2hh
bmdlIGlzIGEgZ2l2ZW4uIEl0IGZvcmNlcyBtYW5hZ2VtZW50IHRvIGNvbnN0YW50bHkgY2hl
Y2sgdGhlaXIgDQpzdHJhdGVnaWMgcG9zaXRpb24uIENoYW5nZXMgbmVlZCB0byBiZSBhbnRp
Y2lwYXRlZCBwcm9tcHRseSBhbmQgZGFuZ2VycyB0byB0aGUgDQpidXNpbmVzcyBoYXZlIHRv
IGJlIHJlY29nbml6ZWQuIER1cmluZyB0aGlzIHByb2Nlc3MsIG5ldyBvcHBvcnR1bml0aWVz
IHdpbGwgDQpiZWNvbWUgYXBwYXJlbnQgYW5kIHNob3VsZCBiZSBjYXBpdGFsaXplZCBvbi4g
VGhhdOKAmXMgd2h5IGl04oCZcyBpbXBvcnRhbnQgZm9yIHlvdSwgDQphcyBhIGRlY2lzaW9u
LW1ha2VyLCB0byByZWNvZ25pemUgdGhlIG5lZWQgZm9yIHN0cmF0ZWdpYyANCmFjdGlvbi4N
CkRldGVybWluaW5nIHlvdXIgY3VycmVudCBzdHJhdGVnaWMgDQogIHBvc2l0aW9uDQpVbmRl
cnN0YW5kaW5nIHN0cmF0ZWdpYyBjaGFsbGVuZ2VzIA0KICBjb3JyZWN0bHkNCkltcG9ydGFu
dCB0b29scyBmb3IgYW5hbHlzaXMNCsKgDQpUaGUgDQpSb2xlIHBsYXllZCBieSB0aGUgQnVz
aW5lc3MgTW9kZWwgaW4gU3RyYXRlZ2ljIE1hbmFnZW1lbnQNCllvdXIgYnVzaW5lc3MgbW9k
ZWwgZGVzY3JpYmVzIGhvdyB5b3VyIGNvbXBhbnkgd2lsbCBnZW5lcmF0ZSANCnByb2ZpdC4g
Q2FsY3VsYXRpbmcgcHJvZml0IGJhc2VkIG9uIGNvc3RzIHBsdXMgbWFyZ2luIGlzIGJhbmFs
LiBNb3JlIGludGVyZXN0aW5nIA0KaXMgdG8gbGluayBtYXJnaW5zIHRvIGNyZWF0ZWQgYmVu
ZWZpdHMuIENsYXNzaWMgYnVzaW5lc3MgY2FzZXMgb2Z0ZW4gb2JzY3VyZSB0aGUgDQpwcm9m
aXQgZHJpdmVycyBvZiBhIGJ1c2luZXNzIG1vZGVsLiBUaGlzIGNvdXJzZSB0ZWFjaGVzIHlv
dSBob3cgdG8gaWRlbnRpZnkgYW5kIA0KdXNlIHRoZSByZWxldmFudCBwcm9maXQgZHJpdmVy
cy4NClRoZSBhcmNoaXRlY3R1cmUgb2YgY3JlYXRpbmcgdmFsdWUsIHVuZGVyc3RhbmRpbmcg
eW91ciBwcm9maXQgDQogIGRyaXZlcnMNCkltcHJvdmluZyBvbiB5b3VyIGN1cnJlbnQgYnVz
aW5lc3MgbW9kZWwsIGRldmVsb3BpbmcgbmV3IGJ1c2luZXNzIA0KICBpZGVhcw0KSW5ub3Zh
dGl2ZSBhbmQgZGlnaXRhbCBidXNpbmVzcyANCiAgbW9kZWxzDQrCoA0KU3RyYXRlZ2ljIA0K
T3B0aW9ucyB0aGF0IFByb21pc2UgU3VjY2Vzcw0KRGVjYWRlcy1sb25nIG9ic2VydmF0aW9u
LCBkaXNjdXNzaW9ucyB3aXRoIHRob3VzYW5kcyBvZiANCmRlY2lzaW9uLW1ha2VycyBhbmQg
ZXZhbHVhdGluZyB0aGUgcmVsZXZhbnQgbGl0ZXJhdHVyZSBvbiB0aGUgc3ViamVjdCBzaG93
IHRoYXQgDQpjb21wYW5pZXMgb2Z0ZW4gaGF2ZSB0aGVpciBvd24gZmF2b3JpdGUgdHJpZWQg
YW5kIHRlc3RlZCBzdHJhdGVnaWVzLiBBIGhpZ2ggDQpwZXJjZW50YWdlIG9mIHRoZXNlIHN0
cmF0ZWdpZXMgYXJlIHRyYW5zZmVycmVkIGludG8gc3RyYXRlZ2ljIHByb2plY3RzIGFuZCB0
aGVuIA0KZm9ybXVsYXRlZCBpbnRvIHN0cmF0ZWdpYyBpbml0aWF0aXZlcy4gQnV0IHdlIGFs
c28gbGl2ZSBpbiB0aW1lcyBjaGFyYWN0ZXJpemVkIA0KYnkgZGlzcnVwdGlvbiwgZ2xvYmFs
aXphdGlvbiBhbmQgZGlnaXRhbGl6YXRpb24uIFdlIHdpbGwgaW50cm9kdWNlIHlvdSB0byAN
CnNldmVyYWwgc3RyYXRlZ2ljIG9wdGlvbnMgdGhhdCBwcm9taXNlIHN1Y2Nlc3MgZHVyaW5n
IHRoZSBzZW1pbmFyLCBhbG9uZyB3aXRoIA0KdGlwcyBmb3IgZXZlcnlkYXkgaW1wbGVtZW50
YXRpb24uIFdlIHdpbGwgc2hvdyB5b3UgdGhlIHRyYXBzIHlvdeKAmWxsIG5lZWQgdG8gDQph
dm9pZCB0byBzdWNjZXNzZnVsbHkgaW1wbGVtZW50IHlvdXIgc3RyYXRlZ3kuDQpTdHJhdGVn
aWMgb3B0aW9ucyDigJMgd2hhdCB3b3JrcyBhbmQgd2hhdCANCiAgZG9lc27igJl0Pw0KQ2xh
c3NpYyBjb21wZXRpdGl2ZSBzdHJhdGVnaWVzDQpHcm93dGggYmFzZWQgb24gY29yZSANCiAg
Y29tcGV0ZW5jaWVzDQpDdXN0b21lci1jZW50cmljIHN0cmF0ZWdpYyANCiAgYXBwcm9hY2hl
cw0KRXZhbHVhdGluZyBzdHJhdGVnaWMgb3B0aW9ucyBhY2NvcmRpbmcgdG8gdGhlaXIgcG90
ZW50aWFsIGZvciANCiAgc3VjY2VzcyBhbmQgdGhlaXIgY2hhbmNlcyBvZiBiZWluZyANCnJl
YWxpemVkDQrCoA0KRWZmZWN0aXZlIA0KU3RyYXRlZ3kgRGV2ZWxvcG1lbnQgUHJvY2Vzc2Vz
DQpTdHJhdGVnaWMgcHJvamVjdHMgb2Z0ZW4gY29tZSB0byBub3RoaW5nIGJlY2F1c2UgYSBz
ZW5zaWJsZSB3YXkgdG8gDQpwcm9jZWVkIGlzIG1pc3NpbmcuIFRoYXTigJlzIHdoeSBtYW55
IGNvbXBhbmllcyBsZXQgdGhlaXIgc3RyYXRlZ3kgYmUgZG9uZSBieSANCmV4dGVybmFsIGNv
bnN1bHRhbnRzLiBXZSB3aWxsIHNob3cgeW91IGhvdyB0byBzdWNjZXNzZnVsbHkgY29uZHVj
dCBlZmZlY3RpdmUgDQpzdHJhdGVneSBkZXZlbG9wbWVudCBwcm9jZXNzZXMsIHNvIHlvdSBj
YW4gcHV0IGRvd24gYSBiYXNpYyByb2FkbWFwIHRvIGVuc3VyZSANCnRoZSBmdXR1cmUgc3Vj
Y2VzcyBvZiB5b3VyIGNvbXBhbnkuDQpEZXNpZ25pbmcgYSBzdHJhdGVneSBwcm9qZWN0LCBw
bGFubmluZyBhbmQgY2FycnlpbmcgaXQgDQogIG91dA0KU3RyYXRlZ2ljIGFuYWx5c2lzLCBz
dHJhdGVnaWMgDQogIG9wdGlvbnMNCkNvcnBvcmF0ZSBwaGlsb3NvcGh5IGFuZCB2YWx1ZXMN
CkNvcnBvcmF0ZSBnb3Zlcm5hbmNlIHByaW5jaXBsZXMNCllvdXIgY29ycG9yYXRlIHN0cmF0
ZWd5IOKAk3RoZSBjb3Vyc2UgdGhlIG93bmVycyBhbmQgdG9wIG1hbmFnZW1lbnQgDQogIHdh
bnQgdG8gdGFrZQ0KT3BlcmF0aW9uYWwgc3RyYXRlZ2llcyDigJMgbWFya2V0aW5nIHN0cmF0
ZWd5LCBwcm9kdWN0aW9uIHN0cmF0ZWd5LCANCiAgc3VwcGx5LWNoYWluIHN0cmF0ZWd5LCBI
UiBzdHJhdGVneSwgZmluYW5jaWFsIHN0cmF0ZWd5IA0KICBldGMuDQpTdHJhdGVnaWVzIGZv
ciBidXNpbmVzcyBkaXZpc2lvbnMsIGRlcGFydG1lbnRzLCBmaWVsZHMgb2YgDQogIGJ1c2lu
ZXNzLCBidXNpbmVzcyB1bml0cw0KUmVnaW9uYWwgc3RyYXRlZ2llcyBmb3IgY291bnRyaWVz
LCBzYWxlcyByZWdpb25zLCBicmFuY2ggDQogIG9mZmljZXMNClN0cmF0ZWdpZXMgZm9yIHN0
YWZmIHBvc2l0aW9ucywgY3Jvc3MtZGVwYXJ0bWVudGFsIGFuZCBzdXBwb3J0IA0KICBmdW5j
dGlvbnMNCkhvdyB0byBpbnRlZ3JhdGUgdGhlIG1hbnkgc3ViLXN0cmF0ZWdpZXMgaW50byBh
biB1bmRlcnN0YW5kYWJsZSwgDQogIGludGVncmF0ZWQgc3RyYXRlZ2ljIHN5c3RlbQ0KSG93
IHRvIHByZWNpc2VseSBmb3JtdWxhdGUgDQogIHN0cmF0ZWdpZXMNClJlc3VsdHMgbWFuYWdl
bWVudA0KwqANCkltcGxlbWVudGluZyANCmEgTmV3IFN0cmF0ZWd5LCBDaGFuZ2UgTWFuYWdl
bWVudA0KVGhlIGltcGxlbWVudGF0aW9uIG9mIG5ldyBzdHJhdGVnaWVzIHJlcXVpcmVzIGFu
IGVmZmljaWVudCANCmltcGxlbWVudGF0aW9uIHN5c3RlbS4gSnVzdCBhcyBpbXBvcnRhbnQg
aXMgdG8gY29udmluY2UgZW1wbG95ZWVzIHRoYXQgYW4gDQp1cGNvbWluZyBjaGFuZ2UgbWFr
ZXMgc2Vuc2UsIHRoYXQgeW91IGlkZW50aWZ5IGJhcnJpZXJzIHRvIGltcGxlbWVudGF0aW9u
IGVhcmx5LCANCmFuZCB0aGF0IHlvdSB3aW4tb3ZlciBldmVyeW9uZSBpbnZvbHZlZC4NClRy
YW5zbGF0aW5nIHN0cmF0ZWdpYyBvYmplY3RpdmVzIGludG8gYW4gZXhlY3V0aW9uIA0KICBw
bGFuDQpFbnN1cmluZyBjbGVhciByZXNwb25zaWJpbGl0eSBhbmQgDQogIGFjY291bnRhYmls
aXR5DQpJbmNlbnRpdmVzIGFuZCBjb250cm9scw0KTGVhcm5pbmcsIGZlZWRiYWNrIGFuZCAN
CiAgYWRhcHRhdGlvbg0KwqANCkdFTkVSQUwgTk9URVMNClRoaXMgY291cnNlIGlzIGRlbGl2
ZXJlZCBieSBvdXIgc2Vhc29uZWQgdHJhaW5lcnMgd2hvIGhhdmUgdmFzdCANCiAgZXhwZXJp
ZW5jZSBhcyBleHBlcnQgcHJvZmVzc2lvbmFscyBpbiB0aGUgcmVzcGVjdGl2ZSBmaWVsZHMg
b2YgcHJhY3RpY2UuIFRoZSANCiAgY291cnNlIGlzIHRhdWdodCB0aHJvdWdoIGEgbWl4IG9m
IHByYWN0aWNhbCBhY3Rpdml0aWVzLCB0aGVvcnksIGdyb3VwIHdvcmtzIA0KICBhbmQgY2Fz
ZSBzdHVkaWVzLg0KVHJhaW5pbmcgbWFudWFscyBhbmQgYWRkaXRpb25hbCByZWZlcmVuY2Ug
bWF0ZXJpYWxzIGFyZSBwcm92aWRlZCANCiAgdG8gdGhlIHBhcnRpY2lwYW50cy4NClVwb24g
c3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMgY291cnNlLCBwYXJ0aWNpcGFudHMgd2ls
bCBiZSANCiAgaXNzdWVkIHdpdGggYSBjZXJ0aWZpY2F0ZS4NCldlIGNhbiBhbHNvIGRvIHRo
aXMgYXMgdGFpbG9yLW1hZGUgY291cnNlIHRvIG1lZXQgDQogIG9yZ2FuaXphdGlvbi13aWRl
IG5lZWRzLiBDb250YWN0IHVzIHRvIGZpbmQgb3V0IG1vcmU6IA0KICB0cmFpbmluZ0Bza2ls
bHNmb3JhZnJpY2Eub3JnDQpUaGUgdHJhaW5pbmcgd2lsbCBiZSBjb25kdWN0ZWQgYXQgU0tJ
TExTIEZPUiBBRlJJQ0EgVFJBSU5JTkcgDQogIElOU1RJVFVURSBJTiBOQUlST0JJIEtFTllB
Lg0KVGhlIHRyYWluaW5nIGZlZSBjb3ZlcnMgdHVpdGlvbiBmZWVzLCB0cmFpbmluZyBtYXRl
cmlhbHMsIGx1bmNoIA0KICBhbmQgdHJhaW5pbmcgdmVudWUuIEFjY29tbW9kYXRpb24gYW5k
IGFpcnBvcnQgdHJhbnNmZXIgYXJlIGFycmFuZ2VkIGZvciBvdXIgDQogIHBhcnRpY2lwYW50
cyB1cG9uIHJlcXVlc3QuDQpQYXltZW50IHNob3VsZCBiZSBzZW50IHRvIG91ciBiYW5rIGFj
Y291bnQgYmVmb3JlIHN0YXJ0IG9mIA0KICB0cmFpbmluZyBhbmQgcHJvb2Ygb2YgcGF5bWVu
dCBzZW50IHRvOiANCiAgdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZw0KwqANCjxodHRw
czovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9
WEhGenB2cTlqcHVQRkRHNGVYTVNiYXhlWERvUmYtUWF3UnFjSUtHVlVIWXlGVkxNN01WNWJu
Vm16LXdJSy1SOElaQXhXbUZ5aW5zTHZIbllNS1A5NEpqMmlmV2ZqdDRtTFQ5Tm9QY25LUWxt
MD4NClVOU1VCU0NSSUJF

--=-eZCfHUGG8T/vIf2mQPAFW3/g/RVD2KoD/XWKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DPS2QW1jY=
bLsZBuW6jufY5zqbm941VieTJK3r2aqqsNHnarpeN9WF2b8RpYEd5Ee9RKfgaqKO9dEC72=
c5-sQh4wTtm8cEmfzC7QTWnbkqq4fjhgbdW3GJp7a093VKLBIYeGPEApxvwQ6DYqyQEzbo=
lzA1"><FONT color=3D#0563c1><FONT=20
face=3DCalibri>STRATEGIC LEADERSHIP AND STRATEGIC MANAGEMENT FOR EXECU=
TIVES=20
PROGRAM APRIL 4<SUP>TH</SUP>-15<SUP>TH</SUP> 2022<?xml:namespace prefi=
x =3D "o" ns=20
=3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></FONT></A></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DI_IGJM9K=
KBMFazlfgRnPYF0hP1VIgX2bWbQW7WZXNNrCcqgSkZDl5Jvj8X8CodHhJ0frAV5jJD-qxl=
8dhDDr3k7SDcrMAjtZg61phGI2LiiuqYC277CC-fslmGjgz0lHqV6lyHy-58V3zZ6cNmeC=
WQmTOxY6jMOgco-U5tWK118U0" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Register for online w=
orkshop=20
attendance <o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DI_IGJM9K=
KBMFazlfgRnPYF0hP1VIgX2bWbQW7WZXNNqhtT0RK05uHPv8dEfRG-BWEacbV-NRP3vZ-1=
l0yXYXeKPOi-dA_cA0_8RN21ZXy05uimLGS0ej19_v8dKBEC_ksmk3xSaifdKWyEzC5ynR=
Vkp4tASn2wRcbWSJL4NwNpLL0" target=3D_blank><FONT=20
color=3D#0563c1><FONT face=3DCalibri>Register to attend the=20
workshop<o:p></o:p></FONT></FONT></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DI_IGJM9K=
KBMFazlfgRnPYF0hP1VIgX2bWbQW7WZXNNqhtT0RK05uHPv8dEfRG-BWEacbV-NRP3vZ-1=
l0yXYXeDCV2wTK1dhFsJg9Ab71cCaaEjd97zgDq316OqiVdeppCsA9t4JqVxggEink_q42=
vIAWrfpFePjEX8g8kzrZCmr30" target=3D_blank><FONT=20
color=3D#0563c1><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></FONT></A></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DPS2QW1jY=
bLsZBuW6jufY5zqbm941VieTJK3r2aqqsNEFe6f7v0X8pVSjQmD8HFlQMD8iQB9SQ2mncp=
9s2zFiNm_pAGoxwsobqIx9rbazSkwl1ga4osSFBkE8O3Q8nM8SW7cm7wLbHIpWadBsUGb4=
dL81" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Calendar for 2022=20
Workshops<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DPS2QW1jY=
bLsZBuW6jufY5zqbm941VieTJK3r2aqqsNHdgpvEoyFnhnRVB0Km9jtfD34yIakfEVlXxL=
JpT0zx7UM96XgIUEUox_4lClC9nFswzIRQQx26ikYiIDl-VVAIaPazxgjUVZ3qau9PThF-=
v-Q1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Contact=20
us<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DRAnyf8LX=
2fAhmeuRPJDlDA58gzptEvbYfiHgWbJ4WyPt0Bd1gZovqJlijUZHP3zT4W4DgBTi7E1u_a=
-5JQLgYq1qtFF_Erx9sArbLTXQPMkUUu9fmmTlpFPvdsjnl80pGuxJDcWaFo6TK5XPueUY=
S6U1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT=20
face=3DCalibri>Whatapp<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>VENUE: HILITON HOTEL, NAIROBI,=20
KENYA<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>Office Telephone: +254-702-249-449<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin; mso-fareast-font-family: "Times New Roman"'><FONT=20
face=3DCalibri>Send us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DKCFb5Kh=
zkl_U4dxWHi6W8gtCdxRZegvhdt-a8PdLEqqOYZ6HhrwcwNuPCSgFxrNwhJAAPoBFXUDfi=
40mBMEzUBraYNLUvPzmUcJ6VVe_Ku_sgUWw0UBk3mXzK38lyfVwrcoYX8VvbTv5tUAFMBx=
GzrI4mmrri5FCzomkPPrDhWybW8hy2-1-nLNNllpSMYfoRTG16RuuD8s70f4dYn7-Fkk1"=
 ><FONT=20
color=3D#0563c1 face=3DCalibri>training@skillsforafrica.org&nbsp;</FON=
T></A><FONT=20
face=3DCalibri>or call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">INTRODUCTION<=
/SPAN></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Success or failure in business is decided by strategy, =
the ability=20
to implement it and leadership qualities. Strategic decisions always a=
im to=20
secure the longer-term, future viability of a company or company area.=
 They show=20
the way forward, and in doing so must be flexible enough to allow adap=
tation to=20
changing conditions. In addition, they define the roadmap on which a c=
ompany=20
must travel to achieve its objectives. If the strategy is unclear, or =
the=20
roadmap not practical, success is not achievable &#8211; and the resul=
t is often=20
operative activities where the company as a whole stalls or goes in ci=
rcles.=20
Strategy expertise at executive level, therefore, determines whether c=
ommitment=20
to the daily business is rewarded with good results &#8211; results th=
at the company=20
is proud of and that motivates staff to further top performance. Nonet=
heless,=20
even the best strategy and the most intelligent guidelines won&rsquo;t=
 help if=20
mistakes are made during implementation. That&rsquo;s why good strateg=
ies are always=20
made by leaders with a solid leadership skill. Whether, and to what de=
gree,=20
their staff is motivated to achieve strategic objectives depends on ho=
w they=20
conduct themselves as leaders. Clear objectives, sensible guidelines a=
nd the=20
right management conduct creates the freedom a company needs for contr=
olled=20
entrepreneurship. This in turn creates the prerequisites for sustainab=
le top=20
performance and first-class results that will secure the future of you=
r=20
company.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategic=20
Management for Executives: </SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">The=20
success of a company and its business units depends on a few strategic=
=20
decisions. This program offers you the latest knowledge and an integra=
ted=20
approach to strategic management. You will learn from many real-world =
examples,=20
have an exchange of experiences, get new ideas, and learn the tools yo=
u need for=20
successful strategic management.<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategy=20
&#8211; </SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">and=20
not effort and diligence in the daily business &#8211; determines succ=
ess or failure=20
of your company, your division or the business unit you lead. In this =
course, we=20
show you what&rsquo;s important in navigating and developing strategy =
in the direction=20
of success and sustainability.<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">How=20
you benefit</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>This course will give you detailed knowledge about stra=
tegy with=20
the goal of better understanding the principles, tools and methods of =
strategic=20
management and strategy development and how they interrelate to the wh=
ole. You=20
will receive the latest know-how about developing innovative, competit=
ive=20
strategies. You will learn how to position your business in a competit=
ive=20
environment and how to launch programs that will optimize your company=
&rsquo;s value,=20
profitability and performance. You will critically analyze your own st=
rategic=20
concepts and will return to you job ready to give new impetus to creat=
ing an=20
innovative future for your company. Methods, concepts, instruments and=
 effective=20
tools to guiding your company are explained using numerous=20
examples.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Who=20
should attend</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Executives=20
and experienced managers, who want to deepen their knowledge of how to=
 ensure=20
future company success, learn the latest principles behind strategic m=
anagement=20
and effective leadership. These include:</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">General=20
managers, heads of business units and profit centers</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">C-level=20
executives</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Heads=20
of larger divisions and departments</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Members=20
of the management board and board of directors</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Those=20
responsible for business units, subsidiaries and important projects</S=
PAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Managers=20
who are soon to move up to a CEO or executive</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">position</SPA=
N><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Decision-make=
rs=20
from management boards, board members, members of supervisory boards</=
SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Mid-level=20
to senior-level executives responsible for strategic planning, impleme=
ntation,=20
and business development</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Executives=20
who test strategy proposals for their plausibility</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Executives=20
of companies, divisions or business units in charge of implementing=20
strategies</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin">,=20
</SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Executives,=20
managers, consultants and specialists who conduct strategic analysis, =
lead=20
strategy meetings or draft strategic concepts<o:p></o:p></SPAN></FONT>=
</P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">DURATION</SPA=
N></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>10 Days<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">COURSE=20
CONTENT</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategic=20
Management as Navigation Tool for the Future</SPAN></B><SPAN lang=3DEN=
=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Executives must steer a company during turbulent times =
as well.=20
Success can be defined in many ways &#8211; by corporate value, cash f=
low, shareholder=20
value, profitability, customer value, market share, customer satisfact=
ion,=20
performance culture and trust. Successful strategic management seeks t=
o secure a=20
balance between short-term results-optimization and long-term success.=
 The main=20
focus is primarily this &#8211; sustainable profitability thanks to hi=
gh customer=20
value.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l12 level1 =
lfo15"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Viability and achieving healthy profit=20
  development<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l12 level1 =
lfo15"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How do you execute a strategy=20
  process?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l12 level1 =
lfo15"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Handling complexity as a practical test for successfu=
l=20
  management<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l12 level1 =
lfo15"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How globalization and digitalization are influencing =
strategy and=20
  management<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategic=20
Objectives and Directions</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>No strategy without objectives or strategic guidelines.=
 As=20
interface between ideal results and feasibility, strategic guidelines =
define the=20
strategic corridor through which company development should take place=
. Here you=20
need to pave the way and actively shape the future.<o:p></o:p></FONT><=
/SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l2 level1 l=
fo14"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Inventing the future &#8211; the importance of vision=
 in the strategic=20
  management process<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l2 level1 l=
fo14"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How do you turn your vision into a concrete=20
  strategy?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l2 level1 l=
fo14"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How to derive motivating goals from your=20
  vision<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Modern Strategy Tools for Understanding your Strategic=20
Situation<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Strategic decisions are made based on analyses, studies=
 and=20
assessments. If these are wrong, or wrongly interpreted, then by neces=
sity the=20
decisions made from them are also wrong. That&rsquo;s why a competent =
use of strategic=20
management tools is so important. We will show you how to use these to=
ols and=20
what pitfalls you need to avoid.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l9 level1 l=
fo13"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Information as basis for strategic decisions &#8211; =
what&rsquo;s really=20
  important?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l9 level1 l=
fo13"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>A look to the future &#8211; always a look at my own =
expertise and=20
  resources<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l9 level1 l=
fo13"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Analysis tools &#8211; what&rsquo;s out there, what&r=
squo;s new, and how do I=20
  employ them expertly?<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">The=20
Spectrum of Strategic Options</SPAN></B><I><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></I></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>The spectrum of possible strategic options is wide &#82=
11; do we expand,=20
retain, differentiate, specialize, move into a niche, work for cost le=
adership,=20
enhance our value-added chain, form alliances, create platform strateg=
ies,=20
purchase, pursue a merger, disinvest, focus on virtuality, internation=
alize &#8211;=20
countless options are available to you. Each one of them is determined=
 by=20
specific rules and have to be well thought-through.<o:p></o:p></FONT><=
/SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l0 level1 l=
fo12"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategic thinking means thinking in alternative=20
  scenarios<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l0 level1 l=
fo12"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Realistic estimation of risks and investment=20
  needs<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l0 level1 l=
fo12"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Business development and=20
  innovation<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategic=20
Decisions</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Strategic decisions determine the direction a company w=
ill develop.=20
They set objectives and pave the way for future=20
success.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l6 level1 l=
fo11"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>What differentiates a good from a bad=20
  strategy?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l6 level1 l=
fo11"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Successful strategy development<o:p></o:p></FONT></SP=
AN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l6 level1 l=
fo11"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>The decision-making process and typical=20
  pitfalls<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l6 level1 l=
fo11"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Plausibility checks<o:p></o:p></FONT></SPAN></I></LI>=
</UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategy=20
Implementation</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>The larger, the more unwieldy &#8211; unfortunately, th=
is is the case=20
with numerous companies. However, many smaller organizations also stru=
ggle to=20
implement what has been decided in their everyday business. Here manag=
ement is=20
called upon. How can new strategies, new concepts and new ideas actual=
ly be=20
realized?<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l1 level1 l=
fo10"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How do you convert strategies skillfully into concret=
e=20
  projects?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l1 level1 l=
fo10"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>The most common mistakes in implementing=20
  strategy<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Leadership=20
and Result-Orientation</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Inspiring others to achieve objectives as a team. Commu=
nicating=20
your vision, deriving ambitious objectives from it and ensuring that t=
he fire of=20
enthusiasm in your daily work does not go out. Giving new impulse. Con=
vincing,=20
supporting and if necessary doing it yourself. To be a normal person a=
nd a role=20
model. Never losing sight of what&rsquo;s important &#8211; results. W=
e show you how to=20
sharpen and develop your leadership skills even=20
further.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l3 level1 l=
fo9"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Effective leadership &#8211; what do you need to achi=
eve=20
  this?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l3 level1 l=
fo9"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Modern leadership approaches and leadership=20
  styles<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l3 level1 l=
fo9"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Performance and motivation<o:p></o:p></FONT></SPAN></=
I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l3 level1 l=
fo9"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Trust as an element of corporate=20
  culture<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Change=20
and Communication</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>When you have to implement new strategies and concepts,=
 you will=20
usually have to change the attitudes, behavior and habits of employees=
 and=20
colleagues. We all know that this is a difficult task. Successful chan=
ge=20
management begins with the right management conduct and targeted commu=
nication.=20
Using numerous examples, we will demonstrate what you need to do in th=
ese=20
situations.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l13 level1 =
lfo8"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How do you communicate=20
  strategies?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l13 level1 =
lfo8"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Agility and digitalization at executive=20
  level<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l13 level1 =
lfo8"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Successful transformation &#8211; approaches and=20
  methods<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">An=20
Integrated Approach to Strategic Management</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>One strategy fad quickly follows another. One strategic=
 project=20
follows the next one, when the first project has really just started a=
nd is not=20
completed by a long shot. Aren&rsquo;t we doing too much of a good thi=
ng here? What=20
are &laquo;must haves&raquo; what are &laquo;nice to haves&raquo;? Wha=
t&rsquo;s important here is the right=20
dosage of the new. Modern management theory and real-world management =
experience=20
offer a lot of insight. In this seminar, we will show you what has pro=
ven itself=20
in real business situations.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l7 level1 l=
fo7"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Current strategic management concepts and=20
  tools<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l7 level1 l=
fo7"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategic principles<o:p></o:p></FONT></SPAN></I></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l7 level1 l=
fo7"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>What characterizes good=20
  strategies<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Clarifying=20
your Strategic Position and the Need for Strategic Action</SPAN></B><S=
PAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Change is a given. It forces management to constantly c=
heck their=20
strategic position. Changes need to be anticipated promptly and danger=
s to the=20
business have to be recognized. During this process, new opportunities=
 will=20
become apparent and should be capitalized on. That&rsquo;s why it&rsqu=
o;s important for you,=20
as a decision-maker, to recognize the need for strategic=20
action.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l11 level1 =
lfo6"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Determining your current strategic=20
  position<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l11 level1 =
lfo6"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Understanding strategic challenges=20
  correctly<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l11 level1 =
lfo6"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Important tools for analysis<o:p></o:p></FONT></SPAN>=
</I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">The=20
Role played by the Business Model in Strategic Management</SPAN></B><S=
PAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Your business model describes how your company will gen=
erate=20
profit. Calculating profit based on costs plus margin is banal. More i=
nteresting=20
is to link margins to created benefits. Classic business cases often o=
bscure the=20
profit drivers of a business model. This course teaches you how to ide=
ntify and=20
use the relevant profit drivers.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l14 level1 =
lfo5"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>The architecture of creating value, understanding you=
r profit=20
  drivers<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l14 level1 =
lfo5"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Improving on your current business model, developing =
new business=20
  ideas<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l14 level1 =
lfo5"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Innovative and digital business=20
  models<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Strategic=20
Options that Promise Success</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Decades-long observation, discussions with thousands of=
=20
decision-makers and evaluating the relevant literature on the subject =
show that=20
companies often have their own favorite tried and tested strategies. A=
 high=20
percentage of these strategies are transferred into strategic projects=
 and then=20
formulated into strategic initiatives. But we also live in times chara=
cterized=20
by disruption, globalization and digitalization. We will introduce you=
 to=20
several strategic options that promise success during the seminar, alo=
ng with=20
tips for everyday implementation. We will show you the traps you&rsquo=
;ll need to=20
avoid to successfully implement your strategy.<o:p></o:p></FONT></SPAN=
></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l8 level1 l=
fo4"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategic options &#8211; what works and what=20
  doesn&rsquo;t?<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l8 level1 l=
fo4"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Classic competitive strategies<o:p></o:p></FONT></SPA=
N></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l8 level1 l=
fo4"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Growth based on core=20
  competencies<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l8 level1 l=
fo4"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Customer-centric strategic=20
  approaches<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l8 level1 l=
fo4"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Evaluating strategic options according to their poten=
tial for=20
  success and their chances of being=20
realized<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Effective=20
Strategy Development Processes</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>Strategic projects often come to nothing because a sens=
ible way to=20
proceed is missing. That&rsquo;s why many companies let their strategy=
 be done by=20
external consultants. We will show you how to successfully conduct eff=
ective=20
strategy development processes, so you can put down a basic roadmap to=
 ensure=20
the future success of your company.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Designing a strategy project, planning and carrying i=
t=20
  out<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategic analysis, strategic=20
  options<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Corporate philosophy and values<o:p></o:p></FONT></SP=
AN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Corporate governance principles<o:p></o:p></FONT></SP=
AN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Your corporate strategy &#8211;the course the owners =
and top management=20
  want to take<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Operational strategies &#8211; marketing strategy, pr=
oduction strategy,=20
  supply-chain strategy, HR strategy, financial strategy=20
  etc.<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategies for business divisions, departments, field=
s of=20
  business, business units<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Regional strategies for countries, sales regions, bra=
nch=20
  offices<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Strategies for staff positions, cross-departmental an=
d support=20
  functions<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How to integrate the many sub-strategies into an unde=
rstandable,=20
  integrated strategic system<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>How to precisely formulate=20
  strategies<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l4 level1 l=
fo2"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Results management<o:p></o:p></FONT></SPAN></I></LI><=
/UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN">Implementing=20
a New Strategy, Change Management</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>The implementation of new strategies requires an effici=
ent=20
implementation system. Just as important is to convince employees that=
 an=20
upcoming change makes sense, that you identify barriers to implementat=
ion early,=20
and that you win-over everyone involved.<o:p></o:p></FONT></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l10 level1 =
lfo3"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Translating strategic objectives into an execution=20
  plan<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l10 level1 =
lfo3"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Ensuring clear responsibility and=20
  accountability<o:p></o:p></FONT></SPAN></I></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l10 level1 =
lfo3"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Incentives and controls<o:p></o:p></FONT></SPAN></I><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l10 level1 =
lfo3"><I><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Learning, feedback and=20
  adaptation<o:p></o:p></FONT></SPAN></I></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
face=3DCalibri>GENERAL NOTES<o:p></o:p></FONT></SPAN></B></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>This course is delivered by our seasoned trainers who=
 have vast=20
  experience as expert professionals in the respective fields of pract=
ice. The=20
  course is taught through a mix of practical activities, theory, grou=
p works=20
  and case studies.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Training manuals and additional reference materials a=
re provided=20
  to the participants.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Upon successful completion of this course, participan=
ts will be=20
  issued with a certificate.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>We can also do this as tailor-made course to meet=20
  organization-wide needs. Contact us to find out more:=20
  training@skillsforafrica.org<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>The training will be conducted at SKILLS FOR AFRICA T=
RAINING=20
  INSTITUTE IN NAIROBI KENYA.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>The training fee covers tuition fees, training materi=
als, lunch=20
  and training venue. Accommodation and airport transfer are arranged =
for our=20
  participants upon request.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-layout-grid-align: none; mso-list: l5 level1 l=
fo1"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: =
Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Cal=
ibri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri=
; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN"><FONT=20
  face=3DCalibri>Payment should be sent to our bank account before sta=
rt of=20
  training and proof of payment sent to:=20
  training@skillsforafrica.org<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D"mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-l=
atin; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-lati=
n; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin"><o=
:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Dy=
C3ozCfZXJYJR6AOqAm4FQ2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DXHFzpvq9jpuPFDG4eXMSbaxeXDoRf-QawRqcIKGVUHYyFVLM7MV5bnVmz-=
wIK-R8IZAxWmFyinsLvHnYMKP94Jj2ifWfjt4mLT9NoPcnKQlm0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfHUGG8T/vIf2mQPAFW3/g/RVD2KoD/XWKzQ==--
