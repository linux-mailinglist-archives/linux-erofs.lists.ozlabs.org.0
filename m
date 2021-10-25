Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B643986D
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 16:24:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdHJq2tTkz2xZL
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 01:24:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256 header.s=api header.b=PQ19AhXU;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=LuuXUAYx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Too many DNS
 lookups) smtp.mailfrom=fdc-k.or.ke (client-ip=176.31.7.123;
 helo=mail1123.elasticemail.info; envelope-from=workshops@fdc-k.or.ke;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256
 header.s=api header.b=PQ19AhXU; 
 dkim=pass (1024-bit key;
 unprotected) header.d=elasticemail.com header.i=@elasticemail.com
 header.a=rsa-sha256 header.s=api header.b=LuuXUAYx; 
 dkim-atps=neutral
X-Greylist: delayed 83 seconds by postgrey-1.36 at boromir;
 Tue, 26 Oct 2021 01:24:17 AEDT
Received: from mail1123.elasticemail.info (mail1123.elasticemail.info
 [176.31.7.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdHJd08VFz2xWj
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Oct 2021 01:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=fdc-k.or.ke; s=api; c=relaxed/simple;
 t=1635171740; h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
 bh=etBQ5FUAH6HZvs+3E2aQuduEmrYbzh9HSTxFZafcucI=;
 b=PQ19AhXUSeaklaDgf+4Z1b0O5e/vY6SWfvSWKxOivYlLED9J7T48HbHfcqYNA42cX5hoQtNOCEd
 pBitPO6j2PQOWIoJ4Ihba08PLk9Guh8HNIDaDczLuAzSfJbwp12bTnRbJklpJh0HTVDr0hjrQok/B
 hxgQIyBx4cSTgNtAhrQ=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
 c=relaxed/simple; t=1635171740;
 h=from:date:subject:reply-to:to:list-unsubscribe;
 bh=etBQ5FUAH6HZvs+3E2aQuduEmrYbzh9HSTxFZafcucI=;
 b=LuuXUAYxcLBNZ8VquKKtedmgZ4MKZD2z18zOhu+24JngafFgHEv9YeZ1n/PH8e7eh6UOl6VlkTz
 3ebRCNOqK7ewfREXTLf7GjxLSgIkRBVuNh2hCnTD9yFG0NiSin0vJIG0xg+R/lX2ngY/sfdt7/QsP
 OkhCFnCgDvPCtpn73oM=
From: Foscore Development Center <workshops@fdc-k.or.ke>
Date: Mon, 25 Oct 2021 14:22:20 +0000
Subject: Invitation to Gender Mainstreaming, Analysis and Planning Workshop
 Nov 29 to Dec 03,2021 for 5 Days Hilton Hotel,Nairobi Kenya
Message-Id: <4uf4iaby98ox.TZSs2eyHh2zL1bAAhwWvhg2@XC82.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: TZSs2eyHh2zL1bAAhwWvhg2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=-eZCfMFjm7XfJPu+WONMDOCvg8wx14ugty3WKzQ=="
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
Reply-To: workshops@fdc-k.or.ke
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfMFjm7XfJPu+WONMDOCvg8wx14ugty3WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9
ZmxubHJZTnk5dWZQWjVsQ2wzczVneVEwUUtkSlUzWEhQQjZsR0ZDcFF0WXRqVUhqREFZYVF4
Mk1fSTV0VGl1UEVsYS1iUzdkZnFvZ2ZzNEw3SVhpeDNKaS1pbUh5YnI0TWxCS2JWYVMtTXk2
TGRfVGpoZ01kWHBESDhQQnN4QjlEMEZYQXZ1ajV1alpoVDVpaHIyaThVa0dFUnZtZEZsWmhC
NkVSclprNDBFWGtRazkwbjQtRUwtaU53NmZ0WHRKbXZlcGpJTE9TSTdJeTlDUjE0YU85WHlj
TzZxS095dTFrTlZnclRnWFE0RXUwPg0KR2VuZGVyIA0KTWFpbnN0cmVhbWluZywgQW5hbHlz
aXMgYW5kIFBsYW5uaW5nwqBXb3Jrc2hvcCBOb3YgMjkgdG8gRGVjIDAzLDIwMjEgZm9yIDUg
DQpEYXlzDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcv
Y2xpY2s/ZD1rN3ZyQm8wdDQwU01zOXM4RmstWFllT2VZMGpLSDJrcUxfS3pCazllSEdidkZO
Znl0WUhrc2tDTm5wSFQwN0hqSkJ2TnJCTnc5aEMza3hpSEs5aURTS0FJTmFpbzN2LVRZa0x3
WTFVNXNRdkFoWmFoU0ppbl9ydXJ4QWtUeUt2anBkTWlnUl9SdlBQZTZTclpZLWpTQWRPUEJI
YXVDbHN1QkZkR1k3SmdLejBWRU5iNGE0clFLY0RobjJBQXFsVUdvUGdyX3RJSzNuMmF3czFQ
bVVSaTFXSW5kTDI1aHpGT25zbUI0dlNKZUFwNEdqSC1vTjFHQlRBbXY2Ni1mWVhBNHJrR2U3
c0pNVmZFMUJCd2JYS2lhNFkxPg0KUmVnaXN0ZXIgZm9yIG9ubGluZSBhdHRlbmRhbmNlIA0K
V29ya3Nob3ANCsKgDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJh
Y2tpbmcvY2xpY2s/ZD1PZWdVX1Mya1cyTUpKU1V0VjR5V05TYnJJSWdqNFlZR1J0MHNLc3lJ
WTcxOVJ6cjlNS0JoaXc0Z0NDbFFhb2VPX1FhQkxINHF0WHJWNEZvZUxmZi1sOFNaeTVjWkVT
OEtNenMxc3J4U3c5b3F3eEpZU0NqX1ZnVms5SGxCU1lnRGxha2p5aVBxVUlnRHY1OU9LX0xk
ZEZIcm95VzJDeUFVekZ4WmVkVnowSzBlM09uLWsyZGR5aktnaVh4d0JadV9lTlJwV09ac01m
VnVYLWtiOHpFVlpjUEI3aU5qOWNCVDRlaUt2OUNUbEQ4QzYxMmVsRlRLSHJQOHRZSnZIb21W
ZXlFY194VHVFamZFRnFEZkhVZGpZemMxPg0KUmVnaXN0ZXIgb25zaXRlIGF0dGVuZGFuY2Ug
DQp3b3Jrc2hvcA0KwqANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90
cmFja2luZy9jbGljaz9kPWh2UVp6ZkVyNmJSWDVTTW5QTG1oTjBqUnJGTjRMT1VkUHc4ZVhN
elZLclpqdnlPcHVEd0lXdjlZT2FobTEyRk1EN19JazVkZHMzRnpXVVRzektPSG53NmxoeWg2
ZHd0dlJ5dWNVQXJOeWhoNG9mZU5TZ1VQTnh0VjhmTERKT0hpM0RuQnEyZ3BhMTRlX3Buc085
cTgzSmhZV0xURmwxbHdTLXhXODRjSDNvU19fbVhDelVIY2kxZm56eGFTU2dLQkszQ0JBUF95
eEhXSzVleG9wSDkyVzJHYlRFUHdTd0V6OC1yRksxSGVrWTJFa1ZVTGpyMUx0QTBfVzlnXzJ5
NVA0MFZWWW5Xall2T0FKbnRCRlVtSjk4VTE+DQpHcm91cCANClJlZ2lzdHJhdGlvbiBIZXJl
DQrCoA0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2Ns
aWNrP2Q9c3JlQndvRHpZZGdqM2JPYUJDUkJzVWpmQmw3SU5zOG02Rzc4ODBGTzkzaVBtNllj
aW9NVmloYkd0NWc5d3ZwN2ROaUwzVjFTbGVOOHEyNmFpQ1BwLXRtNHdYb25TVXVsRjhxa0lL
c0hPeDE4aWZlU1RVSWVwTTJqUkJuRjRxak5RSXczTWo1cU1fLU1vMVNlWEVOVXNaNVVVQmpk
WkUwdGR2S1RmNFpGbEYwUjA+DQpEb3dubG9hZCBQREYgQ2FsZW5kYXIgMjAyMS0yMDIyIFdv
cmtzaG9wcw0KwqANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFj
a2luZy9jbGljaz9kPUl1RGI1ZlQ0ZmFwR0VwS0RlYktaNXJIODkyNkJLbDlJeEdiMVctbUMw
aElDa0F5UTZFOC1WT0ZfenhGaW1WWE55UkRsczAybVN4TWZsUmU1LVQ0OVBRaVh0ZkQxZFY1
TjRHUk1KSi1zdmhHb2xMb0JqUU9COTM3akJ2YzdYRDJ0bkJ4RzcwSnBfeEFVcTMyQWtiZ2M1
UlkxPg0KQ29udGFjdCANCnVzDQrCoA0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1h
aWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9UkFueWY4TFgyZkFobWV1UlBKRGxEQ2ZXeExiV1Vj
TTljUjIwWkExTm1tcGVpdFlCTU04M3RBRGt4Z2tpLWkzQW0xcFQydkpoU3lERE9PYUVENnpt
TUYtN1hmdzNWcFBRWlJTLW56NG42WXBlX28xSDBRbG05TG1mRXJ0M2pfX2tUMURJTlJIakMx
ekhCQ1ZJRXdwdGhmRTE+DQpXaGF0YXBwDQrCoA0KVkVOVUU6IA0KSElMVE9OIEhPVEVMLCBO
QUlST0JJIEtFTllBDQrCoA0KT0ZGSUNJQUwgDQpFTUFJTCBBRERSRVNTOsKgDQo8bWFpbHRv
OnRyYWluaW5nQGZkYy1rLm9yZz4NCnRyYWluaW5nQGZkYy1rLm9yZw0KT2ZmaWNlIA0KVGVs
ZXBob25lOiArMjU0NzEyMjYwMDMxDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFp
bC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1ibll0a1VOUGkzc0dReGRReDdfLUo4OTVlVkNPUm1x
VXFpNFprV2tzTGk1MTUtaXZxVDhSNHd6SWh5c1JaMWxZM3RpWTlUSHd3eHd1bjdRVVdjWEV6
NGFQZDhselFSWkdFcVg2TWJCUFlmQW5WcTRhMWZNSFQ3QXR0SDdadi13M3R1NDBUYkpLc0hI
c0RrOUxIYWFoSG9RdTcxamFmS1lyTFlibGxNOXNHd1MwMD4NCk91ciAyMDIxIC0gMjAyMiBQ
cm9mZXNzaW9uYWwgU2hvcnQgVHJhaW5pbmcgDQpDb3Vyc2VzDQpSZWdpc3RlciANCmFzIGEg
Z3JvdXAgb2YgNSBvciBtb3JlIHBhcnRpY2lwYW50cyBhbmQgZ2V0IDIwJSBkaXNjb3VudCBv
biBjb3Vyc2UgZmVlLiBTZW5kIHVzIA0KZW1haWwgdG8gdHJhaW5pbmdAZmRjLWsub3JnIG9y
IGNhbGwgKzI1NDcxMjI2MDAzMQ0KwqANCklOVFJPRFVDVElPTg0KR2VuZGVyIGVxdWFsaXR5
IA0KYW5kIGVtcG93ZXJtZW50IGlzIGNvbnNpZGVyZWQgYSBjcml0aWNhbCBlbGVtZW50IGZv
ciBkZXZlbG9wbWVudC4gVGhpcyBjb3Vyc2UgaXMgDQpkZXNpZ25lZCB0byBwcmVwYXJlIHBh
cnRpY2lwYW50cyBmb3IgYSB2YXJpZXR5IG9mIGNhcmVlcnMgd2hlcmUgc3BlY2lhbGl6ZWQg
DQprbm93bGVkZ2UgaXMgcmVxdWlyZWQgcmVsYXRlZCB0byB0aGUgaW50ZWdyYXRpb24gb2Yg
Z2VuZGVyIGNvbnNpZGVyYXRpb25zIGludG8gDQpwb2xpY3kgbWFraW5nLCBwcm9qZWN0IGRl
c2lnbiBhbmQgaW1wbGVtZW50YXRpb24sIG1vbml0b3JpbmcgYW5kIGV2YWx1YXRpb24uIA0K
R2VuZGVyIG1haW5zdHJlYW1pbmcgaXMgYW4gaW50ZXJuYXRpb25hbCBzdHJhdGVneSB0byBh
Y2hpZXZlIGdlbmRlciBlcXVhbGl0eSBpbiANCmFsbCBhc3BlY3RzIG9mIHNvY2lldHkuIE1h
bnkgZ292ZXJubWVudHMgaW4gZGV2ZWxvcGluZyBhbmQgZGV2ZWxvcGVkIGNvdW50cmllcyAN
CmhhdmUgZW5kZWF2b3JlZCB0byBpbXBsZW1lbnQgdGhpcyBzdHJhdGVneS4gVGhpcyBjb3Vy
c2UgYWltcyB0byBwcm92aWRlIA0KcGFydGljaXBhbnRzIHdpdGggYSBjb21wcmVoZW5zaXZl
IGtub3dsZWRnZSBvZiBnZW5kZXIgbWFpbnN0cmVhbWluZyBhbmQgZ2VuZGVyIA0KYW5hbHlz
aXMuIEl0IGRyYXdzIG9uIGJlc3QgcHJhY3RpY2UgYW5kIGNhc2Ugc3R1ZGllcyBmcm9tIGFy
b3VuZCB0aGUgd29ybGQuIEFzIA0Kd2VsbCwgaXQgcHJvdmlkZXMgdGhlIG9wcG9ydHVuaXR5
IHRvIGZvY3VzIG9uIGEgc3BlY2lmaWMgcG9saWN5IGFyZWEgKHN1Y2ggYXMgDQpwdWJsaWMg
aGVhbHRoLCBlZHVjYXRpb24sIGVjb25vbWljIG1hbmFnZW1lbnQsIG9yIGh1bWFuIHJlc291
cmNlcykgb3IgZm9yIA0KcGFydGljaXBhbnRzIHRvIGVtcGxveSB0aGlzIGtub3dsZWRnZSBp
biB0aGVpciBvd24gd29ya3BsYWNlIHRocm91Z2ggYW4gYWN0aW9uIA0KcmVzZWFyY2ggdG9w
aWMuDQpPQkpFQ1RJVkVTDQpCeSB0aGUgZW5kIG9mIHRoZSANCmNvdXJzZSwgdGhlIHBhcnRp
Y2lwYW50IHNob3VsZCBiZSBhYmxlIHRvOw0KwrcgSGF2ZSBleHBsb3JlZCANCiAgdGhlIGlu
dHJpbnNpYyByZWxhdGlvbnNoaXAgYmV0d2VlbiBnZW5kZXIgYW5kIGRldmVsb3BtZW50DQrC
tyBCZSBhYmxlIHRvIA0KICBpbnRlZ3JhdGUgZ2VuZGVyIGludG8gY29udGV4dHVhbCBhbmFs
eXNpcywgYW5kIHRvIHVzZSBnZW5kZXIgYW5hbHlzaXMgDQogIGZyYW1ld29ya3MgZWZmZWN0
aXZlbHkNCsK3IEJlIGJldHRlciANCiAgZXF1aXBwZWQgdG8gaW50ZWdyYXRlIGdlbmRlciBp
bnRvIHN0cmF0ZWdpYyBhbmQgb3BlcmF0aW9uYWwgDQogIHBsYW5uaW5nDQrCtyBIYXZlIGFj
cXVpcmVkIA0KICBtZXRob2RzIG9mIGNyZWF0aW5nIGdlbmRlciBhd2FyZW5lc3Mgd2l0aGlu
IGRldmVsb3BtZW50IA0KcHJhY3RpY2UNCldobyBzaG91bGQgDQphdHRlbmQ6DQpHZW5kZXIg
YWR2aXNlcnMsIA0KZGV2ZWxvcG1lbnQgcHJhY3RpdGlvbmVycyB3aXRoIGFuIGludGVyZXN0
IGluIGdlbmRlciBtYWluc3RyZWFtaW5nLCBnZW5kZXIgZm9jYWwgDQpwb2ludHMNCkRVUkFU
SU9ODQo1IGRheXMNClRPUElDUyBUTyBCRSANCkNPVkVSRUQNCkJhc2ljIGNvbmNlcHRzIG9u
IA0KZ2VuZGVyIG1haW5zdHJlYW1pbmcNCkN1cnJlbnQgDQogIGRldmVsb3BtZW50IGNvbnRl
eHQuIEdlbmRlciBFcXVhbGl0eSBpbiB0aGUgU0RHcyBhbmQgMjAzMCBhZ2VuZGENCkdsb2Jh
bCANCiAgY29tbWl0bWVudHMgdG8gR2VuZGVyIG1haW5zdHJlYW1pbmcNClJhdGlvbmFsZXMg
Zm9yIA0KICBnZW5kZXIgbWFpbnN0cmVhbWluZw0KV2hhdCBpcyBnZW5kZXIgDQogIG1haW5z
dHJlYW1pbmc/DQpNdWx0aXBsZSANCiAgc3RyYXRlZ2llcyBmb3IgYXBwbHlpbmcgZ2VuZGVy
IG1haW5zdHJlYW1pbmcuIFdoeSBubyBvbmUgc2l6ZSBmaXRzIGFsbCANCiAgc29sdXRpb24g
aXMgcG9zc2libGU/DQpBZGRlZCB2YWx1ZSBvZiANCiAgZ2VuZGVyIG1haW5zdHJlYW1pbmcN
CsKgR2VuZGVyIA0KaW50ZWdyYXRpb24gZnJhbWV3b3JrIGFuZCBTZW5zaXRpemF0aW9uwqAN
CsKgR2VuZGVyIA0KYW5hbHlzaXMNCkVuZ2FnaW5nIG1lbiANCiAgYW5kIGJveXMNCk92ZXJj
b21pbmcgDQogIHJlc2lzdGFuY2UNCkFwcGx5aW5nIGdlbmRlciANCiAgbWFpbnN0cmVhbWlu
ZyAoaW5kaXZpZHVhbCB3b3JrKQ0KR2VuZGVyIA0KbWFpbnN0cmVhbWluZw0KVG9vbHMgZm9y
IA0KICBnZW5kZXIgbWFpbnN0cmVhbWluZyBhbmQgYW5hbHlzaXMNCkFwcGx5aW5nIGdlbmRl
ciANCiAgbWFpbnN0cmVhbWluZyAoc21hbGwgZ3JvdXAgd29yaykNCkdlbmRlciBhbmFseXNp
cyANCiAgYW5kIGdlbmRlciBwbGFubmluZyB0b29scw0KVGhlIGltcGFjdCBvZiANCiAgZ2Vu
ZGVyIGluZXF1YWxpdHkgb24gZWNvbm9taWMgZ3Jvd3RoIGFuZCBzdXN0YWluYWJsZSANCmRl
dmVsb3BtZW50Ow0KQ29tbXVuaWNhdGlvbiBpbiANCmdlbmRlcg0KU2V4dWFsLWJhc2VkIA0K
ICBiYXJyaWVycyB0byBjb21tdW5pY2F0aW9uO8KgDQpCb2R5IA0KICBsYW5ndWFnZQ0KSG93
IHRvIGNyZWF0ZSANCiAgdGhlIHJpZ2h0IGltYWdlDQpEZWFsaW5nIHdpdGggDQogIG1lZGlh
OyBhbmQgY29tbXVuaWNhdGlvbiBzZWNyZXRzIG9mIGdyZWF0IGxlYWRlcnMuDQpHZW5kZXIg
DQpNYWluc3RyZWFtaW5nIGluIEluc3RpdHV0aW9ucw0KR2VuZGVyIA0KICBtYWluc3RyZWFt
aW5nIGluIGtleSBvcmdhbml6YXRpb25hbCBjb21wb25lbnRzLiBPcHBvcnR1bml0aWVzIGFu
ZCANCiAgY2hhbGxlbmdlcw0KKE9yZ2FuaXphdGlvbmFsIA0KICBjdWx0dXJlOyBIdW1hbiBy
ZXNvdXJjZXM7IFN0YWZmIGFjY291bnRhYmlsaXR5IGFuZCBpbmNlbnRpdmVzIGZvciBnZW5k
ZXIgDQogIG1haW5zdHJlYW1pbmc7IGZpbmFuY2lhbCByZXNvdXJjZXMgYW5kIGJ1ZGdldCkN
Ck5vbnRyYWRpdGlvbmFsIA0KICBpbnN0aXR1dGlvbnMNCkdlbmRlciANCk1haW5zdHJlYW1p
bmcgaW4gUHVibGljIFBvbGljaWVzDQpHZW5kZXIgDQogIEFuYWx5c2lzDQpEZXNpZ24sIA0K
ICBpbXBsZW1lbnRhdGlvbiBhbmQgZXZhbHVhdGlvbiBvZiBwdWJsaWMgcG9saWNpZXMNCkdl
bmRlciANCiAgcmVzcG9uc2l2ZSBidWRnZXRpbmcNCkdlbmRlciANCiAgcmVzcG9uc2l2ZSBw
b2xpY3kgLSBtYWtpbmcgYW5kIGJ1ZGdldGluZw0KwqBHZW5lcmFsIE5vdGVzDQpBbGwgDQog
IG91ciBjb3Vyc2VzIGNhbiBiZSBUYWlsb3ItbWFkZSB0byBwYXJ0aWNpcGFudHMgbmVlZHMg
ICAgDQpUaGUgDQogIHBhcnRpY2lwYW50IG11c3QgYmUgY29udmVyc2FudCB3aXRoIEVuZ2xp
c2ggICAgDQpQcmVzZW50YXRpb25zIA0KICBhcmUgd2VsbCBndWlkZWQsIHByYWN0aWNhbCBl
eGVyY2lzZSwgd2ViIGJhc2VkIHR1dG9yaWFscyBhbmQgZ3JvdXAgd29yay4gT3VyIA0KICBm
YWNpbGl0YXRvcnMgYXJlIGV4cGVydCB3aXRoIG1vcmUgdGhhbiAxMHllYXJzIG9mIA0KICBl
eHBlcmllbmNlLiAgICANClVwb24gDQogIGNvbXBsZXRpb24gb2YgdHJhaW5pbmcgdGhlIHBh
cnRpY2lwYW50IHdpbGwgYmUgaXNzdWVkIHdpdGggRm9zY29yZSBkZXZlbG9wbWVudCANCiAg
Y2VudGVyIGNlcnRpZmljYXRlIChGREMtSykgICAgDQpUcmFpbmluZyANCiAgd2lsbCBiZSBk
b25lIGF0IEZvc2NvcmUgZGV2ZWxvcG1lbnQgY2VudGVyIChGREMtSykgY2VudGVyIGluIE5h
aXJvYmkgS2VueWEuIFdlIA0KICBhbHNvIG9mZmVyIG1vcmUgdGhhbiBmaXZlIHBhcnRpY2lw
YW50cyB0cmFpbmluZyBhdCByZXF1ZXN0ZWQgbG9jYXRpb24gd2l0aGluIA0KICBLZW55YSwg
bW9yZSB0aGFuIHRlbiBwYXJ0aWNpcGFudCB3aXRoaW4gZWFzdCBBZnJpY2EgYW5kIG1vcmUg
dGhhbiB0d2VudHkgDQogIHBhcnRpY2lwYW50IGFsbCBvdmVyIHRoZSB3b3JsZC4gICAgDQpD
b3Vyc2UgDQogIGR1cmF0aW9uIGlzIGZsZXhpYmxlIGFuZCB0aGUgY29udGVudHMgY2FuIGJl
IG1vZGlmaWVkIHRvIGZpdCBhbnkgbnVtYmVyIG9mIA0KICBkYXlzLiAgICANClRoZSANCiAg
Y291cnNlIGZlZSBpbmNsdWRlcyBmYWNpbGl0YXRpb24gdHJhaW5pbmcgbWF0ZXJpYWxzLCAy
IGNvZmZlZSBicmVha3MsIGJ1ZmZldCANCiAgbHVuY2ggYW5kIGEgQ2VydGlmaWNhdGUgb2Yg
c3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIFRyYWluaW5nLiBQYXJ0aWNpcGFudHMgDQogIHdp
bGwgYmUgcmVzcG9uc2libGUgZm9yIHRoZWlyIG93biB0cmF2ZWwgZXhwZW5zZXMgYW5kIGFy
cmFuZ2VtZW50cywgYWlycG9ydCANCiAgdHJhbnNmZXJzLCB2aXNhIGFwcGxpY2F0aW9uIGRp
bm5lcnMsIGhlYWx0aC9hY2NpZGVudCBpbnN1cmFuY2UgYW5kIG90aGVyIA0KICBwZXJzb25h
bCBleHBlbnNlcy4gICAgDQpBY2NvbW1vZGF0aW9uLCANCiAgcGlja3VwLCBmcmVpZ2h0IGJv
b2tpbmcgYW5kIFZpc2EgcHJvY2Vzc2luZyBhcnJhbmdlbWVudCwgYXJlIGRvbmUgb24gcmVx
dWVzdCwgDQogIGF0IGRpc2NvdW50ZWQgcHJpY2VzLiAgICANCk9uZSANCiAgeWVhciBmcmVl
IENvbnN1bHRhdGlvbiBhbmQgQ29hY2hpbmcgcHJvdmlkZWQgYWZ0ZXIgdGhlIA0KICBjb3Vy
c2UuICAgIA0KUmVnaXN0ZXIgDQogIGFzIGEgZ3JvdXAgb2YgbW9yZSB0aGFuIHR3byBhbmQg
ZW5qb3kgZGlzY291bnQgb2YgKDEwJSB0byA1MCUpIHBsdXMgZnJlZSBmaXZlIA0KICBob3Vy
IGFkdmVudHVyZSBkcml2ZSB0byB0aGUgTmF0aW9uYWwgZ2FtZSBwYXJrLiAgICANClBheW1l
bnQgDQogIHNob3VsZCBiZSBkb25lIHR3byB3ZWVrIGJlZm9yZSBjb21tZW5jZSBvZiB0aGUg
dHJhaW5pbmcsIHRvIEZPU0NPUkUgDQogIERFVkVMT1BNRU5UIENFTlRFUiBhY2NvdW50LCBz
byBhcyB0byBlbmFibGUgdXMgcHJlcGFyZSBiZXR0ZXIgZm9yIA0KICB5b3UuICAgIA0KRm9y
IA0KICBhbnkgZW5xdWlyeSB0bzp0cmFpbmluZ0BmZGMtay5vcmcgb3IgKzI1NDcxMjI2MDAz
MQ0KT1RIRVIgDQpVUENPTUlORyBXT1JLU0hPUFMgRk9SIMKgTk9WIDIwMjEgKCBDTElDSyBM
SU5LIFRPIFJFR0lTVEVSIEZPUiBUSEUgV09SS1NIT1AgDQpBUyBJTkRJVklEVUFMIE9SIEdS
T1VQKQ0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2Ns
aWNrP2Q9M1NQRmlkQ1VzRkFIOUpHMk1GRjZzV2tGMExHZjlMeThsTFVqLWZVNUw4VnFOanNn
blhlX1VLRzItN3IxUjhEQ3M5RFV3amNjbEtwQmhoTkhHMUhKb0tiNU9HcFpVa3pKT3Y2bUhR
d3pLTTlKaGYwUEhQbFppOHp2SVNsWUN3bFBkUDIwVld2UEVGd3JzUTdMamtSd3lEWVN5WlEx
RUoteE52dld0dnh6ZHBGQm9ZSDRscUNFcF9FNEw2ajNuS3FCVjhTak1SRXAxR05IY1NGa0xN
TVlRdkJpdGFwRnViSktQbjMyU21QRlhfeWxpbUw3YTE5Z3NFMjIxbGNQN2twTGF3Mj4NCkVs
ZWN0cm9uaWMgRG9jdW1lbnQgJiBSZWNvcmRzIE1hbmFnZW1lbnQgY291cnNlIE5vdiAwMSAN
CiAgICAgICAgdG8gTm92IDA1LDIwMjEgICAgDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0
aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1BSGJPYjZ2RjhCR2pGMHNScC1KQVR6bUsz
TElRY0Y3ZVlLZjluSWtOU2tWQjM1VjI1dVpsbTZjSm0wb0loNVg2cWVheGdhSUpTVWpvUkgt
azQtSy1Ea0dHZGtkb2lFMTJ1b0hGdGR2SS1VU1M3MnJXYU9VZG9UZ3JTWFRsOXA5ZVdmY3gt
Ujl3dllrTXN3bUQyOWxGcDhwcmYybUNhRkRpS2ZhbERuN3B5b3kySVJ0T0tWOElkbV9EZ0lL
TVQ4TEtkSmRrR2N4amNxYUY0NXpSa2UyajEzSHliRExCYTlubS1XMUpNRHUwdWZKU1pNRnla
cUF5V0J1OVluRV82R3dUWUJQejVoLVdJWm1YdllMUzVBcFh4TVdaSllVT0dMeTFfcnRxSnM5
VWFSamgwPg0KRmluYW5jaWFsIE1hbmFnZW1lbnQsIEJ1ZGdldGluZyBhbmQgQXVkaXRpbmcg
b2YgRG9ub3IgDQogICAgICAgIEZ1bmRlZCBQcm9qZWN0cyBjb3Vyc2UgTm92IDA4IHRvIE5v
diANCiAgICAgICAgMTksMjAyMSAgICANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2Vt
YWlsLmNvbS90cmFja2luZy9jbGljaz9kPUN4Mlpybkp0NHlUbGpSRjNMbGJSMUgtVThDc09F
amhHelRnVmpBMUF6ekw3TExaRXlDSnh5djdsVmV1Q2d4ZFhKYXlaSmQzYThDeE50Sl9FWlJH
RWhaWEczUnEwWk5DTmVnejBKbDc1b0FPeDcxcVRqUThxU2swRGx0Qk9qeVByS25hMVdpYjcy
alFnUThwQW4ybnozeDZjUE5nckZEd3JmZVBQOXZZY01OZ3VXc2w2MXd2VHhfSVhrYkhWbWl1
dnF5dVh2YlV1SWJ3ZEJaaDI1WS1Jc2t1Zmc2Sk1QYWhnVlF1OVpmMnFXdkJtYVB1VkdXdGZ1
anR1RDdrdUtINXgzOURad2VleEF0N0FtVXFwYTM5bFJaTmVmMlNLVnZfNWhPWkpHMVhQLTRq
NTA+DQpQcm9qZWN0IA0KICAgICAgICBNb25pdG9yaW5nIGFuZCBFdmFsdWF0aW9uIHdpdGgg
RGF0YSBNYW5hZ2VtZW50IGFuZCBBbmFseXNpcyANCiAgICAgICAgY291cnNlICAgIMKgTm92
IDA4IHRvIE5vdiAxOSwyMDIxIA0KICAgICAgICANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxh
c3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPW1XV2diaTB2WGU2eVBSdkZ6NTFqakg2
V2lKNUtmbmJ0M0M4SW1TYk01cHdKM1oySGxKaFBwTVZzd0YyRVVBZHprT1hqUGRnLXRid05X
Uk5KenZiZGNLTmlYY1NrRzJzYlR4d1BlQU9sTktOeHhEMlRhWTlMRHV2TTdfSHFRTlBjTzNq
Vm5vREFMTDNuMnJDWlJmQU10MEptLUxvNzEwVUF1c2J4bDVlQ2pvd0hYX0JuOEFRX3NXaTZo
QWxtU1RTNWlXWUM1UndHMWxaUlRsVnRwWjVTa19sNmwtb09SN3VNb3dWdjVPZHlkRTV6SGdm
eHZHZHh1NnpOaHpWZEV5a2lfQTI+DQpSZW1vdGUgc2Vuc2luZyBhbmQgR0lTIGZvciBwdWJs
aWMgaGVhbHRoIGFuZCBlcGlkZW1pb2xvZ3kgDQogICAgICAgIE5vdiAwOCB0byAxOSwyMDIx
ICAgIA0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2Ns
aWNrP2Q9X21YWmozZldSR29PbFM3UkxoN0JybWR2blNOTGNhTkVxZ2otdmpGeWxIbDg5VG1G
ZXhvQjhra3I2TmZzaDN4Qm5TeVU3LWJ1Z3FKdVRmSWhqLVlNbXpYZVJaSlJUb2R3YnNuYzJO
bVpUT1FrYTJfR2d3QlV0VUFiWkRjWHplbjVNLUJMbm9nU1J3TW1UQ1BncVJPOVh6RTYzN0dT
aWRrY2s0aXhOcVM0bVdhZnRrOE12U29tRkNFS0JMYXI1T0hXVjdxVGZFTXBaWnNWZEZiTGFC
STdnRm5BWFNacHRubWNzWndRSC1SWHVCSFN2UVd5M2licTVTV3RPR2R6MzRpRGppZmdYY1Rk
NlVCb2FwNjVlQ09lSk5DdkhUVzVtc242TEtlWDBOS3BsODZvazkxSHBYQTRxeGtadFRyZm92
a1lXdzI+DQpSZXNlYXJjaCBEZXNpZ24sT0RLIE1vYmlsZSBEYXRhIENvbGxlY3Rpb24sR0lT
IE1hcHBpbmcsIA0KICAgICAgICBEYXRhIEFuYWx5c2lzIHVzaW5nIE5WSVZPIGFuZCBTVEFU
QcKgDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9X21YWmozZldSR29PbFM3UkxoN0JybWR2blNOTGNhTkVxZ2otdmpGeWxIbDg5VG1GZXhv
Qjhra3I2TmZzaDN4Qm5TeVU3LWJ1Z3FKdVRmSWhqLVlNbXpYZVJaSlJUb2R3YnNuYzJObVpU
T1FrYTJfR2d3QlV0VUFiWkRjWHplbjVNLUJMbm9nU1J3TW1UQ1BncVJPOVh6RTYzN0dTaWRr
Y2s0aXhOcVM0bVdhZnRrOE12U29tRkNFS0JMYXI1T0hXVjdxVGZFTXBaWnNWZEZiTGFCSTdn
Rm5BWFNacHRubWNzWndRSC1SWHVCSG14Qm0tQk9FLVBzcWdObzY2cjlyN3owa3lwd2tVTWl0
NTBwaFFLUndRS1FaRTNNVk9PbFZuVUh1V3ZVeVRDOGpjS2RIOFBrQm5zT3d4M1h0WFh4VEUt
ZzI+DQpDb3Vyc2UgTm92IDE1IHRvIE5vdiAyNiwyMDIxICAgIA0KDQo8aHR0cHM6Ly9YQzgy
LnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9RlpaM2FQaUthMW15ejFU
TXlDeWNLRDFZSWtoMFJqWkJ6a1FzZjJsbDRQVm5mUnczVnlRTHVkS0NvSVV2OW1jUTFyTHBW
dHhrc1ZFVVN3VGU1NkRkU28xQWZ3ZDZtbHA3d0pkX0xZUGZyRDFhOEQzYnNqUUdrRHFYX2Ni
MG9oU2Rjdl9qd0otVHI3OVNId0Y1eEEycmdsLVh4aHJUZV9SM3U2eGI4aUlyVGJiQlFpTmE4
U2FxcmhIeHdrS2szQ3MtT1FhNm9Sb0FGRkYwQ2FMXzliNXZOeXM2MV9rR1ZrU2RSMi0zODFR
VlE1aGxfNjRGYUpiaE9HS21fUkJ3RW4xQ3R3Mj4NClRyYW5zZm9ybWF0aW9uYWwgTGVhZGVy
c2hpcCBhbmQgR292ZXJuYW5jZSBDb3Vyc2UgTm92IDE1IA0KICAgICAgICB0byBOb3YgMTks
MjAyMSAgICANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2lu
Zy9jbGljaz9kPUgwSjRvaV9ldjZhOTd4T1E1WS00bUs0WXU1NVlXNFZMaEZqeXpzdVhjbGZC
NlFXemtwM2dMZkMwNWZNd045QUt2eWo2WUxWdmE3TEtiaHNuZE44OEgyWFc1N3U0NEhzX1NH
S0hxMFdpTUVwdlEwYTZhSjdsR3FnUlhCRjJaRUtlLU8xVW1zUVpVSWprNjNBWXFTMmRuSk4x
bWhJRHBNR011Rkh1cFFqaE4wZjMzeUR6NlMweThnOEEwU3BOUnJpTGdGbkdPMVZaMlhMZzVX
Z2VUSGw1ZzlUblJWeDV4U0pQUTdFYUUwVEhzVUF0RWdlNWh6ZEM5UVZuZXZnTkFaSDVmZzI+
DQpSZWFsIEVzdGF0ZSBEZXZlbG9wbWVudCwgSW52ZXN0bWVudCBhbmQgTWFuYWdlbWVudMKg
IA0KICAgICAgICDCoGNvdXJzZSBOb3YgMjkgdG8gRGVjIDAzLDIwMjEgICAgDQoNCjxodHRw
czovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1vcS1URTk3
ZWZ5VWliMWhkdzFIcUdfaXhKYTNHa1hsWFRhamlNdjROZjhPVGhRVFRROWhaZWo0S3BnaGR0
aUdEYmRaNFRmUUR1QVZRWWN2Zl80Q0lSNW00Q0FsM3hUbVFvS2FNSXl2QlpjWWhGQWRnQVNn
X05QZEN6NG1GWGxxbEh0WWFpSU1CQzkxSU05VlBORGZLMjdXcXFsTHBZVE9OMElsV0hwV2x0
VkFRYnVqaUo1elIxcjM2Zjl4SVVGT1IxN3dIbC1CeGdQang4RjlXYXczdDhBSTE+DQpEaXNh
c3RlciBhbmQgUmlzayBNYW5hZ2VtZW50IENvdXJzZSBOb3YgMTUgdG8gTm92IA0KICAgICAg
ICAxOSwyMDIxICAgIA0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3Ry
YWNraW5nL2NsaWNrP2Q9UXp0anFLLXVTRzl0ZnJoUVMzTGNXb3ZIeGg3c0ZZelM2UDVyUnRO
aWduYnZqOGlCbGhrRHZNT0ZvYXRRMFFJT09MaTN3M2hmWlFKMGdfR1M0N0tKRmYzMUp1LWJr
aHJ0Y1AtbmNFZXUzaWtoVU1tbVlsbGRsX2xFSGREcVZjWmFDb181N015bEczZk5DM1d3R0Nq
UE5PT3c3TmFYenp5STFYWUUzVGNnRzd2QVBOOGYzVVNoX2lvUFRzR01GdzExZTd2aVIwS2FJ
X19LaDZ5UlhDUUs4U0dfZl9fWEU2a0NlOXVQeVhLNWlMODUwPg0KR0lTIERhdGEgQ29sbGVj
dGlvbiwgQW5hbHlzaXMsIFZpc3VhbGl6YXRpb24gYW5kIE1hcHBpbmcgDQogICAgICAgIENv
dXJzZSBOb3YgMDggdG8gTm92IA0KICAgICAgICAxOSwyMDIxwqDCoMKgICAgIA0KDQo8aHR0
cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9R1Bkamdj
elotUm9hZEdTT2FMMGJuaktHYkYxSS1yVXU2S2FXczBPT3lZUHA4S3RLYmFrRzJZNlljY3Zs
S0dDekFxVWp3bFlkVk9MNS1CUU9PT1dWT1FoTVpUUGNZOW5xU1JSM1pEa25EQy0wNXlZWkRZ
STZfVGlVaE10TzBBSm00NG9Uc2NPOTRvaDFOQ29peWtLZ0hSWmhOYzJhQUJRQUFidDNVMmc0
ek1oT1hRZXRhR3lvQzE2S1RMWFVHdW9GdHB6WHhYWlFJUGkxRjZvek5yRENsYU9iUXRvVndK
UzNna1AyR1dBUzFpYngwPg0KR2VuZGVyIEFuYWx5c2lzIGFuZCBEZXZlbG9wbWVudCBDb3Vy
c2UgTm92IDAyIHRvIE5vdiANCiAgICAgICAgMDYsMjAyMSAgICANCg0KPGh0dHBzOi8vWEM4
Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPV92WHRhenRuZW5fN0w0
OTA3OFFPUDBzN1FNejRUWUxwVWNSZG51UmpMQlJaSThmR2pZMXlnemFUcjNoMXctYkNrbDc4
SGlnaFlZakpEMG1FQ2VzUHJCbFFYMnpvd3p4am9XcFhXbW5jQmZCTHM0WEdJVGtWSFJLWUZB
QWctUXdDV1luRTFSb0Z5YmN1cFZ5SWZ0WmpwcmNaOEp1cjNtVGs4YzdWRjgyX2FMblM5bTlT
ckdCNkVhenVIbERqZkJXTnBCdjlPRUZLb28wQ3o0VWZaX1pOTDFoeHJxTXI0cV8tdGw5WHJX
enVBTEVGWU5CUnpaeEloX1BIb3hsbDZMaEQzUTI+DQpDb3Jwb3JhdGUgQ29tbXVuaWNhdGlv
bnMgYW5kIFB1YmxpYyBSZWxhdGlvbnMgY291cnNlIE5vdiANCiAgICAgICAgMjkgdG8gRGVj
IDAzLDIwMjEgICAgDQoNCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90
cmFja2luZy9jbGljaz9kPTExMDBmVWhDSVlhbHV4b1IwYWwzRGczbHBhQTNvSXJWVnJtUmpE
WldMY2xObGp4cnNWUllPMjNDR3JJcXJpcHNJWmVITm1ZcGdPbmFWTUZGQ1FyVUN1VEN2TFNl
ZVpWQjR6aVkyVG1WX2h6Mmtaa1dtbnphZThjMmR6SXRYTUswbEpua2RhZmpKRFpmZkt3U0th
ZGh5OGdIb0RfbFB3d0ZQN0xtbXR4SkpFcnNoeE9WeE9uemVVdk9NbkNhT3d4X3hSSHdBRGtP
VWR2YVRCMVdHLVB6M1JBbEhRVWpmVEdzczNmTjctaEZTd3loeFgwbEJmcFVqRkEwMDN3T1Y5
bHptVDh2TVZVTFVVeXV1R25CblR5UXRZbkt5Y0VBRE0wUDBBVWhPVjJoOUVnazA+DQpNb2Jp
bGUgDQogICAgICAgIERhdGEgQ29sbGVjdGlvbiB1c2luZyBPREsgJiBLb2JvVG9vbEJveCBm
b3IgTW9uaXRvcmluZyBhbmQgDQogICAgICAgIEV2YWx1YXRpb24gV29ya3Nob3AgTm92IDI5
IHRvIERlYyAwMywyMDIxICAgIA0KDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFp
bC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1DbzRZa21VLUpOR0NMTmhIRlZWUHp0eXdwOU1zR19s
UWFZRnNEZGZEN2FWZURzbnNIREJaTUFzMWNTNjVkbWhVYnIzZkIyNU91WHBBNHI3bEs5bkU1
YlQ1RGFYak1jYmpfVTBuZmllLUZmc2VHLTgzb3VSZW9lcmlNRWFMemhsTXJ4aG1hS1YtWWo0
WEZqMTFqTTh1YXBkYTdqU01lbnNlRzJZa2VKWHMyZGFwM2c2MW1WRXBGb3hYc1pRSFFyek8t
T1ZGZ2thQlJ6N2tSU3JnNGFOd0YxSnJ0WlpjcnNQdzc3YlJsSTl2RDZ1MTA+DQpMZWFkZXJz
aGlwIA0KICAgICAgICBhbmQgRGlwbG9tYWN5IFRyYWluaW5nIENvdXJzZSBOb3YgMjIgdG8g
Tm92IA0KICAgICAgICAyNiwyMDIyDQpDb3Vyc2UgDQogICAgICBQcm9ncmFtbWUNCg0KPGh0
dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVQ2bEN5
OHBwN3FhUW0yc3ZzVzBSTzBsU2RMMWthbDlvS184UkhrMjBBMHltR3FtaGEzcmFEelA3b09J
eldQUFdtNTBUTUptUnBpUmtmTF8yWWNlSk5IcFl5cXNxT2cyOHl1RDcxS2NLVTk3dkRsOElw
N0p0cGU0aW45bEJPdk5qcXpiaklvb2V1VUY0N0tXUURoX21NU3ZuZjlOUUMtME1RYThxYW1z
Z1BkTDgwPg0KUmVzZWFyY2ggYW5kIERhdGEgQW5hbHlzaXMgcHJvZmVzc2lvbmFsIHNob3J0
IA0KICAgICAgICBjb3Vyc2VzICAgIA0KDQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1h
aWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9b0lZbGVtUzN0a3lKZG5NcUZ0Z0RzTlhXN1A0UlZY
R0E5UUFxVlgxekhMaEo2VlA4OHBWYmg2aVVLMHlqY2JEMzdjYXlkUFlLZ2JlTkdPQld3XzdU
eFRGR0RYdDlZZ3JCcGNteG1KbFBJNlhHZ2dlUEdIMUdNQ3FWWHh6WkxPTnlEVnltVVd0ZGV1
d2lONmlfaVlfNHlDdUc4VEY3V2xOWHNOSjAtbnRreVVUQjA+DQpNb25pdG9yaW5nIGFuZCBF
dmFsdWF0aW9uIHByb2Zlc3Npb25hbCBzaG9ydCANCiAgICAgICAgY291cnNlcyAgICANCg0K
PGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPURV
a181Y3Vickc0VnpPRnhOT3JnSkZsbmx0a0p2ZmQ1bEFUNFIxamxqX21MbzZaeTJLMi14eFdq
bDBBN3RHUk5BSWVuby13VVV6enpnXzhxdUowYVJPSE9OX2N4dEJpcEg0WmJCX0V1Mzg0Vk1z
Qm1Ga3J1UHZGd3ptSzlhem5vT2dKbDdPNzFzTGROZ3RJZEY1UFUxQ2RpTVNSY3RTQzVxei1s
eTlqTklDNm0wPg0KSHVtYW5pdGFyaWFuIGFuZCBTb2NpYWwgRGV2ZWxvcG1lbnQgcHJvZmVz
c2lvbmFsIHNob3J0IA0KICAgICAgICBjb3Vyc2VzICAgIA0KDQo8aHR0cHM6Ly9YQzgyLnRy
ay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9LWJ1TGpiTTlMNktPcmU0Qzho
VVBIZE5ud29sQ1p5VXIwSUh1N2NSeUpTUGlxOGJPWFVubV83NnhhaUp5NHJhUmp0RmRtUGZB
S2duNUNYUExnNkRZeENlank1ckp5akl5eGt0dFU1OEZ6XzE1UGtZdWxnd09sdTA2YUxteWlr
TE9NdFlXdmFCUlk0Q0MxY2VJc3BZLWw2TjM5NTAzNVY4SVZoS09JNE8wT2k1WjA+DQpJbmZv
cm1hdGlvbiBUZWNobm9sb2d5IHByb2Zlc3Npb25hbCBzaG9ydCANCiAgICAgICAgY291cnNl
cyAgICANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9j
bGljaz9kPXo5MGtwM1hqSWl5UWtaUUtLVVItbElEWmNDZEF2LVNaVnY5d0lZTm9NbnBGQmlF
LVRpUy1WY3N6RnVSZnJkaE11M2dNVVFqNEF4YmRZS0NmMnhsUTI3cVB3TW5kQUpqWU1UMFpW
RnVhY09QQVlVXzNxVWlfNzZ4Mk9BUjhVRm5PRERUQXBfcm9Oc0ZlSmlVOWdBRkhNTlkxPg0K
QWdyaWN1bHR1cmUgcHJvZmVzc2lvbmFsIHNob3J0IA0KICAgICAgICBjb3Vyc2VzICAgIA0K
DQo8aHR0cHM6Ly9YQzgyLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9
NXJ5dmM4VHNRODVod3F5ZWpzS1hLVkRuZGdlZFYyU05iU3doU0k1bHFqWUx1QmlGVVdMQ0lJ
NWRydkhETGJJTkItaTh3Y1dKMk1WU2FlLTd3cThlQks5Y3Zzd0FSSUVOcXU4NmFUMWMzUGlr
LVowNFNxSkRmcVYyMTkxNkpZOVlzejBJVTNqVWNwYmhZdENieGsyVUxKRTE+DQpHSVMgJiAN
CiAgICAgICAgUmVtb3RlIFNlbnNpbmcgcHJvZmVzc2lvbmFsIHNob3J0IGNvdXJzZXMgICAg
DQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/
ZD1ibll0a1VOUGkzc0dReGRReDdfLUo4OTVlVkNPUm1xVXFpNFprV2tzTGk1MTUtaXZxVDhS
NHd6SWh5c1JaMWxZM3RpWTlUSHd3eHd1bjdRVVdjWEV6OFdRWFNPRFNKS1p0Z3E0bEV6WjdL
THNYMlJKdkE5QkxfbHpnc2Y2cUt3TTZUU0tmdmxvSVQzQW1fMFRvSmtQSmhGalZfZkpDN3Vz
Y28wOGdJZ3B6QlhGMD4NCkJ1c2luZXNzIGFuZCBHb3Zlcm5hbmNlIHByb2Zlc3Npb25hbCBz
aG9ydCANCiAgICAgICAgY291cnNlcyAgICANCg0KPGh0dHBzOi8vWEM4Mi50cmsuZWxhc3Rp
Y2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPURLbkhKUTg5SXVZS2hGbVV0ZVBURng4dFF5
bGNiS1MyZHB3NC14WGlEZ0tyTmVwMXp1bzh1U0M2cl9yODBKSUpUNTRsaG1idDUyd2FabzRk
d1hpNUZDOVZkemY3cFNRZVV2Mm9ESnY1cHdtVE9JU1Q3NkF3a2VPc3g2MEhsZ2RVb3A4OUh4
ZUliRXpmWXZJc1FFc3BaMU0xPg0KQ2hvb3NlIHlvdXIgDQogICAgICAgIE9ubGluZSBUcmFp
bmluZyBDb3Vyc2UgICAgDQoNCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20v
dHJhY2tpbmcvY2xpY2s/ZD1Qbk02ZTZDb1JuWjU5cGs0Vm82Y1lhdWNUWjJrOFZVUHVIX0FG
U3Nta3J1Y19mcTA4ZzN0LWdUTVZXY1c5Y2ZrV1hCZkVkNERYUGZKaGRMMHRzc3pZNFRNTkJ5
alpkVTViRjBpM0ZsN1VFNUY1X1V1bWxNa1Q0ektIbUhQUXp5R2ZwU1VNbUhiTTE3RnFmbW9G
bnFVdjBRMT4NCmNvbnN1bHRhbmN5IA0KICAgICAgICBzb2x1dGlvbnMgICAgDQoNCjxodHRw
czovL1hDODIudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1ibll0a1VO
UGkzc0dReGRReDdfLUo4OTVlVkNPUm1xVXFpNFprV2tzTGk1MTUtaXZxVDhSNHd6SWh5c1Ja
MWxZM3RpWTlUSHd3eHd1bjdRVVdjWEV6MWY1OEF0RWlCVUVEcldXMk13LXRVcXFNTDEwMnRk
WFFYS1lWbDNtZ2d2eGVMQU9iU3poSFo0b0kxbVBSTWJXcGhiazQ1X0g4cU9ibksxa0hEdURN
ZER3MD4NCk91ciAyMDIxIC0gMjAyMiBQcm9mZXNzaW9uYWwgU2hvcnQgVHJhaW5pbmcgDQog
ICAgICAgIENvdXJzZXMNCsKgDQpMb29raW5nIA0KZm9yd2FyZCB0byB5b3VyIMKgYXR0ZW5k
YW5jZS4NCsKgDQpGREMgDQpSZXN1bHQgQmFzZWQgc2tpbGxzIERldmVsb3BtZW50DQpSZWdh
cmRzLA0KVHJhaW5pbmcgDQpDb29yZGluYXRvcg0KDQpUZWxlcGhvbmUgDQpvZmZpY2U6ICsy
NTQ3MTIyNjAwMzENCsKgWW91IA0KY2FuIG9wdCBvdXQgb2YgZnV0dXJlIGNvbW11bmljYXRp
b25zIGFib3V0IG91ciBzZXJ2aWNlcyBieSBjbGlja2luZyBvbiB0aGUgDQp1bnN1YnNjcmli
ZSBsaW5rIGJlbG93LlRoYW5rIHlvdQ0KwqANCjxodHRwczovL1hDODIudHJrLmVsYXN0aWNl
bWFpbC5jb20vdHJhY2tpbmcvdW5zdWJzY3JpYmU/ZD1HZkt1Rmo0RDNETmdTVXZLbUZkcHdD
WFNoQXVwMk85dlZrV1FMXzBLTV93Rjk1Mm5WSnNuTmdJd3YtSF8zUHk4ZVpTMzZkODBEUDJO
VUdkRXJNUjVLTVJFaUdhSGg4UU9IbU5uVWJWX0dqWFAwPg0KVU5TVUJTQ1JJQkU=

--=-eZCfMFjm7XfJPu+WONMDOCvg8wx14ugty3WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office"><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BACKGROUND:=
 white; COLOR: #222222; LINE-HEIGHT: 107%'><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>
<H3 class=3Dtext-center><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DflnlrYNy9=
ufPZ5lCl3s5gyQ0QKdJU3XHPB6lGFCpQtYtjUHjDAYaQx2M_I5tTiuPEla-bS7dfqogfs4=
L7IXix3Ji-imHybr4MlBKbVaS-My6Ld_TjhgMdXpDH8PBsxB9D0FXAvuj5ujZhT5ihr2i8=
UkGERvmdFlZhB6ERrZk40EXkQk90n4-EL-iNw6ftXtJmvepjILOSI7Iy9CR14aO9XycO6q=
KOyu1kNVgrTgXQ4Eu0">Gender=20
Mainstreaming, Analysis and Planning&nbsp;Workshop Nov 29 to Dec 03,20=
21 for 5=20
Days</A></H3></SPAN><o:p></o:p></SPAN>
<TABLE class=3DMsoNormalTable=20
style=3D"WIDTH: 786.75pt; BACKGROUND: white; BORDER-COLLAPSE: collapse=
; mso-yfti-tbllook: 1184; mso-padding-alt: 0cm 0cm 0cm 0cm"=20
cellSpacing=3D0 cellPadding=3D0 border=3D0>
  <TBODY>
  <TR style=3D"mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-last=
row: yes">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: #f0f0f0; WIDTH: 786.75=
pt; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PAD=
DING-LEFT: 0cm; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 0cm; BACKGROUND-C=
OLOR: transparent"=20
    vAlign=3Dbottom width=3D1049></TD></TR></TBODY></TABLE>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Dk7vrBo0t4=
0SMs9s8Fk-XYeOeY0jKH2kqL_KzBk9eHGbvFNfytYHkskCNnpHT07HjJBvNrBNw9hC3kxi=
HK9iDSKAINaio3v-TYkLwY1U5sQvAhZahSJin_rurxAkTyKvjpdMigR_RvPPe6SrZY-jSA=
dOPBHauClsuBFdGY7JgKz0VENb4a4rQKcDhn2AAqlUGoPgr_tIK3n2aws1PmURi1WIndL2=
5hzFOnsmB4vSJeAp4GjH-oN1GBTAmv66-fYXA4rkGe7sJMVfE1BBwbXKia4Y1"=20
target=3D_blank><FONT color=3D#0000ff>Register for online attendance=20
Workshop</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DOegU_S2kW=
2MJJSUtV4yWNSbrIIgj4YYGRt0sKsyIY719Rzr9MKBhiw4gCClQaoeO_QaBLH4qtXrV4Fo=
eLff-l8SZy5cZES8KMzs1srxSw9oqwxJYSCj_VgVk9HlBSYgDlakjyiPqUIgDv59OK_Ldd=
FHroyW2CyAUzFxZedVz0K0e3On-k2ddyjKgiXxwBZu_eNRpWOZsMfVuX-kb8zEVZcPB7iN=
j9cBT4eiKv9CTlD8C612elFTKHrP8tYJvHomVeyEc_xTuEjfEFqDfHUdjYzc1"=20
target=3D_blank><FONT color=3D#0000ff>Register onsite attendance=20
workshop<o:p></o:p></FONT></A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DhvQZzfEr6=
bRX5SMnPLmhN0jRrFN4LOUdPw8eXMzVKrZjvyOpuDwIWv9YOahm12FMD7_Ik5dds3FzWUT=
szKOHnw6lhyh6dwtvRyucUArNyhh4ofeNSgUPNxtV8fLDJOHi3DnBq2gpa14e_pnsO9q83=
JhYWLTFl1lwS-xW84cH3oS__mXCzUHci1fnzxaSSgKBK3CBAP_yxHWK5exopH92W2GbTEP=
wSwEz8-rFK1HekY2EkVULjr1LtA0_W9g_2y5P40VVYnWjYvOAJntBFUmJ98U1">Group=20
Registration Here</A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DsreBwoDzY=
dgj3bOaBCRBsUjfBl7INs8m6G7880FO93iPm6YcioMVihbGt5g9wvp7dNiL3V1SleN8q26=
aiCPp-tm4wXonSUulF8qkIKsHOx18ifeSTUIepM2jRBnF4qjNQIw3Mj5qM_-Mo1SeXENUs=
Z5UUBjdZE0tdvKTf4ZFlF0R0" target=3D_blank><FONT=20
color=3D#0000ff>Download PDF Calendar 2021-2022 Workshops</FONT></A></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DIuDb5fT4f=
apGEpKDebKZ5rH8926BKl9IxGb1W-mC0hICkAyQ6E8-VOF_zxFimVXNyRDls02mSxMflRe=
5-T49PQiXtfD1dV5N4GRMJJ-svhGolLoBjQOB937jBvc7XD2tnBxG70Jp_xAUq32Akbgc5=
RY1"><FONT color=3D#0000ff>Contact=20
us</FONT></A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DRAnyf8LX2=
fAhmeuRPJDlDCfWxLbWUcM9cR20ZA1NmmpeitYBMM83tADkxgki-i3Am1pT2vJhSyDDOOa=
ED6zmMF-7Xfw3VpPQZRS-nz4n6Ype_o1H0Qlm9LmfErt3j__kT1DINRHjC1zHBCVIEwpth=
fE1">Whatapp<o:p></o:p></A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>VENUE:=20
HILTON HOTEL, NAIROBI KENYA</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>OFFICIAL=20
EMAIL ADDRESS:&nbsp;<A=20
href=3D"mailto:training@fdc-k.org">training@fdc-k.org</A><o:p></o:p></=
SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>Office=20
Telephone: +254712260031<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BACKGROUND:=
 white; COLOR: #222222; LINE-HEIGHT: 107%'><A=20
href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DbnYtkUNPi=
3sGQxdQx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3tiY9THwwxwun7Q=
UWcXEz4aPd8lzQRZGEqX6MbBPYfAnVq4a1fMHT7AttH7Zv-w3tu40TbJKsHHsDk9LHaahH=
oQu71jafKYrLYbllM9sGwS00"><FONT=20
color=3D#0000ff>Our 2021 - 2022 Professional Short Training=20
Courses</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>Register=20
as a group of 5 or more participants and get 20% discount on course fe=
e. Send us=20
email to training@fdc-k.org or call +254712260031<o:p></o:p></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN></P><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; COLOR: blac=
k; mso-fareast-font-family: "Times New Roman"'><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; BACKGR=
OUND: white; COLOR: black; mso-fareast-font-family: "Times New Roman"'=
>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>INTRO=
DUCTION</SPAN></STRONG></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; TEXT-ALIGN: justify; ORPHANS: 2=
; WIDOWS: 2; MARGIN: 0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT:=
 normal; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickn=
ess: initial; text-decoration-style: initial; text-decoration-color: i=
nitial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gende=
r equality=20
and empowerment is considered a critical element for development. This=
 course is=20
designed to prepare participants for a variety of careers where specia=
lized=20
knowledge is required related to the integration of gender considerati=
ons into=20
policy making, project design and implementation, monitoring and evalu=
ation.=20
Gender mainstreaming is an international strategy to achieve gender eq=
uality in=20
all aspects of society. Many governments in developing and developed c=
ountries=20
have endeavored to implement this strategy. This course aims to provid=
e=20
participants with a comprehensive knowledge of gender mainstreaming an=
d gender=20
analysis. It draws on best practice and case studies from around the w=
orld. As=20
well, it provides the opportunity to focus on a specific policy area (=
such as=20
public health, education, economic management, or human resources) or =
for=20
participants to employ this knowledge in their own workplace through a=
n action=20
research topic.</SPAN></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>OBJEC=
TIVES</SPAN></STRONG></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>By th=
e end of the=20
course, the participant should be able to;</SPAN></STRONG></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>&#1=
83; Have explored=20
  the intrinsic relationship between gender and development</SPAN></LI=
>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>&#1=
83; Be able to=20
  integrate gender into contextual analysis, and to use gender analysi=
s=20
  frameworks effectively</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>&#1=
83; Be better=20
  equipped to integrate gender into strategic and operational=20
  planning</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>&#1=
83; Have acquired=20
  methods of creating gender awareness within development=20
practice</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Who s=
hould=20
attend:</SPAN></STRONG></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gende=
r advisers,=20
development practitioners with an interest in gender mainstreaming, ge=
nder focal=20
points</SPAN></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>DURAT=
ION</SPAN></STRONG></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>5 day=
s</SPAN></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"FONT-WEIGHT: bolder"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>TOPIC=
S TO BE=20
COVERED</SPAN></STRONG></P>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Basic=
 concepts on=20
gender mainstreaming</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Cur=
rent=20
  development context. Gender Equality in the SDGs and 2030 agenda</SP=
AN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Glo=
bal=20
  commitments to Gender mainstreaming</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Rat=
ionales for=20
  gender mainstreaming</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Wha=
t is gender=20
  mainstreaming?</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Mul=
tiple=20
  strategies for applying gender mainstreaming. Why no one size fits a=
ll=20
  solution is possible?</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Add=
ed value of=20
  gender mainstreaming</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>&nbsp=
;Gender=20
integration framework and Sensitization&nbsp;<BR>&nbsp;Gender=20
analysis</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Eng=
aging men=20
  and boys</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Ove=
rcoming=20
  resistance</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>App=
lying gender=20
  mainstreaming (individual work)</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gende=
r=20
mainstreaming</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Too=
ls for=20
  gender mainstreaming and analysis</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>App=
lying gender=20
  mainstreaming (small group work)</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gen=
der analysis=20
  and gender planning tools</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>The=
 impact of=20
  gender inequality on economic growth and sustainable=20
development;</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Commu=
nication in=20
gender</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Sex=
ual-based=20
  barriers to communication;&nbsp;</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Bod=
y=20
  language</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>How=
 to create=20
  the right image</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Dea=
ling with=20
  media; and communication secrets of great leaders.</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gende=
r=20
Mainstreaming in Institutions</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gen=
der=20
  mainstreaming in key organizational components. Opportunities and=20
  challenges</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>(Or=
ganizational=20
  culture; Human resources; Staff accountability and incentives for ge=
nder=20
  mainstreaming; financial resources and budget)</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Non=
traditional=20
  institutions</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"FONT-SIZE: 15px; FONT-FAMILY: Verdana, sans-serif; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 300; =
COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; MARGIN: =
0px 0px 0pt; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gende=
r=20
Mainstreaming in Public Policies</SPAN></P>
<UL=20
style=3D"FONT-SIZE: 15px; MARGIN-BOTTOM: 10px; FONT-FAMILY: Verdana, s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; MARGIN-TOP: 0in; TE=
XT-TRANSFORM: none; FONT-WEIGHT: 300; COLOR: rgb(0,0,0); FONT-STYLE: n=
ormal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial"=20
type=3Ddisc>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gen=
der=20
  Analysis</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Des=
ign,=20
  implementation and evaluation of public policies</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gen=
der=20
  responsive budgeting</SPAN></LI>
  <LI class=3DMsoNormal style=3D"MARGIN-BOTTOM: 0pt; LINE-HEIGHT: norm=
al"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman", serif'>Gen=
der=20
  responsive policy - making and budgeting</SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal"></SPAN></SPAN><B><S=
PAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>General Notes</SPAN></B><SPAN=
=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>All=20
  our courses can be Tailor-made to participants needs<o:p></o:p></SPA=
N>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>The=20
  participant must be conversant with English<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Presentations=20
  are well guided, practical exercise, web based tutorials and group w=
ork. Our=20
  facilitators are expert with more than 10years of=20
  experience.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Upon=20
  completion of training the participant will be issued with Foscore d=
evelopment=20
  center certificate (FDC-K)<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Training=20
  will be done at Foscore development center (FDC-K) center in Nairobi=
 Kenya. We=20
  also offer more than five participants training at requested locatio=
n within=20
  Kenya, more than ten participant within east Africa and more than tw=
enty=20
  participant all over the world.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Course=20
  duration is flexible and the contents can be modified to fit any num=
ber of=20
  days.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>The=20
  course fee includes facilitation training materials, 2 coffee breaks=
, buffet=20
  lunch and a Certificate of successful completion of Training. Partic=
ipants=20
  will be responsible for their own travel expenses and arrangements, =
airport=20
  transfers, visa application dinners, health/accident insurance and o=
ther=20
  personal expenses.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Accommodation,=20
  pickup, freight booking and Visa processing arrangement, are done on=
 request,=20
  at discounted prices.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>One=20
  year free Consultation and Coaching provided after the=20
  course.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Register=20
  as a group of more than two and enjoy discount of (10% to 50%) plus =
free five=20
  hour adventure drive to the National game park.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>Payment=20
  should be done two week before commence of the training, to FOSCORE=20
  DEVELOPMENT CENTER account, so as to enable us prepare better for=20
  you.<o:p></o:p></SPAN>=20
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 8pt; mso-list: l0 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIG=
HT: 107%'>For=20
  any enquiry to:training@fdc-k.org or +254712260031<o:p></o:p></SPAN>=
</LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>OTHER=20
UPCOMING WORKSHOPS FOR &nbsp;NOV 2021 ( CLICK LINK TO REGISTER FOR THE=
 WORKSHOP=20
AS INDIVIDUAL OR GROUP)</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p></o:p></SPAN></P>
<TABLE class=3DMsoNormalTable=20
style=3D"WIDTH: 807.35pt; BORDER-COLLAPSE: collapse; mso-yfti-tbllook:=
 1184; mso-padding-alt: 0cm 0cm 0cm 0cm"=20
cellSpacing=3D0 cellPadding=3D0 border=3D0>
  <TBODY>
  <TR style=3D"mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-last=
row: yes">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: #f0f0f0; WIDTH: 531pt;=
 BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDIN=
G-LEFT: 0cm; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 0cm; BACKGROUND-COLO=
R: transparent"=20
    vAlign=3Dbottom width=3D1076>
      <UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D3=
SPFidCUsFAH9JG2MFF6sWkF0LGf9Ly8lLUj-fU5L8VqNjsgnXe_UKG2-7r1R8DCs9DUwjc=
clKpBhhNHG1HJoKb5OGpZUkzJOv6mHQwzKM9Jhf0PHPlZi8zvISlYCwlPdP20VWvPEFwrs=
Q7LjkRwyDYSyZQ1EJ-xNvvWtvxzdpFBoYH4lqCEp_E4L6j3nKqBV8SjMREp1GNHcSFkLMM=
YQvBitapFubJKPn32SmPFX_ylimL7a19gsE221lcP7kpLaw2"><FONT=20
        color=3D#0000ff>Electronic Document &amp; Records Management c=
ourse Nov 01=20
        to Nov 05,2021</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DA=
HbOb6vF8BGjF0sRp-JATzmK3LIQcF7eYKf9nIkNSkVB35V25uZlm6cJm0oIh5X6qeaxgaI=
JSUjoRH-k4-K-DkGGdkdoiE12uoHFtdvI-USS72rWaOUdoTgrSXTl9p9eWfcx-R9wvYkMs=
wmD29lFp8prf2mCaFDiKfalDn7pyoy2IRtOKV8Idm_DgIKMT8LKdJdkGcxjcqaF45zRke2=
j13HybDLBa9nm-W1JMDu0ufJSZMFyZqAyWBu9YnE_6GwTYBPz5h-WIZmXvYLS5ApXxMWZJ=
YUOGLy1_rtqJs9UaRjh0"><FONT=20
        color=3D#0000ff>Financial Management, Budgeting and Auditing o=
f Donor=20
        Funded Projects course Nov 08 to Nov=20
        19</FONT></A>,2021<o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><A=20
        title=3D"Project Monitoring and Evaluation with Data Managemen=
t and Analysis course"=20
        style=3D"FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: =
Verdana, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRAN=
SFORM: none; FONT-WEIGHT: 300; COLOR: rgb(74,204,209); OUTLINE-WIDTH: =
0px; FONT-STYLE: normal; OUTLINE-STYLE: none; ORPHANS: 2; WIDOWS: 2; L=
ETTER-SPACING: normal; OUTLINE-COLOR: invert; BACKGROUND-COLOR: rgb(24=
5,245,245); TEXT-INDENT: 0px; transition: all 0.2s ease-in-out 0s; fon=
t-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-s=
troke-width: 0px"=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DC=
x2ZrnJt4yTljRF3LlbR1H-U8CsOEjhGzTgVjA1AzzL7LLZEyCJxyv7lVeuCgxdXJayZJd3=
a8CxNtJ_EZRGEhZXG3Rq0ZNCNegz0Jl75oAOx71qTjQ8qSk0DltBOjyPrKna1Wib72jQgQ=
8pAn2nz3x6cPNgrFDwrfePP9vYcMNguWsl61wvTx_IXkbHVmiuvqyuXvbUuIbwdBZh25Y-=
Iskufg6JMPahgVQu9Zf2qWvBmaPuVGWtfujtuD7kuKH5x39DZweexAt7AmUqpa39lRZNef=
2SKVv_5hOZJG1XP-4j50">Project=20
        Monitoring and Evaluation with Data Management and Analysis=20
        course</A>&nbsp;Nov 08 to Nov 19,2021=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: blue; MARGIN: 0cm 0cm 8pt; mso-list: l1 level1=
 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; COLOR: #222222; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Dm=
WWgbi0vXe6yPRvFz51jjH6WiJ5Kfnbt3C8ImSbM5pwJ3Z2HlJhPpMVswF2EUAdzkOXjPdg=
-tbwNWRNJzvbdcKNiXcSkG2sbTxwPeAOlNKNxxD2TaY9LDuvM7_HqQNPcO3jVnoDALL3n2=
rCZRfAMt0Jm-Lo710UAusbxl5eCjowHX_Bn8AQ_sWi6hAlmSTS5iWYC5RwG1lZRTlVtpZ5=
Sk_l6l-oOR7uMowVv5OdydE5zHgfxvGdxu6zNhzVdEyki_A2"><FONT=20
        color=3D#0000ff>Remote sensing and GIS for public health and e=
pidemiology=20
        Nov 08 to 19,2021<o:p></o:p></FONT></A></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: blue; MARGIN: 0cm 0cm 8pt; mso-list: l1 level1=
 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; COLOR: #222222; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D_=
mXZj3fWRGoOlS7RLh7BrmdvnSNLcaNEqgj-vjFylHl89TmFexoB8kkr6Nfsh3xBnSyU7-b=
ugqJuTfIhj-YMmzXeRZJRTodwbsnc2NmZTOQka2_GgwBUtUAbZDcXzen5M-BLnogSRwMmT=
CPgqRO9XzE637GSidkck4ixNqS4mWaftk8MvSomFCEKBLar5OHWV7qTfEMpZZsVdFbLaBI=
7gFnAXSZptnmcsZwQH-RXuBHSvQWy3ibq5SWtOGdz34iDjifgXcTd6UBoap65eCOeJNCvH=
TW5msn6LKeX0NKpl86ok91HpXA4qxkZtTrfovkYWw2"><FONT=20
        color=3D#0000ff>Research Design,ODK Mobile Data Collection,GIS=
 Mapping,=20
        Data Analysis using NVIVO and STATA</FONT></A></SPAN><SPAN=20
        class=3DMsoHyperlink><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'>&nbsp;<A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D_=
mXZj3fWRGoOlS7RLh7BrmdvnSNLcaNEqgj-vjFylHl89TmFexoB8kkr6Nfsh3xBnSyU7-b=
ugqJuTfIhj-YMmzXeRZJRTodwbsnc2NmZTOQka2_GgwBUtUAbZDcXzen5M-BLnogSRwMmT=
CPgqRO9XzE637GSidkck4ixNqS4mWaftk8MvSomFCEKBLar5OHWV7qTfEMpZZsVdFbLaBI=
7gFnAXSZptnmcsZwQH-RXuBHmxBm-BOE-PsqgNo66r9r7z0kypwkUMit50phQKRwQKQZE3=
MVOOlVnUHuWvUyTC8jcKdH8PkBnsOwx3XtXXxTE-g2"><FONT=20
        color=3D#0000ff>Course Nov 15 to Nov 26,2021</FONT></A></SPAN>=
</SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; COLOR: #222222; LINE-HEIGHT: 107%'><o:p></o:p></SPAN>
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DF=
ZZ3aPiKa1myz1TMyCycKD1YIkh0RjZBzkQsf2ll4PVnfRw3VyQLudKCoIUv9mcQ1rLpVtx=
ksVEUSwTe56DdSo1Afwd6mlp7wJd_LYPfrD1a8D3bsjQGkDqX_cb0ohSdcv_jwJ-Tr79SH=
wF5xA2rgl-XxhrTe_R3u6xb8iIrTbbBQiNa8SaqrhHxwkKk3Cs-OQa6oRoAFFF0CaL_9b5=
vNys61_kGVkSdR2-381QVQ5hl_64FaJbhOGKm_RBwEn1Ctw2"><FONT=20
        color=3D#0000ff>Transformational Leadership and Governance Cou=
rse Nov 15=20
        to Nov 19,2021</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DH=
0J4oi_ev6a97xOQ5Y-4mK4Yu55YW4VLhFjyzsuXclfB6QWzkp3gLfC05fMwN9AKvyj6YLV=
va7LKbhsndN88H2XW57u44Hs_SGKHq0WiMEpvQ0a6aJ7lGqgRXBF2ZEKe-O1UmsQZUIjk6=
3AYqS2dnJN1mhIDpMGMuFHupQjhN0f33yDz6S0y8g8A0SpNRriLgFnGO1VZ2XLg5WgeTHl=
5g9TnRVx5xSJPQ7EaE0THsUAtEge5hzdC9QVnevgNAZH5fg2"><FONT=20
        color=3D#0000ff>Real Estate Development, Investment and Manage=
ment&nbsp;=20
        &nbsp;course Nov 29 to Dec 03,2021</FONT></A><o:p></o:p></SPAN=
>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Do=
q-TE97efyUib1hdw1HqG_ixJa3GkXlXTajiMv4Nf8OThQTTQ9hZej4KpghdtiGDbdZ4TfQ=
DuAVQYcvf_4CIR5m4CAl3xTmQoKaMIyvBZcYhFAdgASg_NPdCz4mFXlqlHtYaiIMBC91IM=
9VPNDfK27WqqlLpYTON0IlWHpWltVAQbujiJ5zR1r36f9xIUFOR17wHl-BxgPjx8F9Waw3=
t8AI1"><FONT=20
        color=3D#0000ff>Disaster and Risk Management Course Nov 15 to =
Nov=20
        19,2021</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DQ=
ztjqK-uSG9tfrhQS3LcWovHxh7sFYzS6P5rRtNignbvj8iBlhkDvMOFoatQ0QIOOLi3w3h=
fZQJ0g_GS47KJFf31Ju-bkhrtcP-ncEeu3ikhUMmmYlldl_lEHdDqVcZaCo_57MylG3fNC=
3WwGCjPNOOw7NaXzzyI1XYE3TcgG7vAPN8f3USh_ioPTsGMFw11e7viR0KaI__Kh6yRXCQ=
K8SG_f__XE6kCe9uPyXK5iL850"><FONT=20
        color=3D#0000ff>GIS Data Collection, Analysis, Visualization a=
nd Mapping=20
        Course Nov 08 to Nov=20
        19,2021&nbsp;&nbsp;&nbsp;</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DG=
PdjgczZ-RoadGSOaL0bnjKGbF1I-rUu6KaWs0OOyYPp8KtKbakG2Y6YccvlKGCzAqUjwlY=
dVOL5-BQOOOWVOQhMZTPcY9nqSRR3ZDknDC-05yYZDYI6_TiUhMtO0AJm44oTscO94oh1N=
CoiykKgHRZhNc2aABQAAbt3U2g4zMhOXQetaGyoC16KTLXUGuoFtpzXxXZQIPi1F6ozNrD=
ClaObQtoVwJS3gkP2GWAS1ibx0"><FONT=20
        color=3D#0000ff>Gender Analysis and Development Course Nov 02 =
to Nov=20
        06,2021</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D_=
vXtaztnen_7L49078QOP0s7QMz4TYLpUcRdnuRjLBRZI8fGjY1ygzaTr3h1w-bCkl78Hig=
hYYjJD0mECesPrBlQX2zowzxjoWpXWmncBfBLs4XGITkVHRKYFAAg-QwCWYnE1RoFybcup=
VyIftZjprcZ8Jur3mTk8c7VF82_aLnS9m9SrGB6EazuHlDjfBWNpBv9OEFKoo0Cz4UfZ_Z=
NL1hxrqMr4q_-tl9XrWzuALEFYNBRzZxIh_PHoxll6LhD3Q2"><FONT=20
        color=3D#0000ff>Corporate Communications and Public Relations =
course Nov=20
        29 to Dec 03,2021</FONT></A></SPAN>
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN><SPAN=20
        lang=3D"">
        <P><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D1=
100fUhCIYaluxoR0al3Dg3lpaA3oIrVVrmRjDZWLclNljxrsVRYO23CGrIqripsIZeHNmY=
pgOnaVMFFCQrUCuTCvLSeeZVB4ziY2TmV_hz2kZkWmnzae8c2dzItXMK0lJnkdafjJDZff=
KwSKadhy8gHoD_lPwwFP7LmmtxJJErshxOVxOnzeUvOMnCaOwx_xRHwADkOUdvaTB1WG-P=
z3RAlHQUjfTGss3fN7-hFSwyhxX0lBfpUjFA003wOV9lzmT8vMVULUUyuuGnBnTyQtYnKy=
cEADM0P0AUhOV2h9Egk0">Mobile=20
        Data Collection using ODK &amp; KoboToolBox for Monitoring and=
=20
        Evaluation Workshop Nov 29 to Dec 03,2021</A></P></SPAN></SPAN=
>
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN><SPAN=20
        lang=3D""><SPAN lang=3D"">
        <P><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DC=
o4YkmU-JNGCLNhHFVVPztywp9MsG_lQaYFsDdfD7aVeDsnsHDBZMAs1cS65dmhUbr3fB25=
OuXpA4r7lK9nE5bT5DaXjMcbj_U0nfie-FfseG-83ouReoeriMEaLzhlMrxhmaKV-Yj4XF=
j11jM8uapda7jSMenseG2YkeJXs2dap3g61mVEpFoxXsZQHQrzO-OVFgkaBRz7kRSrg4aN=
wF1JrtZZcrsPw77bRlI9vD6u10">Leadership=20
        and Diplomacy Training Course Nov 22 to Nov=20
        26,2022</A></P></SPAN></SPAN></SPAN></LI></UL>
      <P class=3DMsoNormal=20
      style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 level=
1 lfo2; tab-stops: list 36.0pt"><B=20
      style=3D"mso-bidi-font-weight: normal"><U><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; TEXT-=
TRANSFORM: uppercase; LINE-HEIGHT: 107%'>Course=20
      Programme<o:p></o:p></SPAN></U></B></P>
      <UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DT=
6lCy8pp7qaQm2svsW0RO0lSdL1kal9oK_8RHk20A0ymGqmha3raDzP7oOIzWPPWm50TMJm=
RpiRkfL_2YceJNHpYyqsqOg28yuD71KcKU97vDl8Ip7Jtpe4in9lBOvNjqzbjIooeuUF47=
KWQDh_mMSvnf9NQC-0MQa8qamsgPdL80"><FONT=20
        color=3D#0000ff>Research and Data Analysis professional short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Do=
IYlemS3tkyJdnMqFtgDsNXW7P4RVXGA9QAqVX1zHLhJ6VP88pVbh6iUK0yjcbD37caydPY=
KgbeNGOBWw_7TxTFGDXt9YgrBpcmxmJlPI6XGggePGH1GMCqVXxzZLONyDVymUWtdeuwiN=
6i_iY_4yCuG8TF7WlNXsNJ0-ntkyUTB0"><FONT=20
        color=3D#0000ff>Monitoring and Evaluation professional short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DD=
Uk_5cubrG4VzOFxNOrgJFlnltkJvfd5lAT4R1jlj_mLo6Zy2K2-xxWjl0A7tGRNAIeno-w=
UUzzzg_8quJ0aROHON_cxtBipH4ZbB_Eu384VMsBmFkruPvFwzmK9aznoOgJl7O71sLdNg=
tIdF5PU1CdiMSRctSC5qz-ly9jNIC6m0"><FONT=20
        color=3D#0000ff>Humanitarian and Social Development profession=
al short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D-=
buLjbM9L6KOre4C8hUPHdNnwolCZyUr0IHu7cRyJSPiq8bOXUnm_76xaiJy4raRjtFdmPf=
AKgn5CXPLg6DYxCejy5rJyjIyxkttU58Fz_15PkYulgwOlu06aLmyikLOMtYWvaBRY4CC1=
ceIspY-l6N395035V8IVhKOI4O0Oi5Z0"><FONT=20
        color=3D#0000ff>Information Technology professional short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Dz=
90kp3XjIiyQkZQKKUR-lIDZcCdAv-SZVv9wIYNoMnpFBiE-TiS-VcszFuRfrdhMu3gMUQj=
4AxbdYKCf2xlQ27qPwMndAJjYMT0ZVFuacOPAYU_3qUi_76x2OAR8UFnODDTAp_roNsFeJ=
iU9gAFHMNY1"><FONT=20
        color=3D#0000ff>Agriculture professional short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3D5=
ryvc8TsQ85hwqyejsKXKVDndgedV2SNbSwhSI5lqjYLuBiFUWLCII5drvHDLbINB-i8wcW=
J2MVSae-7wq8eBK9cvswARIENqu86aT1c3Pik-Z04SqJDfqV21916JY9Ysz0IU3jUcpbhY=
tCbxk2ULJE1"><FONT color=3D#0000ff>GIS &amp;=20
        Remote Sensing professional short courses</FONT></A><o:p></o:p=
></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Db=
nYtkUNPi3sGQxdQx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3tiY9TH=
wwxwun7QUWcXEz8WQXSODSJKZtgq4lEzZ7KLsX2RJvA9BL_lzgsf6qKwM6TSKfvloIT3Am=
_0ToJkPJhFjV_fJC7usco08gIgpzBXF0"><FONT=20
        color=3D#0000ff>Business and Governance professional short=20
        courses</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DD=
KnHJQ89IuYKhFmUtePTFx8tQylcbKS2dpw4-xXiDgKrNep1zuo8uSC6r_r80JIJT54lhmb=
t52waZo4dwXi5FC9Vdzf7pSQeUv2oDJv5pwmTOIST76AwkeOsx60HlgdUop89HxeIbEzfY=
vIsQEspZ1M1"><FONT color=3D#0000ff>Choose your=20
        Online Training Course</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3DP=
nM6e6CoRnZ59pk4Vo6cYaucTZ2k8VUPuH_AFSsmkruc_fq08g3t-gTMVWcW9cfkWXBfEd4=
DXPfJhdL0tsszY4TMNByjZdU5bF0i3Fl7UE5F5_UumlMkT4zKHmHPQzyGfpSUMmHbM17Fq=
fmoFnqUv0Q1"><FONT color=3D#0000ff>consultancy=20
        solutions</FONT></A><o:p></o:p></SPAN>=20
        <LI class=3DMsoNormal=20
        style=3D"COLOR: #222222; MARGIN: 0cm 0cm 8pt; mso-list: l1 lev=
el1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; BAC=
KGROUND: white; LINE-HEIGHT: 107%'><A=20
        href=3D"https://XC82.trk.elasticemail.com/tracking/click?d=3Db=
nYtkUNPi3sGQxdQx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3tiY9TH=
wwxwun7QUWcXEz1f58AtEiBUEDrWW2Mw-tUqqML102tdXQXKYVl3mggvxeLAObSzhHZ4oI=
1mPRMbWphbk45_H8qObnK1kHDuDMdDw0"><FONT=20
        color=3D#0000ff>Our 2021 - 2022 Professional Short Training=20
        Courses</FONT></A><o:p></o:p></SPAN></LI></UL>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt 18pt"><B=20
      style=3D"mso-bidi-font-weight: normal"><U><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; TEXT-=
TRANSFORM: uppercase; LINE-HEIGHT: 107%'><o:p><SPAN=20
      style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></SPAN></U></=
B></P></TD></TR></TBODY></TABLE>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>Looking=20
forward to your &nbsp;attendance.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>FDC=20
Result Based skills Development<BR>Regards,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>Training=20
Coordinator</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><BR>Telephone=20
office: +254712260031<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'>You=20
can opt out of future communications about our services by clicking on=
 the=20
unsubscribe link below.Thank you</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Arial",sans-serif; LINE-HEIGHT=
: 107%'><o:p>&nbsp;</o:p></SPAN></P></BODY></HTML>

<img src=3D"https://XC82.trk.elasticemail.com/tracking/open?msgid=3DTZ=
Ss2eyHh2zL1bAAhwWvhg2&c=3D1452641685061462781" style=3D"width:1px;heig=
ht:1px" alt=3D"" /><div style=3D"text-align:center; background-color:#=
fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:san=
s-serif;"><a href=3D"https://XC82.trk.elasticemail.com/tracking/unsubs=
cribe?d=3DGfKuFj4D3DNgSUvKmFdpwCXShAup2O9vVkWQL_0KM_wF952nVJsnNgIwv-H_=
3Py8eZS36d80DP2NUGdErMR5KMREiGaHh8QOHmNnUbV_GjXP0" style=3D"text-align=
:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfMFjm7XfJPu+WONMDOCvg8wx14ugty3WKzQ==--
