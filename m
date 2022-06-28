Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C771E55BF24
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:31:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGVN4yhHz3c8P
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:31:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=JCcUnVcp;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=ED7j8k5j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=162.254.227.220; helo=s220.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=JCcUnVcp;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=ED7j8k5j;
	dkim-atps=neutral
X-Greylist: delayed 83 seconds by postgrey-1.36 at boromir; Tue, 28 Jun 2022 17:31:04 AEST
Received: from s220.mxout.mta4.net (s220.mxout.mta4.net [162.254.227.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGVJ5Hn4z2ywN
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:31:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1656401357;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=Hhl52xrVjmYCvFnYadIc1Tqanwpjt3ivbGdozish0ZY=;
	b=JCcUnVcpjXFY6Gx8QTUzHMX75JAd+IxFjO0p9CbwIFFfotDdVknPTkR4UAivlR1OEEpcszXpLzf
	yWsCOsrgPMuefJjyak6c5lHPEZNQAJmDy3drTcXYU3Vb9U3kZ1l3vMotZYCsi/Ti/c/slqVNOu5bE
	ZVMtdYt9Wv74cqkMO1A=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1656401357;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=Hhl52xrVjmYCvFnYadIc1Tqanwpjt3ivbGdozish0ZY=;
	b=ED7j8k5jlRqTMdqde2ytSzwuptAyNx6zEHquJ/CjbkFjgWuh+mJjb2ZZhI/gNC5rrv521Jw4bCf
	NVuszh07VP6365yPkvjzsVZMIBIY3DxpHNkD06sXUGTG5z0teR0vgPe1lP3/7hoQ2idZx5p45SLnL
	UROLrayPVO4NaGyR6Ic=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Tue, 28 Jun 2022 07:29:17 +0000
Subject: INVITATION TO ATTEND A VALUE CHAIN DEVELOPMENT AND MARKET LINKAGE
 TRAINING SEMINAR 11TH to 15TH JULY, 2022
Message-Id: <4uh7rdue56jh.0q80h_6MN3ooCylc61eohw2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: 0q80h_6MN3ooCylc61eohw2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfVHONri3zceqwOcYgSjDN0VIz0PEt23WKzQ=="
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

--=-eZCfVHONri3zceqwOcYgSjDN0VIz0PEt23WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4S3lWdk9RLWQx
MnNqVUk3QlZBUnlKN1RkYkplSTVTMlNHMUdzaGdKUHNsamtRR3ZwZnc2OHRMZ0M1dW1qc3JS
Q3F4cE82eFNfZEZIRUtUajZtaUpGdFp5MTB5TUtxVXlTRnp4SW8tc1RyVWswNDE+DQpWQUxV
RSBDSEFJTiBERVZFTE9QTUVOVCBBTkQgTUFSS0VUIExJTktBR0UgVFJBSU5JTkcgU0VNSU5B
UiANCjExVEggdG8gMTVUSCBKVUxZLCAyMDIyDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsu
ZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVK
OS1SdDIyNVlZc1BtV2pOV3NxcXJUdFB0QU9JTDk2UGpBS0RKM1JJQlFZeGNfMUUyM1E5MWpr
bUZyanRldjFzWkI5SXRmcktGVWZpSXp1TllOTnV6MUk0Wk4xMHJMdGNYZnpIYmlKNEJGN2NE
UmlPSm9LT1NKMXNHM3hSRldSY2k2WVpSYTE0SVFUQzBQSUlTM1IzREtKTkEwPg0KUmVnaXN0
ZXIgZm9yIG9ubGluZSB3b3Jrc2hvcCANCmF0dGVuZGFuY2UgDQrCoA0KDQo8aHR0cHM6Ly8x
MzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJG
aGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdFB0QU9JTDk2UGpBS0RKM1JJQlFZeGNf
MUUyM1E5MWprbUZyanRldjFzWkIzWkN5eGR2aTRzektZZTZZNnVxZjZZVTdnU25VSkFuRmhp
UGhlVUdSdjZDMklyaHJFbG9NUm9UQkJHZjhvX01HY1RPSEhZdDc3cVdRb2dTUnR2anhjZFUw
Pg0KUmVnaXN0ZXIgdG8gYXR0ZW5kIHRoZSANCndvcmtzaG9wDQrCoA0KDQo8aHR0cHM6Ly8x
MzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPTRSU09HZVM1SEk2
S0ZKaXhRcHlrVUg3U0JEU2owQTJFZEhkY3FxRWstS01MZFlHdEsycm5UR0VPcEZPemNkangx
RzR5cVBiSkYybk9tejl1M3YtR3BGcjU1b3dORGNvd2Rvc0RvVlU5VFpqVTRKV2haWE5QOUdo
R1lMZGdPWUc5QUFDR1F0VmdWckZOMS1MOUNZb2xaM1kxPg0KQ2FsZW5kYXIgZm9yIDIwMjIg
DQpXb3Jrc2hvcHMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29t
L3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRj
cXFFay1LTWNLQlc1R3hqYnVYRmlWbzRFRFFEQVVOV3BCdldSWkVhR1VDblY4YUIybWxIdEU0
dThXdzRVSWtIeFIyVk0zQ0lzN3Y3VXQ1OHZVOTkxLTVLdWJ5bDllZl9sNm5WLVNxcW8xQXk3
MUhBSXpxVTE+DQpDb250YWN0IA0KdXMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFz
dGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9VGRPMWdDdVE3MWhwV0w2MEJXTm50dXdm
MklXSmZrX2tKUV9PZXg1X2VqaEItcmNLOGQzZTdXUjlkSGloSjhMM193X1J0VWk5N1Y2Rkpw
Wl9FUnVBWTBmUy12ZUo3NGtjaTh2d3NOZ2dOMkhqN2dJeTh3LTlta1VLd0lIT0NIYjFKcUpO
QVZwZ0NIR1k5Z1BqUWZYZUpPUTE+DQpXaGF0YXBwDQrCoA0KVkVOVUU6IEJFU1QgV0VTVEVS
TiBNRVJJRElBTiBIT1RFTCwgTkFJUk9CSSwgDQpLRU5ZQQ0KwqANCkNPVVJTRSBGRUU6IDEy
MDBVU0QNCsKgDQpPZmZpY2UgVGVsZXBob25lOiArMjU0LTcwMi0yNDktNDQ5DQpSZWdpc3Rl
ciBhcyBhIGdyb3VwIG9mIDUgb3IgbW9yZSBwYXJ0aWNpcGFudHMgYW5kIGdldCAyNSUgZGlz
Y291bnQgDQpvbiB0aGUgY291cnNlIGZlZS4gDQpTZW5kIHVzIGFuIGVtYWlsOiANCjxodHRw
czovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9Y0J1VEd5
eXdIdlZpck9qbkpVYUhRZFZPRjFYVXk0a2JqSTR3SThLLTR6MUd2MDVNeWlZcElFNERYUTA4
OThkdWdfYmh1WmMwT0NFcUk2S1o5S3Y4am1SMUZQY2owaUlyMm9QUHRieTdSUF8zVXVLejRO
eHA1MllzMXhGMkZXejRlQW5nQUdqTzVEa3lEaG91TDNRUXAwV0Iya2lDNUdLeXI1QThGbzJY
MEVNQ2RweEF2OGlOX1ZaZzhaSnBhcjZ0T3l4WFhjMS1SZkxtVVpMbmU5cEdsQ1kxPg0KdHJh
aW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZ8Kgb3IgY2FsbCArMjU0LTcwMi0yNDktNDQ5DQrC
oA0KSU5UUk9EVUNUSU9ODQpUaGlzIGNvdXJzZSBjb21iaW5lcyB2YWx1ZSBjaGFpbiBhbmFs
eXNpcyBhbmQgbWFya2V0IGJhc2VkIA0Kc29sdXRpb25zIChNQlNzKSB0byBjYXRlciBmb3Ig
dGhlIHJlcXVpcmVtZW50cyBvZiBidXNpbmVzcyBhbmQgZW50ZXJwcmlzZXMuIA0KVmFsdWUg
Y2hhaW4gYW5hbHlzaXMgaGVscHMgaW4gdGhlIGlkZW50aWZpY2F0aW9uIG9mIG1hcmtldHMs
IHJlbGF0aW9uc2hpcCANCmJldHdlZW4gZmlybXMsIGFuZCBjaGFsbGVuZ2VzIHRoYXQgaGlu
ZGVyIG9yZ2FuaXphdGlvbmFsIGdyb3d0aC4gTUJTIGlzIG1hZGUgDQpwb3NzaWJsZSB3aXRo
IHRoZSBjb2xsYWJvcmF0aW9uIG9mIG1hcmtldHMgYW5kIHByaXZhdGUgc2VjdG9yIGluIGFk
ZHJlc3NpbmcgdGhlIA0KY2hhbGxlbmdlcyBvZiB2YWx1ZSBjaGFpbi4gVGhlcmVmb3JlLCB0
aGlzIGNvdXJzZSBpcyBhbmNob3JlZCBieSB0aGUgZ29hbCBvZiANCmVxdWlwcGluZyBwYXJ0
aWNpcGFudHMgdG8gdGhlIGRldmVsb3BtZW50IG9mIHN1c3RhaW5hYmxlIHZhbHVlIGNoYWlu
cy4gDQoNCkhvdyANCnlvdSBiZW5lZml0DQpCeSB0aGUgZW5kIG9mIHRoaXMgY291cnNlIHRo
ZSBwYXJ0aWNpcGFudHMgd2lsbCBiZSBhYmxlIA0KdG86DQrDmMKgIA0KRGV0ZXJtaW5lIHZh
bHVlIGNoYWluIGFwcHJvYWNoIA0KaW1wb3J0YW5jZQ0Kw5jCoCANCkxlYXJuIHZhbHVlIGNo
YWluIHByaW5jaXBsZXMgdGhhdCBlbmhhbmNlIG9yZ2FuaXphdGlvbmFsIA0KY29tcGV0aXRp
dmVuZXNzDQrDmMKgIA0KVW5kZXJzdGFuZCBtYXJrZXQgZGV2ZWxvcG1lbnQgZm91bmRhdGlv
bnMgYW5kIHByb21vdGlvbiBvZiB2YWx1ZSANCmNoYWluDQrDmMKgIA0KRGV0ZXJtaW5lIHRo
ZSBuZWVkcyBvZiB0aGUgbWFya2V0IGFuZCBpZGVudGlmeSANCmNvbnN0cmFpbnMNCsOYwqAg
DQpVbmRlcnN0YW5kIHN0YWtlaG9sZGVy4oCZcyByb2xlcyBpbiB2YWx1ZSANCmNoYWlucw0K
w5jCoCANCkVzdGFibGlzaCBzdHJhdGVnaWVzLCBpbnRlcnZlbnRpb25zLCBhbmQgbWV0aG9k
cyBpbiBkZXZlbG9wbWVudCBvZiANCnZhbHVlIGNoYWluDQpXaG8gDQpzaG91bGQgYXR0ZW5k
DQpUaGUgY291cnNlIHRhcmdldHMgcHJvZmVzc2lvbmFscyB3b3JraW5nIGluIHRoZSBhZ3Jp
Y3VsdHVyYWwgDQpleHRlbnNpb24gc2VjdG9yLCBOR09zIGFuZCBnb3Zlcm5tZW50YWwgY29y
cG9yYXRpb25zLCBhbmQgYWxsIGluZGl2aWR1YWxzIA0KaW50ZXJlc3RlZCBpbiBsZWFybmlu
ZyBhYm91dCB2YWx1ZSBjaGFpbiBkZXZlbG9wbWVudCANCg0KRFVSQVRJT04NCjUgRGF5cw0K
Q09VUlNFIA0KQ09OVEVOVA0KSW50cm9kdWN0aW9uIA0KdG8gVmFsdWUgQ2hhaW4gRGV2ZWxv
cG1lbnQNCsK3wqDCoMKgwqDCoMKgIA0KwqBWYWx1ZSANCmNoYWlucyBjb25jZXB0cw0KwrfC
oMKgwqDCoMKgwqAgDQpGdW5jdGlvbnMgDQpvZiB2YWx1ZSBjaGFpbnMNCsK3wqDCoMKgwqDC
oMKgIA0KU2lnbmlmaWNhbmNlIA0Kb2YgdmFsdWUgY2hhaW5zDQrCt8KgwqDCoMKgwqDCoCAN
CkxpbWl0YXRpb25zIA0Kb2YgdmFsdWUgY2hhaW5zDQpWYWx1ZSANCkNoYWluIFByb2plY3Qg
RGVzaWduIE92ZXJ2aWV3DQrCt8KgwqDCoMKgwqDCoCANClNlbGVjdGlvbiANCm9mIHZhbHVl
IGNoYWluDQrCt8KgwqDCoMKgwqDCoCANCsKgQW5hbHlzaXMgDQpvZiB2YWx1ZSBjaGFpbg0K
wrfCoMKgwqDCoMKgwqAgDQpOZXcgDQpvciBleGlzdGluZyBtYXJrZXQtYmFzZWQgc29sdXRp
b25zIChtYnNzKSANCmlkZW50aWZpY2F0aW9uDQrCt8KgwqDCoMKgwqDCoCANCk1CUyANCmZh
Y2lsaXRhdGlvbiBpZGVudGlmaWNhdGlvbg0KwrfCoMKgwqDCoMKgwqAgDQrCoE1hcmtldC1i
YXNlZCANCnNvbHV0aW9ucyBhc3Nlc3NtZW50DQrCt8KgwqDCoMKgwqDCoCANCkNvbGxhYm9y
YXRpb24gDQpzdHJ1Y3R1cmluZyBhbmQgcGVyZm9ybWFuY2UgbW9uaXRvcmluZw0KwrfCoMKg
wqDCoMKgwqAgDQpQcmFjdGljYWwgDQpleGFtcGxlcyBvZiB2YWx1ZSBjaGFpbnMgaW4gYWdy
aWN1bHR1cmUNClZhbHVlIA0KQ2hhaW4gaW50ZXJ2ZW50aW9uIGNvbmNlcHQgYW5kIGl0cyBy
ZWxhdGlvbnNoaXAgDQp0b8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KwrfCoMKgwqDCoMKg
wqAgDQpWYWx1ZSANCmNoYWluIGZpbmFuY2UNCsK3wqDCoMKgwqDCoMKgIA0KUGFydG5lcnNo
aXBzIA0Kd2l0aCBsZWFkIGZpcm1zDQrCt8KgwqDCoMKgwqDCoCANCkVuYWJsaW5nIA0KZW52
aXJvbm1lbnRzDQrCt8KgwqDCoMKgwqDCoCANCkxvY2FsIA0KZWNvbm9taWMgZGV2ZWxvcG1l
bnQNClJpc2sgDQpJZGVudGlmaWNhdGlvbiBhbmQgTWFuYWdlbWVudCBpbiBWYWx1ZSBDaGFp
bnMNCsK3wqDCoMKgwqDCoMKgIA0KRnJhbWV3b3JrwqBvZiANClJpc2sgbWFuYWdlbWVudA0K
wrfCoMKgwqDCoMKgwqAgDQpUZWNobmlxdWVzIA0Kb2YgdGhlIHJpc2sgbWFuYWdlbWVudA0K
U3RyZW5ndGhzIA0KJiBDb25zdHJhaW50cyBBbmFseXNpcyBpbiBWYWx1ZSBDaGFpbnMNCsK3
wqDCoMKgwqDCoMKgIA0KQW5hbHlzaXMgDQpvZiBFbmQgbWFya2V0DQrCt8KgwqDCoMKgwqDC
oCANCkdvdmVybmFuY2UgDQpvZiBWYWx1ZSBjaGFpbg0KwrfCoMKgwqDCoMKgwqAgDQpJbnRl
ci1maXJtIA0KcmVsYXRpb25zaGlwcw0KwrfCoMKgwqDCoMKgwqAgDQpTdXN0YWluYWJsZSAN
ClNvbHV0aW9ucw0KR2VuZGVyIA0KRW5nYWdlbWVudCBpbiBWYWx1ZSBDaGFpbnMNCsK3wqDC
oMKgwqDCoMKgIA0KR2VuZGVyIA0KYW5hbHlzaXMgYW5kIGFncmljdWx0dXJhbCBtYXJrZXRz
LCBzZXJ2aWNlcyBhbmQgdmFsdWUgDQpjaGFpbnMNCsK3wqDCoMKgwqDCoMKgIA0KwqBXb21l
buKAmXMgDQphY2Nlc3MgdG8gcHJvZHVjdGl2ZSByZXNvdXJjZXMgYW5kIG1hcmtldHMNCsK3
wqDCoMKgwqDCoMKgIA0KSW5mbHVlbmNpbmcgDQp0aGUgcG9saWN5IGFuZCBsZWdhbCBlbnZp
cm9ubWVudA0KTWFya2V0IA0KTGlua2FnZXMgaW4gVmFsdWUgQ2hhaW4NCsK3wqDCoMKgwqDC
oMKgIA0KVHlwZXMgDQpvZiBtYXJrZXQgbGlua2FnZXMNCsK3wqDCoMKgwqDCoMKgIA0KUHJp
bmNpcGxlcyANCmZvciBhZG9wdGluZyBtYXJrZXQgZGV2ZWxvcG1lbnQgYXBwcm9hY2ggZm9y
IGVudGVycHJpc2UgDQpkZXZlbG9wbWVudA0KwrfCoMKgwqDCoMKgwqAgDQpQcm9maXRhYmxl
IA0KbWFya2V0cw0KwrfCoMKgwqDCoMKgwqAgDQpTdGFrZWhvbGRlcnPigJkgDQpyb2xlIGlu
IHZhbHVlIGNoYWlucw0KwrfCoMKgwqDCoMKgwqAgDQpGYWN0b3JzIA0KYWZmZWN0aW5nIHRo
ZSBsaW5rYWdlcyBzdWNjZXNzDQrCt8KgwqDCoMKgwqDCoCANClRoZSBlbmFibGluZyBlbnZp
cm9ubWVudCBmb3IgDQptYXJrZXQgbGlua2FnZXMNCsKgDQpHRU5FUkFMIA0KTk9URVMNClRo
aXMgDQogIGNvdXJzZSBpcyBkZWxpdmVyZWQgYnkgb3VyIHNlYXNvbmVkIHRyYWluZXJzIHdo
byBoYXZlIHZhc3QgZXhwZXJpZW5jZSBhcyANCiAgZXhwZXJ0IHByb2Zlc3Npb25hbHMgaW4g
dGhlIHJlc3BlY3RpdmUgZmllbGRzIG9mIHByYWN0aWNlLiBUaGUgY291cnNlIGlzIA0KICB0
YXVnaHQgdGhyb3VnaCBhIG1peCBvZiBwcmFjdGljYWwgYWN0aXZpdGllcywgdGhlb3J5LCBn
cm91cCB3b3JrcyBhbmQgY2FzZSANCiAgc3R1ZGllcy4NClRyYWluaW5nIA0KICBtYW51YWxz
IGFuZCBhZGRpdGlvbmFsIHJlZmVyZW5jZSBtYXRlcmlhbHMgYXJlIHByb3ZpZGVkIHRvIHRo
ZSANCiAgcGFydGljaXBhbnRzLg0KVXBvbiANCiAgc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9m
IHRoaXMgY291cnNlLCBwYXJ0aWNpcGFudHMgd2lsbCBiZSBpc3N1ZWQgd2l0aCBhIA0KICBj
ZXJ0aWZpY2F0ZS4NCldlIA0KICBjYW4gYWxzbyBkbyB0aGlzIGFzIHRhaWxvci1tYWRlIGNv
dXJzZSB0byBtZWV0IG9yZ2FuaXphdGlvbi13aWRlIG5lZWRzLiANCiAgQ29udGFjdCB1cyB0
byBmaW5kIG91dCBtb3JlOiANCiAgdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZw0KVGhl
IA0KICB0cmFpbmluZyB3aWxsIGJlIGNvbmR1Y3RlZCBhdCBTS0lMTFMgRk9SIEFGUklDQSBU
UkFJTklORyBJTlNUSVRVVEUgSU4gTkFJUk9CSSANCiAgS0VOWUEuDQpUaGUgDQogIHRyYWlu
aW5nIGZlZSBjb3ZlcnMgdHVpdGlvbiBmZWVzLCB0cmFpbmluZyBtYXRlcmlhbHMsIGx1bmNo
IGFuZCB0cmFpbmluZyANCiAgdmVudWUuIEFjY29tbW9kYXRpb24gYW5kIGFpcnBvcnQgdHJh
bnNmZXIgYXJlIGFycmFuZ2VkIGZvciBvdXIgcGFydGljaXBhbnRzIA0KICB1cG9uIHJlcXVl
c3QuDQpQYXltZW50IA0KICBzaG91bGQgYmUgc2VudCB0byBvdXIgYmFuayBhY2NvdW50IGJl
Zm9yZSBzdGFydCBvZiB0cmFpbmluZyBhbmQgcHJvb2Ygb2YgDQogIHBheW1lbnQgc2VudCB0
bzogdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZw0KwqANCjxodHRwczovLzEzM0lLLnRy
ay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9UE9rWmZuSFh1aUp6
bUtscmUwZjZTVXVtQkpFVXZZTUhaSHdxVzhkQ2Q5TXFTWm1xaHZPOUN6Z0NxMFBPN2N4SkpC
UDlzUHZxMWxtNllzSEROSG5BUVhBNEhoSjk5Sko5aGNiUTZxNi11V1c1MD4NClVOU1VCU0NS
SUJF

--=-eZCfVHONri3zceqwOcYgSjDN0VIz0PEt23WKzQ==
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
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28KyVvOQ-d12sjUI7BVARyJ7TdbJeI5S2SG1Gs=
hgJPsljkQGvpfw68tLgC5umjsrRCqxpO6xS_dFHEKTj6miJFtZy10yMKqUySFzxIo-sTrU=
k041"><FONT color=3D#0563c1><FONT=20
face=3DCalibri>VALUE CHAIN DEVELOPMENT AND MARKET LINKAGE TRAINING SEM=
INAR=20
11<SUP>TH </SUP>to 15<SUP>TH</SUP> JULY, 2022<?xml:namespace prefix =3D=
 "o" ns =3D=20
"urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></FONT></A></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'></SPAN></U>&nbsp;</P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPtAOIL96PjAKDJ3RIBQYxc_1E23Q91jkmFrj=
tev1sZB9ItfrKFUfiIzuNYNNuz1I4ZN10rLtcXfzHbiJ4BF7cDRiOJoKOSJ1sG3xRFWRci=
6YZRa14IQTC0PIIS3R3DKJNA0" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Register for online w=
orkshop=20
attendance <o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPtAOIL96PjAKDJ3RIBQYxc_1E23Q91jkmFrj=
tev1sZB3ZCyxdvi4szKYe6Y6uqf6YU7gSnUJAnFhiPheUGRv6C2IrhrEloMRoTBBGf8o_M=
GcTOHHYt77qWQogSRtvjxcdU0" target=3D_blank><FONT=20
color=3D#0563c1><FONT face=3DCalibri>Register to attend the=20
workshop<o:p></o:p></FONT></FONT></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'></SPAN></U>&nbsp;</P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjx1G4yqPbJF2nOmz=
9u3v-GpFr55owNDcowdosDoVU9TZjU4JWhZXNP9GhGYLdgOYG9AACGQtVgVrFN1-L9CYol=
Z3Y1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Calendar for 2022=20
Workshops<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDAUNWpBvWRZEaGUC=
nV8aB2mlHtE4u8Ww4UIkHxR2VM3CIs7v7Ut58vU991-5Kubyl9ef_l6nV-Sqqo1Ay71HAI=
zqU1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT face=3DCalibri>Contact=20
us<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejhB-rcK8d3e7WR9dHihJ8L3_w_RtUi97V6FJp=
Z_ERuAY0fS-veJ74kci8vwsNggN2Hj7gIy8w-9mkUKwIHOCHb1JqJNAVpgCHGY9gPjQfXe=
JOQ1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext"><FONT=20
face=3DCalibri>Whatapp<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>VENUE: BEST WESTERN MERIDIAN HOTEL, NAIROBI,=20
KENYA</FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri></FONT></SPAN></B>&nbsp;</P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>COURSE FEE: 1200USD</FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri><o:p></o:p></FONT></SPAN></B>&nbsp;</P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>Office Telephone: +254-702-249-449<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri'><FONT=20
face=3DCalibri>Send us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DcBuTGyy=
wHvVirOjnJUaHQdVOF1XUy4kbjI4wI8K-4z1Gv05MyiYpIE4DXQ0898dug_bhuZc0OCEqI=
6KZ9Kv8jmR1FPcj0iIr2oPPtby7RP_3UuKz4Nxp52Ys1xF2FWz4eAngAGjO5DkyDhouL3Q=
Qp0WB2kiC5GKyr5A8Fo2X0EMCdpxAv8iN_VZg8ZJpar6tOyxXXc1-RfLmUZLne9pGlCY1"=
 ><FONT=20
color=3D#0563c1 face=3DCalibri>training@skillsforafrica.org&nbsp;</FON=
T></A><FONT=20
face=3DCalibri>or call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">INTRODUCTION</SPAN></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><FONT=20
face=3DCalibri>This course combines value chain analysis and market ba=
sed=20
solutions (MBSs) to cater for the requirements of business and enterpr=
ises.=20
Value chain analysis helps in the identification of markets, relations=
hip=20
between firms, and challenges that hinder organizational growth. MBS i=
s made=20
possible with the collaboration of markets and private sector in addre=
ssing the=20
challenges of value chain. Therefore, this course is anchored by the g=
oal of=20
equipping participants to the development of sustainable value chains.=
=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">How=20
you benefit</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><FONT=20
face=3DCalibri>By the end of this course the participants will be able=
=20
to:<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-fareast-font-fam=
ily: Wingdings; mso-bidi-font-family: Wingdings; mso-ansi-language: EN=
"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Determine value chain approach=20
importance<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-fareast-font-fam=
ily: Wingdings; mso-bidi-font-family: Wingdings; mso-ansi-language: EN=
"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Learn value chain principles that enhance organizationa=
l=20
competitiveness<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-fareast-font-fam=
ily: Wingdings; mso-bidi-font-family: Wingdings; mso-ansi-language: EN=
"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Understand market development foundations and promotion=
 of value=20
chain<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-fareast-font-fam=
ily: Wingdings; mso-bidi-font-family: Wingdings; mso-ansi-language: EN=
"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Determine the needs of the market and identify=20
constrains<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-fareast-font-fam=
ily: Wingdings; mso-bidi-font-family: Wingdings; mso-ansi-language: EN=
"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Understand stakeholder&rsquo;s roles in value=20
chains<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: n=
ormal; TEXT-AUTOSPACE: ; TEXT-INDENT: -18pt; mso-list: l2 level1 lfo3;=
 mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Wingdings; mso-bidi-font-weight=
: bold; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wing=
dings; mso-ansi-language: EN"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ansi-lang=
uage: EN"><FONT=20
face=3DCalibri>Establish strategies, interventions, and methods in dev=
elopment of=20
value chain<B> <o:p></o:p></B></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">Who=20
should attend</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><FONT=20
face=3DCalibri>The course targets professionals working in the agricul=
tural=20
extension sector, NGOs and governmental corporations, and all individu=
als=20
interested in learning about value chain development=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">DURATION</SPAN></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><FONT=20
face=3DCalibri>5 Days<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">COURSE=20
CONTENT</SPAN></B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P style=3D"MARGIN: 0cm 0cm 6.75pt; LINE-HEIGHT: 14.65pt"><STRONG><SPA=
N=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Introduction=20
to Value Chain Development</SPAN></STRONG><?xml:namespace prefix =3D "=
u1" /><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>&nbsp;</SPAN></SPAN>Value=20
chains concepts<o:p></o:p></SPAN><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Functions=20
of value chains<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Significance=20
of value chains<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Limitations=20
of value chains<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Value=20
Chain Project Design Overview</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Selection=20
of value chain<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>&nbsp;</SPAN></SPAN>Analysis=20
of value chain<o:p></o:p></SPAN><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>New=20
or existing market-based solutions (mbss)=20
identification<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>MBS=20
facilitation identification<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>&nbsp;</SPAN></SPAN>Market-based=20
solutions assessment<o:p></o:p></SPAN><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Collaboration=20
structuring and performance monitoring<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Practical=20
examples of value chains in agriculture<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Value=20
Chain intervention concept and its relationship=20
to&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Value=20
chain finance<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Partnerships=20
with lead firms<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Enabling=20
environments<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Local=20
economic development<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Risk=20
Identification and Management in Value Chains</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Framework&nbsp;of=20
Risk management<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Techniques=20
of the risk management<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Strengths=20
&amp; Constraints Analysis in Value Chains</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Analysis=20
of End market<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Governance=20
of Value chain<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Inter-firm=20
relationships<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Sustainable=20
Solutions<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Gender=20
Engagement in Value Chains</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Gender=20
analysis and agricultural markets, services and value=20
chains<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>&nbsp;</SPAN></SPAN>Women&rsquo;s=20
access to productive resources and markets<o:p></o:p></SPAN><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Influencing=20
the policy and legal environment<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 14.2pt; LINE-HEIGHT: 14.65pt; border-radiu=
s: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial"><STRONG=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Market=20
Linkages in Value Chain</SPAN></STRONG><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p></o:p></SPAN></P>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Types=20
of market linkages<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Principles=20
for adopting market development approach for enterprise=20
development<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Profitable=20
markets<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Stakeholders&rsquo;=20
role in value chains<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Factors=20
affecting the linkages success<o:p></o:p></SPAN></P><u1:p=20
style=3D"BOX-SIZING: border-box; border-radius: 0px"></u1:p>
<P=20
style=3D"BOX-SIZING: border-box; WORD-SPACING: 0px; ORPHANS: 2; WIDOWS=
: 2; MARGIN: 0cm 0cm 6.75pt 32.2pt; LINE-HEIGHT: 14.65pt; TEXT-INDENT:=
 -18pt; mso-list: l1 level1 lfo2; border-radius: 0px; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-decoration-style: initia=
l; text-decoration-color: initial"><SPAN=20
style=3D"FONT-FAMILY: Symbol; mso-fareast-font-family: Symbol; mso-bid=
i-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><SPAN=20
style=3D"BOX-SIZING: border-box; border-radius: 0px">The enabling envi=
ronment for=20
market linkages<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%; =
TEXT-AUTOSPACE: ; mso-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">GENERAL=20
NOTES<o:p></o:p></SPAN></B></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">This=20
  course is delivered by our seasoned trainers who have vast experienc=
e as=20
  expert professionals in the respective fields of practice. The cours=
e is=20
  taught through a mix of practical activities, theory, group works an=
d case=20
  studies.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">Training=20
  manuals and additional reference materials are provided to the=20
  participants.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">Upon=20
  successful completion of this course, participants will be issued wi=
th a=20
  certificate.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">We=20
  can also do this as tailor-made course to meet organization-wide nee=
ds.=20
  Contact us to find out more:=20
  training@skillsforafrica.org<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">The=20
  training will be conducted at SKILLS FOR AFRICA TRAINING INSTITUTE I=
N NAIROBI=20
  KENYA.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">The=20
  training fee covers tuition fees, training materials, lunch and trai=
ning=20
  venue. Accommodation and airport transfer are arranged for our parti=
cipants=20
  upon request.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 115%=
; TEXT-AUTOSPACE: ; mso-list: l0 level1 lfo1; mso-layout-grid-align: n=
one"><SPAN=20
  lang=3DEN=20
  style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: C=
alibri; mso-ansi-language: EN">Payment=20
  should be sent to our bank account before start of training and proo=
f of=20
  payment sent to: training@skillsforafrica.org<o:p></o:p></SPAN></LI>=
</UL>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><o:p>&nbsp;</o:p></SPAN></P></=
SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
SPAN></SPAN></SPAN></DIV></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3D0=
q80h_6MN3ooCylc61eohw2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DPOkZfnHXuiJzmKlre0f6SUumBJEUvYMHZHwqW8dCd9MqSZmqhvO9CzgCq0=
PO7cxJJBP9sPvq1lm6YsHDNHnAQXA4HhJ99JJ9hcbQ6q6-uWW50" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfVHONri3zceqwOcYgSjDN0VIz0PEt23WKzQ==--
