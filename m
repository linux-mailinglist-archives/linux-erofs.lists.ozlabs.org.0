Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DE4D2D65
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Mar 2022 11:50:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KD89500Z2z3bT3
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Mar 2022 21:50:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=E+YwUolh;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=I3QVp3Wy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bounces.elasticemail.net (client-ip=216.169.99.28;
 helo=pn28.mxout.mta2.net;
 envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=bounces.elasticemail.net
 header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api
 header.b=E+YwUolh; dkim=pass (1024-bit key;
 unprotected) header.d=elasticemail.com header.i=@elasticemail.com
 header.a=rsa-sha256 header.s=api header.b=I3QVp3Wy; 
 dkim-atps=neutral
X-Greylist: delayed 83 seconds by postgrey-1.36 at boromir;
 Wed, 09 Mar 2022 21:49:51 AEDT
Received: from pn28.mxout.mta2.net (pn28.mxout.mta2.net [216.169.99.28])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KD88v4PGNz2xBl
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Mar 2022 21:49:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
 c=relaxed/simple; t=1646822881;
 h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
 bh=ZS1apHZLtccxjreSwBqIcKflJ6pueZxr9mTw8Ghgfoo=;
 b=E+YwUolhptkzWjfNftaWjr/w0ryaoGepkWbOLK/xSU5vgX+fDqM0/zqeF5vspFb9EeOyam8svcu
 tYVUjNOl/JcpJEt5x11zWcLT1opjxO0Io0WfYig5TXJplfhBOZVryIqtvaYmrTrn2N6vJbSiEaxlO
 PLy+RhzuUPZftRddlTw=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
 c=relaxed/simple; t=1646822881;
 h=from:date:subject:reply-to:to:list-unsubscribe;
 bh=ZS1apHZLtccxjreSwBqIcKflJ6pueZxr9mTw8Ghgfoo=;
 b=I3QVp3Wyjpttk/8esrk1apfkdkz0V1svkuG8ScxkABdPerIrwNAAozQpl7aIMahjtgS+bHxAjsV
 KIg0QK4BD9wVZTvdyczM47mos31QG+blpSBbdGQHRijKQJ/JYvycQbouZizpCEP3F7kkylgL4v8V6
 pqGnz5AKQSyt5lHWSf4=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 09 Mar 2022 10:48:01 +0000
Subject: INVITATION TO ATTEND A TRAINING COURSE ON DIGITAL/SOCIAL MEDIA SKILLS
 ON 18TH to 22ND APRIL 2022
Message-Id: <4ug9t2xmiony.9nVH1fVwF9joOTBhuucT9w2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: 9nVH1fVwF9joOTBhuucT9w2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=-eZCfXWzj1nTKEdC4M8MgRh3j2hF31sp823WKzQ=="
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

--=-eZCfXWzj1nTKEdC4M8MgRh3j2hF31sp823WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTWlFNzJBMnZD
M0xtVktfdnpaLWluUUczM0YxWWtpYjFIcVNSYS10c0pTMlAzczRWSmlqVHZVYU1oNXZBdS1z
Y3NfMG5lZHZhdzl3TWJFXzVOZGtjaGhZeHpSNFFjQWEyVEI0a3NzYVhVdW1KdzE+DQrCoFRS
QUlOSU5HIA0KQ09VUlNFIE9OIERJR0lUQUwvU09DSUFMIE1FRElBIFNLSUxMUyBPTiAxOFRI
IHRvIDIyTkQgQVBSSUwgMjAyMg0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWls
LmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1Bt
V2pOV3NxcXJUdE9iTkd5X3RRWFVVV2I1UGhNVzFXTFBJY0MxVjIwNFNwck9qN3BlRjY2QjJB
d2lFWnY0STBZOTNCVnY3RFQ0S2ZkR0Zrem54QkFMWGtTM3Jwb0MtZ3E4bWdHcTBvb1FseVlf
V1NLal91UTdQNFI2UVJ4RTItUENuSHdGUHV3TlBFMFYwPg0KUmVnaXN0ZXIgZm9yIA0Kb25s
aW5lIHdvcmtzaG9wIGF0dGVuZGFuY2UgDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxh
c3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1S
dDIyNVlZc1BtV2pOV3NxcXJUdE9iTkd5X3RRWFVVV2I1UGhNVzFXTFBJY0MxVjIwNFNwck9q
N3BlRjY2QjJJVFpPRC1pbmZmY05NZGo0MlhZZHU0YURWRV94ZHRPT09HOFU4R1NrUnBKVUFz
cUFneUVsRzNUSm81WHJsUFV4X01vQ0VqTjBIWVJfV1liVVA4S3VNWmowPg0KUmVnaXN0ZXIg
dG8gYXR0ZW5kIHRoZSANCndvcmtzaG9wDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGlj
ZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1
WVlzUG1Xak5Xc3FxclR0T2JOR3lfdFFYVVVXYjVQaE1XMVdMUEljQzFWMjA0U3ByT2o3cGVG
NjZCMkp1ZDluSW1rMC0xbGNfQ19HT1VfRVFlMEtUb0E4b2JxN3I5MktyTGU3eld1eFJEcFNK
X2Z0d3BJNUNGcWJXQ3Azc2ZnT3BHd3FhSllwZG9qUGlBM0lGODA+DQrCoA0KDQo8aHR0cHM6
Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPTRSU09HZVM1
SEk2S0ZKaXhRcHlrVUg3U0JEU2owQTJFZEhkY3FxRWstS01MZFlHdEsycm5UR0VPcEZPemNk
anhodERueUFVVlRMUUpYQU9GTEU4aGQydzdSaXU4dnVFckpKZ1h3NzFzdVJ5eURfYVRCUTdI
NE82M05oTmR2eF9MZWFiTFNhbURIN080dkRRVHh3TUU4amMxPg0KQ2FsZW5kYXIgZm9yIDIw
MjIgDQpXb3Jrc2hvcHMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwu
Y29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVk
SGRjcXFFay1LTWNLQlc1R3hqYnVYRmlWbzRFRFFEQWlRdFVhc0JjRVZUalNMZzBZTW5yNWNi
MHhhMGVWQVpzZ0xEN2NLOEg4THhpN01IYkYzcDVTTWN1clgxYjFnQVppbFBEVmM0STRoNjFj
RFlNdkZ3UnNIbzE+DQpDb250YWN0IA0KdXMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5l
bGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9VGRPMWdDdVE3MWhwV0w2MEJXTm50
dXdmMklXSmZrX2tKUV9PZXg1X2VqaWVwRlMxckNCOHdUZzdGUEttdG4xOFZLcTFDZE9UMlQ4
NjJUTmZMVi1ZZW81ODh6U21XTEdOaHJMeVNHd2NDR19zRUt6UDNmdlNxcFExbS1yaC00YUxO
N3pzWUFWbk5YTU9pcVZaWmM5UGtmMDE+DQpXaGF0YXBwDQrCoA0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVRkTzFnQ3VRNzFocFdM
NjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9lamllcEZTMXJDQjh3VGc3RlBLbXRuMTg5MDdU
NG9rRFRzbEs4OWFfU2R6SjBacHZ0LUQzLURLSEx5Nm8wbmdCQTMtNldaTXEyd0t0WmFGdUpn
dHNzQmx3TllEbHhsTzZZNEx1d045MlpYNUQ0MU8ydFRpOWtYSXpWbHJXZDZmNGpOZlIwPg0K
UEFSVElDSVBBVElPTiBGRUVTOiAxLDIwMFVTRA0KwqANClZFTlVFOiANCkhJTFRPTiBIT1RF
TCwgTkFJUk9CSSwgS0VOWUENCk9mZmljZSANClRlbGVwaG9uZTogKzI1NC03MDItMjQ5LTQ0
OQ0KUmVnaXN0ZXIgDQphcyBhIGdyb3VwIG9mIDUgb3IgbW9yZSBwYXJ0aWNpcGFudHMgYW5k
IGdldCAyNSUgZGlzY291bnQgb24gdGhlIGNvdXJzZSBmZWUuIA0KDQpTZW5kIA0KdXMgYW4g
ZW1haWw6IA0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcv
Y2xpY2s/ZD1jQnVUR3l5d0h2VmlyT2puSlVhSFFkVk9GMVhVeTRrYmpJNHdJOEstNHoxR3Yw
NU15aVlwSUU0RFhRMDg5OGR1Z19iaHVaYzBPQ0VxSTZLWjlLdjhqbVIxRlBjajBpSXIyb1BQ
dGJ5N1JQXzExRW43SDdLV242VTh3Uk9LZ2lfVjVONkZXLUlTWW92bTVoWjZnYk8zcmJ0dm9Z
TjJrMlBveTg5SUtCb29DOW55Wnh0cFU2azliaVlJVnZCZmJwOVU0akRoRHBueVppYzF5d2FT
OC11WUotSTE+DQp0cmFpbmluZ0Bza2lsbHNmb3JhZnJpY2Eub3JnwqBvciANCmNhbGwgKzI1
NC03MDItMjQ5LTQ0OQ0KSU5UUk9EVUNUSU9ODQpEaWdpdGFsIA0KdGVjaG5vbG9neSBoYXMg
cmV2b2x1dGlvbml6ZWQgdGhlIHdheSBpbiB3aGljaCBwZW9wbGUgY29tbXVuaWNhdGUgYW5k
IHNoYXJlIA0KaW5mb3JtYXRpb24g4oCTIGF0IGxvY2FsLCBuYXRpb25hbCBhbmQgaW50ZXJu
YXRpb25hbCBsZXZlbHMuIE9yZ2FuaXphdGlvbnMsIA0KaW5jbHVkaW5nIGdvdmVybm1lbnQs
IG5lZWQgdG8gdW5kZXJzdGFuZCB0aGVzZSBjaGFuZ2VzIHNvIHRoYXQgdGhleSBjYW4gb3Bl
cmF0ZSANCmVmZmVjdGl2ZWx5IGluIGEgZHluYW1pYyBtZWRpYSBlbnZpcm9ubWVudC4NClNv
Y2lhbCBtZWRpYSBpcyBhIHRlcm0gdXNlZCB0byANCnJlZmVyIHRvIG9ubGluZSB0ZWNobm9s
b2dpZXMgYW5kIHByYWN0aWNlcyB0aGF0IGFyZSB1c2VkIHRvIHNoYXJlIG9waW5pb25zIGFu
ZCANCmluZm9ybWF0aW9uLCBwcm9tb3RlIGRpc2N1c3Npb24gYW5kIGJ1aWxkIHJlbGF0aW9u
c2hpcHMuIFNvY2lhbCBtZWRpYSBzZXJ2aWNlcyANCmFuZCB0b29scyBpbnZvbHZlIGEgY29t
YmluYXRpb24gb2YgdGVjaG5vbG9neSwgdGVsZWNvbW11bmljYXRpb25zIGFuZCBzb21lIGtp
bmQgDQpvZiBzb2NpYWwgaW50ZXJhY3Rpb24uIFRoZXkgY2FuIHVzZSBhIHZhcmlldHkgb2Yg
ZGlmZmVyZW50IGZvcm1hdHMsIGZvciBleGFtcGxlIA0KdGV4dCwgcGljdHVyZXMsIHZpZGVv
IGFuZCBhdWRpby4NCk9yZ2FuaXphdGlvbnMsIA0KaW5kaXZpZHVhbHMgYW5kIGNvcnBvcmF0
ZXMgd29ybGR3aWRlIGFyZSB3YWtpbmcgdXAgdG8gdGhlIG9wcG9ydHVuaXR5IG9mIHRoaXMg
DQpyZXZvbHV0aW9uYXJ5IG1lZGl1bSB0byBmdWxmaWxsIHZhcmlvdXMgYnVzaW5lc3Mgb2Jq
ZWN0aXZlcyByYW5naW5nIGZyb20gU2FsZXMsIA0KTWFya2V0aW5nLCBDUk0sIFByb2R1Y3Qg
RGV2ZWxvcG1lbnQsIGFuZCBSZXNlYXJjaC4gVGhpcyBoYXMgY3JlYXRlZCBhbiANCmV2ZXIt
aW5jcmVhc2luZyBkZW1hbmQgZm9yIHNraWxsZWQgRGlnaXRhbCBNYXJrZXRpbmcga25vd2xl
ZGdlIGFuZCANCnByb2Zlc3Npb25hbHMuDQpJbiANCnRoZSBhYnNlbmNlIG9mIGZvcm1hbCBh
dmVudWVzIG9mIERpZ2l0YWwgTWFya2V0aW5nIGVkdWNhdGlvbiwgdGhlcmUgaXMgYSBodWdl
IA0KZ2FwIG9mIHRhbGVudGVkIHByb2Zlc3Npb25hbHMuDQpJZiANCnlvdSBhcmUgYSBQdWJs
aWMgUmVsYXRpb25zIE9mZmljZXIsIA0KQ29tbXVuaWNhdGlvbiBPZmZpY2VyLCBCdXNpbmVz
cyBPd25lciwgYSBTYWxlcyAmIE1hcmtldGluZyANCnByb2Zlc3Npb25hbCBvciBhIFN0dWRl
bnQgd2hvIGlzIHNlcmlvdXMgYWJvdXQgbGV2ZXJhZ2luZyBEaWdpdGFsIE1hcmtldGluZyBm
b3IgDQpwZXJzb25hbCBvciBvcmdhbml6YXRpb25hbCBncm93dGgsIHRoZW4gdGhpcyBjb3Vy
c2UgaXMgZm9yIA0KeW91Lg0KQ09VUlNFIA0KT0JKRUNUSVZFUw0KQXQgDQp0aGUgZW5kIG9m
IHRoaXMgY291cnNlIHRoZSBwYXJ0aWNpcGFudHMgd2lsbCBiZSBhYmxlIHRvOg0KSW5jcmVh
c2UgDQogIG9yZ2FuaXphdGlvbnMgYWNjZXNzIHRvIGF1ZGllbmNlcyBhbmQgaW1wcm92ZSB0
aGUgYWNjZXNzaWJpbGl0eSBvZiANCiAgb3JnYW5pemF0aW9uIGNvbW11bmljYXRpb247DQpF
bmFibGUgDQogIG9yZ2FuaXphdGlvbnMgdG8gYmUgbW9yZSBhY3RpdmUgaW4gaXRzIHJlbGF0
aW9uc2hpcHMgd2l0aCBjbGllbnRzLCBwYXJ0bmVycyANCiAgYW5kIHN0YWtlaG9sZGVyczsN
Ck9mZmVyIGdyZWF0ZXIgDQogIHNjb3BlIHRvIGFkanVzdCBvciByZWZvY3VzIGNvbW11bmlj
YXRpb25zIHF1aWNrbHksIHdoZXJlIA0KICBuZWNlc3Nhcnk7DQpJbXByb3ZlIHRoZSANCiAg
bG9uZy10ZXJtIGNvc3QgZWZmZWN0aXZlbmVzcyBvZiBjb21tdW5pY2F0aW9uOw0KQmVuZWZp
dCBmcm9tIHRoZSANCiAgY3JlZGliaWxpdHkgb2Ygbm9uLWdvdmVybm1lbnQgY2hhbm5lbHM7
DQpJbmNyZWFzZSB0aGUgDQogIHNwZWVkIG9mIHB1YmxpYyBmZWVkYmFjayBhbmQgaW5wdXQ7
DQpSZWFjaCBzcGVjaWZpYyANCiAgYXVkaWVuY2VzIG9uIHNwZWNpZmljIGlzc3VlczsgYW5k
DQpSZWR1Y2UgDQogIG9yZ2FuaXphdGlvbiBkZXBlbmRlbmNlIG9uIHRyYWRpdGlvbmFsIG1l
ZGlhIGNoYW5uZWxzIGFuZCBjb3VudGVyIGluYWNjdXJhdGUgDQogIHByZXNzIGNvdmVyYWdl
Lg0KQXR0cmFjdCB0cmFmZmljIA0KICB0byB0aGVpciB3ZWJzaXRlL29ubGluZSBjb250ZW50
IGFuZCBpbmNyZWFzZSBpbiANCiAgc2FsZXMvYXdhcmVuZXNzLg0KSWRlbnRpZnkgdGhlIA0K
ICBhdWRpZW5jZSBhbmQgcmVhY2ggYW4gdW5saW1pdGVkIG51bWJlciBvZiBwcm9zcGVjdGl2
ZSBjbGllbnRzL2F1ZGllbmNlIHVzaW5nIA0KICBlbWFpbCBhbmQgb3RoZXIgdG9vbHMgYW5k
IHRlY2huaXF1ZS4NCkdldCBtb3JlIHZhbHVlIA0KICBmcm9tIG9ubGluZSBjYW1wYWlnbnMu
DQpXb3JrIHdpdGggDQogIE0uQS5SLlQuIHNvY2lhbCBtZWRpYSBnb2FscyB0byBhY2hpZXZl
IHN1Y2Nlc3NmdWwgb25saW5lIA0KICBjYW1wYWlnbnMuDQpXb3JrIA0KICBjb29wZXJhdGl2
ZWx5IHdpdGhpbiBhbiBvbmxpbmUgY29tbXVuaXR5IGJ5IG9ic2VydmluZyBhbmQgbGlzdGVu
aW5nIGNyaXRpY2FsbHkgDQogIHdpdGggb3Blbm5lc3MsIHRoZW4gYWN0IGV0aGljYWxseSBh
bmQgZm9sbG93IHRocm91Z2ggb24gY29tbWl0bWVudHMgd2hlbiANCiAgY29tbXVuaWNhdGlu
ZyB3aXRoIHZhcmllZCBhdWRpZW5jZXMgYW5kIGJ1aWxkIHBvc2l0aXZlIHJlcHV0YXRpb24g
d2l0aGluIHRoZSANCiAgY29tbXVuaXR5Lg0KRXhwbGFpbiBob3cgdG8gDQogIGRldmVsb3Ag
ZWZmZWN0aXZlIG9ubGluZSBtYXJrZXRpbmcgc3RyYXRlZ2llcyBmb3IgdmFyaW91cyB0eXBl
cyBvZiBpbmR1c3RyaWVzIA0KICBhbmQgYnVzaW5lc3Nlcy4NCklkZW50aWZ5IHNldHVwIA0K
ICBhbmQgdXNlIHRoZSBtYWpvciBzb2NpYWwgbWVkaWEgYW5kIG9ubGluZSBtYXJrZXRpbmcg
cG9ydGFscyB0aGF0IGNhbiBiZSB1c2VkIA0KICB0byBwcm9tb3RlIGEgY29tcGFueSwgYnJh
bmQsIHByb2R1Y3QsIHNlcnZpY2Ugb3IgDQpwZXJzb24uDQpFdmFsdWF0ZSBhIA0KICBjb21w
YW554oCZcyBjdXJyZW50IHNpdHVhdGlvbiwgaXNvbGF0ZSBvbmxpbmUgaXNzdWVzIGFuZCBw
cm92aWRlIHNvbHV0aW9ucyBieSANCiAgaWRlbnRpZnlpbmcgYXBwcm9wcmlhdGUgc29jaWFs
IG1lZGlhIGFuZCBvbmxpbmUgbWFya2V0aW5nIHBvcnRhbHMgdG8gaW5mbHVlbmNlIA0KICBj
b25zdW1lciBhbmQgaW1wcm92ZSB0aGUgY29tcGFueeKAmXMgcmVwdXRhdGlvbi4NClB1dCB0
b2dldGhlciBhIA0KICBzb2NpYWwgbWVkaWEgYW5kIG9ubGluZSBtYXJrZXRpbmcgcGxhbiBh
bmQgdHJhY2sgcHJvZ3Jlc3MgaW4gYWNoaWV2aW5nIGdvYWxzIA0KICB3aXRoIGEgdmFyaWV0
eSBvZiBtZWFzdXJlbWVudCB0b29scywgc2VydmljZXMsIGFuZCANCiAgbWV0cmljcy4NCkRV
UkFUSU9ODQo1IA0KRGF5cw0KV0hPIA0KU0hPVUxEIEFUVEVORA0KUHJlc3MgDQpPZmZpY2Vy
cywgQ29tbXVuaWNhdGlvbiBPZmZpY2VycywgUHVibGljIFJlbGF0aW9ucyBPZmZpY2VycyxE
aWdpdGFsIE1hcmtldGluZyBQcm9mZXNzaW9uYWxzLCANCk1hcmtldGluZyBQcm9mZXNzaW9u
YWxzLCBKb3VybmFsaXN0cywgU2FsZXMgUHJvZmVzc2lvbmFscyBhbmQgb3RoZXJzIHdobyBh
cmUgDQpyZXNwb25zaWJsZSBmb3IgcHVibGljaXR5IGFuZCBtZWRpYSByZWxhdGlvbnMuDQpD
T1VSU0UgDQpDT05URU5UDQpEaXNjdXNzaW5nIHRoZSANCiAgZGlnaXRhbC9zb2NpYWwgbWVk
aWEgb3B0aW9ucyBhbmQgc3RyYXRlZ2llcw0KSW50cm9kdWN0aW9uIHRvIA0KICBGYWNlLWJv
b2sgcGFnZXM6IGJlc3QgcHJhY3RpY2VzIGZvciBvcmdhbml6YXRpb25zDQpJbnRyb2R1Y3Rp
b24gdG8gDQogIFR3aXR0ZXIgUHJvZmlsZXMgLSBUd2l0dGVyIEJlc3QgUHJhY3RpY2VzIGZv
ciANCiAgb3JnYW5pemF0aW9ucw0KU2hhcmluZyBwaG90b3MgDQogIGFuZCBWaWRlb3Mgb25s
aW5lIOKAkyBvcHRpb25zIG9uIG1vYmlsZSBhbmQgc29jaWFsIG1lZGlhDQpCbG9nZ2luZyDi
gJMgaG93IA0KICB0byBwYXJ0aWNpcGF0ZSBpbiBmb3J1bXMgYW5kIGJsb2dzIGFuZCBob3cg
dG8gZm9ybSBwYXJ0bmVyc2hpcHMgd2l0aCBzb2NpYWwgDQogIG1lZGlhIG9yZ2FuaXphdGlv
bnM7DQpNb2JpbGUgV2ViL2FuZCANCiAgbWFya2V0aW5nDQpOZXR3b3JraW5nOiANCiAgT3B0
aW9ucyBmb3Iga25vd2xlZGdlIGFuZCBpbmZvcm1hdGlvbiBTaGFyaW5nDQpFZmZlY3RpdmUg
dXNlIG9mIA0KICBkaWdpdGFsIG1lZGlhIGZvciBjYW1wYWlnbnMNClNlYXJjaCBFbmdpbmUg
DQogIE9wdGltaXphdGlvbiAoU0VPKQ0KV2hhdCBpcyBPbi1QYWdlIA0KICBPcHRpbWl6YXRp
b24/DQpXaGF0IGlzIE9GRi1QYWdlIA0KICBPcHRpbWl6YXRpb24/DQpTZWFyY2ggRW5naW5l
IA0KICBBbGdvcml0aG1zDQpTZWFyY2ggRW5naW5lIA0KICBNYXJrZXRpbmcgKFNlTSkNClNF
TSANCiAgT3ZlcnZpZXcNClBheSBQZXIgQ2xpY2sgDQogIE92ZXJ2aWV3DQpTdHJhdGVnaXpp
bmcgUFBDIA0KICBjYW1wYWlnbnMNCk1hcmtldCANCiAgQW5hbHlzaXMNCkFkIHdyaXRpbmcg
DQogIFRlY2huaXF1ZXMNCkVmZmVjdGl2ZSANCiAgbGFuZGluZyBwYWdlcw0KRGVjaXBoZXIg
VXNlciANCiAgUHN5Y2hvbG9neQ0KU0VNIE1hbmFnZW1lbnQgDQogIChPdGhlciBPcHBvcnR1
bml0aWVzKQ0KUGF5IHBlciBjbGljayANCiAgb3ZlcnZpZXcNCk1hcmtldCANCiAgQW5hbHlz
aXMNCkNhbXBhaWduIA0KICBNYW5hZ2VtZW50DQpCaWQgTWFuYWdlbWVudCANCiAgUGxhbg0K
QmFjayANCiAgTGlua2luZy9MaW5rIEJ1aWxkaW5nDQpQZXJmb3JtYW5jZSANCiAgVHJhY2tp
bmcNClJlcG9ydGluZyAmIA0KICBBbmFseXNpcw0KVGVzdGluZw0KU29jaWFsIE1lZGlhIA0K
ICBNYXJrZXRpbmcgKFNNTSkNCldoeSBjYXJlIGFib3V0IA0KICBTb2NpYWwgTWVkaWE/DQpE
ZW15c3RpZnlpbmcgDQogIENvbW11bml0eSBCdWlsZGluZyBvbiBGYWNlYm9vaw0KQ3JlYXRp
bmcgYSANCiAgVHdpdHRlciBNYXJrZXRpbmcgU3RyYXRlZ3kNCkxldmVyYWdpbmcgDQogIExp
bmtlZEluIGZvciBCMkIgTGVhZCBHZW5lcmF0aW9uDQpNZWFzdXJpbmcgdGhlIA0KICBST0kg
b2YgU29jaWFsIE1lZGlhDQpDcmVhdGluZyBhIA0KICBGYWNlYm9vayBNYXJrZXRpbmcgU3Ry
YXRlZ3kNClR3aXR0ZXI6IFRoZSANCiAgSmV3ZWwgaW4gdGhlIFNvY2lhbCBNZWRpYSBDcm93
bg0KRGlzY3Vzc2lvbiBvbiANCiAgb3RoZXIgU29jaWFsIE1lZGlhIENoYW5uZWxzDQpQbGFu
bmluZyAmIA0KICBDcmVhdGluZyBNdWx0aS1jaGFubmVsIFNvY2lhbCBNZWRpYSBTdHJhdGVn
eQ0KRW1haWwgDQogIE1hcmtldGluZw0KRGVsaXZlcmFiaWxpdHkNCkVmZmVjdGl2ZSBFbWFp
bCANCiAgQ29udGVudA0KRWZmZWN0aXZlIA0KICBDcmVhdGl2ZQ0KQ3VzdG9tZXIgDQogIEFj
cXVpc2l0aW9uIFN0cmF0ZWdpZXMNCk51cnR1cmluZyAmIA0KICBBdXRvbWF0aW9uDQpSZXNv
dXJjZXMgdG8gZG8gDQogIHNpdHVhdGlvbmFsIGFuYWx5c2lzIGFuZCBwcm9ncmVzc2l2ZSB1
cGRhdGVzDQpJbmJvdW5kIA0KICBNYXJrZXRpbmcNCkF0dHJhY3RpbmcgeW91ciANCiAgcG90
ZW50aWFsIGN1c3RvbWVycyBpbnRvIHRoZSBjb252ZXJzaW9uIGZ1bm5lbA0KQ29udmVyc2lv
biANCiAgT3B0aW1pemF0aW9uDQpDb252ZXJzaW9uIA0KICBPcHRpbWl6YXRpb24gUGF0dGVy
bnMgZm9yIEVuZ2FnaW5nIFdlYnNpdGUgVmlzaXRvcnMNCkxpZmUgQ3ljbGUgDQogIEVtYWls
cw0KQW5hbHl0aWNzDQpJbnRyb2R1Y3Rpb24NCkdvb2dsZSANCiAgQW5hbHl0aWNzDQpDb250
ZW50IA0KICBQZXJmb3JtYW5jZSBBbmFseXNpcw0KR29hbHMgJiANCiAgRS1jb21tZXJjZSBU
cmFja2luZw0KVmlzaXRvcnMgDQogIEFuYWx5c2lzDQpTb2NpYWwgTWVkaWEgDQogIEFuYWx5
dGljcw0KQWN0aW9uYWJsZSANCiAgSW5zaWdodHMgYW5kIHRoZSBCaWcgUGljdHVyZQ0KU29j
aWFsIENSTSAmIA0KICBBbmFseXNpcw0KwqANCkdFTkVSQUwgDQpOT1RFUw0Kw5jCoCANClRo
aXMgY291cnNlIGlzIGRlbGl2ZXJlZCBieSBvdXIgc2Vhc29uZWQgdHJhaW5lcnMgd2hvIGhh
dmUgDQp2YXN0IGV4cGVyaWVuY2UgYXMgZXhwZXJ0IHByb2Zlc3Npb25hbHMgaW4gdGhlIHJl
c3BlY3RpdmUgZmllbGRzIG9mIHByYWN0aWNlLiANClRoZSBjb3Vyc2UgaXMgdGF1Z2h0IHRo
cm91Z2ggYSBtaXggb2YgcHJhY3RpY2FsIGFjdGl2aXRpZXMsIHRoZW9yeSwgZ3JvdXAgd29y
a3MgDQphbmQgY2FzZSBzdHVkaWVzLg0Kw5jCoCANClRyYWluaW5nIG1hbnVhbHMgYW5kIGFk
ZGl0aW9uYWwgcmVmZXJlbmNlIG1hdGVyaWFscyBhcmUgDQpwcm92aWRlZCB0byB0aGUgcGFy
dGljaXBhbnRzLg0Kw5jCoCANClVwb24gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMg
Y291cnNlLCBwYXJ0aWNpcGFudHMgDQp3aWxsIGJlIGlzc3VlZCB3aXRoIGEgY2VydGlmaWNh
dGUuDQrDmMKgIA0KV2UgY2FuIGFsc28gZG8gdGhpcyBhcyB0YWlsb3ItbWFkZSBjb3Vyc2Ug
dG8gbWVldCANCm9yZ2FuaXphdGlvbi13aWRlIG5lZWRzLiBDb250YWN0IHVzIHRvIGZpbmQg
b3V0IA0KbW9yZTrCoHRyYWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmcNCsOYwqAgDQpUaGUg
dHJhaW5pbmcgd2lsbCBiZSBjb25kdWN0ZWQgYXTCoFNraWxscyBmb3IgDQpBZnJpY2HCoFRy
YWluaW5nIEluc3RpdHV0ZSBpbiBOYWlyb2JpIEtlbnlhLg0Kw5jCoCANClRoZSB0cmFpbmlu
ZyBmZWUgY292ZXJzIHR1aXRpb24gZmVlcywgdHJhaW5pbmcgbWF0ZXJpYWxzLCANCmx1bmNo
IGFuZCB0cmFpbmluZyB2ZW51ZS4gQWNjb21tb2RhdGlvbiBhbmQgYWlycG9ydCB0cmFuc2Zl
ciBhcmUgYXJyYW5nZWQgZm9yIA0Kb3VyIHBhcnRpY2lwYW50cyB1cG9uIHJlcXVlc3QuDQrD
mMKgIA0KUGF5bWVudCBzaG91bGQgYmUgc2VudCB0byBvdXIgYmFuayBhY2NvdW50IGJlZm9y
ZSBzdGFydCBvZiANCnRyYWluaW5nIGFuZCBwcm9vZiBvZiBwYXltZW50IHNlbnQgDQp0bzrC
oHRyYWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmcNCsKgDQo8aHR0cHM6Ly8xMzNJSy50cmsu
ZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy91bnN1YnNjcmliZT9kPU1pS0djYXgwM2JMMExh
dWxaR1Q2aTdwX1lJSGF4VVFhdFlnU2I0VGxKOUxhTjFiS1hiNHFFRUlON0RwOE1CeUh0UEpK
WFBSMU1Ub1dHZjlJaDNMbjk2cFVLc1VZX202ZkRxcG1TRFhLbVd3ZjA+DQpVTlNVQlNDUklC
RQ==

--=-eZCfXWzj1nTKEdC4M8MgRh3j2hF31sp823WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: medium none; PADDING-RIGHT: 0cm; mso-eleme=
nt: para-border-div">
<P class=3DMsoNormal=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: medium none; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT=
: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: nor=
mal; PADDING-RIGHT: 0cm; mso-outline-level: 2; mso-border-bottom-alt: =
solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0pt 0cm"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMiE72A2vC3LmVK_vzZ-inQG33F1Ykib1HqSR=
a-tsJS2P3s4VJijTvUaMh5vAu-scs_0nedvaw9wMbE_5NdkchhYxzR4QcAa2TB4kssaXUu=
mJw1"><SPAN=20
style=3D"mso-spacerun: yes"><FONT face=3DCalibri>&nbsp;</FONT></SPAN><=
B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>TRAINING=20
COURSE ON DIGITAL/SOCIAL MEDIA SKILLS ON 18TH to 22ND APRIL 2022<?xml:=
namespace=20
prefix =3D "o" ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></B></A></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtObNGy_tQXUUWb5PhMW1WLPIcC1V204SprOj7=
peF66B2AwiEZv4I0Y93BVv7DT4KfdGFkznxBALXkS3rpoC-gq8mgGq0ooQlyY_WSKj_uQ7=
P4R6QRxE2-PCnHwFPuwNPE0V0" target=3D_blank>Register for=20
online workshop attendance <o:p></o:p></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtObNGy_tQXUUWb5PhMW1WLPIcC1V204SprOj7=
peF66B2ITZOD-inffcNMdj42XYdu4aDVE_xdtOOOG8U8GSkRpJUAsqAgyElG3TJo5XrlPU=
x_MoCEjN0HYR_WYbUP8KuMZj0" target=3D_blank><SPAN=20
style=3D"TEXT-DECORATION: none; text-underline: none">Register to atte=
nd the=20
workshop<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"'>=
<A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtObNGy_tQXUUWb5PhMW1WLPIcC1V204SprOj7=
peF66B2Jud9nImk0-1lc_C_GOU_EQe0KToA8obq7r92KrLe7zWuxRDpSJ_ftwpI5CFqbWC=
p3sfgOpGwqaJYpdojPiA3IF80" target=3D_blank><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></A></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxhtDnyAUVTLQJXA=
OFLE8hd2w7Riu8vuErJJgXw71suRyyD_aTBQ7H4O63NhNdvx_LeabLSamDH7O4vDQTxwME=
8jc1" target=3D_blank>Calendar for 2022=20
Workshops<o:p></o:p></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDAiQtUasBcEVTjSL=
g0YMnr5cb0xa0eVAZsgLD7cK8H8Lxi7MHbF3p5SMcurX1b1gAZilPDVc4I4h61cDYMvFwR=
sHo1" target=3D_blank>Contact=20
us<o:p></o:p></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejiepFS1rCB8wTg7FPKmtn18VKq1CdOT2T862T=
NfLV-Yeo588zSmWLGNhrLySGwcCG_sEKzP3fvSqpQ1m-rh-4aLN7zsYAVnNXMOiqVZZc9P=
kf01"=20
target=3D_blank>Whatapp<o:p></o:p></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 14pt; BACKGROUND: lime; mso-highlight: lime"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejiepFS1rCB8wTg7FPKmtn18907T4okDTslK89=
a_SdzJ0Zpvt-D3-DKHLy6o0ngBA3-6WZMq2wKtZaFuJgtssBlwNYDlxlO6Y4LuwN92ZX5D=
41O2tTi9kXIzVlrWd6f4jNfR0" target=3D_blank><FONT=20
face=3DCalibri>PARTICIPATION FEES: 1,200USD</FONT></A></SPAN></B><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 14pt"><o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>VENUE:=20
HILTON HOTEL, NAIROBI, KENYA<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Office=20
Telephone: +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Register=20
as a group of 5 or more participants and get 25% discount on the cours=
e fee.=20
<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Send=20
us an email: <A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DcBuTGyy=
wHvVirOjnJUaHQdVOF1XUy4kbjI4wI8K-4z1Gv05MyiYpIE4DXQ0898dug_bhuZc0OCEqI=
6KZ9Kv8jmR1FPcj0iIr2oPPtby7RP_11En7H7KWn6U8wROKgi_V5N6FW-ISYovm5hZ6gbO=
3rbtvoYN2k2Poy89IKBooC9nyZxtpU6k9biYIVvBfbp9U4jDhDpnyZic1ywaS8-uYJ-I1"=
 >training@skillsforafrica.org&nbsp;</A>or=20
call +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; =
LINE-HEIGHT: 15.75pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>INTRODUCTION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 15.75pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Digital=20
technology has revolutionized the way in which people communicate and =
share=20
information &#8211; at local, national and international levels. Organ=
izations,=20
including government, need to understand these changes so that they ca=
n operate=20
effectively in a dynamic media environment.<BR>Social media is a term =
used to=20
refer to online technologies and practices that are used to share opin=
ions and=20
information, promote discussion and build relationships. Social media =
services=20
and tools involve a combination of technology, telecommunications and =
some kind=20
of social interaction. They can use a variety of different formats, fo=
r example=20
text, pictures, video and audio.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 15.75pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Organizations,=20
individuals and corporates worldwide are waking up to the opportunity =
of this=20
revolutionary medium to fulfill various business objectives ranging fr=
om Sales,=20
Marketing, CRM, Product Development, and Research. This has created an=
=20
ever-increasing demand for skilled Digital Marketing knowledge and=20
professionals.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 15.75pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>In=20
the absence of formal avenues of Digital Marketing education, there is=
 a huge=20
gap of talented professionals.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 15.75pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>If=20
you are a <SPAN style=3D"BACKGROUND: white">Public Relations Officer,=20
Communication Officer,</SPAN> Business Owner, a Sales &amp; Marketing=20
professional or a Student who is serious about leveraging Digital Mark=
eting for=20
personal or organizational growth, then this course is for=20
you.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; TEXT-ALIGN: justify; MARGIN: 0cm 0c=
m 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>At=20
the end of this course the participants will be able to:<o:p></o:p></S=
PAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Incr=
ease=20
  organizations access to audiences and improve the accessibility of=20
  organization communication;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Enab=
le=20
  organizations to be more active in its relationships with clients, p=
artners=20
  and stakeholders;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Offe=
r greater=20
  scope to adjust or refocus communications quickly, where=20
  necessary;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Impr=
ove the=20
  long-term cost effectiveness of communication;<o:p></o:p></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Bene=
fit from the=20
  credibility of non-government channels;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Incr=
ease the=20
  speed of public feedback and input;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Reac=
h specific=20
  audiences on specific issues; and<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Redu=
ce=20
  organization dependence on traditional media channels and counter in=
accurate=20
  press coverage.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Attr=
act traffic=20
  to their website/online content and increase in=20
  sales/awareness.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Iden=
tify the=20
  audience and reach an unlimited number of prospective clients/audien=
ce using=20
  email and other tools and technique.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Get =
more value=20
  from online campaigns.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Work=
 with=20
  M.A.R.T. social media goals to achieve successful online=20
  campaigns.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Work=
=20
  cooperatively within an online community by observing and listening =
critically=20
  with openness, then act ethically and follow through on commitments =
when=20
  communicating with varied audiences and build positive reputation wi=
thin the=20
  community.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Expl=
ain how to=20
  develop effective online marketing strategies for various types of i=
ndustries=20
  and businesses.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Iden=
tify setup=20
  and use the major social media and online marketing portals that can=
 be used=20
  to promote a company, brand, product, service or=20
person.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uate a=20
  company&rsquo;s current situation, isolate online issues and provide=
 solutions by=20
  identifying appropriate social media and online marketing portals to=
 influence=20
  consumer and improve the company&rsquo;s reputation.<o:p></o:p></SPA=
N></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l1 level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Put =
together a=20
  social media and online marketing plan and track progress in achievi=
ng goals=20
  with a variety of measurement tools, services, and=20
  metrics.<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>DURATION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>5=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; BACKGR=
OUND: white; COLOR: black'>Press=20
Officers, Communication Officers, Public Relations Officers,</SPAN><SP=
AN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'> <SPAN=
=20
style=3D"BACKGROUND: white; COLOR: black">Digital Marketing Profession=
als,=20
Marketing Professionals, Journalists, Sales Professionals and others w=
ho are=20
responsible for publicity and media relations.</SPAN><SPAN=20
style=3D"COLOR: black"><o:p></o:p></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 15.75p=
t; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; BACKGR=
OUND: white; COLOR: black'>COURSE=20
CONTENT</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Disc=
ussing the=20
  digital/social media options and strategies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  Face-book pages: best practices for organizations<o:p></o:p></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  Twitter Profiles - Twitter Best Practices for=20
  organizations<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Shar=
ing photos=20
  and Videos online &#8211; options on mobile and social media<o:p></o=
:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Blog=
ging &#8211; how=20
  to participate in forums and blogs and how to form partnerships with=
 social=20
  media organizations;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Mobi=
le Web/and=20
  marketing<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Netw=
orking:=20
  Options for knowledge and information Sharing<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Effe=
ctive use of=20
  digital media for campaigns<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><B=20
  style=3D"mso-bidi-font-weight: normal"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Sear=
ch Engine=20
  Optimization (SEO)<o:p></o:p></SPAN></B></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is On-Page=20
  Optimization?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is OFF-Page=20
  Optimization?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Sear=
ch Engine=20
  Algorithms<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Sear=
ch Engine=20
  Marketing (SeM)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>SEM=20
  Overview<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Pay =
Per Click=20
  Overview<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Stra=
tegizing PPC=20
  campaigns<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Mark=
et=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Ad w=
riting=20
  Techniques<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Effe=
ctive=20
  landing pages<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deci=
pher User=20
  Psychology<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>SEM =
Management=20
  (Other Opportunities)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Pay =
per click=20
  overview<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Mark=
et=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Camp=
aign=20
  Management<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Bid =
Management=20
  Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Back=
=20
  Linking/Link Building<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Perf=
ormance=20
  Tracking<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Repo=
rting &amp;=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Test=
ing<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><B=20
  style=3D"mso-bidi-font-weight: normal"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Soci=
al Media=20
  Marketing (SMM)<o:p></o:p></SPAN></B></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Why =
care about=20
  Social Media?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Demy=
stifying=20
  Community Building on Facebook<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Crea=
ting a=20
  Twitter Marketing Strategy<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Leve=
raging=20
  LinkedIn for B2B Lead Generation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Meas=
uring the=20
  ROI of Social Media<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Crea=
ting a=20
  Facebook Marketing Strategy<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Twit=
ter: The=20
  Jewel in the Social Media Crown<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Disc=
ussion on=20
  other Social Media Channels<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Plan=
ning &amp;=20
  Creating Multi-channel Social Media Strategy<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><B=20
  style=3D"mso-bidi-font-weight: normal"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Emai=
l=20
  Marketing<o:p></o:p></SPAN></B></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deli=
verability<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Effe=
ctive Email=20
  Content<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Effe=
ctive=20
  Creative<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Cust=
omer=20
  Acquisition Strategies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Nurt=
uring &amp;=20
  Automation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Reso=
urces to do=20
  situational analysis and progressive updates<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><B=20
  style=3D"mso-bidi-font-weight: normal"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Inbo=
und=20
  Marketing<o:p></o:p></SPAN></B></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Attr=
acting your=20
  potential customers into the conversion funnel<o:p></o:p></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Conv=
ersion=20
  Optimization<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Conv=
ersion=20
  Optimization Patterns for Engaging Website Visitors<o:p></o:p></SPAN=
></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Life=
 Cycle=20
  Emails<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><B=20
  style=3D"mso-bidi-font-weight: normal"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Anal=
ytics<o:p></o:p></SPAN></B></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Goog=
le=20
  Analytics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Cont=
ent=20
  Performance Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Goal=
s &amp;=20
  E-commerce Tracking<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Visi=
tors=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Soci=
al Media=20
  Analytics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Acti=
onable=20
  Insights and the Big Picture<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 0pt; LINE-HEIGHT: 15.75pt; mso-margin-top-alt: auto; mso-li=
st: l2 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Soci=
al CRM &amp;=20
  Analysis<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>This course is delivered by our seasoned trainers=
 who have=20
vast experience as expert professionals in the respective fields of pr=
actice.=20
The course is taught through a mix of practical activities, theory, gr=
oup works=20
and case studies.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Training manuals and additional reference materia=
ls are=20
provided to the participants.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Upon successful completion of this course, partic=
ipants=20
will be issued with a certificate.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>We can also do this as tailor-made course to meet=
=20
organization-wide needs. Contact us to find out=20
more:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>The training will be conducted at&nbsp;Skills for=
=20
Africa&nbsp;Training Institute in Nairobi Kenya.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>The training fee covers tuition fees, training ma=
terials,=20
lunch and training venue. Accommodation and airport transfer are arran=
ged for=20
our participants upon request.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Payment should be sent to our bank account before=
 start of=20
training and proof of payment sent=20
to:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></P>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3D9=
nVH1fVwF9joOTBhuucT9w2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DMiKGcax03bL0LaulZGT6i7p_YIHaxUQatYgSb4TlJ9LaN1bKXb4qEEIN7D=
p8MByHtPJJXPR1MToWGf9Ih3Ln96pUKsUY_m6fDqpmSDXKmWwf0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfXWzj1nTKEdC4M8MgRh3j2hF31sp823WKzQ==--
