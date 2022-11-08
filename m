Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2153621056
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 13:21:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N66fJ3CCTz3dtj
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 23:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=lo63hL/l;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=czcg26fq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=104.243.65.27; helo=na27.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=lo63hL/l;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=czcg26fq;
	dkim-atps=neutral
Received: from na27.mxout.mta4.net (na27.mxout.mta4.net [104.243.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N66f46wjhz3cMT
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 23:21:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1667910058;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=LM4FdT6qR7CLAh77Hl+/aDitEa82cXhte4bq3KnMdcY=;
	b=lo63hL/l8Vs9/SJZE/yvj/3gPaKa8Piqd/Q1ywFifw+vH6ETXGgefX7Ze7HPHb1gBj04jlTR6II
	Jv7oFKlUSaDvEvnn5g1Dn4VYGkE3a72rnFuEhtSMGeCAwnw9K3VZ6U5siH6Z7l7BiyAIIfh4X2r1O
	efTHrQPebqFVfcGQza0=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1667910058;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=LM4FdT6qR7CLAh77Hl+/aDitEa82cXhte4bq3KnMdcY=;
	b=czcg26fqZToxAzPeE9Dd/A6AjWhIIMNNCvRh3d8lNWLo+r25iEIYuk0bsgtpIIuZRBwp60J6HU6
	dvQVGLPQes1gNoxn2hlIVp75XvQRl0XT4ckkNkrnxCjOqZrII4ykq77PW26909jzpVgKX6hnyqTvM
	4GXwh7S8Lbzs5JMwn8Y=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Tue, 08 Nov 2022 12:20:58 +0000
Subject: Anti-Money Laundering (AML) Training Course for Board of Directors
 and Senior Management On 12th to 23rd December 2022, Kenya
Message-Id: <4uick03426fa.Q7TYsCRp4xHc0W05Ejw6bA2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: Q7TYsCRp4xHc0W05Ejw6bA2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfNTXhxzbvFdfKcuEsOR6RhyFowqgn7XWKzQ=="
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

--=-eZCfNTXhxzbvFdfKcuEsOR6RhyFowqgn7XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTnduNzV4aHFy
TUVVRmdRdklMQ0RrZmhZdU5UMWxLQ1NQSFk0bmo0M0pCZ3E0YnYybllyWTdiOVc1emwzc1lE
dGJYV3dvQ0dmUXRFbEU5SXB1aWlfNm9FeVFxREdyN0pNeUREbll3OVZRNE1ZTTE+DQrCoEFu
dGktTW9uZXkgTGF1bmRlcmluZyANCihBTUwpIFRyYWluaW5nIENvdXJzZSBmb3IgQm9hcmQg
b2YgRGlyZWN0b3JzIGFuZCBTZW5pb3IgTWFuYWdlbWVudCBPbiAxMnRoIHRvIA0KMjNyZCBE
ZWNlbWJlciAyMDIyDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3Ry
YWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3Fx
clR0TzZPN3RsU0hKNzYyRGRlWEdGRTVRMVA5UDhJN1N6MS1ZUlN1U3JYRGhOZ2tSRUM2b0Ra
Rnd4YU5qLVVvZW12Y1FEaW9Wcm9HdUxCcWsxOGxmS2FsUXRLZlpzY3dHSEdPR21LMFNkTXZG
Zm5KS3Y1M0tCXzQ2OERXWDQ2QXdvclNBczA+DQpSZWdpc3RlciBmb3Igb25saW5lIA0KYXR0
ZW5kYW5jZSANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tp
bmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRP
Nk83dGxTSEo3NjJEZGVYR0ZFNVExUDlQOEk3U3oxLVlSU3VTclhEaE5ncXEtTUt1dk5ZY2tQ
X2RBRmNyZ3NWaDJSXzY1LWhLcm9JdEM2S3RTdDlqR1Myc293blVETHZYbUN5WjBzM0I2ZnRm
MUx0ampJcDZrcnlKUDNXUjNaQ1QtMD4NCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFz
dGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0
MjI1WVlzUG1Xak5Xc3FxclR0TzZPN3RsU0hKNzYyRGRlWEdGRTVRMVA5UDhJN1N6MS1ZUlN1
U3JYRGhOZ280R1hKbEJ1b3pWdXdtckQ1Ty1CT1pvUFFWYUxscFFDRnB5SGkzcUtCaEtSNFQ1
Q1djN0x0aGpfLXo3OXA5NVdfendRTklvY1RhX3JRUUd4WVBvRVRDcTA+DQpSZWdpc3RlciB0
byBhdHRlbmQgDQoNCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJh
Y2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFy
VHRPNk83dGxTSEo3NjJEZGVYR0ZFNVExUDlQOEk3U3oxLVlSU3VTclhEaE5ncjMyRnlNLWdG
UHRGVHlFUlpQejl2ZE44dklweUhRcnhjaEtJTkh6QnkwVjlIRnFiTmRYcVhUWnhIR3BRd3BI
VGNQNE02NFJOdWREWXhuSlpDSnROYTVGMD4NCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5l
bGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtV
SDdTQkRTajBBMkVkSGRjcXFFay1LTUxkWUd0SzJyblRHRU9wRk96Y2RqeG5mWWZ6OGlkZ2dR
dkZDVmZua2ZTSUQtcFM0UGNTQm1YQTVTU0ZoU1ZzS2h0TzRFRm1JYWVZb1Y0TzRzb1dRRmd4
WUZKbC0yMGhGc0ZFUWFmWXl4ZFRhRTE+DQpDYWxlbmRhciBmb3IgMjAyMi8yMDIzIA0KV29y
a3Nob3BzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFj
a2luZy9jbGljaz9kPTRSU09HZVM1SEk2S0ZKaXhRcHlrVUg3U0JEU2owQTJFZEhkY3FxRWst
S01jS0JXNUd4amJ1WEZpVm80RURRREFNa25MQnUtRVdkNXFzWHE0bV9TLXp3eGJRZVZ4V1pT
c1lIQk9iZFNSRkJRdnhHa3hWRlhCLVR2UE9HemhIMUx5V0htUGZYVm50b1ZrWW9yYmRidk1O
eHcxPg0KQ29udGFjdCANCnVzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2Vt
YWlsLmNvbS90cmFja2luZy9jbGljaz9kPVRkTzFnQ3VRNzFocFdMNjBCV05udHV3ZjJJV0pm
a19rSlFfT2V4NV9lampGU1N4X19VNDItYktjc2pwMTF4cVROMmdOeklVdkN2VmZod2xnYW5O
aHFGTUhXTnpCWWNxalY3NVBXWGlPdEl2dUZNdHNEVzZhR0tVY2RBLTdmVGJmajliUlBUR1Jv
RlVrUmJNaE51bURRS0kxPg0KV2hhdGFwcA0KwqANClZlbnVlOiANClByaWRlSW5uIFBhcmFk
aXNlIEJlYWNoIFJlc29ydCwgTW9tYmFzYSwgS2VueWENCkNvdXJzZSANCkZlZTogMywwMDBV
U0QNCk9mZmljZSANClRlbGVwaG9uZTogKzI1NC03MDItMjQ5LTQ0OQ0KUmVnaXN0ZXIgYXMg
YSBncm91cCBvZiA1IG9yIG1vcmUgcGFydGljaXBhbnRzIGFuZCBnZXQgMjUlIGRpc2NvdW50
IA0Kb24gdGhlIGNvdXJzZSBmZWUuIA0KU2VuZCANCnVzIGFuIGVtYWlsOiANCjxodHRwczov
LzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9cmFfS3JxdXlt
X3ZBSDdhMHhmeWlSUlJKMG1tTW9nbnlnNTZrbVBlSkRjT0FUZzVoUmtONGptSE13RXpGMHpn
dE80OEtOTnVMR1Vkd2xHMXFLalVuYlVNMkllVDBJY09XYmZKbGxUNDJKc1hmNlkxOVFoV0M4
b0tDZzB3R1ZoTU1SRV8yam9hei1pOVJYTnBGc213eVJ2aWZBNGsyNjJFeWN0M2JoMHl2YVcz
eXF0YllDZUtIUktGREdyRjY5anpfc1MwSHVNc3NMZFpLa0lCdVFOMmNoS3RrMVhxX3BMODkx
akhqSnJuMTFsVWowPg0KdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZ8Kgb3IgY2FsbCAr
MjU0LTcwMi0yNDktNDQ5DQrCoElOVFJPRFVDVElPTg0KQXMgDQpwZXIgRkFUQUbigJlzIElu
dGVybmF0aW9uYWwgR3VpZGVsaW5lcywgVGhlIEJvYXJkIG9mIERpcmVjdG9ycyBvZiBhbnkg
ZmluYW5jaWFsIA0KaW5zdGl0dXRpb24gaGFzIGEgZmlkdWNpYXJ5IGR1dHkgdG93YXJkcyB0
aGUgb3JnYW5pemF0aW9uIHRvIGVuc3VyZSB0aGF0IHRoZXJlIA0KaXMgYSByb2J1c3QgY29t
cGxpYW5jZSBwcm9ncmFtIGluIHBsYWNlLiBUaGUgQm9hcmQgbmVlZHMgdG8gc2V0IOKAnHRo
ZSBUb25lIGZyb20gDQp0aGUgVG9w4oCdLCBlc3RhYmxpc2ggYW4gZWZmZWN0aXZlIGNvbnRy
b2wgZnJhbWV3b3JrIGFuZCBlZmZlY3RpdmVseSBwcm9tb3RlIGEgDQrigJxjdWx0dXJlIG9m
IGNvbXBsaWFuY2XigJ0uIEEgaGlnaC1yaXNrIGNvbXBsaWFuY2UgcmVzcG9uc2liaWxpdHkg
ZW50YWlscyB0aGUgZmxvdyANCm9mIGNyaXRpY2FsIGluZm9ybWF0aW9uIHRvIHJpc2sgY29t
bWl0dGVlcyBhbmQgYm9hcmRzIGFuZCBzaG91bGQgYmUgb2YgcmVsZXZhbmNlIA0KdG8gdGhl
IG92ZXJhbGwgZ292ZXJuYW5jZSBwdXJwb3NlLiBTZW5pb3IgbWFuYWdlbWVudCBpbiBtb3N0
IGZpbmFuY2lhbCANCmluc3RpdHV0aW9ucyBoYXZlIHdlbGwtZXN0YWJsaXNoZWQgcHJvY2Vk
dXJlcyBhbmQgcG9saWNpZXMgZm9yIGRlYWxpbmcgd2l0aCANCm92ZXJhbGwgb3BlcmF0aW9u
YWwgcmlza+KAmXMgbGlrZSBjcmVkaXQgcmlzayBvciBtYXJrZXQgcmlzaywgYnV0IHRoZSBw
cmFjdGljZSBvZiANCmRlYWxpbmcgd2l0aCBLbm93IFlvdXIgQ3VzdG9tZXIgKEtZQykgYW5k
IEFudGktTW9uZXkgTGF1bmRlcmluZyAoQU1MKSByaXNrIGlzIA0KeWV0IHRvIG1hdHVyZS4g
VGhlIEFNTC9LWUMgY29tcGxpYW5jZSBsb29rcyBpbnRvIHRyYW5zZmVyIG9yIGNvbnZlcnNp
b24gb2YgDQppbGxpY2l0IGdvdHRlbiBzb3VyY2VzIChibGFjayBtb25leSkgdG8gbGVnYWxs
eSBhY2Nlc3NpYmxlL3RheGFibGUgKHdoaXRlIG1vbmV5KSANCmZ1bmRzLCBwcmltYXJpbHkg
dXNpbmcgdGhlIGZpbmFuY2lhbCBpbnN0aXR1dGlvbnMgYXMgYSBjb25kdWl0IGZvciBjb25j
ZWFsbWVudCANCmFuZCBkaXNndWlzZSBhY3Rpdml0aWVzIHRvIGhhcHBlbi4NClRlY2huaWNh
bGx5IA0Kc3BlYWtpbmcsIEJvYXJkIG1lbWJlcnMgYXJlIG5vdCByZXF1aXJlZCB0byBiZSBl
eHBlcnRzIGF0IEFNTCBrbm93aG93LCBidXQsIGl04oCZcyANCmhpZ2hseSByZWNvbW1lbmRl
ZCBhbmQgY29tZXMgYXMgaW5kdXN0cnkgYmVzdCBwcmFjdGljZSBmb3IgQm9E4oCZcyB0byBh
Y3F1aXJlIGFuIA0KdW5kZXJzdGFuZGluZyBvZiBmdW5kYW1lbnRhbCBhc3BlY3RzIG9mIEFN
TCBSaXNrIENvbnRyb2wgRnJhbWV3b3JrLCBpbiBvcmRlciB0byANCmVmZmVjdGl2ZWx5IGV4
ZXJjaXNlIHRoZWlyIG92ZXJzaWdodCByZXNwb25zaWJpbGl0aWVzLCBhcyBtYW5kYXRlZCBi
eSBhbG1vc3QgYWxsIA0KdGhlIG5hdGlvbmFsIGZpbmFuY2lhbCByZWd1bGF0b3J5IGF1dGhv
cml0aWVzLiBVbmRlciB0aGlzIHVuZGVyc3RhbmRpbmcgb2YgdGhlIA0KcmVndWxhdG9yeSBl
bnZpcm9ubWVudCBpbiB3aGljaCB0aGUgZmlybSBvcGVyYXRlcywgdGhlIEJvYXJkIG9mIERp
cmVjdG9ycyBhbmQgDQpTci4gTWFuYWdlbWVudCBtdXN0IGhhdmUgYSBiYXNpYyB3b3JraW5n
IGtub3dsZWRnZSBvZiBhcHBsaWNhYmxlIHJlZ3VsYXRpb25zLCANCmluY2x1ZGluZyByZWxl
dmFudCByZXF1aXJlbWVudHMgYXJvdW5kIHRoZSBnbG9iZS4NClRoaXMgDQpjb3Vyc2Ugd2ls
bCBnaXZlIHRoZSBCb0TigJlzIGFuZCBTci4gTWdtdC4gYW4gdW5kZXJzdGFuZGluZyBvZiB0
aGUgc2FpZCBmcmFtZXdvcmsgDQphbmQgd2lsbCBwcm92ZSB0byBiZSBhIG1lYW5zIHRvIGFw
cHJlY2lhdGUgdGhlIGxhdyBlbmZvcmNlbWVudCBtZWNoYW5pc21zIA0Kd29ya2luZyB0byBt
YWludGFpbiBzdWNoIHNhaWQgZXF1aWxpYnJpdW0gYW5kIHRoZSByZXN1bHRhbnQgY29uc2Vx
dWVuY2VzIG9mIA0Kbm9uLWNvbXBsaWFuY2Ugd2l0aCB0aGVzZSByZWd1bGF0aW9ucyB2aXou
IFJlcHV0YXRpb24gbWFuYWdlbWVudCwgU2hhcmVob2xkZXLigJlzIA0KaW50ZXJlc3RzLCBs
ZWdhbCByYW1pZmljYXRpb25zLCBjb25zZXF1ZW5jZXMgb2YgYWRoZXJlbmNlIGZhaWx1cmVz
LCBldGMuIFRoaXMgDQp0cmFpbmluZyBjb3Vyc2UgZGVzaWduZWQgZm9yIHRoZSBCb2FyZCBN
ZW1iZXJzLCBIZWFkcyBvZiBzdWItY29tbWl0dGVlcyBhbmQgdGhlIA0KU2VuaW9yIE1hbmFn
ZW1lbnQgd2lsbCBlcXVpcCB0aGVtIHRvIGhhdmUgYSBjbGVhciBjb21wbGlhbmNlIHVuZGVy
c3RhbmRpbmcgDQp0b3dhcmRzIHRyYW5zcGFyZW5jeSBhbmQgdmlzaWJpbGl0eSBvZiB0aGUg
ZW50ZXJwcmlzZS13aWRlIGNvbXBsaWFuY2Ugb3BlcmF0aW9ucyANCmFuZCBhZGhlcmVuY2Ug
ZHV0aWVzLg0KQ09VUlNFIA0KT0JKRUNUSVZFUw0KQXQgDQp0aGUgZW5kIG9mIHRoZSBjb3Vy
c2UsIHBhcnRpY2lwYW50cyB3aWxsIGJlIGFibGUgdG86DQpvwqDCoCANClVuZGVyc3RhbmQg
DQphbmQgYmUgZXF1aXBwZWQgZm9yIHJlZ3VsYXRpbmcgbW9uZXkgbGF1bmRlcmluZyBjb250
cm9scywgaXTigJlzIHNldC11cCBhbmQgDQpyZXF1aXNpdGUgZ292ZXJuYW5jZSBmb3IgcmVn
dWxhdG9yeSB2aW9sYXRpb24gcHJldmVudGlvbi1vcmllbnRlZCANCmFwcHJvYWNoDQpvwqDC
oCANClVuZGVyc3RhbmRpbmcgDQpvcmdhbml6YXRpb25hbCB2dWxuZXJhYmlsaXRpZXMgdG8g
KG9yIGNvbXBsaWNpdCBpbikgbW9uZXkgbGF1bmRlcmluZyBhbmQgDQptZWFzdXJlcyB0byB0
aWdodGVuIHRoZSBjb250cm9scw0Kb8KgwqAgDQpJbnN0cnVjdGl2ZSANCnVuZGVyc3RhbmRp
bmcgYW5kIGNhc2Ugc3R1ZGllcyBvZiBwb3RlbnRpYWwgY29tcGxpYW5jZSBmYWlsdXJlcyBh
bmQgc3Vic2VxdWVudCANCm1hbmFnZW1lbnQgcmVjb3Vyc2UNCm/CoMKgIA0KTGF3IA0KZW5m
b3JjZW1lbnQgaW52ZXN0aWdhdGlvbnMsIHdoYXQgdHJpZ2dlcnMgdGhlbSwgbWV0aG9kcyBv
ZiBkZWFsaW5nIHdpdGggdGhlbSBhbmQgDQpwb3NzaWJsZSByZW1lZGllcw0Kb8KgwqAgDQpF
eGVjdXRpdmUgDQpsaWFiaWxpdHkgZm9yIGEgY29tcGxpYW5jZSBmYWlsdXJlLCBwb3NzaWJs
ZSBzY2VuYXJpb3MsIHdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIA0KYW5kIGRhbWFnZSBjb250
cm9sDQpvwqDCoCANClRlY2hub2xvZ3kgDQpzZXQtdXAgZm9yIHRoZSBlZmZpY2llbnQgZmxv
dyBvZiBjcml0aWNhbCBjb21wbGlhbmNlIGFuZCBvcGVyYXRpb25hbCBpbmZvcm1hdGlvbiAN
CmZvciBzZWFtbGVzcyBhZGhlcmVuY2UgYW5kIGdvdmVybmFuY2UNCkJvYXJkIA0KbWVtYmVy
cyB3aG8gcGFydGljaXBhdGUgaW4gdGhpcyBjb3Vyc2UgY2FuIGJlbmVmaXQgaW4gdGhlIGZv
bGxvd2luZyANCndheXM6DQpvwqDCoCANCkNvbXBsaWFuY2UgDQpmYWlsdXJlIGlzIGEgcGVy
c29uYWxseSBsaWFibGUgb2ZmZW5jZSwgaGVuY2Ugc3RlZXJpbmcgY2xlYXIgb2YgYW55IGFj
dGlvbnMgaXMgYSANCmh1Z2UgUGVyc29uYWwgQmVuZWZpdHMNCm/CoMKgIA0KQm9hcmQgDQpN
ZW1iZXJzIGdldCB0byBkaXNjdXNzIGFuZCB1bmRlcnN0YW5kIHRoZSBjb21wbGlhbmNlIGFu
ZCB0aGUga25vdyANCmhvdw0Kb8KgwqAgDQpCb0TigJlzIA0Kd2lsbCBmdXJ0aGVyIGxlYXJu
IHRvIHN0cmF0ZWdpemUgbm90IG9ubHkgQU1MIHJpc2tzIGJ1dCBhbnkgY29ycG9yYXRlIHJp
c2sgDQptaXRpZ2F0aW9uIGFnYWluc3QgYW55IHR5cGUgb2Ygcmlza3MgaW4gYSBzdHJ1Y3R1
cmVkIG1hbm5lciBhbmQgYnVpbGQgYSBzeXN0ZW0gDQp0byBtb25pdG9yLCBhdm9pZCBhbmQg
Y291bnRlcg0Kb8KgwqAgDQpVbmRlcnN0YW5kIA0KdGhlIHdvcmtpbmcgb2YgTGF3IEVuZm9y
Y2VtZW50IG5ldHdvcmsgdW5kZXIgYSBwYXJ0aWN1bGFyIHJlZ3VsYXRvcnkgZ3VpZGVsaW5l
IA0KYXMgYW55IGFudGktZnJhdWQgb3IgYW50aS1tYWxwcmFjdGljZSBvciBzaW1pbGFyIGdv
dmVybmFuY2UgbWVjaGFuaXNtcyBhcmUgYnVpbHQgDQppbiB0aGUgc2ltaWxhcmx5IGV4ZWN1
dGFibGUgbWFubmVyDQpXSE8gDQpTSE9VTEQgQVRURU5EDQpGb2xsb3dpbmcgDQppbmRpdmlk
dWFscyBvciBncm91cHMgd2lsbCBiZW5lZml0IGZyb20gaXQ6DQpvwqDCoCANCkJvYXJkIA0K
b2YgRGlyZWN0b3JzDQpvwqDCoCANClNlbmlvciANCk1hbmFnZW1lbnQgb2YgYWxsIGZ1bmN0
aW9ucw0Kb8KgwqAgDQpDb21wbGlhbmNlIA0KcGVyc29ubmVsDQpvwqDCoCANCkxlZ2FsIA0K
dGVhbSAvIHJldGFpbmVkLWV4dGVybmFsIGNvdW5zZWwNCm/CoMKgIA0KRGVzaWduYXRlZCAN
CkRpcmVjdG9yIC8gTUxSTyAvIENvbXBsaWFuY2UgT2ZmaWNlcg0KRFVSQVRJT04NCjEwIA0K
RGF5cw0KQ09VUlNFIA0KQ09OVEVOVDoNCk1vZHVsZSANCjEg4oCTIFVuZGVyc3RhbmRpbmcg
dGhlIEJvRCAvIFNyLiBNYW5hZ2VtZW504oCZcyByZXNwb25zaWJpbGl0aWVzIHRvd2FyZHMg
DQpDb21wbGlhbmNlDQpvwqDCoCANCkFwcG9pbnRtZW50IA0Kb2YgYSBEZXNpZ25hdGVkIERp
cmVjdG9yIC8gRGVzaWduYXRlZCBDb21wbGlhbmNlIE9mZmljZXIgLyBNTFJPIChNb25leSAN
CkxhdW5kZXJpbmcgUmVwb3J0aW5nIE9mZmljZXIpDQpvwqDCoCANCkNvc3QgDQpvZiBDb21w
bGlhbmNlDQpvwqDCoCANClBlbmFsdGllcyANCmFuZCBSZXB1dGF0aW9uIERhbWFnZQ0Kb8Kg
wqAgDQpMb3NzIA0Kb2YgT3BlcmF0aW9uYWwgTGljZW5zZSAvIENoYXJ0ZXINCm/CoMKgIA0K
UGVyc29uYWwgDQpGaW5lcy9QZW5hbHRpZXMNCm/CoMKgIA0KU2hhcmVob2xkZXIgDQpEaXNz
YXRpc2ZhY3Rpb24NCm/CoMKgIA0KUHJvdGVjdCANCnRoZSBvcmdhbml6YXRpb24gZnJvbSBi
ZWluZyB1c2VkIGZvciBpbGxlZ2FsIHB1cnBvc2VzDQpvwqDCoCANCkJlIA0KYXdhcmUgb2Yg
dGhlIEJhbmvigJlzIEJTQS9BTUwgcHJvZ3JhbXMgYW5kIGFjdGl2aXRpZXMNCm/CoMKgIA0K
U3VwcG9ydCANCnNlbmlvciBtYW5hZ2VtZW50IGluIEJTQS9BTUwgZWZmb3J0cw0Kb8KgwqAg
DQpEb27igJl0IA0KaWdub3JlIG9yIGRvd25wbGF5IGluZGljYXRpb25zIHRoYXQgY2xpZW50
cyBtYXkgYmUgaW52b2x2ZWQgaW4gaWxsZWdhbCBvciANCmlsbGljaXQgYWN0aXZpdGllcw0K
b8KgwqAgDQpLZWVwIA0KQlNBL0FNTCBtYXR0ZXJzIGNvbmZpZGVudGlhbA0Kb8KgwqAgDQpV
bm1hdGNoaW5nIA0KcHJvY2Vzc2VzIHRoYW4gdGhlaXIgYm9hcmQtYXBwcm92ZWQgQU1MIHBy
b2dyYW0NCm/CoMKgIA0KQW5udWFsIA0KcmV2aWV3IGFuZCBhcHByb3ZhbCBvZiBCU0EvQU1M
IChhbmQgcmVsYXRlZCkgcG9saWNpZXMsIGFsb25nIHdpdGggdGhlIA0KYXBwb2ludG1lbnQg
b2YgdGhlIEJTQSBPZmZpY2VyKHMpDQpvwqDCoCANCkVzdGFibGlzaCANCmEgd3JpdHRlbiBQ
TUxBL0FNTC9PRkFDIGNvbXBsaWFuY2UgcHJvZ3JhbSwgdGhhdCBpcyBjb21tZW5zdXJhdGUg
d2l0aCB0aGVpciBPRkFDIA0KcmlzayBwcm9maWxlDQpNb2R1bGUgDQoyIOKAkyBVbmRlcnN0
YW5kaW5nIHRoZSBCYXNpYyBmaXZlIHBpbGxhcnMgb2YgQU1MIENvbXBsaWFuY2UgDQooQU1M
L1BNTEEvQlNBKToNCm/CoMKgIA0KRXN0YWJsaXNoaW5nIA0KYSBDdWx0dXJlIG9mIENvbXBs
aWFuY2UNCm/CoMKgIA0KV3JpdHRlbiANCnBvbGljaWVzLCBwcm9jZWR1cmVzIGFuZCBpbnRl
cm5hbCBjb250cm9sczsNCm/CoMKgIA0KQSANCmRlc2lnbmF0ZWQgQlNBIGNvbXBsaWFuY2Ug
b2ZmaWNlcjsNCm/CoMKgIA0KQW4gDQplbXBsb3llZSB0cmFpbmluZyBwcm9ncmFtOw0Kb8Kg
wqAgDQpJbmRlcGVuZGVudCANCnRlc3Rpbmcgb2YgdGhlIEJTQS9BTUwgcHJvZ3JhbTsgYW5k
DQpvwqDCoCANCkN1c3RvbWVyIA0KZHVlIGRpbGlnZW5jZSBwcm9jZWR1cmVzDQpNb2R1bGUg
DQozIOKAkyBDby1vcGVyYXRpbmcgd2l0aCBMYXcgRW5mb3JjZW1lbnQNCm/CoMKgIA0KSW52
ZXN0aWdhdGlvbnMgDQpJbml0aWF0ZWQgYnkgdGhlIEZpbmFuY2lhbCBJbnN0aXR1dGlvbg0K
UmVzcG9uZGluZyB0byBhIExhdyBFbmZvcmNlbWVudCANCkludmVzdGlnYXRpb24NCuKAoiBJ
bnZlc3RpZ2F0aW9ucyBJbml0aWF0ZWQgYnkgdGhlIExhdyANCkVuZm9yY2VtZW50DQrigKLC
oA0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/
ZD00T0V2LUJCbTVxVE5ycl85cnZCNjZfRXVIaHZCdy1ZV0VNV2RwUTRfa0k2TlRjdGNzV21V
eEZod2VrZ1dETXI5T25PRzRyZDlWTWktLVJJZThmelB0WlFRbWJoeXlCT0tnSmZRWFliUm1X
ZEptMXdocXBjbE5BeFBaZzhsbWJoSHdvMVI5ZHhxblowYWh5aTZoRzM3aFJjMT4NClNVQlBP
RU5BDQrigKIgU0VBUkNIIFdBUlJBTlQNCk1vZHVsZSANCjQg4oCTIEFkdmFuY2UgRW5nYWdl
bWVudHMNCm/CoMKgIA0KQ29vcGVyYXRpb24gDQpCZXR3ZWVuIENvdW50cmllcyBhbmQgcmVz
cG9uZGluZyB0byBBTUwvQ0ZUIE1MQVRzDQpJbnRlcm5hdGlvbmFsIEludGVyLUludHJhIA0K
T3JnYW5pemF0aW9uYWwgQ28tb3BlcmF0aW9uICYgUHJvY2VkdXJlcw0KTW9kdWxlIA0KNSDi
gJMgQ29ycG9yYXRlIE91dGxvb2sNCm/CoMKgIA0KT2J0YWluaW5nIA0KQ291bnNlbCBpbiB0
aGUgZXZlbnQgb2YgYW4gSW52ZXN0aWdhdGlvbiBBZ2FpbnN0IGEgRmluYW5jaWFsIA0KSW5z
dGl0dXRpb24NCk9yZ2FuaXphdGlvbiBSZXB1dGF0aW9uIE1hbmFnZW1lbnQNCuKAoiBNZWRp
YSBSZWxhdGlvbnMgJiANCkNvcnJlc3BvbmRlbmNlDQpNb2R1bGUgDQo2IOKAkyBJbnZlc3Rp
Z2F0aW9ucyBJbml0aWF0ZWQgYnkgdGhlIEZpbmFuY2lhbCBJbnN0aXR1dGlvbg0Kb8KgwqAg
DQpDb21tdW5pY2F0aW5nIA0Kd2l0aCBMYXcgRW5mb3JjZW1lbnQgb24gU1RScw0Kb8KgwqAg
DQpJbnZlc3RpZ2F0aW9ucyANCkluaXRpYXRlZCBieSBMYXcgRW5mb3JjZW1lbnQNCm/CoMKg
IA0KUHJvc2VjdXRvciANCkRlY2lzaW9uIGFnYWluc3QgYSBGaW5hbmNpYWwgSW5zdGl0dXRp
b24gZm9yIE1vbmV5IExhdW5kZXJpbmcgDQpWaW9sYXRpb25zDQpvwqDCoCANClJlc3BvbnNl
LCANCk1vbml0b3JpbmcgYW5kIENvb3BlcmF0aW9uIGZyb20gdGhlIEZpbmFuY2lhbCBJbnN0
aXR1dGlvbiB0byBhIExhdyBFbmZvcmNlbWVudCANCkludmVzdGlnYXRpb24NCk1vZHVsZSAN
Cjcg4oCTIE9idGFpbmluZyBDb3Vuc2VsIGZvciBhbiBJbnZlc3RpZ2F0aW9uIEFnYWluc3Qg
YSBGaW5hbmNpYWwgDQpJbnN0aXR1dGlvbg0Kb8KgwqAgDQpSZXRhaW5pbmcgDQpDb3Vuc2Vs
DQpvwqDCoCANCkF0dG9ybmV5LUNsaWVudCANClByaXZpbGVnZSBhcHBsaWVkIHRvIGVudGl0
aWVzIGFuZCBpbmRpdmlkdWFscw0Kb8KgwqAgDQpEaXNzZW1pbmF0aW9uIA0Kb2YgYSBXcml0
dGVuIFJlcG9ydCBieSBDb3Vuc2VsDQpNb2R1bGUgDQo4IOKAkyBOb3RpY2VzIHRvIEVtcGxv
eWVlcyBhcyBhIFJlc3VsdCBvZiBhbiBJbnZlc3RpZ2F0aW9uIEFnYWluc3QgYSBGaW5hbmNp
YWwgDQpJbnN0aXR1dGlvbg0Kb8KgwqAgDQpFbXBsb3llZSANCkludGVydmlld3MgaW4gdGhl
IGV2ZW50IG9mIGEgTGF3IEVuZm9yY2VtZW50IEFjdGlvbg0Kb8KgwqAgDQpJbnZlc3RpZ2F0
aW9uIA0KQWdhaW5zdCBhIEZpbmFuY2lhbCBJbnN0aXR1dGlvbg0Kb8KgwqAgDQpNZWRpYSAN
ClJlbGF0aW9ucw0KTW9kdWxlIA0KOSDigJMgQU1ML0NGVCBDb29wZXJhdGlvbiBCZXR3ZWVu
IENvdW50cmllcw0Kb8KgwqAgDQpGQVRGIA0KUmVjb21tZW5kYXRpb25zIG9uIENvb3BlcmF0
aW9uIEJldHdlZW4gQ291bnRyaWVzDQpvwqDCoCANCkludGVybmF0aW9uYWwgDQpNb25leSBM
YXVuZGVyaW5nIEluZm9ybWF0aW9uIE5ldHdvcmsNCm/CoMKgIA0KTXV0dWFsIA0KTGVnYWwg
QXNzaXN0YW5jZSBUcmVhdGllcw0Kb8KgwqAgDQpGaW5hbmNpYWwgDQpJbnRlbGxpZ2VuY2Ug
VW5pdHMNCk1vZHVsZSANCjEwIOKAkyBDb3N0IG9mIENvbXBsaWFuY2UNCm/CoMKgIA0KQmFz
aWMgDQpSZXNvdXJjZXMgYWxsb3RtZW50DQpvwqDCoCANCkFubnVhbCANCkNvbXBsaWFuY2Ug
QnVkZ2V0Og0Kb8KgwqAgDQpTdXBwb3J0aW5nIA0KQ29tcGxpYW5jZSBUZWFtc+KAmSBCU0Ev
QU1MIGVmZm9ydHMgYnkgcmVxdWlzaXRlIGNvc3QgDQphbGxvY2F0aW9uDQpvwqDCoCANClRl
Y2hub2xvZ3kgDQpDb3N0cyDigJMgQWNxdWlzaXRpb24gcHJvY2VzcyAtPiBMaWNlbnNpbmcg
LT4gSW1wbGVtZW50YXRpb24gLT4gDQpUcmFpbmluZw0Kb8KgwqAgDQpUcmFpbmluZy9Db25z
dWx0aW5nL1Byb2N1cmVtZW50IA0KVmVuZG9ycyBDb3N0cw0Kb8KgwqAgDQpIaXJpbmfCoEV4
cGVyaWVuY2VkIA0KQ29tcGxpYW5jZSBwcm9mZXNzaW9uYWxzDQrCt8KgwqDCoMKgwqDCoMKg
IA0KR0VORVJBTCANCk5PVEVTDQpvwqDCoCANClRoaXMgDQpjb3Vyc2UgaXMgZGVsaXZlcmVk
IGJ5IG91ciBzZWFzb25lZCB0cmFpbmVycyB3aG8gaGF2ZSB2YXN0IGV4cGVyaWVuY2UgYXMg
ZXhwZXJ0IA0KcHJvZmVzc2lvbmFscyBpbiB0aGUgcmVzcGVjdGl2ZSBmaWVsZHMgb2YgcHJh
Y3RpY2UuIFRoZSBjb3Vyc2UgaXMgdGF1Z2h0IHRocm91Z2ggDQphIG1peCBvZiBwcmFjdGlj
YWwgYWN0aXZpdGllcywgdGhlb3J5LCBncm91cCB3b3JrcyBhbmQgY2FzZSANCnN0dWRpZXMu
DQpvwqDCoCANClRyYWluaW5nIA0KbWFudWFscyBhbmQgYWRkaXRpb25hbCByZWZlcmVuY2Ug
bWF0ZXJpYWxzIGFyZSBwcm92aWRlZCB0byB0aGUgDQpwYXJ0aWNpcGFudHMuDQpvwqDCoCAN
ClVwb24gDQpzdWNjZXNzZnVsIGNvbXBsZXRpb24gb2YgdGhpcyBjb3Vyc2UsIHBhcnRpY2lw
YW50cyB3aWxsIGJlIGlzc3VlZCB3aXRoIGEgDQpjZXJ0aWZpY2F0ZS4NCm/CoMKgIA0KV2Ug
DQpjYW4gYWxzbyBkbyB0aGlzIGFzIHRhaWxvci1tYWRlIGNvdXJzZSB0byBtZWV0IG9yZ2Fu
aXphdGlvbi13aWRlIG5lZWRzLiBDb250YWN0IA0KdXMgdG8gZmluZCBvdXQgbW9yZTrCoHRy
YWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmcNCm/CoMKgIA0KwqBUaGUgDQp0cmFpbmluZyB3
aWxsIGJlIGNvbmR1Y3RlZCBhdMKgU0tJTExTIEZPUiBBRlJJQ0HCoFRSQUlOSU5HIElOU1RJ
VFVURSANCg0Kb8KgwqAgDQpUaGUgDQp0cmFpbmluZyBmZWUgY292ZXJzIHR1aXRpb24gZmVl
cywgdHJhaW5pbmcgbWF0ZXJpYWxzLCBsdW5jaCBhbmQgdHJhaW5pbmcgdmVudWUuIA0KQWNj
b21tb2RhdGlvbiBhbmQgYWlycG9ydCB0cmFuc2ZlciBhcmUgYXJyYW5nZWQgZm9yIG91ciBw
YXJ0aWNpcGFudHMgdXBvbiANCnJlcXVlc3QuDQpvwqDCoCANClBheW1lbnQgDQpzaG91bGQg
YmUgc2VudCB0byBvdXIgYmFuayBhY2NvdW50IGJlZm9yZSBzdGFydCBvZiB0cmFpbmluZyBh
bmQgcHJvb2Ygb2YgcGF5bWVudCANCnNlbnQgdG86wqB0cmFpbmluZ0Bza2lsbHNmb3JhZnJp
Y2Eub3JnDQrCoA0KwqANCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3Ry
YWNraW5nL3Vuc3Vic2NyaWJlP2Q9UmlqRFdjMjJSMjlHUkVGYnhjMHV0OVRKajVNVkNYZ0Uw
czlnWmhhNG9TZ2JqOG5yTDdvVEozc2JFZXBHS3E2UjhHS2pMbjNXWXhCb09nbWxKTm8xQW51
eVpXREYtNEFiSlFxeWJHanR2cEVrMD4NClVOU1VCU0NSSUJF

--=-eZCfNTXhxzbvFdfKcuEsOR6RhyFowqgn7XWKzQ==
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
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; MARGIN-LEFT: 2cm; BORDER-LEFT: medium none; PADDING-RIG=
HT: 0cm; MARGIN-RIGHT: 0cm; mso-element: para-border-div">
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
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KNwn75xhqrMEUFgQvILCDkfhYuNT1lKCSPHY4=
nj43JBgq4bv2nYrY7b9W5zl3sYDtbXWwoCGfQtElE9Ipuii_6oEyQqDGr7JMyDDnYw9VQ4=
MYM1"><SPAN=20
style=3D"FONT-SIZE: 11pt; TEXT-DECORATION: none; FONT-WEIGHT: normal; =
COLOR: windowtext; text-underline: none"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN></SPAN><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082>Anti-Mon=
ey Laundering=20
(AML) Training Course for Board of Directors and Senior Management On =
12th to=20
23rd December 2022</FONT></SPAN></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1P9P8I7Sz1-YRSu=
SrXDhNgkREC6oDZFwxaNj-UoemvcQDioVroGuLBqk18lfKalQtKfZscwGHGOGmK0SdMvFf=
nJKv53KB_468DWX46AworSAs0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082>Register=
 for online=20
attendance <?xml:namespace prefix =3D "o" ns =3D=20
"urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1P9P8I7Sz1-YRSu=
SrXDhNgqq-MKuvNYckP_dAFcrgsVh2R_65-hKroItC6KtSt9jGS2sownUDLvXmCyZ0s3B6=
ftf1LtjjIp6kryJP3WR3ZCT-0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT face=3D"Times New Roman"=
><FONT=20
color=3D#410082>&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></SPAN></SPA=
N></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1P9P8I7Sz1-YRSu=
SrXDhNgo4GXJlBuozVuwmrD5O-BOZoPQVaLlpQCFpyHi3qKBhKR4T5CWc7Lthj_-z79p95=
W_zwQNIocTa_rQQGxYPoETCq0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082>Register=
 to attend=20
<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1P9P8I7Sz1-YRSu=
SrXDhNgr32FyM-gFPtFTyERZPz9vdN8vIpyHQrxchKINHzBy0V9HFqbNdXqXTZxHGpQwpH=
TcP4M64RNudDYxnJZCJtNa5F0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxnfYfz8idggQvFC=
VfnkfSID-pS4PcSBmXA5SSFhSVsKhtO4EFmIaeYoV4O4soWQFgxYFJl-20hFsFEQafYyxd=
TaE1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Calendar fo=
r 2022/2023=20
Workshops<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDAMknLBu-EWd5qsX=
q4m_S-zwxbQeVxWZSsYHBObdSRFBQvxGkxVFXB-TvPOGzhH1LyWHmPfXVntoVkYorbdbvM=
Nxw1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Contact=20
us<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejjFSSx__U42-bKcsjp11xqTN2gNzIUvCvVfhw=
lganNhqFMHWNzBYcqjV75PWXiOtIvuFMtsDW6aGKUcdA-7fTbfj9bRPTGRoFUkRbMhNumD=
QKI1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Whatapp<o:p=
></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: nor=
mal"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Venue:=20
PrideInn Paradise Beach Resort, Mombasa, Kenya<o:p></o:p></FONT></SPAN=
></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: nor=
mal"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Course=20
Fee: 3,000USD<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Office=20
Telephone: +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt 2cm; LINE-HEIGHT: norm=
al"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><FONT face=3D=
Calibri>Send=20
us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMRE_2joaz-i9RXNpFsmw=
yRvifA4k262Eyct3bh0yvaW3yqtbYCeKHRKFDGrF69jz_sS0HuMssLdZKkIBuQN2chKtk1=
Xq_pL891jHjJrn11lUj0" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT=20
color=3D#410082>training@skillsforafrica.org&nbsp;</FONT></SPAN></A><F=
ONT=20
face=3DCalibri>or call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 12pt 0cm 0pt 2cm; LINE-HEIGHT: n=
ormal"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>INTRODUCTION</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p></o:p></=
SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>As=20
per FATAF&rsquo;s International Guidelines, The Board of Directors of =
any financial=20
institution has a fiduciary duty towards the organization to ensure th=
at there=20
is a robust compliance program in place. The Board needs to set &ldquo=
;the Tone from=20
the Top&rdquo;, establish an effective control framework and effective=
ly promote a=20
&ldquo;culture of compliance&rdquo;. A high-risk compliance responsibi=
lity entails the flow=20
of critical information to risk committees and boards and should be of=
 relevance=20
to the overall governance purpose. Senior management in most financial=
=20
institutions have well-established procedures and policies for dealing=
 with=20
overall operational risk&rsquo;s like credit risk or market risk, but =
the practice of=20
dealing with Know Your Customer (KYC) and Anti-Money Laundering (AML) =
risk is=20
yet to mature. The AML/KYC compliance looks into transfer or conversio=
n of=20
illicit gotten sources (black money) to legally accessible/taxable (wh=
ite money)=20
funds, primarily using the financial institutions as a conduit for con=
cealment=20
and disguise activities to happen.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Technically=20
speaking, Board members are not required to be experts at AML knowhow,=
 but, it&rsquo;s=20
highly recommended and comes as industry best practice for BoD&rsquo;s=
 to acquire an=20
understanding of fundamental aspects of AML Risk Control Framework, in=
 order to=20
effectively exercise their oversight responsibilities, as mandated by =
almost all=20
the national financial regulatory authorities. Under this understandin=
g of the=20
regulatory environment in which the firm operates, the Board of Direct=
ors and=20
Sr. Management must have a basic working knowledge of applicable regul=
ations,=20
including relevant requirements around the globe.<o:p></o:p></SPAN></P=
>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>This=20
course will give the BoD&rsquo;s and Sr. Mgmt. an understanding of the=
 said framework=20
and will prove to be a means to appreciate the law enforcement mechani=
sms=20
working to maintain such said equilibrium and the resultant consequenc=
es of=20
non-compliance with these regulations viz. Reputation management, Shar=
eholder&rsquo;s=20
interests, legal ramifications, consequences of adherence failures, et=
c. This=20
training course designed for the Board Members, Heads of sub-committee=
s and the=20
Senior Management will equip them to have a clear compliance understan=
ding=20
towards transparency and visibility of the enterprise-wide compliance =
operations=20
and adherence duties.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><BR>At=20
the end of the course, participants will be able to:<o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Understand=20
and be equipped for regulating money laundering controls, it&rsquo;s s=
et-up and=20
requisite governance for regulatory violation prevention-oriented=20
approach<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Understanding=20
organizational vulnerabilities to (or complicit in) money laundering a=
nd=20
measures to tighten the controls<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Instructive=20
understanding and case studies of potential compliance failures and su=
bsequent=20
management recourse<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Law=20
enforcement investigations, what triggers them, methods of dealing wit=
h them and=20
possible remedies<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Executive=20
liability for a compliance failure, possible scenarios, what are the n=
ext steps=20
and damage control<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Technology=20
set-up for the efficient flow of critical compliance and operational i=
nformation=20
for seamless adherence and governance<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Board=20
members who participate in this course can benefit in the following=20
ways:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Compliance=20
failure is a personally liable offence, hence steering clear of any ac=
tions is a=20
huge Personal Benefits<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Board=20
Members get to discuss and understand the compliance and the know=20
how<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>BoD&rsquo;s=20
will further learn to strategize not only AML risks but any corporate =
risk=20
mitigation against any type of risks in a structured manner and build =
a system=20
to monitor, avoid and counter<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Understand=20
the working of Law Enforcement network under a particular regulatory g=
uideline=20
as any anti-fraud or anti-malpractice or similar governance mechanisms=
 are built=20
in the similarly executable manner<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Following=20
individuals or groups will benefit from it:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Board=20
of Directors<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Senior=20
Management of all functions<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Compliance=20
personnel<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Legal=20
team / retained-external counsel<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Designated=20
Director / MLRO / Compliance Officer<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>DURATION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>10=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>COURSE=20
CONTENT:</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
1 &#8211; Understanding the BoD / Sr. Management&rsquo;s responsibilit=
ies towards=20
Compliance</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Appointment=20
of a Designated Director / Designated Compliance Officer / MLRO (Money=
=20
Laundering Reporting Officer)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Cost=20
of Compliance<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Penalties=20
and Reputation Damage<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Loss=20
of Operational License / Charter<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Personal=20
Fines/Penalties<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Shareholder=20
Dissatisfaction<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Protect=20
the organization from being used for illegal purposes<o:p></o:p></SPAN=
></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Be=20
aware of the Bank&rsquo;s BSA/AML programs and activities<o:p></o:p></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Support=20
senior management in BSA/AML efforts<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Don&rsquo;t=20
ignore or downplay indications that clients may be involved in illegal=
 or=20
illicit activities<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Keep=20
BSA/AML matters confidential<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Unmatching=20
processes than their board-approved AML program<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Annual=20
review and approval of BSA/AML (and related) policies, along with the=20
appointment of the BSA Officer(s)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Establish=20
a written PMLA/AML/OFAC compliance program, that is commensurate with =
their OFAC=20
risk profile<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
2 &#8211; Understanding the Basic five pillars of AML Compliance=20
(AML/PMLA/BSA):</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Establishing=20
a Culture of Compliance<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Written=20
policies, procedures and internal controls;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>A=20
designated BSA compliance officer;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>An=20
employee training program;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Independent=20
testing of the BSA/AML program; and<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Customer=20
due diligence procedures<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
3 &#8211; Co-operating with Law Enforcement</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Investigations=20
Initiated by the Financial Institution<BR>Responding to a Law Enforcem=
ent=20
Investigation<BR>&#8226; Investigations Initiated by the Law=20
Enforcement<BR>&#8226;&nbsp;</SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4OEv-BBm=
5qTNrr_9rvB66_EuHhvBw-YWEMWdpQ4_kI6NTctcsWmUxFhwekgWDMr9OnOG4rd9VMi--R=
Ie8fzPtZQQmbhyyBOKgJfQXYbRmWdJm1whqpclNAxPZg8lmbhHwo1R9dxqnZ0ahyi6hG37=
hRc1"><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; text-underline: non=
e"><FONT=20
face=3D"Times New Roman">SUBPOENA</FONT></SPAN></A><BR>&#8226; SEARCH =
WARRANT<SPAN=20
style=3D"COLOR: #333333"><o:p></o:p></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
4 &#8211; Advance Engagements</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Cooperation=20
Between Countries and responding to AML/CFT MLATs<BR>International Int=
er-Intra=20
Organizational Co-operation &amp; Procedures<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
5 &#8211; Corporate Outlook</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Obtaining=20
Counsel in the event of an Investigation Against a Financial=20
Institution<BR>Organization Reputation Management<BR>&#8226; Media Rel=
ations &amp;=20
Correspondence<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
6 &#8211; Investigations Initiated by the Financial Institution</SPAN>=
</B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Communicating=20
with Law Enforcement on STRs<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Investigations=20
Initiated by Law Enforcement<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Prosecutor=20
Decision against a Financial Institution for Money Laundering=20
Violations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Response,=20
Monitoring and Cooperation from the Financial Institution to a Law Enf=
orcement=20
Investigation<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
7 &#8211; Obtaining Counsel for an Investigation Against a Financial=20
Institution</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Retaining=20
Counsel<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Attorney-Client=20
Privilege applied to entities and individuals<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Dissemination=20
of a Written Report by Counsel<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
8 &#8211; Notices to Employees as a Result of an Investigation Against=
 a Financial=20
Institution</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Employee=20
Interviews in the event of a Law Enforcement Action<o:p></o:p></SPAN><=
/P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Investigation=20
Against a Financial Institution<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Media=20
Relations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
9 &#8211; AML/CFT Cooperation Between Countries</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>FATF=20
Recommendations on Cooperation Between Countries<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>International=20
Money Laundering Information Network<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Mutual=20
Legal Assistance Treaties<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Financial=20
Intelligence Units<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal"><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Module=20
10 &#8211; Cost of Compliance</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Basic=20
Resources allotment<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Annual=20
Compliance Budget:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Supporting=20
Compliance Teams&rsquo; BSA/AML efforts by requisite cost=20
allocation<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Technology=20
Costs &#8211; Acquisition process -&gt; Licensing -&gt; Implementation=
 -&gt;=20
Training<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Training/Consulting/Procurement=20
Vendors Costs<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Hiring&nbsp;Experienced=20
Compliance professionals<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt 2cm; LINE-HEIGHT: =
normal; TEXT-INDENT: -18pt; tab-stops: list 36.0pt; mso-list: l0 level=
1 lfo1"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: #333333; mso-bid=
i-font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-=
size: 10.5pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
</SPAN></SPAN></SPAN><B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>This=20
course is delivered by our seasoned trainers who have vast experience =
as expert=20
professionals in the respective fields of practice. The course is taug=
ht through=20
a mix of practical activities, theory, group works and case=20
studies.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Training=20
manuals and additional reference materials are provided to the=20
participants.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Upon=20
successful completion of this course, participants will be issued with=
 a=20
certificate.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>We=20
can also do this as tailor-made course to meet organization-wide needs=
. Contact=20
us to find out more:&nbsp;<A><SPAN=20
style=3D"COLOR: #337ab7">training@skillsforafrica.org</SPAN></A><o:p><=
/o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>&nbsp;The=20
training will be conducted at&nbsp;SKILLS FOR AFRICA&nbsp;TRAINING INS=
TITUTE=20
<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>The=20
training fee covers tuition fees, training materials, lunch and traini=
ng venue.=20
Accommodation and airport transfer are arranged for our participants u=
pon=20
request.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt 2cm; LINE-HEIGHT: n=
ormal; TEXT-INDENT: -18pt; tab-stops: list 72.0pt; mso-margin-top-alt:=
 auto; mso-margin-bottom-alt: auto; mso-list: l0 level2 lfo1"><SPAN=20
style=3D'FONT-SIZE: 10pt; FONT-FAMILY: "Courier New"; COLOR: #333333; =
mso-fareast-font-family: "Courier New"; mso-bidi-font-size: 10.5pt'><S=
PAN=20
style=3D"mso-list: Ignore">o<SPAN style=3D'FONT: 7pt "Times New Roman"=
'>&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR=
: #333333'>Payment=20
should be sent to our bank account before start of training and proof =
of payment=20
sent to:&nbsp;<A><SPAN=20
style=3D"COLOR: #337ab7">training@skillsforafrica.org</SPAN></A><o:p><=
/o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></P></DIV></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3DQ=
7TYsCRp4xHc0W05Ejw6bA2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DRijDWc22R29GREFbxc0ut9TJj5MVCXgE0s9gZha4oSgbj8nrL7oTJ3sbEe=
pGKq6R8GKjLn3WYxBoOgmlJNo1AnuyZWDF-4AbJQqybGjtvpEk0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfNTXhxzbvFdfKcuEsOR6RhyFowqgn7XWKzQ==--
