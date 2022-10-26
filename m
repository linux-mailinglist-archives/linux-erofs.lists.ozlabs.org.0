Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B5660E2BE
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Oct 2022 15:57:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4My9PC1S5kz3bhR
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 00:57:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=MK27hAnH;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=fu1nEjY2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.87.8; helo=n8.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=MK27hAnH;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=fu1nEjY2;
	dkim-atps=neutral
Received: from n8.mxout.mta4.net (n8.mxout.mta4.net [67.227.87.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4My9Nv4YsCz3bm6
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Oct 2022 00:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1666792627;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=mI8Z7o/eEaBHUhbY3Xg2WVubHS4jBLRlEEeTrvf7Kp4=;
	b=MK27hAnHFrTDQmx+oZ03mcTG9PD9jM5U1fLzLhzTHiE77NjGVnxXo2YBF0YEVjoDlQ4zxmn4+dN
	RG+Pv48v/JmflWhGQ93tVcMyE1M1qa75vXbRPvHdB+vVCp8kXgerc4X7x4OYPM8Ip0u4GH6sLSalo
	aafMuqcWgag/+BxLwYA=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1666792627;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=mI8Z7o/eEaBHUhbY3Xg2WVubHS4jBLRlEEeTrvf7Kp4=;
	b=fu1nEjY2PtByRE68a1eKEkCt4sBagtRaSpBsevd2HI1rc5twgWgW7s0IkqevgCJZ29soFJ9rIRe
	QUB165r9Q5YTd4nmdIv3XUPZa8WqqVz0FXu56HCw4B86A99BtFHq/Ur2CgkydeXEnR0lEawBJwjEh
	MjogieI0S6SuhDLgsBs=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 26 Oct 2022 13:57:07 +0000
Subject: Advanced Financial Management, Grants Management And Auditing For
 Donor Funded Projects from 7th To 18th November 2022
Message-Id: <4ui8leoh2c7u.r5mRkHQu1-eMzWgxGw1gzw2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: r5mRkHQu1-eMzWgxGw1gzw2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfFjfYzC7kFtLPJ8wCcx7GyiN1hPk/23WKzQ=="
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfFjfYzC7kFtLPJ8wCcx7GyiN1hPk/23WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4SmlwLWRjRzVL
QlpTZWxtNzJvOEhUNlJjUmV5aVBoQXhTSnRmaXN1cXZob1pueUd6Y0tLMmd4bEJJSEtTZDlp
R3p2Yk1BbGcwaFB1dGItVjczYl83RFhMZ0x5WnpBalNDYkhwWlVJOXgyU1FPNDE+DQpBZHZh
bmNlZCBGaW5hbmNpYWwgTWFuYWdlbWVudCwgR3JhbnRzIE1hbmFnZW1lbnQgQW5kIA0KQXVk
aXRpbmcgRm9yIERvbm9yIEZ1bmRlZCBQcm9qZWN0cyBPbiA3dGggVG8gMTh0aCBOb3ZlbWJl
ciANCjIwMjINCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tp
bmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRQ
ZVFUTVBfd29yQUg0bHdnQmxNWktnRnNvMHRoZGJkR3hCUERaWHJLLUduYm5saTB6ekJaZzdk
ZkM1MDYxTXRSeGFydlJKbm50MGlEMk5rRl90TmR0ejlCTTU5eHRiUXVOamJfeUt0S3R6Y2tP
YVRseklMc3JQOGIwWDBvZEVhMzhYMD4NClJlZ2lzdGVyIGZvciBvbmxpbmUgd29ya3Nob3Ag
YXR0ZW5kYW5jZSANCg0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90
cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3Nx
cXJUdFBlUVRNUF93b3JBSDRsd2dCbE1aS2dGc28wdGhkYmRHeEJQRFpYckstR25jWEJHUlhh
MG5velNoSkoxTFhRQUU2eW03NDJfeERaUlpNSUstWjBPckloN3pJM2NGaFJNWDBHWG1wdlpu
UDhDSWQwRXY5YTNJM3RXSjRYY1Rsck5MckMwPg0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJr
LmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhl
SjktUnQyMjVZWXNQbVdqTldzcXFyVHRQZVFUTVBfd29yQUg0bHdnQmxNWktnRnNvMHRoZGJk
R3hCUERaWHJLLUduWnZ6SzE1SFNON1FBTkx2bWp0bF94Q29kdFNDVTZNTUhZLUdFUzRabHVH
YV9OSEhMRDRPZXFDSlFYT0lHaVZyRUdXSW1Wa1gzc2FXTFRPT210aV82MWh2MD4NClJlZ2lz
dGVyIHRvIGF0dGVuZCB0aGUgDQp3b3Jrc2hvcA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxh
c3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1S
dDIyNVlZc1BtV2pOV3NxcXJUdFBlUVRNUF93b3JBSDRsd2dCbE1aS2dGc28wdGhkYmRHeEJQ
RFpYckstR25YcFVUUUhkbXhGV3hKZm45SDFqd2hOWkdZaWRPS1NURWF2NzRIQ2FqejhpZ2RF
T0NxSk00bmZJMHRkMUtPMzlnWk9HSXNQOFh1ZDlHbkNIQkxFM0txYjUwPg0KwqANCg0KPGh0
dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD00UlNP
R2VTNUhJNktGSml4UXB5a1VIN1NCRFNqMEEyRWRIZGNxcUVrLUtNTGRZR3RLMnJuVEdFT3BG
T3pjZGp4Q1R2eTdJWWczcXVZbmhHWWNIX2xUejJNOUhyMWZ4U3hoMHpvQlp4V19ySU1QY1ZG
MGxTVkNqV2hFYlgwYk5GQ0o0UnljU1pNeDBDTlgtYWItTUdfemtnMT4NCkNhbGVuZGFyIGZv
ciAyMDIyLzIwMjMgDQpXb3Jrc2hvcHMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFz
dGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdT
QkRTajBBMkVkSGRjcXFFay1LTWNLQlc1R3hqYnVYRmlWbzRFRFFEQUNRWTdJNi1iSGl6eXNI
eXZyZ3hZdUZwZG9iRklwT095ci1tME5UU3lJUjZhYUZpYmNfSTgwcnhDaF9tSUppaG5sQ0Zx
YnRzMmplTXNkbjhUaXgzck9OSTE+DQpDb250YWN0IHVzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVRkTzFnQ3VRNzFocFdM
NjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9lamluNFQ2eTM2XzFtNHZ4Y2M0ODI0S1NBU1dX
Z3drY2Q5ZzlKekpWcVJ6VzdkcE5VOWhTeHBFMlNra2EyaTNHanEzRWhLWnpFbHRaTDFmV0h2
YnBCRTJHR0FCbHV4TkJnM280cFNiMlNKLXB0eVUxPg0KV2hhdGFwcA0KwqANClZFTlVFOiBC
RVNUIFdFU1RFUk4gDQpNRVJJRElBTiBIT1RFTCwgTkFJUk9CSSwgS0VOWUENCkNPVVJTRSBG
RUU6IA0KMiw0MDBVU0QNCk9mZmljZSBUZWxlcGhvbmU6IA0KKzI1NC03MDItMjQ5LTQ0OQ0K
UmVnaXN0ZXIgYXMgYSBncm91cCBvZiA1IA0Kb3IgbW9yZSBwYXJ0aWNpcGFudHMgYW5kIGdl
dCAyNSUgZGlzY291bnQgb24gdGhlIGNvdXJzZSBmZWUuIA0KDQpTZW5kIHVzIGFuIGVtYWls
OiANCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9cmFfS3JxdXltX3ZBSDdhMHhmeWlSUlJKMG1tTW9nbnlnNTZrbVBlSkRjT0FUZzVoUmtO
NGptSE13RXpGMHpndE80OEtOTnVMR1Vkd2xHMXFLalVuYlVNMkllVDBJY09XYmZKbGxUNDJK
c1hmNlkxOVFoV0M4b0tDZzB3R1ZoTU1IYUNOcFRoTEYzelFVaFJCTU5obUxFZzg0ZV9KU2tV
SmNMQVRZYWtGdlI5VkRIRi0yV1U0bUZQdHhhbUJWMWg4N1NCTFMzbTNEeEVhY3NHZ2lzYWVQ
RnpTWVFvamZvRWlUUmxPNFRoVDlwQ0IwPg0KdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9y
Z8Kgb3IgDQpjYWxsICsyNTQtNzAyLTI0OS00NDkNCklOVFJPRFVDVElPTg0KVGhpcyBjb3Vy
c2UgaXMgZGVzaWduZWQgDQp0byBlbmFibGUgdGhvc2UgaW52b2x2ZWQgd2l0aCBncmFudCBt
YW5hZ2VtZW50IHRvIGJlY29tZSBlZmZpY2llbnQgYW5kIGVmZmVjdGl2ZSANCmluIHRoZSBh
Y3F1aXNpdGlvbiBhbmQgdXRpbGl6YXRpb24gb2YgZnVuZHMgZm9yIGRldmVsb3BtZW50IHB1
cnBvc2VzLCB1c2luZyANCmFwcHJvcHJpYXRlIHRlY2huaXF1ZXMgYW5kIGFwcGxpY2F0aW9u
IG9mIGFjY291bnRpbmcgYW5kIGZpbmFuY2UgDQpwcmluY2lwbGVzLg0KV0hPIFNIT1VMRCAN
CkFUVEVORA0KRmluYW5jZSBEaXJlY3RvcnMsIA0KRmluYW5jZSBNYW5hZ2VycywgUHJvY3Vy
ZW1lbnQgRGlyZWN0b3JzLCBQcm9jdXJlbWVudCBtYW5hZ2VycywgUHJvY3VyZW1lbnQgDQpv
ZmZpY2VycywgQWRtaW5pc3RyYXRvcnMsIFByb2plY3Qgb2ZmaWNlcnMsIEJ1ZGdldCBBY2Nv
dW50YW50cywgQXVkaXRvcnMsIENoaWVmIA0KQWNjb3VudGFudHMsIENyZWRpdCBDb250cm9s
bGVycw0KQ09VUlNFIA0KT0JKRUNUSVZFUw0KQXQgdGhlIGVuZCBvZiB0aGUgDQpjb3Vyc2Us
IHBhcnRpY2lwYW50cyB3aWxsIGJlIGFibGUgdG86DQrigKIgSWRlbnRpZnkgYW5kIHVuZGVy
c3RhbmQgdGhlIGNyaXRpY2FsIA0KdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgZ3JhbnQgYWlk
OyBmb3IgZG9ub3ItZnVuZGVkIHByb2plY3RzDQrigKIgRW5zdXJlIA0KY29tcGxpYW5jZSB3
aXRoIGRvbm9yIHRlcm1zIGFuZCBjb25kaXRpb25zOw0K4oCiIFByb3ZpZGluZyBzdXBwb3J0
aW5nIGRvY3VtZW50cywgDQpjb3JyZWN0IHByb2N1cmVtZW50IG9mIGdvb2RzIGFuZCBzZXJ2
aWNlcyBhbmQgbWVldGluZyBmaW5hbmNpYWwgcmVwb3J0aW5nIA0KcmVxdWlyZW1lbnRzOw0K
4oCiIE1hbmFnaW5nIG11bHRpcGxlLWZ1bmRlZCBwcm9ncmFtbWVzDQrigKIgUHJvdmlkZSB0
b29scyBmb3IgDQplZmZpY2llbnQgTWFuYWdlbWVudCBvZiBEb25vci0gZnVuZGVkIHByb2pl
Y3QNCuKAoiBEZXNpZ24gYW5kIG1vbml0b3IgZG9ub3IgDQpidWRnZXRzDQrigKIgUHJlcGFy
ZSBhIGRvbm9yIGZpbmFuY2lhbCByZXBvcnQgdG8gbWF0Y2ggd2l0aCBhIHByb2plY3QgbmFy
cmF0aXZlIA0KcmVwb3J0Ow0K4oCiIERlc2NyaWJlIHRoZSBwaGFzZXMgaW4gdGhlIGdyYW50
IG1hbmFnZW1lbnQgY3ljbGUgY2xhcmlmeSBrZXkgDQpyZXNwb25zaWJpbGl0aWVzIGFuZCBy
b3V0aW5lcyBuZWVkZWQgZm9yIHN1Y2Nlc3NmdWwgZ3JhbnQgbWFuYWdlbWVudDsNCuKAoiAN
CklkZW50aWZ5IHRoZSByZXF1aXJlbWVudHMgZm9yIGNsb3Npbmcgb2ZmIGEgZG9ub3IgZ3Jh
bnQ7DQrigKIgTWFuYWdlIHRoZSANCnJlbGF0aW9uc2hpcCB3aXRoIGRvbm9ycywgaGVhZCBv
ZmZpY2UgYW5kIGltcGxlbWVudGluZyBwYXJ0bmVycyB3aXRoIGdyZWF0ZXIgDQpjb25maWRl
bmNlOw0K4oCiIEFwcHJlY2lhdGUgdGhhdCBmaW5hbmNlIGFuZCBwcm9ncmFtbWUgc3RhZmYg
bXVzdCB3b3JrIGNsb3NlbHkgDQpmb3IgU3VjY2Vzc2Z1bCBncmFudCBtYW5hZ2VtZW50Lg0K
RFVSQVRJT04NCjEwIA0KRGF5cw0KQ09VUlNFIA0KQ09OVEVOVDoNCuKAoiBPdmVydmlldyBv
ZiBHcmFudHMgDQpNYW5hZ2VtZW50IEN5Y2xlDQrigKIgRGV2ZWxvcGluZyBwcm9wb3NhbA0K
4oCiIEJ1ZGdldGluZw0K4oCiIFR5cGVzIG9mIA0KY29zdHMNCuKAoiBHcmFudCBBd2FyZCBD
b250cmFjdCwNCuKAoiBBd2FyZCBSZXZpZXcsDQrigKIgRnVuZHJhaXNpbmcgVGlwcywgDQpJ
bXBsZW1lbnRhdGlvbiwgQ29tcGxpYW5jZQ0K4oCiIEVsaWdpYmxlIGFuZCBpbmVsaWdpYmxl
IGNvc3RzLA0K4oCiIENvc3QgU2hhcmUvIA0KTWF0Y2hpbmcgY29zdHMsDQrigKIgUHJvY3Vy
ZW1lbnQgUHJvY2VkdXJlcywNCuKAoiBHcmFudCBUcmFja2luZyBUb29scywgOg0K4oCiIA0K
Q29zdHMgZWxpZ2liaWxpdHksIGFkbWluaXN0cmF0aW9uDQrigKIgUHJvZ3JhbW1lIGV2YWx1
YXRpb24NCuKAoiBHcmFudCANClJlcG9ydGluZywNCuKAoiBGaW5hbmNpYWwgRG9jdW1lbnRh
dGlvbiBhbmQgUmVwb3J0aW5nDQrigKIgRG9jdW1lbnRhdGlvbiwgDQpJbnRlcm5hbCBDb250
cm9sczsgQXVkaXQsIE5hcnJhdGl2ZSBSZXBvcnRpbmcsIFBhcnRuZXJzaGlwcyAmIGNvbnNv
cnRpYSANCm1hbmFnZW1lbnQsIERvbm9yIENvbXBsaWFuY2UsDQrigKIgUGVyc29ubmVsICZT
dGFmZiBJc3N1ZXMgKGV0aGljcykgOiANCkNvbnRyYWN0cywgVGltZSBzaGVldHMsIFRyYXZl
bCAmIFBlciBkaWVtOiBJdGluZXJhcnksIGFzc2lnbmluZywgQXNzZXRzIA0KJiBJbnZlbnRv
cnkgTWFuYWdlbWVudCwgQ28tRmluYW5jaW5nICYNCuKAoiBNdWx0aS0gRG9ub3IgRnVuZGlu
ZywgDQpJbmRpcmVjdCBDb3N0cyAmIENvbnRpbmdlbmNpZXMsIENsb3NlIE91dCBQcm9jZWR1
cmVzICYgdGhlIEZpbmFsIA0KVHJhbmNoZS4NCuKAoiBCYXNpYyBjb25jZXB0cyBpbiBncmFu
dCBtYW5hZ2VtZW50DQrigKIgS2V5IGNoYWxsZW5nZXMgaW4gZ3JhbnQgDQptYW5hZ2VtZW50
DQrigKIgVGhlIGdyYW50IG1hbmFnZW1lbnQgbGlmZSBjeWNsZQ0K4oCiIEdyYW50IG1hbmFn
ZW1lbnQgcGxhbg0K4oCiIA0KUmVzcG9uc2liaWxpdGllcyBhbmQgcm91dGluZXMgaW4gZ3Jh
bnQgbWFuYWdlbWVudA0K4oCiIFRoZSBmbG93IG9mIGRvbm9yIA0KZnVuZHMNCuKAoiBBc3Nl
c3NpbmcgdGhlIHRlcm1zIGFuZCBjb25kaXRpb25zIGluIGdyYW50IGFncmVlbWVudHMNCuKA
oiBHcmFudCANCmFncmVlbWVudHMsIGFuZCBhY2NvdW50aW5nIGFuZCBwcm9jdXJlbWVudCBz
eXN0ZW1zDQrigKIgQ29tcGx5aW5nIHdpdGggZG9ub3IgDQpyZXBvcnRpbmcgcmVxdWlyZW1l
bnRzDQrigKIgTWFuYWdpbmcga2V5IHJlbGF0aW9uc2hpcHMgZm9yIHN1Y2Nlc3NmdWwgZ3Jh
bnQgDQptYW5hZ2VtZW50DQrigKIgQ29tbXVuaXR5IERldmVsb3BtZW50IA0KYW5kIFByb2pl
Y3RzIGZ1bmRpbmcNCuKAoiBGdW5kaW5nIHJlcXVpcmVtZW50cw0K4oCiIFByb2plY3QgZmlu
YW5jZQ0K4oCiIENhcGl0YWwgDQpCdWRnZXRpbmcgYW5kIEludmVzdG1lbnQgQXBwcmFpc2Fs
DQrigKIgRG9ub3IgUG9saWNpZXMgYW5kIHByb2NlZHVyZXMNCuKAoiANCkNvbXBseWluZyB3
aXRoIERvbm9yIHByb2NlZHVyZXMNCuKAoiBEaXNidXJzZW1lbnQgbWV0aG9kcw0K4oCiIEJh
bmtpbmc6IExvYW4gDQpNYW5hZ2VtZW50L1BheW1lbnQNCuKAoiBFeHBlbmRpdHVyZSBCdWRn
ZXRzDQrigKIgUHJvamVjdCBCdWRnZXRpbmcgYW5kIA0KUGxhbm5pbmcNCuKAoiBQcm9qZWN0
IEZpbmFuY2lhbCBNYW5hZ2VtZW50DQrigKIgRmluYW5jaWFsIFJpc2sgQW5hbHlzaXMgDQpU
ZWNobmlxdWVzDQrigKIgRmluYW5jaWFsIFBlcmZvcm1hbmNlIE1lYXN1cmVtZW50DQrigKIg
QnVkZ2V0aW5nIGFuZCBCdWRnZXRhcnkgDQpDb250cm9sDQrigKIgSW50ZXJuYWwgQ29udHJv
bCBhbmQgQ29udHJvbCBNZWNoYW5pc21zDQrigKIgSW50ZWdyYXRlZCBhY2NvdW50aW5nIA0K
JiBGaW5hbmNpYWwgU3lzdGVtcw0K4oCiIEFjY291bnRpbmcgcG9saWNpZXMgYW5kIHN5c3Rl
bXMNCuKAoiBBdWRpdGluZyBvZiANCmZpbmFuY2lhbCBzdGF0ZW1lbnRzDQrigKIgTWFuYWdl
bWVudCBDb250cm9sIEZyYW1ld29yaw0K4oCiIEF1ZGl0b3LigJlzIGR1dGllcyBhbmQgDQpy
ZXNwb25zaWJpbGl0aWVzDQrigKIgS25vd2xlZGdlIG9mIHRoZSBMYXcgaW4gcmVsYXRpb24g
dG8gYWNjb3VudHMgYW5kIA0KYXVkaXQNCuKAoiBJbnRlcm5hbCBjb250cm9scw0K4oCiIFJp
c2sgYXNzZXNzbWVudA0K4oCiIENvZGUgb2YgcHJvZmVzc2lvbmFsIA0KQ29uZHVjdCBhbmQg
RXRoaWNzDQrigKIgUHJlcGFyYXRpb24gb2YgQXVkaXRpbmcgUHJvY2VkdXJlcw0K4oCiIFBs
YW5uaW5nIGFuZCANClB1Ymxpc2hpbmcgdGhlIGF1ZGl0IHNjaGVkdWxlDQrigKIgUGVyaW9k
aWMgcmVwb3J0cw0K4oCiIFByb2plY3QgTWFuYWdlbWVudCANCnJlcG9ydHMNCuKAoiBGaW5h
bmNpYWwgUmVwb3J0aW5nIChQZXJpb2RpYyBSZXF1aXJlbWVudHMpIA0K4oCiIFRoZSByb2xl
IG9mIGdvdmVybm1lbnQgDQppbiBkb25vciBmdW5kZWQgcHJvamVjdHMuDQrCoA0KR0VORVJB
TCANCk5PVEVTDQrDmMKgIA0KVGhpcyBjb3Vyc2UgDQppcyBkZWxpdmVyZWQgYnkgb3VyIHNl
YXNvbmVkIHRyYWluZXJzIHdobyBoYXZlIHZhc3QgZXhwZXJpZW5jZSBhcyBleHBlcnQgDQpw
cm9mZXNzaW9uYWxzIGluIHRoZSByZXNwZWN0aXZlIGZpZWxkcyBvZiBwcmFjdGljZS4gVGhl
IGNvdXJzZSBpcyB0YXVnaHQgdGhyb3VnaCANCmEgbWl4IG9mIHByYWN0aWNhbCBhY3Rpdml0
aWVzLCB0aGVvcnksIGdyb3VwIHdvcmtzIGFuZCBjYXNlIA0Kc3R1ZGllcy4NCsOYwqAgDQpU
cmFpbmluZyANCm1hbnVhbHMgYW5kIGFkZGl0aW9uYWwgcmVmZXJlbmNlIG1hdGVyaWFscyBh
cmUgcHJvdmlkZWQgdG8gdGhlIA0KcGFydGljaXBhbnRzLg0Kw5jCoCANClVwb24gDQpzdWNj
ZXNzZnVsIGNvbXBsZXRpb24gb2YgdGhpcyBjb3Vyc2UsIHBhcnRpY2lwYW50cyB3aWxsIGJl
IGlzc3VlZCB3aXRoIGEgDQpjZXJ0aWZpY2F0ZS4NCsOYwqAgDQpXZSBjYW4gYWxzbyANCmRv
IHRoaXMgYXMgdGFpbG9yLW1hZGUgY291cnNlIHRvIG1lZXQgb3JnYW5pemF0aW9uLXdpZGUg
bmVlZHMuIENvbnRhY3QgdXMgdG8gDQpmaW5kIG91dCBtb3JlOsKgdHJhaW5pbmdAc2tpbGxz
Zm9yYWZyaWNhLm9yZw0Kw5jCoCANClRoZSANCnRyYWluaW5nIHdpbGwgYmUgY29uZHVjdGVk
IGF0wqBTa2lsbHMgZm9yIEFmcmljYcKgVHJhaW5pbmcgSW5zdGl0dXRlIGluIA0KTmFpcm9i
aSBLZW55YS4NCsOYwqAgDQpUaGUgDQp0cmFpbmluZyBmZWUgY292ZXJzIHR1aXRpb24gZmVl
cywgdHJhaW5pbmcgbWF0ZXJpYWxzLCBsdW5jaCBhbmQgdHJhaW5pbmcgdmVudWUuIA0KQWNj
b21tb2RhdGlvbiBhbmQgYWlycG9ydCB0cmFuc2ZlciBhcmUgYXJyYW5nZWQgZm9yIG91ciBw
YXJ0aWNpcGFudHMgdXBvbiANCnJlcXVlc3QuDQrDmMKgIA0KUGF5bWVudCANCnNob3VsZCBi
ZSBzZW50IHRvIG91ciBiYW5rIGFjY291bnQgYmVmb3JlIHN0YXJ0IG9mIHRyYWluaW5nIGFu
ZCBwcm9vZiBvZiBwYXltZW50IA0Kc2VudCB0bzrCoHRyYWluaW5nQHNraWxsc2ZvcmFmcmlj
YS5vcmcNCsKgDQrCoA0KwqANCsKgDQrCoMKgDQrCoA0KPGh0dHBzOi8vMTMzSUsudHJrLmVs
YXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvdW5zdWJzY3JpYmU/ZD1salpMZ1hIcmUwZHlMR0hy
Tll2MFpLYmhTeE1wTEJ0bXdkMzVGVWI4WVF2YlRqb3hPblBQeXpCYk1UcXQ1QUlZMTg1LXNh
UFQ4dHh6YTJ1cGx4WmpTc00zbXAzdHFubkxDSzF1S3N2WjlPT0IwPg0KVU5TVUJTQ1JJQkU=

--=-eZCfFjfYzC7kFtLPJ8wCcx7GyiN1hPk/23WKzQ==
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
nt: para-border-div"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin"><?xml:namespace=20
prefix =3D "o" ns =3D "urn:schemas-microsoft-com:office:office" /><o:p=
><FONT=20
face=3DCalibri>
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: medium none; PADDING-RIGHT: 0cm; mso-eleme=
nt: para-border-div"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: medium none; PADDING-RIGHT: 0cm; mso-eleme=
nt: para-border-div">
<P class=3DMsoNormal=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: medium none; PADDING-BOTTOM: 0cm; TEXT-ALIGN: justify; PADDING-T=
OP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm =
0pt; LINE-HEIGHT: normal; PADDING-RIGHT: 0cm; mso-outline-level: 2; ms=
o-border-bottom-alt: solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0=
pt 0cm"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28Jip-dcG5KBZSelm72o8HT6RcReyiPhAxSJtf=
isuqvhoZnyGzcKK2gxlBIHKSd9iGzvbMAlg0hPutb-V73b_7DXLgLyZzAjSCbHpZUI9x2S=
QO41"><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">Advanced Financial Management, Grants Managem=
ent And=20
Auditing For Donor Funded Projects On 7th To 18th November=20
2022<o:p></o:p></FONT></FONT></SPAN></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgFso0thdbdGxBPD=
ZXrK-Gnbnli0zzBZg7dfC5061MtRxarvRJnnt0iD2NkF_tNdtz9BM59xtbQuNjb_yKtKtz=
ckOaTlzILsrP8b0X0odEa38X0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">Register for online workshop attendance=20
<o:p></o:p></FONT></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgFso0thdbdGxBPD=
ZXrK-GncXBGRXa0nozShJJ1LXQAE6ym742_xDZRZMIK-Z0OrIh7zI3cFhRMX0GXmpvZnP8=
CId0Ev9a3I3tWJ4XcTlrNLrC0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgFso0thdbdGxBPD=
ZXrK-GnZvzK15HSN7QANLvmjtl_xCodtSCU6MMHY-GES4ZluGa_NHHLD4OeqCJQXOIGiVr=
EGWImVkX3saWLTOOmti_61hv0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">Register to attend the=20
workshop<o:p></o:p></FONT></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgFso0thdbdGxBPD=
ZXrK-GnXpUTQHdmxFWxJfn9H1jwhNZGYidOKSTEav74HCajz8igdEOCqJM4nfI0td1KO39=
gZOGIsP8Xud9GnCHBLE3Kqb50" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxCTvy7IYg3quYnh=
GYcH_lTz2M9Hr1fxSxh0zoBZxW_rIMPcVF0lSVCjWhEbX0bNFCJ4RycSZMx0CNX-ab-MG_=
zkg1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Calendar for 2022/2023=20
Workshops<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">&nbsp;<o:p></=
o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDACQY7I6-bHizysH=
yvrgxYuFpdobFIpOOyr-m0NTSyIR6aaFibc_I80rxCh_mIJihnlCFqbts2jeMsdn8Tix3r=
ONI1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Contact us<o:p></o:p></FONT></SPAN></A></SPAN=
></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">&nbsp;<o:p></=
o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejin4T6y36_1m4vxcc4824KSASWWgwkcd9g9Jz=
JVqRzW7dpNU9hSxpE2Skka2i3Gjq3EhKZzEltZL1fWHvbpBE2GGABluxNBg3o4pSb2SJ-p=
tyU1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Whatapp<o:p></o:p></FONT></SPAN></A></SPAN></=
U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">&nbsp;<o:p></=
o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">VENUE: BEST W=
ESTERN=20
MERIDIAN HOTEL, NAIROBI, KENYA<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">COURSE FEE:=20
2,400USD<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">Office Teleph=
one:=20
+254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">Register as a=
 group of 5=20
or more participants and get 25% discount on the course fee.=20
<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">Send us an em=
ail: <A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMHaCNpThLF3zQUhRBMNh=
mLEg84e_JSkUJcLATYakFvR9VDHF-2WU4mFPtxamBV1h87SBLS3m3DxEacsGgisaePFzSY=
QojfoEiTRlO4ThT9pCB0" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082=20
face=3D"Times New Roman">training@skillsforafrica.org&nbsp;</FONT></SP=
AN></A>or=20
call +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 12pt 0cm 0pt; LINE-HEIGHT: norma=
l"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">INTRODUCTION<=
/SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p></o:p></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 5.25pt; LINE-HEIGHT: 15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">This course i=
s designed=20
to enable those involved with grant management to become efficient and=
 effective=20
in the acquisition and utilization of funds for development purposes, =
using=20
appropriate techniques and application of accounting and finance=20
principles.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 12pt; LINE-HEIGHT: 15pt"><=
B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">WHO SHOULD=20
ATTEND</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p></o:p></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 5.25pt; LINE-HEIGHT: 15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">Finance Direc=
tors,=20
Finance Managers, Procurement Directors, Procurement managers, Procure=
ment=20
officers, Administrators, Project officers, Budget Accountants, Audito=
rs, Chief=20
Accountants, Credit Controllers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 12pt; LINE-HEIGHT: 17.15pt=
"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><BR>At the en=
d of the=20
course, participants will be able to:<BR>&#8226; Identify and understa=
nd the critical=20
terms and conditions of grant aid; for donor-funded projects<BR>&#8226=
; Ensure=20
compliance with donor terms and conditions;<BR>&#8226; Providing suppo=
rting documents,=20
correct procurement of goods and services and meeting financial report=
ing=20
requirements;<BR>&#8226; Managing multiple-funded programmes<BR>&#8226=
; Provide tools for=20
efficient Management of Donor- funded project<BR>&#8226; Design and mo=
nitor donor=20
budgets<BR>&#8226; Prepare a donor financial report to match with a pr=
oject narrative=20
report;<BR>&#8226; Describe the phases in the grant management cycle c=
larify key=20
responsibilities and routines needed for successful grant management;<=
BR>&#8226;=20
Identify the requirements for closing off a donor grant;<BR>&#8226; Ma=
nage the=20
relationship with donors, head office and implementing partners with g=
reater=20
confidence;<BR>&#8226; Appreciate that finance and programme staff mus=
t work closely=20
for Successful grant management.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 12pt; LINE-HEIGHT: 16.5p=
t"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">DURATION</SPA=
N></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p></o:p></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 12pt; LINE-HEIGHT: 16.5p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">10=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">COURSE=20
CONTENT:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><BR>&#8226; O=
verview of Grants=20
Management Cycle<BR>&#8226; Developing proposal<BR>&#8226; Budgeting<B=
R>&#8226; Types of=20
costs<BR>&#8226; Grant Award Contract,<BR>&#8226; Award Review,<BR>&#8=
226; Fundraising Tips,=20
Implementation, Compliance<BR>&#8226; Eligible and ineligible costs,<B=
R>&#8226; Cost Share/=20
Matching costs,<BR>&#8226; Procurement Procedures,<BR>&#8226; Grant Tr=
acking Tools, :<BR>&#8226;=20
Costs eligibility, administration<BR>&#8226; Programme evaluation<BR>&=
#8226; Grant=20
Reporting,<BR>&#8226; Financial Documentation and Reporting<BR>&#8226;=
 Documentation,=20
Internal Controls; Audit, Narrative Reporting, Partnerships &amp; cons=
ortia=20
management, Donor Compliance,<BR>&#8226; Personnel &amp;Staff Issues (=
ethics) :=20
Contracts, Time sheets, Travel &amp; Per diem: Itinerary, assigning, A=
ssets=20
&amp; Inventory Management, Co-Financing &amp;<BR>&#8226; Multi- Donor=
 Funding,=20
Indirect Costs &amp; Contingencies, Close Out Procedures &amp; the Fin=
al=20
Tranche.<BR>&#8226; Basic concepts in grant management<BR>&#8226; Key =
challenges in grant=20
management<BR>&#8226; The grant management life cycle<BR>&#8226; Grant=
 management plan<BR>&#8226;=20
Responsibilities and routines in grant management<BR>&#8226; The flow =
of donor=20
funds<BR>&#8226; Assessing the terms and conditions in grant agreement=
s<BR>&#8226; Grant=20
agreements, and accounting and procurement systems<BR>&#8226; Complyin=
g with donor=20
reporting requirements<BR>&#8226; Managing key relationships for succe=
ssful grant=20
management<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">&#8226; Commu=
nity Development=20
and Projects funding<BR>&#8226; Funding requirements<BR>&#8226; Projec=
t finance<BR>&#8226; Capital=20
Budgeting and Investment Appraisal<BR>&#8226; Donor Policies and proce=
dures<BR>&#8226;=20
Complying with Donor procedures<BR>&#8226; Disbursement methods<BR>&#8=
226; Banking: Loan=20
Management/Payment<BR>&#8226; Expenditure Budgets<BR>&#8226; Project B=
udgeting and=20
Planning<BR>&#8226; Project Financial Management<BR>&#8226; Financial =
Risk Analysis=20
Techniques<BR>&#8226; Financial Performance Measurement<BR>&#8226; Bud=
geting and Budgetary=20
Control<BR>&#8226; Internal Control and Control Mechanisms<BR>&#8226; =
Integrated accounting=20
&amp; Financial Systems<BR>&#8226; Accounting policies and systems<BR>=
&#8226; Auditing of=20
financial statements<BR>&#8226; Management Control Framework<BR>&#8226=
; Auditor&rsquo;s duties and=20
responsibilities<BR>&#8226; Knowledge of the Law in relation to accoun=
ts and=20
audit<BR>&#8226; Internal controls<BR>&#8226; Risk assessment<BR>&#822=
6; Code of professional=20
Conduct and Ethics<BR>&#8226; Preparation of Auditing Procedures<BR>&#=
8226; Planning and=20
Publishing the audit schedule<BR>&#8226; Periodic reports<BR>&#8226; P=
roject Management=20
reports<BR>&#8226; Financial Reporting (Periodic Requirements) <o:p></=
o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">&#8226; The r=
ole of government=20
in donor funded projects.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'><o:p>&=
nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p></o:p></=
SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>This course=20
is delivered by our seasoned trainers who have vast experience as expe=
rt=20
professionals in the respective fields of practice. The course is taug=
ht through=20
a mix of practical activities, theory, group works and case=20
studies.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>Training=20
manuals and additional reference materials are provided to the=20
participants.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>Upon=20
successful completion of this course, participants will be issued with=
 a=20
certificate.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>We can also=20
do this as tailor-made course to meet organization-wide needs. Contact=
 us to=20
find out more:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; text-underline: none">training@skillsforafrica.org</SPAN><=
/A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>The=20
training will be conducted at&nbsp;Skills for Africa&nbsp;Training Ins=
titute in=20
Nairobi Kenya.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>The=20
training fee covers tuition fees, training materials, lunch and traini=
ng venue.=20
Accommodation and airport transfer are arranged for our participants u=
pon=20
request.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D'FONT-FAMILY: "Calibri",sans-serif'=
>Payment=20
should be sent to our bank account before start of training and proof =
of payment=20
sent to:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; text-underline: none">training@skillsforafrica.org</SPAN><=
/A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><o:p>=
<FONT=20
face=3D"Times New Roman">&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><o:p>&nbsp;</o:p><=
/P>
<P class=3DMsoNormal=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: medium none; PADDING-BOTTOM: 0cm; TEXT-ALIGN: justify; PADDING-T=
OP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm =
0pt; LINE-HEIGHT: normal; PADDING-RIGHT: 0cm; mso-outline-level: 2; ms=
o-border-bottom-alt: solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0=
pt 0cm"></SPAN>&nbsp;</P></DIV>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt">&nbsp=
;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin"><o:p>&nbsp;</o:p></SPAN></P>&nbsp;</=
FONT></o:p></SPAN></DIV>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Dr=
5mRkHQu1-eMzWgxGw1gzw2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DljZLgXHre0dyLGHrNYv0ZKbhSxMpLBtmwd35FUb8YQvbTjoxOnPPyzBbMT=
qt5AIY185-saPT8txza2uplxZjSsM3mp3tqnnLCK1uKsvZ9OOB0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfFjfYzC7kFtLPJ8wCcx7GyiN1hPk/23WKzQ==--
