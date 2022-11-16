Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E362B780
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 11:16:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBzVG4rJDz3cJX
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 21:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=GPOuv59V;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=YRhkQgJe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.87.8; helo=n8.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=GPOuv59V;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=YRhkQgJe;
	dkim-atps=neutral
Received: from n8.mxout.mta4.net (n8.mxout.mta4.net [67.227.87.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBzV9042Rz307C
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Nov 2022 21:16:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1668593760;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=5yohND+m7SQ4h7iDV9EdaGg6KVZIpYD24sQ7PO37SiY=;
	b=GPOuv59V1GRPip66WlVt63tanKgMEoo4e9lDoYF3r6OtVbX2nVqwYvmQ676kZZj+4KXa28jGnw+
	LwiOPrSxjlk3MfFY83Ve2UElSPs8LSBwlnIuVr8JMcZrpD1JDghdUsB5T3TAz0rrMzIhuGZ0MNtl/
	m88waJGqIYYAmuhibto=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1668593760;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=5yohND+m7SQ4h7iDV9EdaGg6KVZIpYD24sQ7PO37SiY=;
	b=YRhkQgJe5st8L5+oEx3Bx3Wk2c4nq38Qc8N8xGkOu/53Fu8LMnVOi3kypme4wlhervX3UFZ9/ZC
	MzyL0nyv+CcZzAGVOMb+XG+34QHa6QG6EZLFlImzUczUlYqUZYB9lAlEFA34aPB4l6l9JaImCJET5
	E8TZEpcXLxlFydz85j0=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 16 Nov 2022 10:16:00 +0000
Subject: Invitation to Attend a Training Workshop on Corporate Compliance,
 Audit, Monitoring and Risk Management from 12th to 23rd December 2022 in
 Mombasa, Kenya
Message-Id: <4uiez8yue55j.4VMIW37JnoVQeOkndPhEgQ2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: 4VMIW37JnoVQeOkndPhEgQ2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfUFT41xKfcO2QZf8ebAbK3ABS3dsi/XWKzQ=="
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

--=-eZCfUFT41xKfcO2QZf8ebAbK3ABS3dsi/XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTnYyRnF3czZT
TEhCaFlNYnJZa3JIRkNRNG5rQnlSVzNTcGFVOGFTRzlQZlB5bzVubDJ6MldOTXpTTDZPUE1f
OVF0S2tBaUQybjlITEdSVTA5ZGVDeDR5WXpRYkpxQ2d6bFpqYUpYRml1SDhZZzE+DQpUcmFp
bmluZyBXb3Jrc2hvcCBvbiANCkNvcnBvcmF0ZSBDb21wbGlhbmNlLCBBdWRpdCwgTW9uaXRv
cmluZyBhbmQgUmlzayBNYW5hZ2VtZW50IGZyb20gMTJ0aCB0byAyM3JkIA0KRGVjZW1iZXIg
MjAyMiBpbiBNb21iYXNhLCBLZW55YQ0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2Vt
YWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZ
c1BtV2pOV3NxcXJUdE1DN3JiSUVuN2JBQ1RxMlF1a2FwcXVHYVVBekNOSm5TV25PWlRDQVpJ
TERZVkVUTWhPYlV6dmxWUTZZdmMzVGxWZmdnZUlGR2o2WDRTYWxkMGM0QnZ1NmNhVFMyZm55
alJWdWppT2lQR1Q4TmRrV0dGMmRrdUU2bVBrREpPZXFtUDAwPg0KDQoNCjxodHRwczovLzEz
M0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZo
aDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TzZPN3RsU0hKNzYyRGRlWEdGRTVRMWNV
TWU4WllEc0RMSFlpelpiVURQVWU5UXJ6dzkyblBaakdEdklPM3pjZ09WNDJkZG5lNmNKVUtX
VlZHVlEtWmJ1aXdfSjV5ZkdGSV9vcVhTOUtCaFNnRkZfajJxMXp5TlllejJKTmYtU3dNeTA+
DQpSZWdpc3RlciB0byBhdHRlbmQgdGhlIA0KV29ya3Nob3ANCg0KPGh0dHBzOi8vMTMzSUsu
dHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzky
UkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRPNk83dGxTSEo3NjJEZGVYR0ZFNVExY1VNZTha
WURzRExIWWl6WmJVRFBVV3JQSDJCVTJQR2N3VTlxS0RCLTc5QU1LWi16SGdlTTdsU2xQcU9y
Q1o0dDN0WE1FeVlwaWgxVXg1Y2tkcUx3c1J3aGM1Z0JmQ3J4RzcwS1VSSXB4cjFBMD4NCsKg
DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTUxkWUd0SzJy
blRHRU9wRk96Y2RqeFRNbWJPTUNuZVNDVnhvbHpBZDFzaHh6QXRONWdNRnlKM2JFSG5meEJT
SDhvNGR6eXVSbkxhVldjN19JclBBWTd3V2U2aFhZVjVqeHdTb0pjelFFZGxlNDE+DQpDYWxl
bmRhciBmb3IgMjAyMi8yMDIzIA0KV29ya3Nob3BzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50
cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPTRSU09HZVM1SEk2S0ZKaXhR
cHlrVUg3U0JEU2owQTJFZEhkY3FxRWstS01jS0JXNUd4amJ1WEZpVm80RURRREFiTGVEMWVZ
VDFhTjlkZFJESmZ4SjlPb2lrV3JsS2lfTWU4Mm9ZZWVmUnVZWEd0SGVodUxFRjR0RjdjRGFS
bzY3TDYydl9oVHN6V2pfdnNNQ2FYb2JsQncxPg0KQ29udGFjdCANCnVzDQrCoA0KDQo8aHR0
cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVRkTzFn
Q3VRNzFocFdMNjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9lamh0ektPd1V3YXRUN1pFMjFq
MUw5UjdFRnl4NTN4d09fc2V2ZERUaUNYaU9VdWNaWTNWcm1MYmlCS09nYUJzc1dYT2dtWW03
ZTJLbGhJRVpVeXNVMWFqeDAwNGE4ekNrR2xoN3R6UUE3YS1ZSE0xPg0KV2hhdGFwcA0KwqAN
ClZlbnVlOiANClByaWRlSW5uIFBhcmFkaXNlIEJlYWNoIFJlc29ydCwgTW9tYmFzYSwgS2Vu
eWENCkNvdXJzZSANCkZlZTogMywwMDBVU0QNCk9mZmljZSANClRlbGVwaG9uZTogKzI1NC03
MDItMjQ5LTQ0OQ0KUmVnaXN0ZXIgYXMgYSBncm91cCBvZiA1IG9yIG1vcmUgcGFydGljaXBh
bnRzIGFuZCBnZXQgMjUlIGRpc2NvdW50IA0Kb24gdGhlIGNvdXJzZSBmZWUuIA0KU2VuZCAN
CnVzIGFuIGVtYWlsOiANCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3Ry
YWNraW5nL2NsaWNrP2Q9cmFfS3JxdXltX3ZBSDdhMHhmeWlSUlJKMG1tTW9nbnlnNTZrbVBl
SkRjT0FUZzVoUmtONGptSE13RXpGMHpndE80OEtOTnVMR1Vkd2xHMXFLalVuYlVNMkllVDBJ
Y09XYmZKbGxUNDJKc1hmNlkxOVFoV0M4b0tDZzB3R1ZoTU1IeGxqTEFBVjZ1eWw1a0lvMDNM
VzZ1SXBwekhiVENtOWUtcnVoazRQSGZrTjF4ckd6SVYxWjU4SVZDSUNSa0dzT2YzU2tRbWF1
TEp5UnV2bVBTQ19qS1NlYW1keExxNkZCOU9sN2h3ckVyYTIwPg0KdHJhaW5pbmdAc2tpbGxz
Zm9yYWZyaWNhLm9yZ8Kgb3IgY2FsbCArMjU0LTcwMi0yNDktNDQ5DQrCoA0KSU5UUk9EVUNU
SU9ODQpDb21wbGlhbmNlIHRyYWluaW5nIGlzIGEgY29tcHJlaGVuc2l2ZSBwcm9ncmFtbWUg
dGhhdCBoZWxwcyANCm9yZ2FuaXNhdGlvbnMgYW5kIHRoZWlyIGVtcGxveWVlcyBjb25kdWN0
IG9wZXJhdGlvbnMgaW4gYW4gZXRoaWNhbCBtYW5uZXIsIHdpdGggDQpleHRyZW1lIGludGVn
cml0eSwgYW5kIGluIGNvbXBsaWFuY2Ugd2l0aCBsZWdhbCBhbmQgcmVndWxhdG9yeSByZXF1
aXJlbWVudHMuIE5ldyANCnJpc2tzIGJlY2F1c2Ugb2YgZGVtYW5kaW5nIGVjb25vbWljIGNv
bmRpdGlvbnMgaW5jcmVhc2UgcHJlc3N1cmUgb24gY29tcGxpYW5jZSANCmxlYWRlcnMuDQpU
cmFkaXRpb25hbGx5LCBjb21wbGlhbmNlIG9mZmljZXJzIGZvY3VzZWQgb24gZXhwYW5kaW5n
IGNvdmVyYWdlIHRvIA0KdmFyaW91cyByaXNrcyBhbmQgbGF5ZXJpbmcgY29tcGxpYW5jZSBh
Y3Rpdml0aWVzIG9uIHRvcCBvZiBidXNpbmVzcyB3b3JrZmxvd3MgDQphbmQgc3lzdGVtcy4g
SG93ZXZlciwgcmVjZW50bHksIHRoZSBmb2N1cyBoYXMgc2hpZnRlZCB0byBpbnRyb2R1Y2lu
ZyBjb21wbGlhbmNlIA0KcHJvZ3JhbW1lcyBhcyBwYXJ0IG9mIG9wZXJhdGlvbnMuDQpUaGlz
IGFwcHJvYWNoIGhhcyBiZWVuIGFkb3B0ZWQgdG8gZW5zdXJlIGFwcHJvcHJpYXRlIGVmZmVj
dCB3aXRoIA0KbGltaXRlZCBidXNpbmVzcyBpbXBhY3QuIEFzIGEgcmVzdWx0LCBjb21wbGlh
bmNlIHByb2dyYW1tZXMgYXJlIG5vdyBwYXJ0IG9mIA0Kb3BlcmF0aW9ucyByYXRoZXIgdGhh
biBmdW5jdGlvbmluZyBhcyBhIHNlcGFyYXRlIHByb2Nlc3MuIFdoZXRoZXIgYW4gDQpvcmdh
bmlzYXRpb24gaXMgc21hbGwgb3IgbGFyZ2UsIGNvbXBsaWFuY2UgaXMgYW4gaW1wb3J0YW50
IHBhcnQgb2YgaXRzIHN0cnVjdHVyZSANCmFuZCBmdW5jdGlvbmluZyBiZWNhdXNlIGNvbXBs
aWFuY2UgaGFzIGdyZWF0IHBvdGVudGlhbCB0byBwb3NpdGl2ZWx5IG9yIA0KbmVnYXRpdmVs
eSBpbXBhY3QgdGhlIGdyb3d0aCBhbmQgc3VjY2VzcyBvZiBhbiANCm9yZ2FuaXNhdGlvbi4N
ClRoZXJlZm9yZSwgb3JnYW5pc2F0aW9ucyB0aGVzZSBkYXlzIGFyZSBpbnZlc3RpbmcgdGhl
aXIgZWZmb3J0cyB0byANCmJ1aWxkIHN0cm9uZyBjb21wbGlhbmNlIHN5c3RlbXMgYW5kIHBy
b2Nlc3NlcyBhbmQgc3VjY2Vzc2Z1bGx5IGVzdGFibGlzaCANCmNvbXBsaWFuY2UgcHJvZ3Jh
bW1lcyB0byBrZWVwIGEgY2hlY2sgb24gYWRoZXJlbmNlIHRvIHN0YW5kYXJkcyBhbmQgDQpy
dWxlcy4NCkZvciBvcmdhbmlzYXRpb25zIHRvIGltcHJvdmUgdGhlaXIgY29tcGxpYW5jZSBw
cm9ncmFtbWVzLCBpdCBpcyANCmltcG9ydGFudCBmb3IgdGhlbSB0byB1bmRlcnN0YW5kIHRo
ZWlyIGZ1bmN0aW9uYWwgcGFydG5lcnMgYW5kIGFjdGl2aXRpZXMgYW5kIA0KaWRlbnRpZnkg
YXJlYXMgZm9yIGNsb3NlciBjb29wZXJhdGlvbi4gQmVzaWRlcyBlc3RhYmxpc2hpbmcgY29t
cGxpYW5jZSANCnByb2dyYW1tZXMsIG9yZ2FuaXNhdGlvbnMgc2hvdWxkIGtlZXAgYSByZWd1
bGFyIGNoZWNrIGFuZCBhdWRpdCB0aGUgcGVyZm9ybWFuY2UgDQpvZiBzdWNoIHByb2dyYW1t
ZXMgdG8gaWRlbnRpZnkgYW55IG9wcG9ydHVuaXRpZXMgZm9yIGVuaGFuY2VtZW50IG9yIGNo
YW5nZXMgYXMgDQpwZXIgY2hhbmdpbmcgc3RhbmRhcmRzIGFuZCBydWxlcy4gVGh1cywgaW4g
dGVjaG5pY2FsIHRlcm1zLCBjb21wbGlhbmNlIA0KbWFuYWdlbWVudCBpcyBhcyBjcml0aWNh
bCBhcyBjb21wbGlhbmNlIA0KaW50cm9kdWN0aW9uLg0KVGhpcyB0cmFpbmluZyBjb3Vyc2Ug
d2lsbCBlbXBvd2VyIHlvdSB3aXRoIGRldGFpbGVkIGluZm9ybWF0aW9uIGFuZCANCmtub3ds
ZWRnZSBhYm91dCBjcmVhdGluZyBhbmQgbWFuYWdpbmcgY29tcGxpYW5jZSBpbiB5b3VyIG9y
Z2FuaXNhdGlvbi4gSXQgd2lsbCANCnByb3ZpZGUgeW91IHdpdGggdGhlIG5lY2Vzc2FyeSBl
eHBlcmllbmNlLCBleHBvc3VyZSBhbmQgc2tpbGwgdG8gcGxheSBhbiANCmltcG9ydGFudCBw
YXJ0IGluIGNyZWF0aW5nIGNvbXBsaWFuY2UgcG9saWNpZXMgYW5kIHN5c3RlbXMgaW4geW91
ciBvcmdhbmlzYXRpb24gDQphbmQgc3VjY2Vzc2Z1bGx5IGFuZCBlZmZlY3RpdmVseSBtYW5h
Z2UgdGhlc2UgdG8gaGVscCB0aGUgb3JnYW5pc2F0aW9uIHByb2dyZXNzIA0Kd2l0aGluIGFs
bCBldGhpY2FsIGFuZCBsZWdhbCBib3VuZGFyaWVzLg0KRnVydGhlciwgYnkgdW5kZXJ0YWtp
bmcgdGhpcyBDb3Jwb3JhdGUgQ29tcGxpYW5jZSwgQXVkaXQsIA0KTW9uaXRvcmluZyBhbmQg
UmlzayBNYW5hZ2VtZW50IGNvdXJzZSwgeW91IHdpbGwgZ2FpbiBjb25maWRlbmNlIGFuZCBr
bm93bGVkZ2UgdG8gDQpyZWFkaWx5IGFjY2VwdCBhbmQgYXNzdW1lIGNyaXRpY2FsIGFuZCBz
ZW5zaXRpdmUgcm9sZXMgYW5kIHJlc3BvbnNpYmlsaXRpZXMgaW4gDQp5b3VyIG9yZ2FuaXNh
dGlvbi4NClRoaXMgQ29ycG9yYXRlIENvbXBsaWFuY2UsIEF1ZGl0LCBNb25pdG9yaW5nIGFu
ZCBSaXNrIE1hbmFnZW1lbnQgDQpjb3Vyc2Ugd2lsbCBhbHNvIHByb3ZpZGUgeW91IHdpdGgg
dGhlIHJlcXVpcmVkIGZvcmVzaWdodCBhbmQgaW50dWl0aXZlbmVzcyB0byANCmlkZW50aWZ5
IGN1cnJlbnQgYW5kIHByZWRpY3QgZnV0dXJlIGdhcHMgaW4gY29tcGxpYW5jZSBwcm9jZXNz
ZXMgYXMgd2VsbCBhcyANCnVuZXRoaWNhbCBwcmFjdGljZXMgYW5kIGFkZHJlc3MgdGhlc2Ug
dG8gcHJldmVudCBhIG5lZ2F0aXZlIGltcGFjdCBvbiB0aGUgDQpidXNpbmVzcy4NCkNvdXJz
ZSANCk9iamVjdGl2ZXMNClRoZSBtYWluIG9iamVjdGl2ZSBvZiB0aGlzIENvcnBvcmF0ZSBD
b21wbGlhbmNlLCBBdWRpdCwgTW9uaXRvcmluZyANCmFuZCBSaXNrIE1hbmFnZW1lbnQgY291
cnNlIGlzIHRvIGVtcG93ZXIgcHJvZmVzc2lvbmFscyANCndpdGjigJQNCmluLWRlcHRoIHVu
ZGVyc3RhbmRpbmcgb2YgY29tcGxpYW5jZSBhbmQgY29tcGxpYW5jZSANCiAgbWFuYWdlbWVu
dA0KdGhlIA0KICByZXF1aXJlZCBrbm93bGVkZ2UgdG8gY29tcGx5IHdpdGggYWxsIG5lY2Vz
c2FyeSBzdGFuZGFyZHMgYW5kIHJ1bGVzIGluIG9uZeKAmXMgDQogIHdvcmsNCnRoZSANCiAg
cmVxdWlyZWQgY29uZmlkZW5jZSBhbmQgc2tpbGwgdG8gcGFydGFrZSBpbiBkZXZpc2luZyBj
b21wbGlhbmNlIHByb2dyYW1tZXMgYW5kIA0KICBwcm9jZXNzZXMgYW5kIG1hbmFnaW5nIGNv
bXBsaWFuY2Ugd2l0aGluIHRoZSBvcmdhbmlzYXRpb24gDQogIHRocm91Z2hvdXQNCnRoZSAN
CiAgcmVxdWlyZWQgc2tpbGwgYW5kIGNhcGFiaWxpdGllcyB0byB3b3JrIHdpdGggYWR2YW5j
ZWQgdGVjaG5pcXVlcyBhbmQgdG9vbHMgdG8gDQogIG1hbmFnZSBjb21wbGlhbmNlIGVmZmVj
dGl2ZWx5IGluIHRoZSANCm9yZ2FuaXNhdGlvbg0KdGhlIA0KICBuZWNlc3NhcnkgZXhwb3N1
cmUgdG8gcHJlZGljdCBwb3NzaWJsZSBjb21wbGlhbmNlLXJlbGF0ZWQgcmlza3MgdG8gdGhl
IA0KICBvcmdhbmlzYXRpb24gYW5kIGltcGxlbWVudCBuZWNlc3Nhcnkgc3RlcHMgdG8gY29u
dHJvbCANCiAgdGhlc2UNCmFkZXF1YXRlIGZvcmVzaWdodCB0byBtYWtlIGFycmFuZ2VtZW50
cyBmb3IgZnV0dXJlIGNoYW5nZXMgaW4gDQogIHN0YW5kYXJkcyBhbmQgcnVsZXMgYW5kIHBy
ZXBhcmUgb25l4oCZcyBvcmdhbmlzYXRpb24gdG8gbWFrZSBhbHRlcmF0aW9ucyB0byANCiAg
Y29tcGx5IHdpdGggY2hhbmdpbmcgc3RhbmRhcmRzDQppbmNyZWFzZWQgYWJpbGl0eSwgZXhw
b3N1cmUsIHNraWxsIGFuZCBleHBlcmllbmNlIHRvIHBsYXkgYW4gDQogIGltcG9ydGFudCBy
b2xlIGluIHRoZSBzdWNjZXNzIG9mIHlvdXIgb3JnYW5pc2F0aW9uLCB0aHVzIGVzdGFibGlz
aGluZyANCiAgb3Bwb3J0dW5pdGllcyBmb3IgZ3Jvd3RoIGFuZCBkZXZlbG9wbWVudCBhbmQg
c3Ryb25nIGNhcmVlciANCiAgcHJvc3BlY3RzDQpEdXJhdGlvbg0KMTAgRGF5cw0KV2hvIA0K
U2hvdWxkIEF0dGVuZA0KU2VuaW9yIG1lbWJlcnMgb2YgbWFuYWdlbWVudCByZXNwb25zaWJs
ZSBmb3IgZW5zdXJpbmcgdGhhdCB0aGUgDQogIG9yZ2FuaXNhdGlvbiBpcyBjb21wbGlhbnQg
d2l0aCB1bml2ZXJzYWxseSBhY2NlcHRlZCANCiAgc3RhbmRhcmRzDQpDb21wbGlhbmNlIG9m
ZmljZXJzIHJlc3BvbnNpYmxlIGZvciBlbnN1cmluZyBhZGhlcmVuY2UgdG8gDQogIGNvbXBs
aWFuY2UgcG9saWNpZXMgYW5kIHByb3RvY29scyBhbmQgZm9yIG1hbmFnaW5nIGNoYW5nZSBp
biBzdGFuZGFyZHMgd2hlbiANCiAgdGhlIG5lZWQgYXJpc2VzDQpIdW1hbiByZXNvdXJjZSBw
cm9mZXNzaW9uYWxzIHJlc3BvbnNpYmxlIGZvciBlbnN1cmluZyB0aGF0IA0KICBjb21wbGlh
bmNlIGlzIHBhcnQgb2YgdGhlaXIgd29yayBjdWx0dXJlIGFuZCBvcGVyYXRpb25zIGFuZCBk
ZWZhdWx0ZXJzIGFyZSBwdXQgDQogIHRvIHRoZSB0ZXN0DQpJbnRlcm5hbCBhbmQgZXh0ZXJu
YWwgYXVkaXRvcnMgd2hvIGNvbmR1Y3QgcmVndWxhciBjaGVja3MgdG8gDQogIGVuc3VyZSBh
bmQgY2VydGlmeSBhZGhlcmVuY2UgdG8gc2V0IHN0YW5kYXJkcw0KSW52ZXN0b3JzIGFuZCBz
aGFyZWhvbGRlcnMgd2hvIHdvdWxkIGJlIGludGVyZXN0ZWQgdG8gaW52ZXN0IGluIA0KICBh
biBvcmdhbmlzYXRpb24gdGhhdCBpcyBjb21wbGlhbnQgd2l0aCB1bml2ZXJzYWwgc3RhbmRh
cmRzLCB0aHVzIGRlcGljdGluZyANCiAgY3JlZGliaWxpdHkNCkFueSANCiAgb3RoZXIgd29y
a2luZyBwcm9mZXNzaW9uYWwgd2hvIHdvdWxkIGxpa2UgdG8ga25vdyBtb3JlIGFib3V0IGNv
bXBsaWFuY2UgYW5kIA0KICBjb21wbGlhbmNlIG1hbmFnZW1lbnQgdG8gZGV2ZWxvcCBvbmXi
gJlzIHdvcmsgZXRoaWMgYW5kL29yIHRvIHVuZGVydGFrZSBoaWdoZXIgDQogIHJvbGVzIGFu
ZCByZXNwb25zaWJpbGl0aWVzIHJlbGF0ZWQgdG8gY29tcGxpYW5jZSBhbmQgY29tcGxpYW5j
ZSANCiAgbWFuYWdlbWVudA0KQ09VUlNFIA0KQ09OVEVOVA0KTW9kdWxlIDEgDQrigJMgT3Zl
cnZpZXcgb2YgQ29tcGxpYW5jZQ0KRGVmaW5pdGlvbiBvZiBjb21wbGlhbmNlDQpEZWZpbml0
aW9uIG9mIHRoZSBjb21wbGlhbmNlIA0KICBmcmFtZXdvcmsNCkRlZmluaXRpb24gb2YgY29t
cGxpYW5jZSBzdGFuZGFyZHMNCkRlZmluaXRpb24gb2YgY29tcGxpYW5jZSBzdGFuZGFyZCAN
CiAgcnVsZQ0KTW9kdWxlIDIgDQrigJMgRmVhdHVyZXMgb2YgU3VjY2Vzc2Z1bCBDb21wbGlh
bmNlIEFjdGl2aXRpZXMNCkRlc2lnbiAodG8gYmUgcGFydCBvZiB0aGUgYnVzaW5lc3MgDQog
IHdvcmtmbG93KQ0KQ29vcmRpbmF0ZSAod2l0aCByZWxhdGVkIGFzc3VyYW5jZSANCiAgYWN0
aXZpdGllcykNCkFzc2VzcyAoZm9yIGJ1cmRlbiBhbmQgDQppbnRlZ3JhdGlvbikNCk1vZHVs
ZSAzIA0K4oCTIFN0ZXBzIHRvIGEgQ29tcGxpYW5jZSBSaXNrIE1hbmFnZW1lbnQgQXBwcm9h
Y2gNClByaW9yaXRpc2UgYWN0aXZpdGllcw0KTWFrZSANCiAgcmVndWxhdG9yeSBhbGVydHMg
YW5kIHVwZGF0ZXMgYWN0aW9uYWJsZQ0KQXNzZXNzIGFuZCBtYW5hZ2UgdGhlIEJ1c2luZXNz
IA0KICBpbXBhY3QNCk1vZHVsZSA0IA0K4oCTIFN0ZXBzIGluIENvbXBsaWFuY2UgUmlzayBB
bmFseXNpcw0KUmlzayANCiAgaWRlbnRpZmljYXRpb24NClJpc2sgDQogIGFzc2Vzc21lbnQN
ClJpc2sgDQogIGV2YWx1YXRpb24NClJpc2sgDQogIHRyZWF0bWVudA0KTW9uaXRvcmluZywg
cmV2aWV3IGFuZCBjb3JyZWN0aXZlIA0KICBhY3Rpb24NCkNvbW11bmljYXRpb24NCk1vZHVs
ZSA1IA0K4oCTIFNjb3BlIG9mIGEgQ29tcGxpYW5jZSBQcm9ncmFtbWUNCkRlZmluZSBwcm9n
cmFtbWUgbWFuZGF0ZQ0KTWl0aWdhdGUgYW5kIG1vbml0b3Igcmlza3MNCkVzdGFibGlzaCBw
b2xpY2llcyBhbmQgcHJvY2VkdXJlcw0KT3ZlcnNlZSBhbGxlZ2F0aW9ucyBvZiBtaXNjb25k
dWN0DQpQcm92aWRlIHRyYWluaW5nIGFuZCBjb21tdW5pY2F0aW9uDQpSZWluZm9yY2UgYmVo
YXZpb3VyYWwgZXhwZWN0YXRpb25zDQpNYW5hZ2UgdGhlIGZ1bmN0aW9uDQpNb2R1bGUgNiAN
CuKAkyBDaGFsbGVuZ2VzIGluIENvbXBsaWFuY2UgTWFuYWdlbWVudA0KQ29tcGxpYW5jZSBz
aWxvcw0KTm8gDQogIHNpbmdsZSB2aWV3IG9mIGNvbXBsaWFuY2UgYXNzdXJhbmNlDQpIb21l
LWdyb3duIHN5c3RlbXMNCk9sZCwgDQogIHJpZ2lkIHNvZnR3YXJlDQpMYWNrIA0KICBvZiBh
dXRvbWF0ZWQgbW9uaXRvcmluZw0KTW9kdWxlIDcgDQrigJMgRmFjdG9ycyBJbXBhY3Rpbmcg
Q29tcGxpYW5jZSBNYW5hZ2VtZW50DQpOYXR1cmUgb2YgQm9hcmQgYW5kIGF1ZGl0IGNvbW1p
dHRlZQ0KTWFuYWdlbWVudOKAmXMgcGhpbG9zb3BoeSBhbmQgb3BlcmF0aW5nIA0KICBzdHls
ZQ0KT3JnYW5pc2F0aW9uYWwgc3RydWN0dXJlDQpSaXNrIA0KICBjdWx0dXJlIGFuZCB0b2xl
cmFuY2UNCk1vZHVsZSA4IA0K4oCTIEltcG9ydGFuY2Ugb2YgQ29tcGxpYW5jZSBQcm9ncmFt
bWVzDQpFbmhhbmNlZCB2aXNpYmlsaXR5IGludG8gb3JnYW5pc2F0aW9uYWwgDQogIHJpc2tz
DQpHcmVhdGVyIGFjY291bnRhYmlsaXR5IGZvciByaXNrIA0KICBtYW5hZ2VtZW50DQpBc3N1
cmFuY2Ugb24gc3Rld2FyZHNoaXAgb2YgZG9uYXRlZCANCiAgZnVuZHMNCkN1bHR1cmUgb2Yg
ZXRoaWNzIGFuZCBjb21wbGlhbmNlDQpNb2R1bGUgOSANCuKAkyBFbGVtZW50cyBvZiBhbiBF
ZmZlY3RpdmUgQ29tcGxpYW5jZSBQcm9ncmFtbWUNCkV4cGVyaWVuY2VkIGF1ZGl0IGNvbW1p
dHRlZQ0KV3JpdHRlbiBwb2xpY2llcyBhbmQgcHJvY2VkdXJlcw0KVHJhaW5pbmcgYW5kIGVk
dWNhdGlvbg0KTGluZXMgb2YgY29tbXVuaWNhdGlvbg0KU3RhbmRhcmRzIHRocm91Z2ggZGlz
Y2lwbGluYXJ5IA0KICBndWlkZWxpbmVzDQpJbnRlcm5hbCBjb21wbGlhbmNlIG1vbml0b3Jp
bmcNClJlc3BvbnNlIHRvIGRldGVjdGVkIG9mZmVuY2VzDQpQZXJpb2RpYyByaXNrIGFzc2Vz
c21lbnRzDQpNb2R1bGUgMTAgDQrigJMgUmVzcG9uc2liaWxpdGllcyBvZiBDb21wbGlhbmNl
IFByb2dyYW1tZXMNCkZpZHVjaWFyeSByZXNwb25zaWJpbGl0eQ0KRmVkZXJhbMKgZmluYW5j
aWFsIHJlcG9ydGluZw0KSW50ZXJuYWwgY29udHJvbHMvc3RhbmRhcmRzDQpMZWdhbCBhbmQg
cmVndWxhdG9yeSByZXF1aXJlbWVudHMNCk9yZ2FuaXNhdGlvbmFsIHBvbGljaWVzDQpHZW5l
cmFsIA0KTm90ZXMNClRoaXMgDQogIGNvdXJzZSBpcyBkZWxpdmVyZWQgYnkgb3VyIHNlYXNv
bmVkIHRyYWluZXJzIHdobyBoYXZlIHZhc3QgZXhwZXJpZW5jZSBhcyANCiAgZXhwZXJ0IHBy
b2Zlc3Npb25hbHMgaW4gdGhlIHJlc3BlY3RpdmUgZmllbGRzIG9mIHByYWN0aWNlLiBUaGUg
Y291cnNlIGlzIA0KICB0YXVnaHQgdGhyb3VnaCBhIG1peCBvZiBwcmFjdGljYWwgYWN0aXZp
dGllcywgdGhlb3J5LCBncm91cCB3b3JrcyBhbmQgY2FzZSANCiAgc3R1ZGllcy4NClRyYWlu
aW5nIG1hbnVhbHMgYW5kIGFkZGl0aW9uYWwgcmVmZXJlbmNlIG1hdGVyaWFscyBhcmUgcHJv
dmlkZWQgDQogIHRvIHRoZSBwYXJ0aWNpcGFudHMuDQpVcG9uIA0KICBzdWNjZXNzZnVsIGNv
bXBsZXRpb24gb2YgdGhpcyBjb3Vyc2UsIHBhcnRpY2lwYW50cyB3aWxsIGJlIGlzc3VlZCB3
aXRoIGEgDQogIGNlcnRpZmljYXRlLg0KV2UgDQogIGNhbiBhbHNvIGRvIHRoaXMgYXMgdGFp
bG9yLW1hZGUgY291cnNlIHRvIG1lZXQgb3JnYW5pemF0aW9uLXdpZGUgbmVlZHMuIA0KICBD
b250YWN0IHVzIHRvIGZpbmQgb3V0IG1vcmU6IA0KICB0cmFpbmluZ0Bza2lsbHNmb3JhZnJp
Y2Eub3JnDQpUaGUgDQogIHRyYWluaW5nIHdpbGwgYmUgY29uZHVjdGVkIGF0IFNLSUxMUyBG
T1IgQUZSSUNBIFRSQUlOSU5HIA0KICBJTlNUSVRVVEUNClRoZSANCiAgdHJhaW5pbmcgZmVl
IGNvdmVycyB0dWl0aW9uIGZlZXMsIHRyYWluaW5nIG1hdGVyaWFscywgbHVuY2ggYW5kIHRy
YWluaW5nIA0KICB2ZW51ZS4gQWNjb21tb2RhdGlvbiBhbmQgYWlycG9ydCB0cmFuc2ZlciBh
cmUgYXJyYW5nZWQgZm9yIG91ciBwYXJ0aWNpcGFudHMgDQogIHVwb24gcmVxdWVzdC4NClBh
eW1lbnQgc2hvdWxkIGJlIHNlbnQgdG8gb3VyIGJhbmsgYWNjb3VudCBiZWZvcmUgc3RhcnQg
b2YgDQogIHRyYWluaW5nIGFuZCBwcm9vZiBvZiBwYXltZW50IHNlbnQgdG86IA0KICB0cmFp
bmluZ0Bza2lsbHNmb3JhZnJpY2Eub3JnDQrCoA0KwqANCjxodHRwczovLzEzM0lLLnRyay5l
bGFzdGljZW1haWwuY29tL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9MHlXbzFMUnNjRXpHVWhi
UFZpR0ZHTVJPQVNzdzA2RjUtNER5WUpiN2tnUmxCTndTY2JtWlp5Z0h1N1ptaXlRbGtyZ0Vk
dHNpclBoN1lkc1psNTNQcXdLMTdubk9WZlZLVGRGU3VVV3ZZTEdjMD4NClVOU1VCU0NSSUJF


--=-eZCfUFT41xKfcO2QZf8ebAbK3ABS3dsi/XWKzQ==
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
TTOM: medium none; PADDING-BOTTOM: 0cm; TEXT-ALIGN: justify; PADDING-T=
OP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm =
0pt; LINE-HEIGHT: normal; PADDING-RIGHT: 0cm; mso-outline-level: 2; ms=
o-border-bottom-alt: solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0=
pt 0cm"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KNv2Fqws6SLHBhYMbrYkrHFCQ4nkByRW3SpaU=
8aSG9PfPyo5nl2z2WNMzSL6OPM_9QtKkAiD2n9HLGRU09deCx4yYzQbJqCgzlZjaJXFiuH=
8Yg1"><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082>Training=
 Workshop on=20
Corporate Compliance, Audit, Monitoring and Risk Management from 12th =
to 23rd=20
December 2022 in Mombasa, Kenya<?xml:namespace prefix =3D "o" ns =3D=20
"urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></SPAN></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMC7rbIEn7bACTq2QukapquGaUAzCNJnSWnOZ=
TCAZILDYVETMhObUzvlVQ6Yvc3TlVfggeIFGj6X4Sald0c4Bvu6caTS2fnyjRVujiOiPGT=
8NdkWGF2dkuE6mPkDJOeqmP00" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><o:p></o:p></SPAN></A></SPAN><=
/U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1cUMe8ZYDsDLHYi=
zZbUDPUe9Qrzw92nPZjGDvIO3zcgOV42ddne6cJUKWVVGVQ-Zbuiw_J5yfGFI_oqXS9KBh=
SgFF_j2q1zyNYez2JNf-SwMy0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082>Register=
 to attend the=20
Workshop<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1cUMe8ZYDsDLHYi=
zZbUDPUWrPH2BU2PGcwU9qKDB-79AMKZ-zHgeM7lSlPqOrCZ4t3tXMEyYpih1Ux5ckdqLw=
sRwhc5gBfCrxG70KURIpxr1A0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><o:p><SPAN=20
style=3D"TEXT-DECORATION: none"><FONT color=3D#410082=20
face=3D"Times New Roman">&nbsp;</FONT></SPAN></o:p></SPAN></A></SPAN><=
/SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxTMmbOMCneSCVxo=
lzAd1shxzAtN5gMFyJ3bEHnfxBSH8o4dzyuRnLaVWc7_IrPAY7wWe6hXYV5jxwSoJczQEd=
le41" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Calendar fo=
r 2022/2023=20
Workshops<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDAbLeD1eYT1aN9dd=
RDJfxJ9OoikWrlKi_Me82oYeefRuYXGtHehuLEF4tF7cDaRo67L62v_hTszWj_vsMCaXob=
lBw1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Contact=20
us<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejhtzKOwUwatT7ZE21j1L9R7EFyx53xwO_sevd=
DTiCXiOUucZY3VrmLbiBKOgaBssWXOgmYm7e2KlhIEZUysU1ajx004a8zCkGlh7tzQA7a-=
YHM1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Whatapp<o:p=
></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Venue:=20
PrideInn Paradise Beach Resort, Mombasa, Kenya<o:p></o:p></FONT></SPAN=
></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Course=20
Fee: 3,000USD<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Office=20
Telephone: +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Send=20
us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMHxljLAAV6uyl5kIo03L=
W6uIppzHbTCm9e-ruhk4PHfkN1xrGzIV1Z58IVCICRkGsOf3SkQmauLJyRuvmPSC_jKSea=
mdxLq6FB9Ol7hwrEra20" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT=20
color=3D#410082>training@skillsforafrica.org&nbsp;</FONT></SPAN></A><F=
ONT=20
face=3DCalibri>or call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-AUTOSPACE: ; m=
so-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-AUTOSPACE: ; m=
so-layout-grid-align: none"><FONT=20
face=3DCalibri><B><SPAN lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN">INTRODUCTION</SPAN></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>Compliance training is a comprehensive programme that h=
elps=20
organisations and their employees conduct operations in an ethical man=
ner, with=20
extreme integrity, and in compliance with legal and regulatory require=
ments. New=20
risks because of demanding economic conditions increase pressure on co=
mpliance=20
leaders.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>Traditionally, compliance officers focused on expanding=
 coverage to=20
various risks and layering compliance activities on top of business wo=
rkflows=20
and systems. However, recently, the focus has shifted to introducing c=
ompliance=20
programmes as part of operations.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>This approach has been adopted to ensure appropriate ef=
fect with=20
limited business impact. As a result, compliance programmes are now pa=
rt of=20
operations rather than functioning as a separate process. Whether an=20
organisation is small or large, compliance is an important part of its=
 structure=20
and functioning because compliance has great potential to positively o=
r=20
negatively impact the growth and success of an=20
organisation.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>Therefore, organisations these days are investing their=
 efforts to=20
build strong compliance systems and processes and successfully establi=
sh=20
compliance programmes to keep a check on adherence to standards and=20
rules.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>For organisations to improve their compliance programme=
s, it is=20
important for them to understand their functional partners and activit=
ies and=20
identify areas for closer cooperation. Besides establishing compliance=
=20
programmes, organisations should keep a regular check and audit the pe=
rformance=20
of such programmes to identify any opportunities for enhancement or ch=
anges as=20
per changing standards and rules. Thus, in technical terms, compliance=
=20
management is as critical as compliance=20
introduction.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>This training course will empower you with detailed inf=
ormation and=20
knowledge about creating and managing compliance in your organisation.=
 It will=20
provide you with the necessary experience, exposure and skill to play =
an=20
important part in creating compliance policies and systems in your org=
anisation=20
and successfully and effectively manage these to help the organisation=
 progress=20
within all ethical and legal boundaries.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>Further, by undertaking this Corporate Compliance, Audi=
t,=20
Monitoring and Risk Management course, you will gain confidence and kn=
owledge to=20
readily accept and assume critical and sensitive roles and responsibil=
ities in=20
your organisation.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>This Corporate Compliance, Audit, Monitoring and Risk M=
anagement=20
course will also provide you with the required foresight and intuitive=
ness to=20
identify current and predict future gaps in compliance processes as we=
ll as=20
unethical practices and address these to prevent a negative impact on =
the=20
business.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Course=20
Objectives</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>The main objective of this Corporate Compliance, Audit,=
 Monitoring=20
and Risk Management course is to empower professionals=20
with&#8212;<o:p></o:p></FONT></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>in-depth understanding of compliance and compliance=20
  management<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>the=20
  required knowledge to comply with all necessary standards and rules =
in one&rsquo;s=20
  work<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>the=20
  required confidence and skill to partake in devising compliance prog=
rammes and=20
  processes and managing compliance within the organisation=20
  throughout<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>the=20
  required skill and capabilities to work with advanced techniques and=
 tools to=20
  manage compliance effectively in the=20
organisation<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>the=20
  necessary exposure to predict possible compliance-related risks to t=
he=20
  organisation and implement necessary steps to control=20
  these<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>adequate foresight to make arrangements for future ch=
anges in=20
  standards and rules and prepare one&rsquo;s organisation to make alt=
erations to=20
  comply with changing standards<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo1"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>increased ability, exposure, skill and experience to =
play an=20
  important role in the success of your organisation, thus establishin=
g=20
  opportunities for growth and development and strong career=20
  prospects<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Duration</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><FONT=20
face=3DCalibri>10 Days<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Who=20
Should Attend</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Senior members of management responsible for ensuring=
 that the=20
  organisation is compliant with universally accepted=20
  standards<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Compliance officers responsible for ensuring adherenc=
e to=20
  compliance policies and protocols and for managing change in standar=
ds when=20
  the need arises<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Human resource professionals responsible for ensuring=
 that=20
  compliance is part of their work culture and operations and defaulte=
rs are put=20
  to the test<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Internal and external auditors who conduct regular ch=
ecks to=20
  ensure and certify adherence to set standards<o:p></o:p></FONT></SPA=
N></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Investors and shareholders who would be interested to=
 invest in=20
  an organisation that is compliant with universal standards, thus dep=
icting=20
  credibility<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l11 level1 lfo2"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Any=20
  other working professional who would like to know more about complia=
nce and=20
  compliance management to develop one&rsquo;s work ethic and/or to un=
dertake higher=20
  roles and responsibilities related to compliance and compliance=20
  management<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">COURSE=20
CONTENT</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 1=20
&#8211; Overview of Compliance</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l10 level1 lfo3"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Definition of compliance<o:p></o:p></FONT></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l10 level1 lfo3"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Definition of the compliance=20
  framework<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l10 level1 lfo3"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Definition of compliance standards<o:p></o:p></FONT><=
/SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l10 level1 lfo3"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Definition of compliance standard=20
  rule<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 2=20
&#8211; Features of Successful Compliance Activities</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l8 level1 lfo4"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Design (to be part of the business=20
  workflow)<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l8 level1 lfo4"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Coordinate (with related assurance=20
  activities)<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l8 level1 lfo4"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Assess (for burden and=20
integration)<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 3=20
&#8211; Steps to a Compliance Risk Management Approach</SPAN></B><SPAN=
=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l4 level1 lfo5"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Prioritise activities<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l4 level1 lfo5"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Make=20
  regulatory alerts and updates actionable<o:p></o:p></FONT></SPAN></L=
I>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l4 level1 lfo5"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Assess and manage the Business=20
  impact<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 4=20
&#8211; Steps in Compliance Risk Analysis</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Risk=20
  identification<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Risk=20
  assessment<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Risk=20
  evaluation<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Risk=20
  treatment<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Monitoring, review and corrective=20
  action<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l2 level1 lfo6"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Communication<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 5=20
&#8211; Scope of a Compliance Programme</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Define programme mandate<o:p></o:p></FONT></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Mitigate and monitor risks<o:p></o:p></FONT></SPAN></=
LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Establish policies and procedures<o:p></o:p></FONT></=
SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Oversee allegations of misconduct<o:p></o:p></FONT></=
SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Provide training and communication<o:p></o:p></FONT><=
/SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Reinforce behavioural expectations<o:p></o:p></FONT><=
/SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l9 level1 lfo7"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Manage the function<o:p></o:p></FONT></SPAN></LI></UL=
>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 6=20
&#8211; Challenges in Compliance Management</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l6 level1 lfo8"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Compliance silos<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l6 level1 lfo8"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>No=20
  single view of compliance assurance<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l6 level1 lfo8"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Home-grown systems<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l6 level1 lfo8"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Old,=20
  rigid software<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l6 level1 lfo8"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Lack=20
  of automated monitoring<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 7=20
&#8211; Factors Impacting Compliance Management</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l5 level1 lfo9"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Nature of Board and audit committee<o:p></o:p></FONT>=
</SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l5 level1 lfo9"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Management&rsquo;s philosophy and operating=20
  style<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l5 level1 lfo9"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Organisational structure<o:p></o:p></FONT></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l5 level1 lfo9"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Risk=20
  culture and tolerance<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 8=20
&#8211; Importance of Compliance Programmes</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l7 level1 lfo10"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Enhanced visibility into organisational=20
  risks<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l7 level1 lfo10"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Greater accountability for risk=20
  management<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l7 level1 lfo10"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Assurance on stewardship of donated=20
  funds<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l7 level1 lfo10"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Culture of ethics and compliance<o:p></o:p></FONT></S=
PAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 9=20
&#8211; Elements of an Effective Compliance Programme</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Experienced audit committee<o:p></o:p></FONT></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Written policies and procedures<o:p></o:p></FONT></SP=
AN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Training and education<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Lines of communication<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Standards through disciplinary=20
  guidelines<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Internal compliance monitoring<o:p></o:p></FONT></SPA=
N></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Response to detected offences<o:p></o:p></FONT></SPAN=
></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l3 level1 lfo11"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Periodic risk assessments<o:p></o:p></FONT></SPAN></L=
I></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">Module 10=20
&#8211; Responsibilities of Compliance Programmes</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l1 level1 lfo12"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Fiduciary responsibility<o:p></o:p></FONT></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l1 level1 lfo12"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Federal&nbsp;financial reporting<o:p></o:p></FONT></S=
PAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l1 level1 lfo12"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Internal controls/standards<o:p></o:p></FONT></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l1 level1 lfo12"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Legal and regulatory requirements<o:p></o:p></FONT></=
SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l1 level1 lfo12"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Organisational policies<o:p></o:p></FONT></SPAN></LI>=
</UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt; LINE-HEIGHT: norm=
al"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i">General=20
Notes</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #333333; mso-bidi-font-family: Calibr=
i"><o:p></o:p></SPAN></FONT></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>This=20
  course is delivered by our seasoned trainers who have vast experienc=
e as=20
  expert professionals in the respective fields of practice. The cours=
e is=20
  taught through a mix of practical activities, theory, group works an=
d case=20
  studies.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Training manuals and additional reference materials a=
re provided=20
  to the participants.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Upon=20
  successful completion of this course, participants will be issued wi=
th a=20
  certificate.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>We=20
  can also do this as tailor-made course to meet organization-wide nee=
ds.=20
  Contact us to find out more:=20
  training@skillsforafrica.org<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>The=20
  training will be conducted at SKILLS FOR AFRICA TRAINING=20
  INSTITUTE<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>The=20
  training fee covers tuition fees, training materials, lunch and trai=
ning=20
  venue. Accommodation and airport transfer are arranged for our parti=
cipants=20
  upon request.<o:p></o:p></FONT></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: #333333; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; =
LINE-HEIGHT: normal; tab-stops: list 36.0pt; mso-margin-top-alt: auto;=
 mso-margin-bottom-alt: auto; mso-list: l12 level1 lfo13"><SPAN=20
  style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
  face=3DCalibri>Payment should be sent to our bank account before sta=
rt of=20
  training and proof of payment sent to:=20
  training@skillsforafrica.org<o:p></o:p></FONT></SPAN></LI></UL>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><SPAN=
=20
style=3D'FONT-FAMILY: "Calibri",sans-serif'><o:p>&nbsp;</o:p></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3D4=
VMIW37JnoVQeOkndPhEgQ2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3D0yWo1LRscEzGUhbPViGFGMROASsw06F5-4DyYJb7kgRlBNwScbmZZygHu7=
ZmiyQlkrgEdtsirPh7YdsZl53PqwK17nnOVfVKTdFSuUWvYLGc0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfUFT41xKfcO2QZf8ebAbK3ABS3dsi/XWKzQ==--
