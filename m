Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D095955ED9C
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 21:08:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXYzF5synz3cCD
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 05:08:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=globalkingprojectmanagement.com header.i=@globalkingprojectmanagement.com header.a=rsa-sha256 header.s=api header.b=QHmOA+7b;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=WoSHIkNB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=globalkingprojectmanagement.com (client-ip=162.254.227.219; helo=s219.mxout.mta4.net; envelope-from=outreach@globalkingprojectmanagement.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=globalkingprojectmanagement.com header.i=@globalkingprojectmanagement.com header.a=rsa-sha256 header.s=api header.b=QHmOA+7b;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=WoSHIkNB;
	dkim-atps=neutral
X-Greylist: delayed 640 seconds by postgrey-1.36 at boromir; Wed, 29 Jun 2022 05:08:30 AEST
Received: from s219.mxout.mta4.net (s219.mxout.mta4.net [162.254.227.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXYz25vCZz3c7H
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 05:08:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=globalkingprojectmanagement.com; s=api;
	c=relaxed/simple; t=1656442632;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=1mqaaQS87BTVs9HTCCxbdQOQsA2dK4VIxi9OcLxYQAM=;
	b=QHmOA+7bYLTCy4UYewAlL4eV1uE4GWTzO9doAUP1krjkYScucgfxszPOLamhUVqgavUhTVEwWmk
	i+i3YLFwBNZxiy5pG+IP3MDkDkVUUvzb/NHGBOz8LWo3GVisFamU7T5zg2H3QGVGjWLYW2Rf+NLrB
	hrH9OBibavVOkpiS4tA=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1656442632;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=1mqaaQS87BTVs9HTCCxbdQOQsA2dK4VIxi9OcLxYQAM=;
	b=WoSHIkNBMh5GctBDc8YcIQUsM+Is/H1w1v1EBXSeetLZX9zNJ27ONVDMTrFO1wN7fe8FgtePbW8
	qsVT4wzAKpKZX1Aho4WJIC4Z/wgD/NZkv2RESDipj/8gO8uYHJd7zn2qifOoUO+3Xv7HQcQ3GolvW
	/3thJVS1jx6+xZsXftM=
From: Global King Project Management
	<outreach@globalkingprojectmanagement.com>
Date: Tue, 28 Jun 2022 18:57:12 +0000
Subject: Invitation for a course In Project Monitoring and Evaluation with
 Data Management and Analysis Course
Message-Id: <4uh7wngf3yqz.kl58GOZCxRAOmbs0ksg8vA2@tracking.globalkingprojectmanagement.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: kl58GOZCxRAOmbs0ksg8vA2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfD26ApgLjHeSGWOgAZCvSgg9x0qYz7XWKzQ=="
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
Reply-To: outreach@globalkingprojectmanagement.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfD26ApgLjHeSGWOgAZCvSgg9x0qYz7XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdlbWVudC5jb20vdHJh
Y2tpbmcvY2xpY2s/ZD1OeTBIUU9fREpteFFqMDlLb0k1UUw0R0lmelBidGs1QmowMUdsWlFJ
S2todUNvX1JtTi1qY090M2JPU3M3bFVwQjMyV2phdThoSUVNVGpWeEczS05QMEh1ZmZsdG5R
NU1jMkdwQldGTnlzUTJELTFObFlnSjY3Z0tfaVZzS2FKaGxkNERRQW9iVVp1bFVoWThnNldK
bC01TVZkQnZWQXhFOXUwNVBRdllBbmVmMD4NClByb2plY3QgTW9uaXRvcmluZyBhbmQgRXZh
bHVhdGlvbiB3aXRoIERhdGEgTWFuYWdlbWVudCBhbmQgDQpBbmFseXNpcyBDb3Vyc2UgSnVs
eSAxMSAyMDIyIHRvIEp1bHkyMiAyMDIyIE1vbWJhc2EgDQpLZW55YS7CoFZlbnVlOsKgIE1v
bWJhc2EsIA0KS2VueWHCoFJlZ2lzdHJhdGlvbjrCoCANCjxodHRwOi8vdHJhY2tpbmcuZ2xv
YmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy9jbGljaz9kPW9NdkFEYVJU
T0lBbUZ1aHlLMGZ0RnMtVjlhM25tMkJ6bjVJNTlWZGduVjNFSnRDUE5QZWhGSHZTR3IzdmM1
bllreHltTVZsMzB6NWpKUmF6eU1TVjRCYXl2dTBTdV8zSjJNVFdwcjh1RXZremdfeWRsUnBt
NG5WUGRrVUY1TmVrZTJuV0FBcXl2cHVzdl8xOEZYMUVjVHhMTTNwMUVjTlFiODVLdTRiT3lm
bjhFQ2o3OHlab0duN3dGVFU5VXQ2Z0l3Mj4NClVzZSB0aGlzIGxpbmsgdG8gDQpyZWdpc3Rl
csKgDQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdlbWVudC5jb20v
dHJhY2tpbmcvY2xpY2s/ZD1Gdm0zdTA2UmJWbjdtOEZjTjdEdVBzbVIxMVVpdWtIYVEtMFFZ
d09hdmRpbFhpQU5vMXlZYkw2SHVyTEZXMWdzV05PcUVZdlgwdGJMTllhRS1KTTJwVThCbW1q
YjRvTVdtT3R4cHdXbkRsQm5IM01sZ0RxbVFJRUlydmU4VTI2SFFtYlozSTBIM0x6ak4yWkxo
S2wwNC1tajJUdGZqVmZtRGZ1M3l5ZkZfREUyczc1b2dDbkVMd1E5d25tbTVYNG9DUDhrWGNi
ZWNnRWpOYkhkd0RZTk1nQUl1b3FHQUxSV2tYMEM2Zi1wUE1VRkdiWVRlOEtIWlo5czVQQkF3
c2twbVVPeVpZaWdqdXlVU0hEY1JkX3RobTQxPg0KRG93bmxvYWQgQWRtaXNzaW9uIEZvcm06
wqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90
cmFja2luZy9jbGljaz9kPXdvMmFYLV9oNTJlRHVFdDE5NHhZTzUyaVhSNTI2V0JIWE5jb2st
ZWpESlhmc1FyT1p5WHUwX0tERFFJTGtfcmh2QU1FQlZSREcxMU0tNWYzR2NlNXZXMjJoSjBI
cGZaUzRJRW54WGc0UEF1VmxGSElFbkJ1WVZFZXZJV0JiaTZOcGZTQ2JrX0ZPRDJFZ2tGd2pX
RGhpckg5cWZLeTVsZno2ZTBjei1XS0RkZ1drTlJRcEgyUF9iYVgzM050YzluRllnMj4NCkRv
d25sb2FkIE91ciANCkNhbGVuZGFyOsKgDQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdw
cm9qZWN0bWFuYWdlbWVudC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1OeTBIUU9fREpteFFqMDlL
b0k1UUw0R0lmelBidGs1QmowMUdsWlFJS2tncXF5N1FLQVZCazBMUndmMjAxMWNXdmVMT0tI
T0VvQjNSZ3lISDlTaEpCa01TaDczeWtHOHc3SHpNZjZ6WTVXREFxbVlKNDBnakRCckIzb2I2
RmMxZDllSEl4b0JNcVREWkwzUzdGeVBLT3BuUXljYVpyVGp4eTBMZ0JYV0NoaldzMD4NClZp
ZXcgYWxsIG91ciANCmNvdXJzZXPCoA0KPGh0dHA6Ly90cmFja2luZy5nbG9iYWxraW5ncHJv
amVjdG1hbmFnZW1lbnQuY29tL3RyYWNraW5nL2NsaWNrP2Q9anpkb2gxQ1RaNW04YXZ6MmpH
SjRidm90TEFTaENCaDZqdFJFTV9XYzdMMGgzVVBpazJ3Y3JDandLQmsxYWJkSVFpRFQ4aUt0
eHBUYWM0SEJ3d3VEZUdjZ2lfT2ZYS0R5TjhqaWJ5OEV3V0FLNG9OQ0tjQmFBaVhoRHN1VWpa
QWJxUUl2VlFVLWJnTGVfdU1Nb213R3dBX1hRSnNXeG9qZ05yR0FFSDJGNDdjNDl1NDExZEpS
MXZUUTVSeHhsaDJPY1FKWkpMeXR4Q3c4NzE4eGN4dy1DVHpYNS13a09ienRKM1B0eXhqWExY
RGdNWGJEdHVDMkZvZnJLck4xSzVNZWNQOHZGZ05sVXlIN3ZNYXlRZkdQdHdWOHFsNEc2Z0s4
SGlwdHRWUGlQeS1jZUZPdzV0MUtha1UzdU5OTmpTYjFyQTI+DQpSZWFjaCB1cyB0aHJvdWdo
IA0KV2hhdHNBcHDCoFJlYWNoIHVzOiANCnRyYWluaW5nQGdsb2JhbGtpbmdwcm9qZWN0bWFu
YWdlbWVudC5vcmcgLyArMjU0IDExNCA4MzAgDQo4ODkNCsKgQWJvdXQgdGhlIGNvdXJzZQ0K
VGhpcyANCmlzIGEgY29tcHJlaGVuc2l2ZSAxMCBkYXlzIE0mRSBjb3Vyc2UgdGhhdCBjb3Zl
cnMgdGhlIHByaW5jaXBsZXMgYW5kIA0KcHJhY3RpY2VzIGZvciByZXN1bHRzLWJhc2VkIG1v
bml0b3JpbmcgYW5kIGV2YWx1YXRpb24gZm9yIHRoZSBlbnRpcmUgcHJvamVjdCANCmxpZmUg
Y3ljbGUuIFRoaXMgY291cnNlIGVxdWlwcyBwYXJ0aWNpcGFudHMgd2l0aCBza2lsbHMgaW4g
c2V0dGluZyB1cCBhbmQgDQppbXBsZW1lbnRpbmcgcmVzdWx0cy1iYXNlZCBtb25pdG9yaW5n
IGFuZCBldmFsdWF0aW9uIHN5c3RlbXMgaW5jbHVkaW5nIE0mRSANCmRhdGEgbWFuYWdlbWVu
dCwgYW5hbHlzaXMsIGFuZCByZXBvcnRpbmcuIFRoZSBwYXJ0aWNpcGFudHMgd2lsbCBiZW5l
Zml0IGZyb20gdGhlIA0KbGF0ZXN0IE0mRSB0aGlua2luZyBhbmQgcHJhY3RpY2VzIGluY2x1
ZGluZyB0aGUgcmVzdWx0cyBhbmQgcGFydGljaXBhdG9yeSANCmFwcHJvYWNoZXMuIFRoaXMg
Y291cnNlIGlzIGRlc2lnbmVkIHRvIGVuYWJsZSB0aGUgcGFydGljaXBhbnRzIGJlY29tZSBl
eHBlcnRzIGluIA0KbW9uaXRvcmluZyBhbmQgZXZhbHVhdGluZyB0aGVpciBkZXZlbG9wbWVu
dCBwcm9qZWN0cy4gVGhlIGNvdXJzZSBjb3ZlcnMgYWxsIHRoZSANCmtleSBlbGVtZW50cyBv
ZiBhIHJvYnVzdCBNJkUgc3lzdGVtIGNvdXBsZWQgd2l0aCBhIHByYWN0aWNhbCBwcm9qZWN0
IHRvIA0KaWxsdXN0cmF0ZSB0aGUgTSZFIGNvbmNlcHRzLsKgDQpUYXJnZXQgDQpQYXJ0aWNp
cGFudHMNClRoaXMgDQpjb3Vyc2UgaXMgZGVzaWduZWQgZm9yIHJlc2VhcmNoZXJzLCBwcm9q
ZWN0IHN0YWZmLCBkZXZlbG9wbWVudCBwcmFjdGl0aW9uZXJzLCANCm1hbmFnZXJzIGFuZCBk
ZWNpc2lvbiBtYWtlcnMgd2hvIGFyZSByZXNwb25zaWJsZSBmb3IgcHJvamVjdCwgcHJvZ3Jh
bSBvciANCm9yZ2FuaXphdGlvbi1sZXZlbCBNJkUuIFRoZSBjb3Vyc2UgYWltcyB0byBlbmhh
bmNlIHRoZSBza2lsbHMgb2YgDQpwcm9mZXNzaW9uYWxzIHdobyBuZWVkIHRvIHJlc2VhcmNo
LCBzdXBlcnZpc2UsIG1hbmFnZSwgcGxhbiwgaW1wbGVtZW50LCBtb25pdG9yIA0KYW5kIGV2
YWx1YXRlIGRldmVsb3BtZW50IHByb2plY3RzLg0KQ291cnNlIA0KZHVyYXRpb24NCjEwIA0K
ZGF5cw0KQ291cnNlIA0Kb2JqZWN0aXZlcw0KRGV2ZWxvcCBwcm9qZWN0IA0KICByZXN1bHRz
IGxldmVscw0KRGVzaWduIGEgcHJvamVjdCANCiAgdXNpbmcgbG9naWNhbCBmcmFtZXdvcmsN
CkRldmVsb3AgDQogIGluZGljYXRvcnMgYW5kIHRhcmdldHMgZm9yIGVhY2ggcmVzdWx0IGxl
dmVsDQpUcmFjayANCiAgcGVyZm9ybWFuY2UgaW5kaWNhdG9ycyBvdmVyIHRoZSBsaWZlIG9m
IHRoZSBwcm9qZWN0DQpFdmFsdWF0aW9uIGEgDQogIHByb2plY3QgYWdhaW5zdCB0aGUgc2V0
IHJlc3VsdHMNCkRldmVsb3AgYW5kIA0KICBpbXBsZW1lbnQgTSZFIHN5c3RlbXMNCkRldmVs
b3AgYSANCiAgY29tcHJlaGVuc2l2ZSBtb25pdG9yaW5nIGFuZCBldmFsdWF0aW9uIHBsYW4N
ClVzZSBkYXRhIA0KICBhbmFseXNpcyBzb2Z0d2FyZSAoU3RhdGEvU1BTUy9SKQ0KQ29sbGVj
dCBkYXRhIA0KICB1c2luZyBtb2JpbGUgZGF0YSBjb2xsZWN0aW9uIHRvb2xzDQpDYXJyeW91
dCBpbXBhY3QgDQogIGV2YWx1YXRpb24NClVzZSBHSVMgdG8gDQogIGFuYWx5emUgYW5kIHNo
YXJlIHByb2plY3QgZGF0YQ0KQ291cnNlIA0KT3V0bGluZQ0KSW50cm9kdWN0aW9uIA0KdG8g
UmVzdWx0cyBCYXNlZCBQcm9qZWN0IE1hbmFnZW1lbnQNCkZ1bmRhbWVudGFscyBvZiANCiAg
UmVzdWx0cyBCYXNlZCBNYW5hZ2VtZW50DQpXaHkgaXMgUkJNIA0KICBpbXBvcnRhbnQ/DQpS
ZXN1bHRzIGJhc2VkIA0KICBtYW5hZ2VtZW50IHZzIHRyYWRpdGlvbmFsIHByb2plY3RzIG1h
bmFnZW1lbnQNClJCTSBMaWZlY3ljbGUgDQogIChzZXZlbiBwaGFzZXMpDQpBcmVhcyBvZiBm
b2N1cyANCiAgb2YgUkJNDQpGdW5kYW1lbnRhbHMgDQpvZiBNb25pdG9yaW5nIGFuZCBFdmFs
dWF0aW9uDQpEZWZpbml0aW9uIG9mIA0KICBNb25pdG9yaW5nIGFuZCBFdmFsdWF0aW9uDQpX
aHkgTW9uaXRvcmluZyANCiAgYW5kIEV2YWx1YXRpb24gaXMgaW1wb3J0YW50DQpLZXkgcHJp
bmNpcGxlcyANCiAgYW5kIGNvbmNlcHRzIGluIE0mRQ0KTSZFIGluIA0KICBwcm9qZWN0IGxp
ZmVjeWNsZQ0KUGFydGljaXBhdG9yeSANCiAgTSZFDQpQcm9qZWN0IA0KQW5hbHlzaXMNClNp
dHVhdGlvbiANCiAgQW5hbHlzaXMNCk5lZWRzIA0KICBBc3Nlc3NtZW50DQpTdHJhdGVneSAN
CiAgQW5hbHlzaXMNCkRlc2lnbiANCm9mIFJlc3VsdHMgaW4gTW9uaXRvcmluZyBhbmQgRXZh
bHVhdGlvbg0KUmVzdWx0cyBjaGFpbiANCiAgYXBwcm9hY2hlczogSW1wYWN0LCBvdXRjb21l
cywgb3V0cHV0cyBhbmQgYWN0aXZpdGllcw0KUmVzdWx0cyANCiAgZnJhbWV3b3JrDQpNJkUg
Y2F1c2FsIA0KICBwYXRod2F5DQpQcmluY2lwbGVzIG9mIA0KICBwbGFubmluZywgbW9uaXRv
cmluZyBhbmQgZXZhbHVhdGluZyBmb3IgcmVzdWx0cw0KTSZFIA0KSW5kaWNhdG9ycw0KSW5k
aWNhdG9ycyANCiAgZGVmaW5pdGlvbg0KSW5kaWNhdG9yIA0KICBtZXRyaWNzDQpMaW5raW5n
IA0KICBpbmRpY2F0b3JzIHRvIHJlc3VsdHMNCkluZGljYXRvciANCiAgbWF0cml4DQpUcmFj
a2luZyBvZiANCiAgaW5kaWNhdG9ycw0KTG9naWNhbCANCkZyYW1ld29yayBBcHByb2FjaA0K
TEZBIOKAkyBBbmFseXNpcyANCiAgYW5kIFBsYW5uaW5nIHBoYXNlDQpEZXNpZ24gb2YgDQog
IGxvZ2ZyYW1lDQpSaXNrIHJhdGluZyBpbiANCiAgbG9nZnJhbWUNCkhvcml6b250YWwgYW5k
IA0KICB2ZXJ0aWNhbCBsb2dpYyBpbiBsb2dmcmFtZQ0KVXNpbmcgbG9nZnJhbWUgDQogIHRv
IGNyZWF0ZSBzY2hlZHVsZXM6IEFjdGl2aXR5IGFuZCBCdWRnZXQgc2NoZWR1bGVzDQpVc2lu
ZyBsb2dmcmFtZSANCiAgYXMgYSBwcm9qZWN0IG1hbmFnZW1lbnQgdG9vbA0KVGhlb3J5IA0K
b2YgQ2hhbmdlDQpPdmVydmlldyBvZiANCiAgdGhlb3J5IG9mIGNoYW5nZQ0KRGV2ZWxvcGlu
ZyANCiAgdGhlb3J5IG9mIGNoYW5nZQ0KVGhlb3J5IG9mIENoYW5nZSANCiAgdnMgTG9nIEZy
YW1lDQpDYXNlIHN0dWR5OiANCiAgVGhlb3J5IG9mIGNoYW5nZQ0KTSZFIA0KU3lzdGVtcw0K
V2hhdCBpcyBhbiANCiAgTSZFIFN5c3RlbT8NCkVsZW1lbnRzIG9mIA0KICBNJkUgU3lzdGVt
DQpTdGVwcyBmb3IgDQogIGRldmVsb3BpbmcgUmVzdWx0cyBiYXNlZCBNJkUgU3lzdGVtDQpN
JkUgDQpQbGFubmluZw0KSW1wb3J0YW5jZSBvZiBhbiANCiAgTSZFIFBsYW4NCkRvY3VtZW50
aW5nIA0KICBNJkUgU3lzdGVtIGluIHRoZSBNJkUgUGxhbg0KQ29tcG9uZW50cyBvZiBhbiAN
CiAgTSZFIFBsYW4tTW9uaXRvcmluZywgRXZhbHVhdGlvbiwgRGF0YSBtYW5hZ2VtZW50LCAN
CiAgUmVwb3J0aW5nDQpVc2luZyBNJkUgDQogIFBsYW4gdG8gaW1wbGVtZW50IE0mRSBpbiBh
IFByb2plY3QNCk0mRSBwbGFuIHZzIA0KICBQZXJmb3JtYW5jZSBNYW5hZ2VtZW50IFBsYW4g
KFBNUCkNCkJhc2UgDQpTdXJ2ZXkgaW4gUmVzdWx0cyBiYXNlZCBNJkUNCkltcG9ydGFuY2Ug
b2YgDQogIGJhc2VsaW5lIHN0dWRpZXMNClByb2Nlc3Mgb2YgDQogIGNvbmR1Y3RpbmcgYmFz
ZWxpbmUgc3R1ZGllcw0KQmFzZWxpbmUgc3R1ZHkgDQogIHZzIGV2YWx1YXRpb24NClByb2pl
Y3QgDQpQZXJmb3JtYW5jZSBFdmFsdWF0aW9uDQpQcm9jZXNzIGFuZCANCiAgcHJvZ3Jlc3Mg
ZXZhbHVhdGlvbnMNCkV2YWx1YXRpb24gDQogIHJlc2VhcmNoIGRlc2lnbg0KRXZhbHVhdGlv
biANCiAgcXVlc3Rpb25zDQpFdmFsdWF0aW9uIA0KICByZXBvcnQgRGlzc2VtaW5hdGlvbg0K
TSZFIA0KRGF0YSBNYW5hZ2VtZW50DQpEaWZmZXJlbnQgDQogIHNvdXJjZXMgb2YgTSZFIGRh
dGENClF1YWxpdGF0aXZlIGRhdGEgDQogIGNvbGxlY3Rpb24gbWV0aG9kcw0KUXVhbnRpdGF0
aXZlIA0KICBkYXRhIGNvbGxlY3Rpb24gbWV0aG9kcw0KUGFydGljaXBhdG9yeSANCiAgbWV0
aG9kcyBvZiBkYXRhIGNvbGxlY3Rpb24NCkRhdGEgUXVhbGl0eSANCiAgQXNzZXNzbWVudA0K
TSZFIA0KUmVzdWx0cyBVc2UgYW5kIERpc3NlbWluYXRpb24NClN0YWtlaG9sZGVy4oCZcyAN
CiAgaW5mb3JtYXRpb24gbmVlZHMNClVzZSBvZiBNJkUgDQogIHJlc3VsdHMgdG8gaW1wcm92
ZSBhbmQgc3RyZW5ndGhlbiBwcm9qZWN0cw0KVXNlIG9mIE0mRSANCiAgTGVzc29ucyBsZWFy
bnQgYW5kIEJlc3QgUHJhY3RpY2VzDQpPcmdhbml6YXRpb24gDQogIGtub3dsZWRnZSBjaGFt
cGlvbnMNCk0mRSANCiAgcmVwb3J0aW5nIGZvcm1hdA0KTSZFIHJlc3VsdHMgDQogIGNvbW11
bmljYXRpb24gc3RyYXRlZ2llcw0KR2VuZGVyIA0KUGVyc3BlY3RpdmUgaW4gTSZFDQpJbXBv
cnRhbmNlIG9mIA0KICBnZW5kZXIgaW4gTSZFDQpJbnRlZ3JhdGluZyANCiAgZ2VuZGVyIGlu
dG8gcHJvZ3JhbSBsb2dpYw0KU2V0dGluZyBnZW5kZXIgDQogIHNlbnNpdGl2ZSBpbmRpY2F0
b3JzDQpDb2xsZWN0aW5nIA0KICBnZW5kZXIgZGlzYWdncmVnYXRlZCBkYXRhDQpBbmFseXpp
bmcgDQogIE0mRSBkYXRhIGZyb20gYSBnZW5kZXIgcGVyc3BlY3RpdmUNCkFwcHJhaXNhbCBv
ZiANCiAgcHJvamVjdHMgZnJvbSBhIGdlbmRlciBwZXJzcGVjdGl2ZQ0KRGF0YSANCkNvbGxl
Y3Rpb24gVG9vbHMgYW5kIFRlY2huaXF1ZXMNClNvdXJjZXMgb2YgDQogIE0mRSBkYXRhIOKA
k3ByaW1hcnkgYW5kIHNlY29uZGFyeQ0KU2FtcGxpbmcgZHVyaW5nIA0KICBkYXRhIGNvbGxl
Y3Rpb24NClF1YWxpdGF0aXZlIGRhdGEgDQogIGNvbGxlY3Rpb24gbWV0aG9kcw0KUXVhbnRp
dGF0aXZlIA0KICBkYXRhIGNvbGxlY3Rpb24gbWV0aG9kcw0KUGFydGljaXBhdG9yeSANCiAg
ZGF0YSBjb2xsZWN0aW9uIG1ldGhvZHMNCkludHJvZHVjdGlvbiB0byANCiAgZGF0YSB0cmlh
bmd1bGF0aW9uDQpEYXRhIA0KUXVhbGl0eQ0KV2hhdCBpcyBkYXRhIA0KICBxdWFsaXR5Pw0K
V2h5IGRhdGEgDQogIHF1YWxpdHk/DQpEYXRhIHF1YWxpdHkgDQogIHN0YW5kYXJkcw0KRGF0
YSBmbG93IGFuZCANCiAgZGF0YSBxdWFsaXR5DQpEYXRhIFF1YWxpdHkgDQogIEFzc2Vzc21l
bnRzDQpNJkUgc3lzdGVtIA0KICBkZXNpZ24gZm9yIGRhdGEgcXVhbGl0eQ0KSUNUIA0KaW4g
TW9uaXRvcmluZyBhbmQgRXZhbHVhdGlvbg0KTW9iaWxlIGJhc2VkIA0KICBkYXRhIGNvbGxl
Y3Rpb24gdXNpbmcgT0RLDQpEYXRhIA0KICB2aXN1YWxpemF0aW9uIC0gaW5mbyBncmFwaGlj
cyBhbmQgZGFzaGJvYXJkcw0KVXNlIG9mIElDVCB0b29scyANCiAgZm9yIFJlYWwtdGltZSBt
b25pdG9yaW5nIGFuZCBldmFsdWF0aW9uDQpRdWFsaXRhdGl2ZSANCkRhdGEgQW5hbHlzaXMN
ClByaW5jaXBsZXMgb2YgDQogIHF1YWxpdGF0aXZlIGRhdGEgYW5hbHlzaXMNCkRhdGEgcHJl
cGFyYXRpb24gDQogIGZvciBxdWFsaXRhdGl2ZSBhbmFseXNpcw0KTGlua2luZyBhbmQgDQog
IGludGVncmF0aW5nIG11bHRpcGxlIGRhdGEgc2V0cyBpbiBkaWZmZXJlbnQgZm9ybXMNClRo
ZW1hdGljIA0KICBhbmFseXNpcyBmb3IgcXVhbGl0YXRpdmUgZGF0YQ0KQ29udGVudCBhbmFs
eXNpcyANCiAgZm9yIHF1YWxpdGF0aXZlIGRhdGENCk1hbmlwdWxhdGlvbiBhbmQgDQogIGFu
YWx5c2lzIG9mIGRhdGEgdXNpbmcgTlZpdm8NClF1YW50aXRhdGl2ZSANCkRhdGEgQW5hbHlz
aXMg4oCTIChVc2luZyBTUFNTL1N0YXRhKQ0KSW50cm9kdWN0aW9uIHRvIA0KICBzdGF0aXN0
aWNhbCBjb25jZXB0cw0KQ3JlYXRpbmcgDQogIHZhcmlhYmxlcyBhbmQgZGF0YSBlbnRyeQ0K
RGF0YSANCiAgcmVjb25zdHJ1Y3Rpb24NClZhcmlhYmxlcyANCiAgbWFuaXB1bGF0aW9uDQpE
ZXNjcmlwdGl2ZSANCiAgc3RhdGlzdGljcw0KVW5kZXJzdGFuZGluZyANCiAgZGF0YSB3ZWln
aHRpbmcNCkluZmVyZW50aWFsIA0KICBzdGF0aXN0aWNzOiBoeXBvdGhlc2lzIHRlc3Rpbmcs
IFQtdGVzdCwgQU5PVkEsIHJlZ3Jlc3Npb24gDQogIGFuYWx5c2lzDQpJbXBhY3QgDQpBc3Nl
c3NtZW50DQpJbnRyb2R1Y3Rpb24gdG8gDQogIGltcGFjdCBldmFsdWF0aW9uDQpBdHRyaWJ1
dGlvbiBpbiANCiAgaW1wYWN0IGV2YWx1YXRpb24NCkVzdGltYXRpb24gb2YgDQogIGNvdW50
ZXJmYWN0dWFsDQpJbXBhY3QgDQogIGV2YWx1YXRpb24gbWV0aG9kczogRG91YmxlIGRpZmZl
cmVuY2UsIFByb3BlbnNpdHkgc2NvcmUgDQogIG1hdGNoaW5nDQpHSVMgDQppbiBNJkUNCklu
dHJvZHVjdGlvbiB0byANCiAgR0lTIGluIE0mRQ0KR0lTIGFuYWx5c2lzIGFuZCANCiAgbWFw
cGluZyB0ZWNobmlxdWVzDQpEYXRhIHByZXBhcmF0aW9uIA0KICBmb3IgZ2Vvc3BhdGlhbCBh
bmFseXNpcw0KR2Vvc3BhdGlhbCANCiAgYW5hbHlzaXMgdXNpbmcgR0lTIHNvZnR3YXJlIChR
R0lTKQ0KR2VuZXJhbCANCk5vdGVzDQrCt8KgwqDCoMKgwqDCoMKgwqAgDQpBbGwgb3VyIGNv
dXJzZXMgY2FuIGJlIA0KVGFpbG9yLW1hZGUgdG8gcGFydGljaXBhbnRzIG5lZWRzDQpUaGUg
cGFydGljaXBhbnQgDQogIG11c3QgYmUgY29udmVyc2FudCB3aXRoIEVuZ2xpc2gNCsKgUHJl
c2VudGF0aW9ucyANCiAgYXJlIHdlbGwgZ3VpZGVkLCBwcmFjdGljYWwgZXhlcmNpc2VzLCB3
ZWItYmFzZWQgdHV0b3JpYWxzLCBhbmQgZ3JvdXAgd29yay4gT3VyIA0KICBmYWNpbGl0YXRv
cnMgYXJlIGV4cGVydHPCoHdpdGggbW9yZSB0aGFuIDEweWVhcnMgb2YgDQogIGV4cGVyaWVu
Y2UNCsKgVXBvbiANCiAgY29tcGxldGlvbiBvZiB0cmFpbmluZywgdGhlIHBhcnRpY2lwYW50
IHdpbGwgYmUgaXNzdWVkIHdpdGggYSBHbG9iYWwgS2luZyANCiAgUHJvamVjdCBNYW5hZ2Vt
ZW50IGNlcnRpZmljYXRlDQpUcmFpbmluZyB3aWxsIGJlIA0KICBkb25lIGF0IHRoZSBHbG9i
YWwgS2luZyBQcm9qZWN0IE1hbmFnZW1lbnQgQ2VudGVycyAoTmFpcm9iaSBLZW55YSwgTW9t
YmFzYSANCiAgS2VueWEsIEtpZ2FsaSBSd2FuZGEsIER1YmFpICxMYWdvc8KgIE5pZ2VyaWEg
YW5kIE1vcmUgDQogIG90aGVycykuDQpBIGRpc2NvdW50IG9mIA0KICAyMCUgd2lsbCBiZSBn
aXZlbiB0byBtb3JlIHRoYW4gNCBwYXJ0aWNpcGFudHMgZnJvbSBzYW1lIA0KICBvcmdhbml6
YXRpb24uDQpDb3Vyc2UgZHVyYXRpb24gDQogIGlzIGZsZXhpYmxlIGFuZCB0aGUgY29udGVu
dHMgY2FuIGJlIG1vZGlmaWVkIHRvIGZpdCBhbnkgbnVtYmVyIG9mIA0KICBkYXlzLsKgwqDC
oMKgwqDCoA0KUGF5bWVudCBzaG91bGQgDQogIGJlIGRvbmUgdHdvIHdlZWtzIGJlZm9yZSBj
b21tZW5jZW1lbnQgb2YgdGhlIHRyYWluaW5nLCB0byB0aGUgR2xvYmFsIEtpbmcgDQogIFBy
b2plY3QgTWFuYWdlbWVudCBhY2NvdW50LCBzbyBhcyB0byBlbmFibGUgdXMgdG8gcHJlcGFy
ZSBiZXR0ZXIgZm9yIA0KICB5b3UuDQpGb3IgYW55IGlucXVpcnkgDQogIHRvOsKgwqB0cmFp
bmluZ0BnbG9iYWxraW5ncHJvamVjdG1hbmFnZW1lbnQub3JnwqBvciArMjU0IA0KICAxMTQg
ODMwIDg4OQ0KwqDCoFdlYnNpdGU6wqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3By
b2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy9jbGljaz9kPUxOeDRybHRnRHVNMkpXWEYw
R1B3akN0VjFpWC1KOUFhbENkVldHbmxJd2tjeWhLcHRQR0I2Zl9ZVk9JWEJwd3BPRzVJLXJf
ek11VkpDRnVvTEVDTGxESGR5b1drVkxNcGswZ3VBVFFIclFKYjB1U0kxUWlLVmN1Q19PNkNp
NzJWdVEyPg0Kd3d3LiANCiAgZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50Lm9yZ8KgDQrC
oA0KSW1wb3J0YW50wqAgR0tQTSBMaW5rczrCoMKgIA0KDQo8aHR0cDovL3RyYWNraW5nLmds
b2JhbGtpbmdwcm9qZWN0bWFuYWdlbWVudC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1OeTBIUU9f
REpteFFqMDlLb0k1UUw0R0lmelBidGs1QmowMUdsWlFJS2tncXF5N1FLQVZCazBMUndmMjAx
MWNXdmVMT0tIT0VvQjNSZ3lISDlTaEpCcnFuRmNzTHRJdzJYeVNJU3d3NXV4cGZ4ZTRGVF8y
OWpDbUNNdm1kQUlGZ0FnTUkwVTJvclNyUkdLczZkZU5jR2ZPU2pfSTlsU2tlVmpfLUJfR1dP
R0NSMD4NCkFsbCBDb3Vyc2VzDQpQcm9qZWN0IA0KTWFuYWdlbWVudCBUcmFpbmluZ3MNCg0K
PGh0dHA6Ly90cmFja2luZy5nbG9iYWxraW5ncHJvamVjdG1hbmFnZW1lbnQuY29tL3RyYWNr
aW5nL2NsaWNrP2Q9TnkwSFFPX0RKbXhRajA5S29JNVFMNEdJZnpQYnRrNUJqMDFHbFpRSUtr
anljSzluM2kwdGdBS0NMMzRBWGNJVlFqbWFJVFFhZFV5WENWWHRkMnNtZU5ZcDRja21fWVJK
bmZwNkhHMW5PbUk4WXdOR0RyTDhMUzUySmhvUG9OS1pJVEJ3ekdRaU9Wa2p0d0NraFhSZlBj
N3pDY0ZndTVfRWVTazNIUjNaeWotcjA+DQpSZXNlYXJjaCB0cmFpbmluZyBDb3Vyc2VzDQoN
CjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFj
a2luZy9jbGljaz9kPU55MEhRT19ESm14UWowOUtvSTVRTDRHSWZ6UGJ0azVCajAxR2xaUUlL
a2p5Y0s5bjNpMHRnQUtDTDM0QVhjSVZuWEVCYUdmQmhPY3ZiajF0MEdWSjVpdWoxLTlFOE84
U2c0eld3YmdEMmV5Qm5ib0NITWl2bXlDWUZ1cUNkVG9pREVEdUxnUnpPczRUOC05dERtOUY5
QUlYT0Z6VFcweWdYaXBGbDNRdGJiTHEwPg0KTGVhZGVyc2hpcCBUcmFpbmluZyBDb3Vyc2Vz
IMKgDQoNCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNv
bS90cmFja2luZy9jbGljaz9kPXdvMmFYLV9oNTJlRHVFdDE5NHhZTzUyaVhSNTI2V0JIWE5j
b2stZWpESlhmc1FyT1p5WHUwX0tERFFJTGtfcmh2QU1FQlZSREcxMU0tNWYzR2NlNXZXNldq
cGN5V0hPVmJZalBjVmJqRGU5bHptcFYwWkpjQ3NvUTNMV3NkeGlTcV9zYTliSVV0VFZEYUdu
dEJmOG43V21pdlVGU2dHLUstdWFSOUg3dlprNTdZbzR5aWtLbmFsNWdpcU5jU1A3eTdRMj4N
CkRvd25sb2FkIG91ciBDYWxlbmRhcg0KWW91cnMgDQpTaW5jZXJlbHkswqAgwqDCoMKgDQrC
oA0KVmlyZ2luaWEgDQpXYW1haXRoYSANClByb2plY3QgDQpNYW5hZ2VtZW50IEV4cGVydCBh
bmQgUE1QIGNlcnRpZmllZA0KDQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0
bWFuYWdlbWVudC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1UNWg3SjVPbExIZ1JQNU9vcW1VMUhf
RWtnN1dub1EtUGZkZmM1bkZZaG5HSnRYbGNDNUpxb1ViYmFxUHpXUGZScVhzVmlHcW1oN3Uw
dWxvVm9pSWpCZG4xbnpzTWhfaHdPZlpfc0dneGpPRUZPdnZvQmNKamFuQTVQdXVGVDJtcjlw
Q0M3N01wOERTRFVXY0llR09lbTNSbHhGYTFPdEUyaVd0VHRsTnE5eG1zMD4NCkdsb2JhbCBL
aW5nIFByb2plY3QgTWFuYWdlbWVudCANClRlbGU6IA0KKzI1NDExNDgzMDg4OQ0KRW1haWwg
DQpBZGRyZXNzOiB0cmFpbmluZ0BnbG9iYWxraW5ncHJvamVjdG1hbmFnZW1lbnQub3JnwqAg
DQpUcmFuc25hdGlvbmFsIA0KUGxhemEgM3JkIEZsb29yIE5haXJvYmksIEtlbnlhIMKgwqDC
oA0KwqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNv
bS90cmFja2luZy91bnN1YnNjcmliZT9kPVRXRUdPM0NObnBCVW4xZkpSSzBzc0w0OEdnS1c4
YnZ4TVFRYjMzSGFUX3d2WXBGU2xwSmNJeUx4VkNrS1gzOUxkZ01VdFdFOC16QnFTUDlyVW1S
MkpVRm1iT29NRHhiRWpvOHZPNnBybVBWNDA+DQpVTlNVQlNDUklCRQ==

--=-eZCfD26ApgLjHeSGWOgAZCvSgg9x0qYz7XWKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<H4 style=3D"MARGIN: auto 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkhuCo_RmN-jcOt3bOSs7lUpB=
32Wjau8hIEMTjVxG3KNP0HuffltnQ5Mc2GpBWFNysQ2D-1NlYgJ67gK_iVsKaJhld4DQAo=
bUZulUhY8g6WJl-5MVdBvVAxE9u05PQvYAnef0"><FONT=20
color=3D#0000ff>Project Monitoring and Evaluation with Data Management=
 and=20
Analysis Course July 11 2022 to July22 2022 Mombasa=20
Kenya</FONT></A>.<?xml:namespace prefix =3D "o" ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN>=
</H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c">Venue:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN></SPAN><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: black; mso-themecolor: text1">Mom=
basa,=20
Kenya</SPAN><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN>=
</H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c">Registration:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN></SPAN><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DoMvADaRTOIAmFuhyK0ftFs-V9a3nm2Bzn5I59VdgnV3EJtCPNPehFHvSGr3vc5nYk=
xymMVl30z5jJRazyMSV4Bayvu0Su_3J2MTWpr8uEvkzg_ydlRpm4nVPdkUF5Neke2nWAAq=
yvpusv_18FX1EcTxLM3p1EcNQb85Ku4bOyfn8ECj78yZoGn7wFTU9Ut6gIw2"><SPAN=20
style=3D"FONT-WEIGHT: normal"><FONT color=3D#0000ff>Use this link to=20
register</FONT></SPAN></A><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN>=
</H4>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"FONT-WEIGHT: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DFvm3u06RbVn7m8FcN7DuPsmR11UiukHaQ-0QYwOavdilXiANo1yYbL6HurLFW1gsW=
NOqEYvX0tbLNYaE-JM2pU8Bmmjb4oMWmOtxpwWnDlBnH3MlgDqmQIEIrve8U26HQmbZ3I0=
H3LzjN2ZLhKl04-mj2TtfjVfmDfu3yyfF_DE2s75ogCnELwQ9wnmm5X4oCP8kXcbecgEjN=
bHdwDYNMgAIuoqGALRWkX0C6f-pPMUFGbYTe8KHZZ9s5PBAwskpmUOyZYigjuyUSHDcRd_=
thm41"><FONT=20
color=3D#0000ff>Download Admission Form:<o:p></o:p></FONT></A></SPAN><=
/H4>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"FONT-WEIGHT: normal"><SPAN=20
style=3D"COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Dwo2aX-_h52eDuEt194xYO52iXR526WBHXNcok-ejDJXfsQrOZyXu0_KDDQILk_rhv=
AMEBVRDG11M-5f3Gce5vW22hJ0HpfZS4IEnxXg4PAuVlFHIEnBuYVEevIWBbi6NpfSCbk_=
FOD2EgkFwjWDhirH9qfKy5lfz6e0cz-WKDdgWkNRQpH2P_baX33Ntc9nFYg2"><SPAN=20
style=3D"FONT-WEIGHT: normal"><FONT color=3D#0000ff>Download Our=20
Calendar:</FONT></SPAN></A><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN>=
</H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkgqqy7QKAVBk0LRwf2011cWv=
eLOKHOEoB3RgyHH9ShJBkMSh73ykG8w7HzMf6zY5WDAqmYJ40gjDBrB3ob6Fc1d9eHIxoB=
MqTDZL3S7FyPKOpnQycaZrTjxy0LgBXWChjWs0"><SPAN=20
style=3D"FONT-WEIGHT: normal"><FONT color=3D#0000ff>View all our=20
courses</FONT></SPAN></A><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-WEIGHT: normal"><o:p></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-WEIGHT: normal"><o:p><SPAN style=3D"TEXT-DECORATION: non=
e"><U><FONT=20
color=3D#0000ff>&nbsp;</FONT></U></SPAN></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Djzdoh1CTZ5m8avz2jGJ4bvotLAShCBh6jtREM_Wc7L0h3UPik2wcrCjwKBk1abdIQ=
iDT8iKtxpTac4HBwwuDeGcgi_OfXKDyN8jiby8EwWAK4oNCKcBaAiXhDsuUjZAbqQIvVQU=
-bgLe_uMMomwGwA_XQJsWxojgNrGAEH2F47c49u411dJR1vTQ5Rxxlh2OcQJZJLytxCw87=
18xcxw-CTzX5-wkObztJ3PtyxjXLXDgMXbDtuC2FofrKrN1K5MecP8vFgNlUyH7vMayQfG=
PtwV8ql4G6gK8HipttVPiPy-ceFOw5t1KakU3uNNNjSb1rA2"><SPAN=20
style=3D"FONT-WEIGHT: normal"><FONT color=3D#0000ff>Reach us through=20
WhatsApp</FONT></SPAN></A><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-WEIGHT: normal"><o:p></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-WEIGHT: normal"><o:p><SPAN style=3D"TEXT-DECORATION: non=
e"><U><FONT=20
color=3D#0000ff>&nbsp;</FONT></U></SPAN></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-WEIGHT: normal"><U><FONT color=3D#0000ff>Reach us:=20
training@globalkingprojectmanagement.org / +254 114 830=20
889</FONT></U></SPAN></SPAN><A name=3D_Hlk106179249><SPAN=20
style=3D"FONT-WEIGHT: normal; COLOR: blue"><o:p></o:p></SPAN></A></H4>=
<SPAN=20
style=3D"mso-bookmark: _Hlk106179249"></SPAN>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 15pt">=
<SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: Roboto; COLOR: #222222; mso-f=
areast-font-family: "Times New Roman"; mso-bidi-font-family: "Times Ne=
w Roman"'><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"COLOR: black">About the cours=
e</SPAN><SPAN=20
style=3D"COLOR: #555555"><o:p></o:p></SPAN></H4>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>This=20
is a comprehensive 10 days M&amp;E course that covers the principles a=
nd=20
practices for results-based monitoring and evaluation for the entire p=
roject=20
life cycle. This course equips participants with skills in setting up =
and=20
implementing results-based monitoring and evaluation systems including=
 M&amp;E=20
data management, analysis, and reporting. The participants will benefi=
t from the=20
latest M&amp;E thinking and practices including the results and partic=
ipatory=20
approaches. This course is designed to enable the participants become =
experts in=20
monitoring and evaluating their development projects. The course cover=
s all the=20
key elements of a robust M&amp;E system coupled with a practical proje=
ct to=20
illustrate the M&amp;E concepts.&nbsp;</SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Target=20
Participants</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>This=20
course is designed for researchers, project staff, development practit=
ioners,=20
managers and decision makers who are responsible for project, program =
or=20
organization-level M&amp;E. The course aims to enhance the skills of=20
professionals who need to research, supervise, manage, plan, implement=
, monitor=20
and evaluate development projects.</SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Course=20
duration</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>10=20
days</SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Course=20
objectives</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop project=20
  results levels<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Desi=
gn a project=20
  using logical framework<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop=20
  indicators and targets for each result level<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Trac=
k=20
  performance indicators over the life of the project<o:p></o:p></SPAN=
></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation a=20
  project against the set results<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop and=20
  implement M&amp;E systems<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop a=20
  comprehensive monitoring and evaluation plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Use =
data=20
  analysis software (Stata/SPSS/R)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Coll=
ect data=20
  using mobile data collection tools<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Carr=
yout impact=20
  evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Use =
GIS to=20
  analyze and share project data<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Course=20
Outline</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Introduction=20
to Results Based Project Management</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Fund=
amentals of=20
  Results Based Management<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Why =
is RBM=20
  important?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts based=20
  management vs traditional projects management<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>RBM =
Lifecycle=20
  (seven phases)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Area=
s of focus=20
  of RBM<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Fundamentals=20
of Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Defi=
nition of=20
  Monitoring and Evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Why =
Monitoring=20
  and Evaluation is important<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Key =
principles=20
  and concepts in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E in=20
  project lifecycle<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  M&amp;E<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Project=20
Analysis</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Situ=
ation=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Need=
s=20
  Assessment<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Stra=
tegy=20
  Analysis<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Design=20
of Results in Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts chain=20
  approaches: Impact, outcomes, outputs and activities<o:p></o:p></SPA=
N></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts=20
  framework<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E causal=20
  pathway<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Prin=
ciples of=20
  planning, monitoring and evaluating for results<o:p></o:p></SPAN></L=
I></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Indicators</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-margin-top-alt: auto; mso-list: l0 level1 lfo6; tab-stop=
s: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cators=20
  definition<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-margin-top-alt: auto; mso-list: l0 level1 lfo6; tab-stop=
s: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cator=20
  metrics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-margin-top-alt: auto; mso-list: l0 level1 lfo6; tab-stop=
s: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Link=
ing=20
  indicators to results<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-margin-top-alt: auto; mso-list: l0 level1 lfo6; tab-stop=
s: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cator=20
  matrix<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-margin-top-alt: auto; mso-list: l0 level1 lfo6; tab-stop=
s: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Trac=
king of=20
  indicators<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Logical=20
Framework Approach</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>LFA =
&#8211; Analysis=20
  and Planning phase<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Desi=
gn of=20
  logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Risk=
 rating in=20
  logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Hori=
zontal and=20
  vertical logic in logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g logframe=20
  to create schedules: Activity and Budget schedules<o:p></o:p></SPAN>=
</LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g logframe=20
  as a project management tool<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Theory=20
of Change</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Over=
view of=20
  theory of change<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
loping=20
  theory of change<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Theo=
ry of Change=20
  vs Log Frame<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Case=
 study:=20
  Theory of change<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Systems</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is an=20
  M&amp;E System?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Elem=
ents of=20
  M&amp;E System<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Step=
s for=20
  developing Results based M&amp;E System<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Planning</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l11 level1 lfo10; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of an=20
  M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l11 level1 lfo10; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Docu=
menting=20
  M&amp;E System in the M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l11 level1 lfo10; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Comp=
onents of an=20
  M&amp;E Plan-Monitoring, Evaluation, Data management,=20
  Reporting<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l11 level1 lfo10; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g M&amp;E=20
  Plan to implement M&amp;E in a Project<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l11 level1 lfo10; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E plan vs=20
  Performance Management Plan (PMP)<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Base=20
Survey in Results based M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l13 level1 lfo11; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of=20
  baseline studies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l13 level1 lfo11; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Proc=
ess of=20
  conducting baseline studies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l13 level1 lfo11; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Base=
line study=20
  vs evaluation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Project=20
Performance Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l22 level1 lfo12; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Proc=
ess and=20
  progress evaluations<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l22 level1 lfo12; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  research design<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l22 level1 lfo12; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  questions<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l22 level1 lfo12; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  report Dissemination<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Data Management</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l17 level1 lfo13; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Diff=
erent=20
  sources of M&amp;E data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l17 level1 lfo13; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Qual=
itative data=20
  collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l17 level1 lfo13; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Quan=
titative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l17 level1 lfo13; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  methods of data collection<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l17 level1 lfo13; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 Quality=20
  Assessment<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Results Use and Dissemination</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Stak=
eholder&rsquo;s=20
  information needs<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of M&amp;E=20
  results to improve and strengthen projects<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of M&amp;E=20
  Lessons learnt and Best Practices<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Orga=
nization=20
  knowledge champions<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E=20
  reporting format<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l23 level1 lfo14; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E results=20
  communication strategies<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Gender=20
Perspective in M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of=20
  gender in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Inte=
grating=20
  gender into program logic<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Sett=
ing gender=20
  sensitive indicators<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Coll=
ecting=20
  gender disaggregated data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Anal=
yzing=20
  M&amp;E data from a gender perspective<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l18 level1 lfo15; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Appr=
aisal of=20
  projects from a gender perspective<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Data=20
Collection Tools and Techniques</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Sour=
ces of=20
  M&amp;E data &#8211;primary and secondary<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Samp=
ling during=20
  data collection<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Qual=
itative data=20
  collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Quan=
titative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  data triangulation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Data=20
Quality</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is data=20
  quality?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Why =
data=20
  quality?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 quality=20
  standards<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 flow and=20
  data quality<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 Quality=20
  Assessments<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E system=20
  design for data quality<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>ICT=20
in Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Mobi=
le based=20
  data collection using ODK<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
=20
  visualization - info graphics and dashboards<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of ICT tools=20
  for Real-time monitoring and evaluation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Qualitative=20
Data Analysis</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Prin=
ciples of=20
  qualitative data analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 preparation=20
  for qualitative analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Link=
ing and=20
  integrating multiple data sets in different forms<o:p></o:p></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Them=
atic=20
  analysis for qualitative data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Cont=
ent analysis=20
  for qualitative data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Mani=
pulation and=20
  analysis of data using NVivo<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Quantitative=20
Data Analysis &#8211; (Using SPSS/Stata)</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  statistical concepts<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Crea=
ting=20
  variables and data entry<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
=20
  reconstruction<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Vari=
ables=20
  manipulation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Desc=
riptive=20
  statistics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Unde=
rstanding=20
  data weighting<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l21 level1 lfo20; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Infe=
rential=20
  statistics: hypothesis testing, T-test, ANOVA, regression=20
  analysis<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Impact=20
Assessment</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l20 level1 lfo21; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l20 level1 lfo21; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Attr=
ibution in=20
  impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l20 level1 lfo21; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Esti=
mation of=20
  counterfactual<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l20 level1 lfo21; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Impa=
ct=20
  evaluation methods: Double difference, Propensity score=20
  matching<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt; LINE-HEIGHT: 16.9pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>GIS=20
in M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l12 level1 lfo22; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  GIS in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l12 level1 lfo22; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>GIS =
analysis and=20
  mapping techniques<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l12 level1 lfo22; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 preparation=20
  for geospatial analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l12 level1 lfo22; tab-stops: list .5in"><SPAN=
=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Geos=
patial=20
  analysis using GIS software (QGIS)<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 8pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>General=20
Notes</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: auto 0in auto 0.5in; TEXT-INDENT: -0.25in; mso-list: =
l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 12.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">All our courses can =
be=20
Tailor-made to participants needs<o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>The =
participant=20
  must be conversant with English<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;Presentations=20
  are well guided, practical exercises, web-based tutorials, and group=
 work. Our=20
  facilitators are experts&nbsp;with more than 10years of=20
  experience<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;Upon=20
  completion of training, the participant will be issued with a Global=
 King=20
  Project Management certificate<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Trai=
ning will be=20
  done at the Global King Project Management Centers (Nairobi Kenya, M=
ombasa=20
  Kenya, Kigali Rwanda, Dubai ,Lagos&nbsp; Nigeria and More=20
  others).<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>A di=
scount of=20
  20% will be given to more than 4 participants from same=20
  organization.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Cour=
se duration=20
  is flexible and the contents can be modified to fit any number of=20
  days.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>Paym=
ent should=20
  be done two weeks before commencement of the training, to the Global=
 King=20
  Project Management account, so as to enable us to prepare better for=
=20
  you.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>For =
any inquiry=20
  to:&nbsp;</SPAN><SPAN style=3D"COLOR: windowtext"><A><SPAN=20
  style=3D"TEXT-DECORATION: none; COLOR: black; text-underline: none">=
<FONT=20
  face=3DCalibri>&nbsp;training@globalkingprojectmanagement.org</FONT>=
</SPAN></A></SPAN><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;or +254=20
  114 830 889<o:p></o:p></SPAN></LI></UL>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-margin-=
top-alt: auto; mso-list: l5 level1 lfo24; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;&nbsp;Website:&nbsp;</SPAN><SPAN=20
  style=3D"COLOR: windowtext"><A href=3D"http://tracking.globalkingpro=
jectmanagement.com/tracking/click?d=3DLNx4rltgDuM2JWXF0GPwjCtV1iX-J9Aa=
lCdVWGnlIwkcyhKptPGB6f_YVOIXBpwpOG5I-r_zMuVJCFuoLECLlDHdyoWkVLMpk0guAT=
QHrQJb0uSI1QiKVcuC_O6Ci72VuQ2" target=3D_blank><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLO=
R: black'>www.=20
  globalkingprojectmanagement.org&nbsp;</SPAN></A></SPAN><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif'><o:p=
></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0in 0.25in; LINE-HEIGHT: normal; mso-margin-t=
op-alt: auto"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIGHT: normal"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'>Important<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>GKPM Links:</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIG=
HT: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkgqqy7QKAVBk0LRwf2011cWv=
eLOKHOEoB3RgyHH9ShJBrqnFcsLtIw2XySISww5uxpfxe4FT_29jCmCMvmdAIFgAgMI0U2=
orSrRGKs6deNcGfOSj_I9lSkeVj_-B_GWOGCR0"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>All Courses</FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIGHT: normal"><U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: Calibri'>Project=20
Management Trainings<o:p></o:p></SPAN></U></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIG=
HT: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkjycK9n3i0tgAKCL34AXcIVQ=
jmaITQadUyXCVXtd2smeNYp4ckm_YRJnfp6HG1nOmI8YwNGDrL8LS52JhoPoNKZITBwzGQ=
iOVkjtwCkhXRfPc7zCcFgu5_EeSk3HR3Zyj-r0"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>Research training Courses</FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIG=
HT: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkjycK9n3i0tgAKCL34AXcIVn=
XEBaGfBhOcvbj1t0GVJ5iuj1-9E8O8Sg4zWwbgD2eyBnboCHMivmyCYFuqCdToiDEDuLgR=
zOs4T8-9tDm9F9AIXOFzTW0ygXipFl3QtbbLq0"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>Leadership Training Courses </FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIG=
HT: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Dwo2aX-_h52eDuEt194xYO52iXR526WBHXNcok-ejDJXfsQrOZyXu0_KDDQILk_rhv=
AMEBVRDG11M-5f3Gce5vW6WjpcyWHOVbYjPcVbjDe9lzmpV0ZJcCsoQ3LWsdxiSq_sa9bI=
UtTVDaGntBf8n7WmivUFSgG-K-uaR9H7vZk57Yo4yikKnal5giqNcSP7y7Q2"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><FONT=20
color=3D#0000ff>Download our Calendar</FONT></SPAN></A><U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: Calibri'><o:p></o:p></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 4.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Yours=20
Sincerely,<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN></SPAN><SPAN=
=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;</SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 4.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 4.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Virginia=20
Wamaitha <o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 4.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Project=20
Management Expert and PMP certified<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 4.7pt 0.45pt; LINE-HEIGH=
T: normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DT5h7J5OlLHgRP5OoqmU1H_Ekg7WnoQ-Pfdfc5nFYhnGJtXlcC5JqoUbbaqPzWPfRq=
XsViGqmh7u0uloVoiIjBdn1nzsMh_hwOfZ_sGgxjOEFOvvoBcJjanA5PuuFT2mr9pCC77M=
p8DSDUWcIeGOem3RlxFa1OtE2iWtTtlNq9xms0"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><FONT=20
color=3D#0000ff>Global King Project Management </FONT></SPAN></A><U><S=
PAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN><=
/U></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Tele:=20
+254114830889<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Email=20
Address: training@globalkingprojectmanagement.org<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 14.7pt 0.45pt; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Transnational=20
Plaza 3<SUP>rd</SUP> Floor Nairobi, Kenya </SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;</SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 6pt 0in 8pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P></BODY></HTML>

<img src=3D"http://tracking.globalkingprojectmanagement.com/tracking/o=
pen?msgid=3Dkl58GOZCxRAOmbs0ksg8vA2&c=3D1536700066050578323" style=3D"=
width:1px;height:1px" alt=3D"" /><div style=3D"text-align:center; back=
ground-color:#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;f=
ont-family:sans-serif;"><a href=3D"http://tracking.globalkingprojectma=
nagement.com/tracking/unsubscribe?d=3DTWEGO3CNnpBUn1fJRK0ssL48GgKW8bvx=
MQQb33HaT_wvYpFSlpJcIyLxVCkKX39LdgMUtWE8-zBqSP9rUmR2JUFmbOoMDxbEjo8vO6=
prmPV40" style=3D"text-align:center;text-decoration:none;color:#666;">=
UNSUBSCRIBE</a></div>
--=-eZCfD26ApgLjHeSGWOgAZCvSgg9x0qYz7XWKzQ==--
