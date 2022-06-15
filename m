Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F554C4DF
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jun 2022 11:40:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNKzv2Kd4z3brF
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jun 2022 19:40:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=IKKqPgD9;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=GQmiwjZE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=216.169.98.95; helo=np95.mxout.mta3.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=IKKqPgD9;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=GQmiwjZE;
	dkim-atps=neutral
X-Greylist: delayed 84 seconds by postgrey-1.36 at boromir; Wed, 15 Jun 2022 19:40:40 AEST
Received: from np95.mxout.mta3.net (np95.mxout.mta3.net [216.169.98.95])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNKzr38gpz305S
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jun 2022 19:40:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1655285895;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=7xB6PrKA1qjIfOt9gpVY+P8bIATyMHTJ3WfrJoGOTe0=;
	b=IKKqPgD94sYwdPVMNL6yrSpZTxCAszf1Sw2UgojXhaHFEw4BD3IGjrOO99m1orYEqstjCfdtucB
	5B1fRTTotFbfItFJSJlsh3Vd84YBbqTsUluHtc24qXWsk+ffHOI+yMhif3VjmSJwEJpWquZkyvtQ3
	NtyqMg7m7rqZp8WmRfQ=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1655285895;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=7xB6PrKA1qjIfOt9gpVY+P8bIATyMHTJ3WfrJoGOTe0=;
	b=GQmiwjZE5rmeaqidxy6fuVsZGkRkpXzsJnAcIWuo3KGqdYxc3wZp7JBcIFpRKwTVWrK8qOClyLo
	gmYGWyo+TIM/BIWDlU94bjOW8fSfRHu1P/6f+MjGhGUJaFODz3QotVNE8RSOfM+sTafl+kUNzccdR
	yVbZxwSQkpALk5+8ntU=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 15 Jun 2022 09:38:15 +0000
Subject: INVITATION TO ATTEND A VALUE CHAIN DEVELOPMENT AND MARKET LINKAGE
 TRAINING SEMINAR 11TH to 15TH JULY, 2022
Message-Id: <4uh3t1hb5i40.UljeKiF9OuKnEkd4RVowzg2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: UljeKiF9OuKnEkd4RVowzg2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfMW7f+w7FAZ6xf+IhTCLFhjZU2uk/y3WKzQ=="
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

--=-eZCfMW7f+w7FAZ6xf+IhTCLFhjZU2uk/y3WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4S0dVdUFzcUNF
eFRETTlFN3ZzNDFGeWh6RFc1UzVueTB0VDBSQm9EbENvLTY4a0NfLWk5V0lJQVR2U3lNNXl1
RTdNQXNMY0tPMU9ENE9OU29VMFdfT0o3YUplc1d1YVkyNWRhV0V1czF1TzFOQTE+DQpWQUxV
RSBDSEFJTiBERVZFTE9QTUVOVCANCkFORCBNQVJLRVQgTElOS0FHRSBUUkFJTklORyBTRU1J
TkFSIDExVEggdG8gMTVUSCBKVUxZLCANCjIwMjINCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVs
YXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjkt
UnQyMjVZWXNQbVdqTldzcXFyVHRQdEFPSUw5NlBqQUtESjNSSUJRWXhjeU43YVVhVGxzQjE5
bWJBaHBIcU1WREd4U2poeTNuOXhTRHUwMTdJcUZzcjZTU0VDMGdpeWNNMFhTZ21taG1rWlhQ
c3d4bFNqNDFvSlhlcF9GMDBMTUxMOVVXNVEtcUFScXlobE1wLVNkOXBCMD4NClJlZ2lzdGVy
IGZvciBvbmxpbmUgd29ya3Nob3AgDQphdHRlbmRhbmNlwqDCoA0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3
OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdFB0QU9JTDk2UGpBS0RKM1JJQlFZeGN5Tjdh
VWFUbHNCMTltYkFocEhxTVZKbGU5NHpxbUQtZl9MZVRBNjNJTkViNXNqcVc5X1BTOThOYmlm
dnJPV0lNUzJqNDNJMDJZWXRpdWtybjdLeXBJN1lKM0NVT1g5eEdqSEptWnhaUGJuME4wPg0K
UmVnaXN0ZXIgdG8gYXR0ZW5kIHRoZSANCndvcmtzaG9wDQoNCjxodHRwczovLzEzM0lLLnRy
ay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFw
eWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTUxkWUd0SzJyblRHRU9wRk96Y2RqeGZ6UUpRMk5E
dzFfSk1SS0xuclNjb1NiVi16WjB1RFgwRVFGcmZERFBXa1ZIYzFwX2pWbXVwTFotRkQwdWwt
OVR4MzJWaVV4STBpdTU4SlFUSkpLUVZYdzE+DQpDYWxlbmRhciBmb3IgMjAyMiANCldvcmtz
aG9wcw0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9j
bGljaz9kPTRSU09HZVM1SEk2S0ZKaXhRcHlrVUg3U0JEU2owQTJFZEhkY3FxRWstS01jS0JX
NUd4amJ1WEZpVm80RURRREFYWFNXZVZNdDlyWUhZV0ppYnVWc29tM3YwempiOGFlMDBzZVBx
Z1NDV01kd19GR0JEVDZFdUtXZmEzMXR0Z3B4bEdZTWRvZmpFSFJkWkJESlR3NmFYVjgxPg0K
Q29udGFjdCB1cw0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFj
a2luZy9jbGljaz9kPVRkTzFnQ3VRNzFocFdMNjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9l
amlhNS1YRzdNR0JUd2VBYVpMOTBWYjBxODlaRFhtbmFPb2VHa29UQ25mZ1RQaUNxUFhnTS1Q
Rm92N2doYlhyQmVseFNtTm5rQjUwQjhTd1hRS05lMVF4VEIzSGpFZnBNQUxKS0RjdTRwaXNV
YkkxPg0KV2hhdGFwcA0KVkVOVUU6IEJFU1QgV0VTVEVSTiANCk1FUklESUFOIEhPVEVMLCBO
QUlST0JJLCBLRU5ZQQ0KQ09VUlNFIEZFRTogDQoxMjAwVVNEDQpPZmZpY2UgVGVsZXBob25l
OiANCisyNTQtNzAyLTI0OS00NDkNClJlZ2lzdGVyIGFzIGEgZ3JvdXAgb2YgNSBvciBtb3Jl
IHBhcnRpY2lwYW50cyANCmFuZCBnZXQgMjUlIGRpc2NvdW50IG9uIHRoZSBjb3Vyc2UgZmVl
LiANClNlbmQgdXMgYW4gZW1haWw6IA0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFp
bC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1jQnVUR3l5d0h2VmlyT2puSlVhSFFkVk9GMVhVeTRr
YmpJNHdJOEstNHoxR3YwNU15aVlwSUU0RFhRMDg5OGR1Z19iaHVaYzBPQ0VxSTZLWjlLdjhq
bVIxRlBjajBpSXIyb1BQdGJ5N1JQOXQxMHYzY1c0UjJBVWk4RGJoa3RZRm1HazBOT0EtbVpV
eWw2cjA2eHVrSkxNUzlEdm1KZnNvd21ocjFPUnlJUExNcmUzNm0welFxOHpDNzN4RHZhNlUw
dGlNQU0wQVNxTHg3UmpxTXNTYjhNNDE+DQp0cmFpbmluZ0Bza2lsbHNmb3JhZnJpY2Eub3Jn
wqBvciANCmNhbGwgKzI1NC03MDItMjQ5LTQ0OQ0KSU5UUk9EVUNUSU9ODQpUaGlzIGNvdXJz
ZSBjb21iaW5lcyB2YWx1ZSBjaGFpbiBhbmFseXNpcyANCmFuZCBtYXJrZXQgYmFzZWQgc29s
dXRpb25zIChNQlNzKSB0byBjYXRlciBmb3IgdGhlIHJlcXVpcmVtZW50cyBvZiBidXNpbmVz
cyBhbmQgDQplbnRlcnByaXNlcy4gVmFsdWUgY2hhaW4gYW5hbHlzaXMgaGVscHMgaW4gdGhl
IGlkZW50aWZpY2F0aW9uIG9mIG1hcmtldHMsIA0KcmVsYXRpb25zaGlwIGJldHdlZW4gZmly
bXMsIGFuZCBjaGFsbGVuZ2VzIHRoYXQgaGluZGVyIG9yZ2FuaXphdGlvbmFsIGdyb3d0aC4g
DQpNQlMgaXMgbWFkZSBwb3NzaWJsZSB3aXRoIHRoZSBjb2xsYWJvcmF0aW9uIG9mIG1hcmtl
dHMgYW5kIHByaXZhdGUgc2VjdG9yIGluIA0KYWRkcmVzc2luZyB0aGUgY2hhbGxlbmdlcyBv
ZiB2YWx1ZSBjaGFpbi4gVGhlcmVmb3JlLCB0aGlzIGNvdXJzZSBpcyBhbmNob3JlZCBieSAN
CnRoZSBnb2FsIG9mIGVxdWlwcGluZyBwYXJ0aWNpcGFudHMgdG8gdGhlIGRldmVsb3BtZW50
IG9mIHN1c3RhaW5hYmxlIHZhbHVlIA0KY2hhaW5zLiANCkhvdyB5b3UgYmVuZWZpdA0KQnkg
dGhlIGVuZCBvZiB0aGlzIGNvdXJzZSB0aGUgDQpwYXJ0aWNpcGFudHMgd2lsbCBiZSBhYmxl
IHRvOg0Kw5jCoCBEZXRlcm1pbmUgdmFsdWUgY2hhaW4gYXBwcm9hY2ggDQppbXBvcnRhbmNl
DQrDmMKgIExlYXJuIHZhbHVlIGNoYWluIHByaW5jaXBsZXMgdGhhdCBlbmhhbmNlIG9yZ2Fu
aXphdGlvbmFsIA0KY29tcGV0aXRpdmVuZXNzDQrDmMKgIFVuZGVyc3RhbmQgbWFya2V0IGRl
dmVsb3BtZW50IGZvdW5kYXRpb25zIGFuZCBwcm9tb3Rpb24gb2YgdmFsdWUgDQpjaGFpbg0K
w5jCoCBEZXRlcm1pbmUgdGhlIG5lZWRzIG9mIHRoZSBtYXJrZXQgYW5kIGlkZW50aWZ5IA0K
Y29uc3RyYWlucw0Kw5jCoCBVbmRlcnN0YW5kIHN0YWtlaG9sZGVy4oCZcyByb2xlcyBpbiB2
YWx1ZSANCmNoYWlucw0Kw5jCoCBFc3RhYmxpc2ggc3RyYXRlZ2llcywgaW50ZXJ2ZW50aW9u
cywgYW5kIG1ldGhvZHMgaW4gZGV2ZWxvcG1lbnQgb2YgDQp2YWx1ZSBjaGFpbg0KV2hvIHNo
b3VsZCBhdHRlbmQNClRoZSBjb3Vyc2UgdGFyZ2V0cyBwcm9mZXNzaW9uYWxzIHdvcmtpbmcg
DQppbiB0aGUgYWdyaWN1bHR1cmFsIGV4dGVuc2lvbiBzZWN0b3IsIE5HT3MgYW5kIGdvdmVy
bm1lbnRhbCBjb3Jwb3JhdGlvbnMsIGFuZCANCmFsbCBpbmRpdmlkdWFscyBpbnRlcmVzdGVk
IGluIGxlYXJuaW5nIGFib3V0IHZhbHVlIGNoYWluIGRldmVsb3BtZW50IA0KDQpEVVJBVElP
Tg0KNSBEYXlzDQpDT1VSU0UgQ09OVEVOVA0KSW50cm9kdWN0aW9uIHRvIFZhbHVlIENoYWlu
IA0KRGV2ZWxvcG1lbnQNCsK3wqDCoMKgwqDCoMKgIA0KwqBWYWx1ZSBjaGFpbnMgDQpjb25j
ZXB0cw0KwrfCoMKgwqDCoMKgwqAgDQpGdW5jdGlvbnMgb2YgdmFsdWUgDQpjaGFpbnMNCsK3
wqDCoMKgwqDCoMKgIA0KU2lnbmlmaWNhbmNlIG9mIHZhbHVlIA0KY2hhaW5zDQrCt8KgwqDC
oMKgwqDCoCANCkxpbWl0YXRpb25zIG9mIHZhbHVlIA0KY2hhaW5zDQpWYWx1ZSBDaGFpbiBQ
cm9qZWN0IERlc2lnbiANCk92ZXJ2aWV3DQrCt8KgwqDCoMKgwqDCoCANClNlbGVjdGlvbiBv
ZiB2YWx1ZSANCmNoYWluDQrCt8KgwqDCoMKgwqDCoCANCsKgQW5hbHlzaXMgb2YgdmFsdWUg
DQpjaGFpbg0KwrfCoMKgwqDCoMKgwqAgDQpOZXcgb3IgZXhpc3RpbmcgbWFya2V0LWJhc2Vk
IHNvbHV0aW9ucyAobWJzcykgDQppZGVudGlmaWNhdGlvbg0KwrfCoMKgwqDCoMKgwqAgDQpN
QlMgZmFjaWxpdGF0aW9uIA0KaWRlbnRpZmljYXRpb24NCsK3wqDCoMKgwqDCoMKgIA0KwqBN
YXJrZXQtYmFzZWQgc29sdXRpb25zIA0KYXNzZXNzbWVudA0KwrfCoMKgwqDCoMKgwqAgDQpD
b2xsYWJvcmF0aW9uIHN0cnVjdHVyaW5nIGFuZCBwZXJmb3JtYW5jZSANCm1vbml0b3JpbmcN
CsK3wqDCoMKgwqDCoMKgIA0KUHJhY3RpY2FsIGV4YW1wbGVzIG9mIHZhbHVlIGNoYWlucyBp
biANCmFncmljdWx0dXJlDQpWYWx1ZSBDaGFpbiBpbnRlcnZlbnRpb24gY29uY2VwdCBhbmQg
aXRzIHJlbGF0aW9uc2hpcCANCnRvwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQrCt8KgwqDC
oMKgwqDCoCANClZhbHVlIGNoYWluIA0KZmluYW5jZQ0KwrfCoMKgwqDCoMKgwqAgDQpQYXJ0
bmVyc2hpcHMgd2l0aCBsZWFkIA0KZmlybXMNCsK3wqDCoMKgwqDCoMKgIA0KRW5hYmxpbmcg
DQplbnZpcm9ubWVudHMNCsK3wqDCoMKgwqDCoMKgIA0KTG9jYWwgZWNvbm9taWMgDQpkZXZl
bG9wbWVudA0KUmlzayBJZGVudGlmaWNhdGlvbiBhbmQgTWFuYWdlbWVudCBpbiBWYWx1ZSAN
CkNoYWlucw0KwrfCoMKgwqDCoMKgwqAgDQpGcmFtZXdvcmvCoG9mIFJpc2sgDQptYW5hZ2Vt
ZW50DQrCt8KgwqDCoMKgwqDCoCANClRlY2huaXF1ZXMgb2YgdGhlIHJpc2sgDQptYW5hZ2Vt
ZW50DQpTdHJlbmd0aHMgJiBDb25zdHJhaW50cyBBbmFseXNpcyBpbiBWYWx1ZSANCkNoYWlu
cw0KwrfCoMKgwqDCoMKgwqAgDQpBbmFseXNpcyBvZiBFbmQgDQptYXJrZXQNCsK3wqDCoMKg
wqDCoMKgIA0KR292ZXJuYW5jZSBvZiBWYWx1ZSANCmNoYWluDQrCt8KgwqDCoMKgwqDCoCAN
CkludGVyLWZpcm0gDQpyZWxhdGlvbnNoaXBzDQrCt8KgwqDCoMKgwqDCoCANClN1c3RhaW5h
YmxlIA0KU29sdXRpb25zDQpHZW5kZXIgRW5nYWdlbWVudCBpbiBWYWx1ZSANCkNoYWlucw0K
wrfCoMKgwqDCoMKgwqAgDQpHZW5kZXIgYW5hbHlzaXMgYW5kIGFncmljdWx0dXJhbCBtYXJr
ZXRzLCBzZXJ2aWNlcyANCmFuZCB2YWx1ZSBjaGFpbnMNCsK3wqDCoMKgwqDCoMKgIA0KwqBX
b21lbuKAmXMgYWNjZXNzIHRvIHByb2R1Y3RpdmUgDQpyZXNvdXJjZXMgYW5kIG1hcmtldHMN
CsK3wqDCoMKgwqDCoMKgIA0KSW5mbHVlbmNpbmcgdGhlIHBvbGljeSBhbmQgbGVnYWwgDQpl
bnZpcm9ubWVudA0KTWFya2V0IExpbmthZ2VzIGluIFZhbHVlIA0KQ2hhaW4NCsK3wqDCoMKg
wqDCoMKgIA0KVHlwZXMgb2YgbWFya2V0IA0KbGlua2FnZXMNCsK3wqDCoMKgwqDCoMKgIA0K
UHJpbmNpcGxlcyBmb3IgYWRvcHRpbmcgbWFya2V0IGRldmVsb3BtZW50IGFwcHJvYWNoIA0K
Zm9yIGVudGVycHJpc2UgZGV2ZWxvcG1lbnQNCsK3wqDCoMKgwqDCoMKgIA0KUHJvZml0YWJs
ZSBtYXJrZXRzDQrCt8KgwqDCoMKgwqDCoCANClN0YWtlaG9sZGVyc+KAmSByb2xlIGluIHZh
bHVlIA0KY2hhaW5zDQrCt8KgwqDCoMKgwqDCoCANCkZhY3RvcnMgYWZmZWN0aW5nIHRoZSBs
aW5rYWdlcyANCnN1Y2Nlc3MNCsK3wqDCoMKgwqDCoMKgIA0KVGhlIA0KZW5hYmxpbmcgZW52
aXJvbm1lbnQgZm9yIG1hcmtldCBsaW5rYWdlcw0KwqANCkdFTkVSQUwgTk9URVMNClRoaXMg
Y291cnNlIGlzIGRlbGl2ZXJlZCBieSBvdXIgc2Vhc29uZWQgDQogIHRyYWluZXJzIHdobyBo
YXZlIHZhc3QgZXhwZXJpZW5jZSBhcyBleHBlcnQgcHJvZmVzc2lvbmFscyBpbiB0aGUgcmVz
cGVjdGl2ZSANCiAgZmllbGRzIG9mIHByYWN0aWNlLiBUaGUgY291cnNlIGlzIHRhdWdodCB0
aHJvdWdoIGEgbWl4IG9mIHByYWN0aWNhbCANCiAgYWN0aXZpdGllcywgdGhlb3J5LCBncm91
cCB3b3JrcyBhbmQgY2FzZSBzdHVkaWVzLg0KVHJhaW5pbmcgbWFudWFscyBhbmQgYWRkaXRp
b25hbCByZWZlcmVuY2UgDQogIG1hdGVyaWFscyBhcmUgcHJvdmlkZWQgdG8gdGhlIHBhcnRp
Y2lwYW50cy4NClVwb24gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMgY291cnNlLCAN
CiAgcGFydGljaXBhbnRzIHdpbGwgYmUgaXNzdWVkIHdpdGggYSBjZXJ0aWZpY2F0ZS4NCldl
IGNhbiBhbHNvIGRvIHRoaXMgYXMgdGFpbG9yLW1hZGUgY291cnNlIHRvIA0KICBtZWV0IG9y
Z2FuaXphdGlvbi13aWRlIG5lZWRzLiBDb250YWN0IHVzIHRvIGZpbmQgb3V0IG1vcmU6IA0K
ICB0cmFpbmluZ0Bza2lsbHNmb3JhZnJpY2Eub3JnDQpUaGUgdHJhaW5pbmcgd2lsbCBiZSBj
b25kdWN0ZWQgYXQgU0tJTExTIEZPUiANCiAgQUZSSUNBIFRSQUlOSU5HIElOU1RJVFVURSBJ
TiBOQUlST0JJIEtFTllBLg0KVGhlIHRyYWluaW5nIGZlZSBjb3ZlcnMgdHVpdGlvbiBmZWVz
LCANCiAgdHJhaW5pbmcgbWF0ZXJpYWxzLCBsdW5jaCBhbmQgdHJhaW5pbmcgdmVudWUuIEFj
Y29tbW9kYXRpb24gYW5kIGFpcnBvcnQgDQogIHRyYW5zZmVyIGFyZSBhcnJhbmdlZCBmb3Ig
b3VyIHBhcnRpY2lwYW50cyB1cG9uIA0KcmVxdWVzdC4NClBheW1lbnQgc2hvdWxkIGJlIHNl
bnQgdG8gb3VyIGJhbmsgYWNjb3VudCANCiAgYmVmb3JlIHN0YXJ0IG9mIHRyYWluaW5nIGFu
ZCBwcm9vZiBvZiBwYXltZW50IHNlbnQgdG86IA0KICB0cmFpbmluZ0Bza2lsbHNmb3JhZnJp
Y2Eub3JnDQrCoA0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tp
bmcvdW5zdWJzY3JpYmU/ZD1CdVFHQllDWm1xOGVMWHo5a3owM0c5di1iOXZ6MFBOLUEtdUdu
RVZHYko4dDRkbno5WXVVMEV0WHFiN25VbkRneU1nR3cxSmlHX0dSUVNLN0tEMkZybFJFYzZS
ZjdjN1Z1bEwtVWg2TXFIcXcwPg0KVU5TVUJTQ1JJQkU=

--=-eZCfMW7f+w7FAZ6xf+IhTCLFhjZU2uk/y3WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<P class=3DMsoNormal><B><SPAN lang=3DEN><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28KGUuAsqCExTDM9E7vs41FyhzDW5S5ny0tT0R=
BoDlCo-68kC_-i9WIIATvSyM5yuE7MAsLcKO1OD4ONSoU0W_OJ7aJesWuaY25daWEus1uO=
1NA1"><FONT><FONT>VALUE CHAIN DEVELOPMENT=20
AND MARKET LINKAGE TRAINING SEMINAR 11<SUP>TH </SUP>to 15<SUP>TH</SUP>=
 JULY,=20
2022<?xml:namespace prefix =3D "o" ns =3D "urn:schemas-microsoft-com:o=
ffice:office"=20
/><o:p></o:p></FONT></FONT></A></SPAN></B></P>
<P class=3DMsoNormal><U><SPAN><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPtAOIL96PjAKDJ3RIBQYxcyN7aUaTlsB19mb=
AhpHqMVDGxSjhy3n9xSDu017IqFsr6SSEC0giycM0XSgmmhmkZXPswxlSj41oJXep_F00L=
MLL9UW5Q-qARqyhlMp-Sd9pB0"=20
target=3D_blank><SPAN><FONT>Register for online workshop=20
attendance&nbsp;</FONT></SPAN></A></SPAN></U><SPAN><o:p><FONT>&nbsp;</=
FONT></o:p></SPAN></P>
<P class=3DMsoNormal><U><SPAN><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPtAOIL96PjAKDJ3RIBQYxcyN7aUaTlsB19mb=
AhpHqMVJle94zqmD-f_LeTA63INEb5sjqW9_PS98NbifvrOWIMS2j43I02YYtiukrn7Kyp=
I7YJ3CUOX9xGjHJmZxZPbn0N0"=20
target=3D_blank><FONT><FONT>Register to attend the=20
workshop<o:p></o:p></FONT></FONT></A></SPAN></U></P>
<P class=3DMsoNormal><U><SPAN><A href=3D"https://133IK.trk.elasticemai=
l.com/tracking/click?d=3D4RSOGeS5HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLd=
YGtK2rnTGEOpFOzcdjxfzQJQ2NDw1_JMRKLnrScoSbV-zZ0uDX0EQFrfDDPWkVHc1p_jVm=
upLZ-FD0ul-9Tx32ViUxI0iu58JQTJJKQVXw1"=20
target=3D_blank><SPAN><FONT>Calendar for 2022=20
Workshops</FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal><U><SPAN><A href=3D"https://133IK.trk.elasticemai=
l.com/tracking/click?d=3D4RSOGeS5HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcK=
BW5GxjbuXFiVo4EDQDAXXSWeVMt9rYHYWJibuVsom3v0zjb8ae00sePqgSCWMdw_FGBDT6=
EuKWfa31ttgpxlGYMdofjEHRdZBDJTw6aXV81"=20
target=3D_blank><SPAN><FONT>Contact us</FONT></SPAN></A></SPAN></U></P=
>
<P class=3DMsoNormal><U><SPAN><A href=3D"https://133IK.trk.elasticemai=
l.com/tracking/click?d=3DTdO1gCuQ71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejia5=
-XG7MGBTweAaZL90Vb0q89ZDXmnaOoeGkoTCnfgTPiCqPXgM-PFov7ghbXrBelxSmNnkB5=
0B8SwXQKNe1QxTB3HjEfpMALJKDcu4pisUbI1"=20
target=3D_blank><SPAN><FONT>Whatapp</FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal><U><SPAN></SPAN></U><B><SPAN><FONT>VENUE: BEST WE=
STERN=20
MERIDIAN HOTEL, NAIROBI, KENYA</FONT></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN><FONT>COURSE FEE:=20
1200USD<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal><SPAN><FONT>Office Telephone:=20
+254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><B><SPAN><FONT>Register as a group of 5 or more p=
articipants=20
and get 25% discount on the course fee. <o:p></o:p></FONT></SPAN></B><=
/P>
<P class=3DMsoNormal><SPAN><FONT>Send us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DcBuTGyy=
wHvVirOjnJUaHQdVOF1XUy4kbjI4wI8K-4z1Gv05MyiYpIE4DXQ0898dug_bhuZc0OCEqI=
6KZ9Kv8jmR1FPcj0iIr2oPPtby7RP9t10v3cW4R2AUi8DbhktYFmGk0NOA-mZUyl6r06xu=
kJLMS9DvmJfsowmhr1ORyIPLMre36m0zQq8zC73xDva6U0tiMAM0ASqLx7RjqMsSb8M41"=
 ><FONT>training@skillsforafrica.org&nbsp;</FONT></A><FONT>or=20
call +254-702-249-449</FONT></SPAN></P>
<P class=3DMsoNormal><FONT><B><SPAN lang=3DEN>INTRODUCTION</SPAN></B><=
SPAN=20
lang=3DEN><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><SPAN lang=3DEN><FONT>This course combines value =
chain analysis=20
and market based solutions (MBSs) to cater for the requirements of bus=
iness and=20
enterprises. Value chain analysis helps in the identification of marke=
ts,=20
relationship between firms, and challenges that hinder organizational =
growth.=20
MBS is made possible with the collaboration of markets and private sec=
tor in=20
addressing the challenges of value chain. Therefore, this course is an=
chored by=20
the goal of equipping participants to the development of sustainable v=
alue=20
chains. <o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><FONT><B><SPAN lang=3DEN>How you benefit</SPAN></=
B><SPAN=20
lang=3DEN><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><SPAN lang=3DEN><FONT>By the end of this course t=
he=20
participants will be able to:<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Determine value chain approach=20
importance<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Learn value chain principles that enhance organization=
al=20
competitiveness<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Understand market development foundations and promotio=
n of value=20
chain<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Determine the needs of the market and identify=20
constrains<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Understand stakeholder&rsquo;s roles in value=20
chains<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&#216;<SPAN>&nbsp; </SPAN><=
/SPAN></SPAN><SPAN=20
lang=3DEN><FONT>Establish strategies, interventions, and methods in de=
velopment of=20
value chain<B> <o:p></o:p></B></FONT></SPAN></P>
<P class=3DMsoNormal><FONT><B><SPAN lang=3DEN>Who should attend</SPAN>=
</B><SPAN=20
lang=3DEN><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><SPAN lang=3DEN><FONT>The course targets professi=
onals working=20
in the agricultural extension sector, NGOs and governmental corporatio=
ns, and=20
all individuals interested in learning about value chain development=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal><FONT><B><SPAN lang=3DEN>DURATION</SPAN></B><SPAN=
=20
lang=3DEN><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><SPAN lang=3DEN><FONT>5 Days<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal><FONT><B><SPAN lang=3DEN>COURSE CONTENT</SPAN></B=
><SPAN=20
lang=3DEN><o:p></o:p></SPAN></FONT></P>
<P><STRONG><SPAN>Introduction to Value Chain=20
Development</SPAN></STRONG><?xml:namespace prefix =3D "u1"=20
/><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>&nbsp;</SPAN></SPAN>Value chains=20
concepts<o:p></o:p></SPAN><u1:p></u1:p></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Functions of value=20
chains<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Significance of value=20
chains<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Limitations of value=20
chains<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Value Chain Project Design=20
Overview</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Selection of value=20
chain<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>&nbsp;</SPAN></SPAN>Analysis of value=20
chain<o:p></o:p></SPAN><u1:p></u1:p></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>New or existing market-based solutions (mbs=
s)=20
identification<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>MBS facilitation=20
identification<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>&nbsp;</SPAN></SPAN>Market-based solutions=20
assessment<o:p></o:p></SPAN><u1:p></u1:p></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Collaboration structuring and performance=20
monitoring<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Practical examples of value chains in=20
agriculture<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Value Chain intervention concept and its relationship=
=20
to&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Value chain=20
finance<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Partnerships with lead=20
firms<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Enabling=20
environments<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Local economic=20
development<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Risk Identification and Management in Value=20
Chains</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Framework&nbsp;of Risk=20
management<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Techniques of the risk=20
management<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Strengths &amp; Constraints Analysis in Value=20
Chains</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Analysis of End=20
market<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Governance of Value=20
chain<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Inter-firm=20
relationships<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Sustainable=20
Solutions<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Gender Engagement in Value=20
Chains</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Gender analysis and agricultural markets, s=
ervices=20
and value chains<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>&nbsp;</SPAN></SPAN>Women&rsquo;s access to=
 productive=20
resources and markets<o:p></o:p></SPAN><u1:p></u1:p></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Influencing the policy and legal=20
environment<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><STRONG><SPAN>Market Linkages in Value=20
Chain</SPAN></STRONG><u1:p></u1:p><SPAN><o:p></o:p></SPAN></P>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Types of market=20
linkages<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Principles for adopting market development =
approach=20
for enterprise development<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Profitable markets<o:p></o:p></SPAN></P><u1=
:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Stakeholders&rsquo; role in value=20
chains<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN><SPAN>&#183=
;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN>Factors affecting the linkages=20
success<o:p></o:p></SPAN></P><u1:p></u1:p>
<P><SPAN><SPAN>&#183;<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><SPAN>The=20
enabling environment for market linkages<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN><SPAN>&nbsp;</SPAN><o:p></o:p></S=
PAN></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN>GENERAL NOTES<o:p></o:p></SPAN=
></B></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal><SPAN lang=3DEN>This course is delivered by ou=
r seasoned=20
  trainers who have vast experience as expert professionals in the res=
pective=20
  fields of practice. The course is taught through a mix of practical=20
  activities, theory, group works and case studies.<o:p></o:p></SPAN><=
/LI>
  <LI class=3DMsoNormal><SPAN lang=3DEN>Training manuals and additiona=
l reference=20
  materials are provided to the participants.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal><SPAN lang=3DEN>Upon successful completion of =
this course,=20
  participants will be issued with a certificate.<o:p></o:p></SPAN></L=
I>
  <LI class=3DMsoNormal><SPAN lang=3DEN>We can also do this as tailor-=
made course to=20
  meet organization-wide needs. Contact us to find out more:=20
  training@skillsforafrica.org<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal><SPAN lang=3DEN>The training will be conducted=
 at SKILLS FOR=20
  AFRICA TRAINING INSTITUTE IN NAIROBI KENYA.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal><SPAN lang=3DEN>The training fee covers tuitio=
n fees,=20
  training materials, lunch and training venue. Accommodation and airp=
ort=20
  transfer are arranged for our participants upon=20
request.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal><SPAN lang=3DEN>Payment should be sent to our =
bank account=20
  before start of training and proof of payment sent to:=20
  training@skillsforafrica.org<o:p></o:p></SPAN></LI></UL>
<P=20
class=3DMsoNormal><SPAN><o:p>&nbsp;</o:p></SPAN></P></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3DU=
ljeKiF9OuKnEkd4RVowzg2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DBuQGBYCZmq8eLXz9kz03G9v-b9vz0PN-A-uGnEVGbJ8t4dnz9YuU0EtXqb=
7nUnDgyMgGw1JiG_GRQSK7KD2FrlREc6Rf7c7VulL-Uh6MqHqw0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfMW7f+w7FAZ6xf+IhTCLFhjZU2uk/y3WKzQ==--
