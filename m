Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3555ED6BA
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Sep 2022 09:49:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4McpYG69pgz3bd3
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Sep 2022 17:49:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=an78u/Sg;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=W7RKAiX/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.87.8; helo=n8.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=an78u/Sg;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=W7RKAiX/;
	dkim-atps=neutral
Received: from n8.mxout.mta4.net (n8.mxout.mta4.net [67.227.87.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4McpY756Twz2yxc
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Sep 2022 17:49:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1664351345;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=pLb4eqaWYMHTeUw3hgDaPr8REPGR+QvjKRcz8P5lHFo=;
	b=an78u/Sg72HH0JeWkpMA2vHUk6zR3oJpHCGf/Iz9NYFXr6vefTdeRou9zLINj7KIllivMOYjKYj
	yfkYXPZQvwVPtuiOKZNHL0LcT+t9GfjnPHTp/SKGpSXikksuVoXDOhDcgBOZKKVg/HWtIHhKLFJvE
	R8FBpyH26MiHAS6Q46Y=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1664351345;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=pLb4eqaWYMHTeUw3hgDaPr8REPGR+QvjKRcz8P5lHFo=;
	b=W7RKAiX/3sv/uXcwx9kt4UeOtFtjKrBCd8zYrnoEl2pEdgWLpC2frumf2ze89x6OepG3yNFToIP
	mEfPZQGfKIiNrhTSv3e28zlkx5EO7FzZRV+2FiquAabZx6B9ZweGCNYzxkRc6Yi1xG/enD6mLVPGV
	gLcX+kV9mRzfohGL9nc=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 28 Sep 2022 07:49:05 +0000
Subject: Invitation to Attend an International Training Workshop on Advanced
 Financial Management, Grants Management and Auditing for Donor Funded
 Projects on 7th to 18th November 2022
Message-Id: <4uhzxvky8koj.QTw5mGfAey_Z29kApfLiHw2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: QTw5mGfAey_Z29kApfLiHw2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfNVbCqyjrIeabc/YVO3DK8xRk+fcN23WKzQ=="
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

--=-eZCfNVbCqyjrIeabc/YVO3DK8xRk+fcN23WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4SW5UVDlnd0Qy
MGs2YnZra0FINWxfMVpFdlN0SHo2ckluLUUyUGp3UW1NeHlpSWExVE53M3JKMy1zQ0p4bTBQ
ZDh4bzBCUHpacWttdEZJaEhHU1QtWlN1Tk1nd2NPODA0ZFdwa2U0VTVvVlVGTTE+DQpBZHZh
bmNlZCANCkZpbmFuY2lhbCBNYW5hZ2VtZW50LCBHcmFudHMgTWFuYWdlbWVudCBhbmQgQXVk
aXRpbmcgZm9yIERvbm9yIEZ1bmRlZCBQcm9qZWN0cyANCm9uIDd0aCB0byAxOHRoIE5vdmVt
YmVyIDIwMjINCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tp
bmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRQ
ZVFUTVBfd29yQUg0bHdnQmxNWktnTEJUQll0RnVaN1NyZE5ScTdZSU1abzBWVGRsa2xOdmdR
MGxiUFI1WEl2QmR6VzBVYXZnVzlJaS16NlJTODd0aXF5RzdfZXdFc1NFRXhfbExsckZ3MXhI
ZUFwZTY0aTFVdUhIQXh3UFg5Q21uMD4NClJlZ2lzdGVyIA0KZm9yIG9ubGluZSB3b3Jrc2hv
cCBhdHRlbmRhbmNlIA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90
cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3Nx
cXJUdFBlUVRNUF93b3JBSDRsd2dCbE1aS2dMQlRCWXRGdVo3U3JkTlJxN1lJTVpnNXRWSHFk
bmtEVHM4aVp1dTVQZDVvNkY4U0wwUndhcGxoYVVNZnpHeWg4cERqR21CQkxRNGdvNU80LW9T
aFlDa2JaTFlyNkh3QzVac01GUDl3QllXUVYwPg0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJr
LmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhl
SjktUnQyMjVZWXNQbVdqTldzcXFyVHRQZVFUTVBfd29yQUg0bHdnQmxNWktnTEJUQll0RnVa
N1NyZE5ScTdZSU1ab3FYUUZEVndmQWM2bldTX1hybjhLWGI5S3dHU0tUb05tTjZDQkM4c29w
eWNDUTJhRkN3UTdsUzd4anNFbHlvMzg2QUpxSjBETDFJc1JreUFVV1JrNWxEMD4NClJlZ2lz
dGVyIA0KdG8gYXR0ZW5kIHRoZSB3b3Jrc2hvcA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxh
c3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1S
dDIyNVlZc1BtV2pOV3NxcXJUdFBlUVRNUF93b3JBSDRsd2dCbE1aS2dMQlRCWXRGdVo3U3Jk
TlJxN1lJTVp0ZUUtdFllUHcwWG5sVlBoRDBFR01wYktZcjZhSVlsVWJwamFIa3laZkR2a3RI
NW43MFVGTFZ2bnNzT2xRdk1JcTlZMEE5OGE3Vi1DRTV1NWRKUE0zTU8wPg0KwqANCg0KPGh0
dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD00UlNP
R2VTNUhJNktGSml4UXB5a1VIN1NCRFNqMEEyRWRIZGNxcUVrLUtNTGRZR3RLMnJuVEdFT3BG
T3pjZGp4VjF1TWNsYllNLXBWQlU4cWZOb183YVd2SWdKVTNYeWVpdmxXdjFJcjlfMFhfZkxQ
VGZRaXAtRnRNangybmc0VVRsZS1QZjNjcUJ6UWx2c3JKTDN2bTJNMT4NCkNhbGVuZGFyIGZv
ciAyMDIyLzIwMjMgDQpXb3Jrc2hvcHMNCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFz
dGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdT
QkRTajBBMkVkSGRjcXFFay1LTWNLQlc1R3hqYnVYRmlWbzRFRFFEQWpCY0l5dmRGSjVlMG9E
Z213VmZvY2Z5Q1MxbU5jWEV6SG5WeUZrSnpCNXpxMGxMOUhvMUJDMlNRaGNwZllzX2xSUWdN
YTBINkctYVo0VGhsYUJFdGdKbzE+DQpDb250YWN0IHVzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVRkTzFnQ3VRNzFocFdM
NjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9lamlqY3pmVGZBcVRpTDlhVnNOWTFfbWRuMnlE
a2tmYnREVHItUWl3SklwVWE3c3RFTUpaWUZkQTUxOWVZRzlmVFB1TGVESWlZdi1vcUpWaGQ0
N1dIUThrY0k5Tk1XUzFNRDNKVlVURTNoMnotSU0xPg0KV2hhdGFwcA0KwqANClZFTlVFOiBC
RVNUIFdFU1RFUk4gTUVSSURJQU4gSE9URUwsIE5BSVJPQkksIA0KS0VOWUENCkNPVVJTRSBG
RUU6IDIsNDAwVVNEDQpPZmZpY2UgVGVsZXBob25lOiArMjU0LTcwMi0yNDktNDQ5DQpSZWdp
c3RlciBhcyBhIGdyb3VwIG9mIDUgb3IgbW9yZSBwYXJ0aWNpcGFudHMgYW5kIGdldCAyNSUg
ZGlzY291bnQgDQpvbiB0aGUgY291cnNlIGZlZS4gDQpTZW5kIHVzIGFuIGVtYWlsOiANCjxo
dHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9cmFf
S3JxdXltX3ZBSDdhMHhmeWlSUlJKMG1tTW9nbnlnNTZrbVBlSkRjT0FUZzVoUmtONGptSE13
RXpGMHpndE80OEtOTnVMR1Vkd2xHMXFLalVuYlVNMkllVDBJY09XYmZKbGxUNDJKc1hmNlkx
OVFoV0M4b0tDZzB3R1ZoTU1XTjhERDJ1STJIV3VDZEkyTkpUdXcxdVYtdWU4VXBiT1A1YmZv
bnNDSzlVNDNSV3JoczgzQ0Y3VlY2TUI3VThQZzFJQmlzQUlqUU04UkFkTEt0RTFTcnZzNm9T
S0JPc1N2Vi1rMkd4c19mUVIwPg0KdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZ8Kgb3Ig
DQpjYWxsICsyNTQtNzAyLTI0OS00NDkNCklOVFJPRFVDVElPTg0KVGhpcyBjb3Vyc2UgaXMg
ZGVzaWduZWQgdG8gZW5hYmxlIHRob3NlIGludm9sdmVkIHdpdGggZ3JhbnQgDQptYW5hZ2Vt
ZW50IHRvIGJlY29tZSBlZmZpY2llbnQgYW5kIGVmZmVjdGl2ZSBpbiB0aGUgYWNxdWlzaXRp
b24gYW5kIHV0aWxpemF0aW9uIA0Kb2YgZnVuZHMgZm9yIGRldmVsb3BtZW50IHB1cnBvc2Vz
LCB1c2luZyBhcHByb3ByaWF0ZSB0ZWNobmlxdWVzIGFuZCBhcHBsaWNhdGlvbiANCm9mIGFj
Y291bnRpbmcgYW5kIGZpbmFuY2UgcHJpbmNpcGxlcy4NCldITyANClNIT1VMRCBBVFRFTkQN
CkZpbmFuY2UgRGlyZWN0b3JzLCBGaW5hbmNlIE1hbmFnZXJzLCBQcm9jdXJlbWVudCBEaXJl
Y3RvcnMsIA0KUHJvY3VyZW1lbnQgbWFuYWdlcnMsIFByb2N1cmVtZW50IG9mZmljZXJzLCBB
ZG1pbmlzdHJhdG9ycywgUHJvamVjdCBvZmZpY2VycywgDQpCdWRnZXQgQWNjb3VudGFudHMs
IEF1ZGl0b3JzLCBDaGllZiBBY2NvdW50YW50cywgQ3JlZGl0IA0KQ29udHJvbGxlcnMNCkNP
VVJTRSBPQkpFQ1RJVkVTDQpBdCB0aGUgZW5kIG9mIHRoZSBjb3Vyc2UsIHBhcnRpY2lwYW50
cyB3aWxsIGJlIGFibGUgdG86DQrigKIgDQpJZGVudGlmeSBhbmQgdW5kZXJzdGFuZCB0aGUg
Y3JpdGljYWwgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgZ3JhbnQgYWlkOyBmb3IgDQpkb25v
ci1mdW5kZWQgcHJvamVjdHMNCuKAoiBFbnN1cmUgY29tcGxpYW5jZSB3aXRoIGRvbm9yIHRl
cm1zIGFuZCANCmNvbmRpdGlvbnM7DQrigKIgUHJvdmlkaW5nIHN1cHBvcnRpbmcgZG9jdW1l
bnRzLCBjb3JyZWN0IHByb2N1cmVtZW50IG9mIGdvb2RzIA0KYW5kIHNlcnZpY2VzIGFuZCBt
ZWV0aW5nIGZpbmFuY2lhbCByZXBvcnRpbmcgcmVxdWlyZW1lbnRzOw0K4oCiIE1hbmFnaW5n
IA0KbXVsdGlwbGUtZnVuZGVkIHByb2dyYW1tZXMNCuKAoiBQcm92aWRlIHRvb2xzIGZvciBl
ZmZpY2llbnQgTWFuYWdlbWVudCBvZiBEb25vci0gDQpmdW5kZWQgcHJvamVjdA0K4oCiIERl
c2lnbiBhbmQgbW9uaXRvciBkb25vciBidWRnZXRzDQrigKIgUHJlcGFyZSBhIGRvbm9yIA0K
ZmluYW5jaWFsIHJlcG9ydCB0byBtYXRjaCB3aXRoIGEgcHJvamVjdCBuYXJyYXRpdmUgcmVw
b3J0Ow0K4oCiIERlc2NyaWJlIHRoZSANCnBoYXNlcyBpbiB0aGUgZ3JhbnQgbWFuYWdlbWVu
dCBjeWNsZSBjbGFyaWZ5IGtleSByZXNwb25zaWJpbGl0aWVzIGFuZCByb3V0aW5lcyANCm5l
ZWRlZCBmb3Igc3VjY2Vzc2Z1bCBncmFudCBtYW5hZ2VtZW50Ow0K4oCiIElkZW50aWZ5IHRo
ZSByZXF1aXJlbWVudHMgZm9yIA0KY2xvc2luZyBvZmYgYSBkb25vciBncmFudDsNCuKAoiBN
YW5hZ2UgdGhlIHJlbGF0aW9uc2hpcCB3aXRoIGRvbm9ycywgaGVhZCBvZmZpY2UgDQphbmQg
aW1wbGVtZW50aW5nIHBhcnRuZXJzIHdpdGggZ3JlYXRlciBjb25maWRlbmNlOw0K4oCiIEFw
cHJlY2lhdGUgdGhhdCBmaW5hbmNlIA0KYW5kIHByb2dyYW1tZSBzdGFmZiBtdXN0IHdvcmsg
Y2xvc2VseSBmb3IgU3VjY2Vzc2Z1bCBncmFudCANCm1hbmFnZW1lbnQuDQpEVVJBVElPTg0K
MTAgRGF5cw0KQ09VUlNFIENPTlRFTlQ6DQrigKIgT3ZlcnZpZXcgb2YgR3JhbnRzIE1hbmFn
ZW1lbnQgQ3ljbGUNCuKAoiBEZXZlbG9waW5nIHByb3Bvc2FsDQrigKIgDQpCdWRnZXRpbmcN
CuKAoiBUeXBlcyBvZiBjb3N0cw0K4oCiIEdyYW50IEF3YXJkIENvbnRyYWN0LA0K4oCiIEF3
YXJkIFJldmlldywNCuKAoiANCkZ1bmRyYWlzaW5nIFRpcHMsIEltcGxlbWVudGF0aW9uLCBD
b21wbGlhbmNlDQrigKIgRWxpZ2libGUgYW5kIGluZWxpZ2libGUgDQpjb3N0cywNCuKAoiBD
b3N0IFNoYXJlLyBNYXRjaGluZyBjb3N0cywNCuKAoiBQcm9jdXJlbWVudCBQcm9jZWR1cmVz
LA0K4oCiIEdyYW50IA0KVHJhY2tpbmcgVG9vbHMsIDoNCuKAoiBDb3N0cyBlbGlnaWJpbGl0
eSwgYWRtaW5pc3RyYXRpb24NCuKAoiBQcm9ncmFtbWUgDQpldmFsdWF0aW9uDQrigKIgR3Jh
bnQgUmVwb3J0aW5nLA0K4oCiIEZpbmFuY2lhbCBEb2N1bWVudGF0aW9uIGFuZCBSZXBvcnRp
bmcNCuKAoiANCkRvY3VtZW50YXRpb24sIEludGVybmFsIENvbnRyb2xzOyBBdWRpdCwgTmFy
cmF0aXZlIFJlcG9ydGluZywgUGFydG5lcnNoaXBzICYgDQpjb25zb3J0aWEgbWFuYWdlbWVu
dCwgRG9ub3IgQ29tcGxpYW5jZSwNCuKAoiBQZXJzb25uZWwgJlN0YWZmIElzc3VlcyANCihl
dGhpY3MpIDogQ29udHJhY3RzLCBUaW1lIHNoZWV0cywgVHJhdmVsICYgUGVyIGRpZW06IEl0
aW5lcmFyeSwgYXNzaWduaW5nLCANCkFzc2V0cyAmIEludmVudG9yeSBNYW5hZ2VtZW50LCBD
by1GaW5hbmNpbmcgJg0K4oCiIE11bHRpLSBEb25vciBGdW5kaW5nLCANCkluZGlyZWN0IENv
c3RzICYgQ29udGluZ2VuY2llcywgQ2xvc2UgT3V0IFByb2NlZHVyZXMgJiB0aGUgRmluYWwg
DQpUcmFuY2hlLg0K4oCiIEJhc2ljIGNvbmNlcHRzIGluIGdyYW50IG1hbmFnZW1lbnQNCuKA
oiBLZXkgY2hhbGxlbmdlcyBpbiBncmFudCANCm1hbmFnZW1lbnQNCuKAoiBUaGUgZ3JhbnQg
bWFuYWdlbWVudCBsaWZlIGN5Y2xlDQrigKIgR3JhbnQgbWFuYWdlbWVudCBwbGFuDQrigKIg
DQpSZXNwb25zaWJpbGl0aWVzIGFuZCByb3V0aW5lcyBpbiBncmFudCBtYW5hZ2VtZW50DQri
gKIgVGhlIGZsb3cgb2YgZG9ub3IgDQpmdW5kcw0K4oCiIEFzc2Vzc2luZyB0aGUgdGVybXMg
YW5kIGNvbmRpdGlvbnMgaW4gZ3JhbnQgYWdyZWVtZW50cw0K4oCiIEdyYW50IA0KYWdyZWVt
ZW50cywgYW5kIGFjY291bnRpbmcgYW5kIHByb2N1cmVtZW50IHN5c3RlbXMNCuKAoiBDb21w
bHlpbmcgd2l0aCBkb25vciANCnJlcG9ydGluZyByZXF1aXJlbWVudHMNCuKAoiBNYW5hZ2lu
ZyBrZXkgcmVsYXRpb25zaGlwcyBmb3Igc3VjY2Vzc2Z1bCBncmFudCANCm1hbmFnZW1lbnQN
CuKAoiBDb21tdW5pdHkgRGV2ZWxvcG1lbnQgYW5kIFByb2plY3RzIGZ1bmRpbmcNCuKAoiBG
dW5kaW5nIA0KcmVxdWlyZW1lbnRzDQrigKIgUHJvamVjdCBmaW5hbmNlDQrigKIgQ2FwaXRh
bCBCdWRnZXRpbmcgYW5kIEludmVzdG1lbnQgDQpBcHByYWlzYWwNCuKAoiBEb25vciBQb2xp
Y2llcyBhbmQgcHJvY2VkdXJlcw0K4oCiIENvbXBseWluZyB3aXRoIERvbm9yIA0KcHJvY2Vk
dXJlcw0K4oCiIERpc2J1cnNlbWVudCBtZXRob2RzDQrigKIgQmFua2luZzogTG9hbiBNYW5h
Z2VtZW50L1BheW1lbnQNCuKAoiANCkV4cGVuZGl0dXJlIEJ1ZGdldHMNCuKAoiBQcm9qZWN0
IEJ1ZGdldGluZyBhbmQgUGxhbm5pbmcNCuKAoiBQcm9qZWN0IEZpbmFuY2lhbCANCk1hbmFn
ZW1lbnQNCuKAoiBGaW5hbmNpYWwgUmlzayBBbmFseXNpcyBUZWNobmlxdWVzDQrigKIgRmlu
YW5jaWFsIFBlcmZvcm1hbmNlIA0KTWVhc3VyZW1lbnQNCuKAoiBCdWRnZXRpbmcgYW5kIEJ1
ZGdldGFyeSBDb250cm9sDQrigKIgSW50ZXJuYWwgQ29udHJvbCBhbmQgDQpDb250cm9sIE1l
Y2hhbmlzbXMNCuKAoiBJbnRlZ3JhdGVkIGFjY291bnRpbmcgJiBGaW5hbmNpYWwgU3lzdGVt
cw0K4oCiIA0KQWNjb3VudGluZyBwb2xpY2llcyBhbmQgc3lzdGVtcw0K4oCiIEF1ZGl0aW5n
IG9mIGZpbmFuY2lhbCBzdGF0ZW1lbnRzDQrigKIgDQpNYW5hZ2VtZW50IENvbnRyb2wgRnJh
bWV3b3JrDQrigKIgQXVkaXRvcuKAmXMgZHV0aWVzIGFuZCByZXNwb25zaWJpbGl0aWVzDQri
gKIgDQpLbm93bGVkZ2Ugb2YgdGhlIExhdyBpbiByZWxhdGlvbiB0byBhY2NvdW50cyBhbmQg
YXVkaXQNCuKAoiBJbnRlcm5hbCANCmNvbnRyb2xzDQrigKIgUmlzayBhc3Nlc3NtZW50DQri
gKIgQ29kZSBvZiBwcm9mZXNzaW9uYWwgQ29uZHVjdCBhbmQgRXRoaWNzDQrigKIgDQpQcmVw
YXJhdGlvbiBvZiBBdWRpdGluZyBQcm9jZWR1cmVzDQrigKIgUGxhbm5pbmcgYW5kIFB1Ymxp
c2hpbmcgdGhlIGF1ZGl0IA0Kc2NoZWR1bGUNCuKAoiBQZXJpb2RpYyByZXBvcnRzDQrigKIg
UHJvamVjdCBNYW5hZ2VtZW50IHJlcG9ydHMNCuKAoiBGaW5hbmNpYWwgDQpSZXBvcnRpbmcg
KFBlcmlvZGljIFJlcXVpcmVtZW50cykgDQrigKIgVGhlIHJvbGUgb2YgZ292ZXJubWVudCBp
biBkb25vciBmdW5kZWQgDQpwcm9qZWN0cy4NCsKgDQpHRU5FUkFMIA0KTk9URVMNCsOYwqAg
DQpUaGlzIA0KY291cnNlIGlzIGRlbGl2ZXJlZCBieSBvdXIgc2Vhc29uZWQgdHJhaW5lcnMg
d2hvIGhhdmUgdmFzdCBleHBlcmllbmNlIGFzIGV4cGVydCANCnByb2Zlc3Npb25hbHMgaW4g
dGhlIHJlc3BlY3RpdmUgZmllbGRzIG9mIHByYWN0aWNlLiBUaGUgY291cnNlIGlzIHRhdWdo
dCB0aHJvdWdoIA0KYSBtaXggb2YgcHJhY3RpY2FsIGFjdGl2aXRpZXMsIHRoZW9yeSwgZ3Jv
dXAgd29ya3MgYW5kIGNhc2UgDQpzdHVkaWVzLg0Kw5jCoCANClRyYWluaW5nIA0KbWFudWFs
cyBhbmQgYWRkaXRpb25hbCByZWZlcmVuY2UgbWF0ZXJpYWxzIGFyZSBwcm92aWRlZCB0byB0
aGUgDQpwYXJ0aWNpcGFudHMuDQrDmMKgIA0KVXBvbiANCnN1Y2Nlc3NmdWwgY29tcGxldGlv
biBvZiB0aGlzIGNvdXJzZSwgcGFydGljaXBhbnRzIHdpbGwgYmUgaXNzdWVkIHdpdGggYSAN
CmNlcnRpZmljYXRlLg0Kw5jCoCANCldlIA0KY2FuIGFsc28gZG8gdGhpcyBhcyB0YWlsb3It
bWFkZSBjb3Vyc2UgdG8gbWVldCBvcmdhbml6YXRpb24td2lkZSBuZWVkcy4gQ29udGFjdCAN
CnVzIHRvIGZpbmQgb3V0IA0KbW9yZTrCoHRyYWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmcN
CsOYwqAgDQpUaGUgDQp0cmFpbmluZyB3aWxsIGJlIGNvbmR1Y3RlZCBhdMKgU2tpbGxzIGZv
ciBBZnJpY2HCoFRyYWluaW5nIEluc3RpdHV0ZSBpbiANCk5haXJvYmkgS2VueWEuDQrDmMKg
IA0KVGhlIA0KdHJhaW5pbmcgZmVlIGNvdmVycyB0dWl0aW9uIGZlZXMsIHRyYWluaW5nIG1h
dGVyaWFscywgbHVuY2ggYW5kIHRyYWluaW5nIHZlbnVlLiANCkFjY29tbW9kYXRpb24gYW5k
IGFpcnBvcnQgdHJhbnNmZXIgYXJlIGFycmFuZ2VkIGZvciBvdXIgcGFydGljaXBhbnRzIHVw
b24gDQpyZXF1ZXN0Lg0Kw5jCoCANClBheW1lbnQgDQpzaG91bGQgYmUgc2VudCB0byBvdXIg
YmFuayBhY2NvdW50IGJlZm9yZSBzdGFydCBvZiB0cmFpbmluZyBhbmQgcHJvb2Ygb2YgcGF5
bWVudCANCnNlbnQgdG86wqB0cmFpbmluZ0Bza2lsbHNmb3JhZnJpY2Eub3JnDQrCoMKgDQo8
aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy91bnN1YnNjcmli
ZT9kPWoyZ1BpOVlNM0FwM3hZSnU4d1I3OFhUOHh1RkxuWDVMZGIwZHRTMnZEdENpcG55cHU3
MmIzVjVzZjAxOW9EbERTZmluNF9CN2dhakc0M1dLVGhjMHdLYUxIS3FFNE1HMlk0amlwQXVK
MXUzMDA+DQpVTlNVQlNDUklCRQ==

--=-eZCfNVbCqyjrIeabc/YVO3DK8xRk+fcN23WKzQ==
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
nt: para-border-div"><?xml:namespace=20
prefix =3D "o" ns =3D "urn:schemas-microsoft-com:office:office" /><o:p=
>
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
pt 0cm"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri; mso-ascii-fon=
t-family: Calibri; mso-hansi-font-family: Calibri; mso-ascii-theme-fon=
t: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28InTT9gwD20k6bvkkAH5l_1ZEvStHz6rIn-E2=
PjwQmMxyiIa1TNw3rJ3-sCJxm0Pd8xo0BPzZqkmtFIhHGST-ZSuNMgwcO804dWpke4U5oV=
UFM1"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'mso-fareast-font-family: "Times New Roman"'><FONT face=3DCali=
bri>Advanced=20
Financial Management, Grants Management and Auditing for Donor Funded =
Projects=20
on 7th to 18th November 2022<o:p></o:p></FONT></SPAN></B></A></SPAN></=
P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgLBTBYtFuZ7SrdN=
Rq7YIMZo0VTdlklNvgQ0lbPR5XIvBdzW0UavgW9Ii-z6RS87tiqyG7_ewEsSEEx_lLlrFw=
1xHeApe64i1UuHHAxwPX9Cmn0" target=3D_blank><SPAN=20
style=3D"TEXT-DECORATION: none; text-underline: none"><FONT face=3DCal=
ibri>Register=20
for online workshop attendance <o:p></o:p></FONT></SPAN></A></SPAN></U=
></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-farea=
st-font-family: "Times New Roman"; mso-ascii-theme-font: minor-latin; =
mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><=
A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgLBTBYtFuZ7SrdN=
Rq7YIMZg5tVHqdnkDTs8iZuu5Pd5o6F8SL0RwaplhaUMfzGyh8pDjGmBBLQ4go5O4-oShY=
CkbZLYr6HwC5ZsMFP9wBYWQV0"=20
target=3D_blank>&nbsp;<o:p></o:p></A></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgLBTBYtFuZ7SrdN=
Rq7YIMZoqXQFDVwfAc6nWS_Xrn8KXb9KwGSKToNmN6CBC8sopycCQ2aFCwQ7lS7xjsElyo=
386AJqJ0DL1IsRkyAUWRk5lD0" target=3D_blank><SPAN=20
style=3D"TEXT-DECORATION: none; text-underline: none"><FONT face=3DCal=
ibri>Register=20
to attend the workshop<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-farea=
st-font-family: "Times New Roman"; mso-ascii-theme-font: minor-latin; =
mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><=
A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPeQTMP_worAH4lwgBlMZKgLBTBYtFuZ7SrdN=
Rq7YIMZteE-tYePw0XnlVPhD0EGMpbKYr6aIYlUbpjaHkyZfDvktH5n70UFLVvnssOlQvM=
Iq9Y0A98a7V-CE5u5dJPM3MO0"=20
target=3D_blank>&nbsp;<o:p></o:p></A></SPAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxV1uMclbYM-pVBU=
8qfNo_7aWvIgJU3XyeivlWv1Ir9_0X_fLPTfQip-FtMjx2ng4UTle-Pf3cqBzQlvsrJL3v=
m2M1" target=3D_blank><FONT=20
face=3DCalibri>Calendar for 2022/2023=20
Workshops<o:p></o:p></FONT></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDAjBcIyvdFJ5e0oD=
gmwVfocfyCS1mNcXEzHnVyFkJzB5zq0lL9Ho1BC2SQhcpfYs_lRQgMa0H6G-aZ4ThlaBEt=
gJo1" target=3D_blank><FONT=20
face=3DCalibri>Contact us<o:p></o:p></FONT></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejijczfTfAqTiL9aVsNY1_mdn2yDkkfbtDTr-Q=
iwJIpUa7stEMJZYFdA519eYG9fTPuLeDIiYv-oqJVhd47WHQ8kcI9NMWS1MD3JVUTE3h2z=
-IM1" target=3D_blank><FONT=20
face=3DCalibri>Whatapp<o:p></o:p></FONT></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>VENUE: BEST WESTERN MERIDIAN HOTEL, NAIROBI,=20
KENYA<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>COURSE FEE: 2,400USD<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>Office Telephone: +254-702-249-449<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>Send us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMWN8DD2uI2HWuCdI2NJT=
uw1uV-ue8UpbOP5bfonsCK9U43RWrhs83CF7VV6MB7U8Pg1IBisAIjQM8RAdLKtE1Srvs6=
oSKBOsSvV-k2Gxs_fQR0" ><FONT=20
face=3DCalibri>training@skillsforafrica.org&nbsp;</FONT></A><FONT face=
=3DCalibri>or=20
call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 12pt 0cm 0pt; LINE-HEIGHT: norma=
l"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'>INTRODUCTIO=
N</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><o:p></o:p>=
</SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 5.25pt; LINE-HEIGHT: 15pt"=
><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>This course is designed to enable those involved with g=
rant=20
management to become efficient and effective in the acquisition and ut=
ilization=20
of funds for development purposes, using appropriate techniques and ap=
plication=20
of accounting and finance principles.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 12pt; LINE-HEIGHT: 15pt"><=
FONT=20
face=3DCalibri><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'>WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><o:p></o:p>=
</SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 5.25pt; LINE-HEIGHT: 15pt"=
><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>Finance Directors, Finance Managers, Procurement Direct=
ors,=20
Procurement managers, Procurement officers, Administrators, Project of=
ficers,=20
Budget Accountants, Auditors, Chief Accountants, Credit=20
Controllers<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 12pt; LINE-HEIGHT: 17.15pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>COURSE OBJECTIVES</FONT></SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><BR><FONT=20
face=3DCalibri>At the end of the course, participants will be able to:=
<BR>&#8226;=20
Identify and understand the critical terms and conditions of grant aid=
; for=20
donor-funded projects<BR>&#8226; Ensure compliance with donor terms an=
d=20
conditions;<BR>&#8226; Providing supporting documents, correct procure=
ment of goods=20
and services and meeting financial reporting requirements;<BR>&#8226; =
Managing=20
multiple-funded programmes<BR>&#8226; Provide tools for efficient Mana=
gement of Donor-=20
funded project<BR>&#8226; Design and monitor donor budgets<BR>&#8226; =
Prepare a donor=20
financial report to match with a project narrative report;<BR>&#8226; =
Describe the=20
phases in the grant management cycle clarify key responsibilities and =
routines=20
needed for successful grant management;<BR>&#8226; Identify the requir=
ements for=20
closing off a donor grant;<BR>&#8226; Manage the relationship with don=
ors, head office=20
and implementing partners with greater confidence;<BR>&#8226; Apprecia=
te that finance=20
and programme staff must work closely for Successful grant=20
management.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 12pt; LINE-HEIGHT: 16.5p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'>DURATION</S=
PAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><o:p></o:p>=
</SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 12pt; LINE-HEIGHT: 16.5p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>10 Days<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>COURSE CONTENT:</FONT></SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><BR><FONT=20
face=3DCalibri>&#8226; Overview of Grants Management Cycle<BR>&#8226; =
Developing proposal<BR>&#8226;=20
Budgeting<BR>&#8226; Types of costs<BR>&#8226; Grant Award Contract,<B=
R>&#8226; Award Review,<BR>&#8226;=20
Fundraising Tips, Implementation, Compliance<BR>&#8226; Eligible and i=
neligible=20
costs,<BR>&#8226; Cost Share/ Matching costs,<BR>&#8226; Procurement P=
rocedures,<BR>&#8226; Grant=20
Tracking Tools, :<BR>&#8226; Costs eligibility, administration<BR>&#82=
26; Programme=20
evaluation<BR>&#8226; Grant Reporting,<BR>&#8226; Financial Documentat=
ion and Reporting<BR>&#8226;=20
Documentation, Internal Controls; Audit, Narrative Reporting, Partners=
hips &amp;=20
consortia management, Donor Compliance,<BR>&#8226; Personnel &amp;Staf=
f Issues=20
(ethics) : Contracts, Time sheets, Travel &amp; Per diem: Itinerary, a=
ssigning,=20
Assets &amp; Inventory Management, Co-Financing &amp;<BR>&#8226; Multi=
- Donor Funding,=20
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
management<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>&#8226; Community Development and Projects funding<BR>&=
#8226; Funding=20
requirements<BR>&#8226; Project finance<BR>&#8226; Capital Budgeting a=
nd Investment=20
Appraisal<BR>&#8226; Donor Policies and procedures<BR>&#8226; Complyin=
g with Donor=20
procedures<BR>&#8226; Disbursement methods<BR>&#8226; Banking: Loan Ma=
nagement/Payment<BR>&#8226;=20
Expenditure Budgets<BR>&#8226; Project Budgeting and Planning<BR>&#822=
6; Project Financial=20
Management<BR>&#8226; Financial Risk Analysis Techniques<BR>&#8226; Fi=
nancial Performance=20
Measurement<BR>&#8226; Budgeting and Budgetary Control<BR>&#8226; Inte=
rnal Control and=20
Control Mechanisms<BR>&#8226; Integrated accounting &amp; Financial Sy=
stems<BR>&#8226;=20
Accounting policies and systems<BR>&#8226; Auditing of financial state=
ments<BR>&#8226;=20
Management Control Framework<BR>&#8226; Auditor&rsquo;s duties and res=
ponsibilities<BR>&#8226;=20
Knowledge of the Law in relation to accounts and audit<BR>&#8226; Inte=
rnal=20
controls<BR>&#8226; Risk assessment<BR>&#8226; Code of professional Co=
nduct and Ethics<BR>&#8226;=20
Preparation of Auditing Procedures<BR>&#8226; Planning and Publishing =
the audit=20
schedule<BR>&#8226; Periodic reports<BR>&#8226; Project Management rep=
orts<BR>&#8226; Financial=20
Reporting (Periodic Requirements) <o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><FONT=20
face=3DCalibri>&#8226; The role of government in donor funded=20
projects.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'>GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; mso-fareast-font-family: "Times New Roman"; =
mso-bidi-font-family: Calibri; mso-ascii-font-family: Calibri; mso-han=
si-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-hansi-=
theme-font: minor-latin; mso-bidi-theme-font: minor-latin'><o:p></o:p>=
</SPAN></FONT></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>This=20
course is delivered by our seasoned trainers who have vast experience =
as expert=20
professionals in the respective fields of practice. The course is taug=
ht through=20
a mix of practical activities, theory, group works and case=20
studies.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Training=20
manuals and additional reference materials are provided to the=20
participants.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Upon=20
successful completion of this course, participants will be issued with=
 a=20
certificate.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>We=20
can also do this as tailor-made course to meet organization-wide needs=
. Contact=20
us to find out=20
more:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>The=20
training will be conducted at&nbsp;Skills for Africa&nbsp;Training Ins=
titute in=20
Nairobi Kenya.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>The=20
training fee covers tuition fees, training materials, lunch and traini=
ng venue.=20
Accommodation and airport transfer are arranged for our participants u=
pon=20
request.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Payment=20
should be sent to our bank account before start of training and proof =
of payment=20
sent to:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></SPAN></P=
>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><o:p>&nbsp;</o:p></P>&nbsp;</o:p>=
</DIV></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3DQ=
Tw5mGfAey_Z29kApfLiHw2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3Dj2gPi9YM3Ap3xYJu8wR78XT8xuFLnX5Ldb0dtS2vDtCipnypu72b3V5sf0=
19oDlDSfin4_B7gajG43WKThc0wKaLHKqE4MG2Y4jipAuJ1u300" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfNVbCqyjrIeabc/YVO3DK8xRk+fcN23WKzQ==--
