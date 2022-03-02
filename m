Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C37574CA103
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 10:42:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7pzt6qdPz3brF
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 20:42:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=gc3Mffhl;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=VqClmlHn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.87.24;
 helo=n24.mxout.mta4.net;
 envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=bounces.elasticemail.net
 header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api
 header.b=gc3Mffhl; dkim=pass (1024-bit key;
 unprotected) header.d=elasticemail.com header.i=@elasticemail.com
 header.a=rsa-sha256 header.s=api header.b=VqClmlHn; 
 dkim-atps=neutral
X-Greylist: delayed 82 seconds by postgrey-1.36 at boromir;
 Wed, 02 Mar 2022 20:41:58 AEDT
Received: from n24.mxout.mta4.net (n24.mxout.mta4.net [67.227.87.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7pzp5H3Qz3bgS
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Mar 2022 20:41:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
 c=relaxed/simple; t=1646214009;
 h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
 bh=HDnVgl077nPRjuoyTpkz3j7kh+2bGidq0L+huUzW2sQ=;
 b=gc3MffhlxntdW89io/q5D9CHA02IqIGjdKjdrk7pZ+j2xgLMovgcOI7ZJzmPgDGbHePh+ADL4a9
 a8zAjzjhvvFE3CekN7poVKwUR4xzxgti1XsmD5Dya/L51NpCOTs0wpfKVyyLJD++b3ttNFya823mN
 hEGQmwIkDi1+55n3tVw=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
 c=relaxed/simple; t=1646214009;
 h=from:date:subject:reply-to:to:list-unsubscribe;
 bh=HDnVgl077nPRjuoyTpkz3j7kh+2bGidq0L+huUzW2sQ=;
 b=VqClmlHnYuIInkGhZlLsBhorZXJdKdBs07tYAlP8+Uw+0sPENF6PlPE0sUktT1vgc4BflPme7oD
 J7K/GCAsioDGnhjKsYciO+MNdAZs3ZdAC48RAz3MWqW0s8ni2RxOgcvd8C+v3B8Q7Gzei8xZBTaBM
 /fh+yZ66igiN8dE7QQI=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Wed, 02 Mar 2022 09:40:09 +0000
Subject: INVITATION TO ATTEND AN INTERNATIONAL TRAINING WORKSHOP ON MONITORING
 AND EVALUATION FOR DEVELOPMENT RESULTS 4TH =?iso-8859-1?b?4oCT?= 15TH
 APRIL 2022
Message-Id: <4ug7ndtcpjze.vHFMwtM2KWU0p9xJNbq03A2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: vHFMwtM2KWU0p9xJNbq03A2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=-eZCfEkrz0zLYCpW1Xfx/eXDZ+CpgxK527XWKzQ=="
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

--=-eZCfEkrz0zLYCpW1Xfx/eXDZ+CpgxK527XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4SlVhbGlqTVhp
UktuUjZtUkxfYTRSbXJ6c1A1SXRVZ0hjTVBpU0s5LXVkSmNYNVRvelEyYWxqR1VNQ0h4TXlp
YUxCMDNabUVLLVgxQTFxTFp2OUFZWHRQLXJva3YtUkkwUHdyNlc3dTU5MllNVTE+DQpJTlRF
Uk5BVElPTkFMIFRSQUlOSU5HIFdPUktTSE9QIE9OIA0KTU9OSVRPUklORyBBTkQgRVZBTFVB
VElPTiBGT1IgREVWRUxPUE1FTlQgUkVTVUxUUyA0VEgg4oCTIA0KMTVUSCBBUFJJTCAyMDIy
DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0T0I4QlYtaXlP
UjR2VlF4MG9QbTJFY0ZrRmdhODA2T2xaQWdDTkhybkV0Nm0xMldJTTN0MVc4XzlYcUZVTTJR
UHpNQ25VV3c4dEVHcnVGdEZJR1ZYNmxLMUpZMnZRWURtUlNucHFYM013cGNGM0ZwVHY1THh1
WGJYdnVXSDhtVlhoXzA+DQpSZWdpc3RlciBmb3IgDQpvbmxpbmUgd29ya3Nob3AgYXR0ZW5k
YW5jZSANCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNr
aW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0
T2JDcUNHc3FMWVM2dDgtYnVXYmd2REVKU00wMlNId3Exb1Rmak8tZkh0dTVRdThyU3RvSEN5
OU9IUkJDZ0VvUjVhQ05ySVg2RDZFeXYzQ2NocDNhQzFoMGRQNWdEMDNiNWttSG5CZVVEcUdn
SXA2Z2dLZWR5SE9wZlhnZHcwVDdPSjA+DQpSZWdpc3RlciB0byANCmF0dGVuZCB0aGUgd29y
a3Nob3ANCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNr
aW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1L
TTg5bVBvY3pSRmlKMFlJU0YtYVZ1VGZuNVNjcmc3eTFCd0FKVU9GV3JOTUV6MERCNldhTFZr
NXRZWGR2THJTQUFCLVFwRFVfMFB1aEx3V3V4emtxb2RhR2RQVzk2WERuaVkwMkVWdHR2V25V
ODE+DQpDYWxlbmRhciBmb3IgMjAyMiANCldvcmtzaG9wcw0KwqANCg0KPGh0dHBzOi8vMTMz
SUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD00UlNPR2VTNUhJNktG
Sml4UXB5a1VIN1NCRFNqMEEyRWRIZGNxcUVrLUtQUmJ3Y1VpZGt2QlV4eEFTaks1UEo4UHZL
TnlXNU0wdGJtbGhQdGhJZUZDbzRpV1VTYnYyWHZwa001bFg4X0ZHNnZOSzhXWElCM2NIbkZS
T3FCMlJFN1JsdEtuc19La2Z6Q2xCbzhGbWJPLW5nMT4NCkNvbnRhY3QgDQp1cw0KwqANCg0K
PGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1U
ZE8xZ0N1UTcxaHBXTDYwQldObnR1d2YySVdKZmtfa0pRX09leDVfZWppX2xwcmxRYmhiTTRU
Z0x0eDlmQjJjdjNJSVltVGZ5c0tmSV9jOHVZdW51RFNvd2JuWkRVblNyY0lVR0ViWTRkMEsw
WHYxNW8wU1dNTkI3bDA1SXg2RVkyeG5jbU5fUmt3Rm00R0toN014a3dJMT4NCldoYXRhcHDC
oCANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xp
Y2s/ZD1UZE8xZ0N1UTcxaHBXTDYwQldObnR1d2YySVdKZmtfa0pRX09leDVfZWppX2xwcmxR
YmhiTTRUZ0x0eDlmQjJjR2V1Ul9SbGRpX1JUWW9lOXRVX0diLXlZSEYzMTBPcTlMTFZyeHRm
UkJMb1ZKV3lnSjhKQjl6V3NZY1lzblZ1MWtGa1hFY1oyT3dLSW1EN1RPMmpEYjJIU19vUE94
cW5wTzVaVHI0aGl6SnRvMD4NCsKgDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1h
aWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9VGRPMWdDdVE3MWhwV0w2MEJXTm50dXdmMklXSmZr
X2tKUV9PZXg1X2VqaV9scHJsUWJoYk00VGdMdHg5ZkIyY0kxYTBiN2NSbDJta21IQ2Z2VVEt
eV81Z3lTbnQ3UTAxbnZWQzQtSHhKVkVkRHo2ODZ5M1JxSTEwT29fbVJ3R3UtdVRXdW95aV90
YVhGTkNJU0x1Q3d0TjFoaXl5V2dySU9DRFU2UVFtWmN0NzA+DQpQQVJUSUNJUEFUSU9OIEZF
RVM6IA0KMjQwMFVTRA0KwqANClZFTlVFOiANClZJTExBIFJPU0EgS0VNUElOU0tJLCBOQUlS
T0JJLCBLRU5ZQQ0KT2ZmaWNlIA0KVGVsZXBob25lOiArMjU0LTcwMi0yNDktNDQ5DQpSZWdp
c3RlciANCmFzIGEgZ3JvdXAgb2YgNSBvciBtb3JlIHBhcnRpY2lwYW50cyBhbmQgZ2V0IDI1
JSBkaXNjb3VudCBvbiB0aGUgY291cnNlIGZlZS4gDQoNClNlbmQgDQp1cyBhbiBlbWFpbDog
DQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9k
PW9CSEZTMU5HSnBHd1pMUURHUDJ2RzJUb0R3X3JKXzFTYThIRXZnRnBIVVF6ZHgyYzFWMmgw
M21kb2huSlpBTmEzTzloMzJSQ0dHZkVEMURWYWJuQWROVFdwLXZOTGkzX0ttRFItb0V2Y2E2
aU50RzZ0V2t4bTJ5bjQtVWRIZFM1M0hNNlRYVGJ2XzZZWWdhTkdBYjYzV2hwWUEtcTRoVUlw
YWZlajFPVFBZSklVUE5nQWxsWHRId0pEaWlOMVZkcE1BMj4NCnRyYWluaW5nQHNraWxsc2Zv
cmFmcmljYS5vcmfCoG9yIA0KY2FsbCArMjU0LTcwMi0yNDktNDQ5DQpJTlRST0RVQ1RJT04N
ClRoaXMgDQpjb3Vyc2UgZm9jdXNlcyBvbiBlcXVpcHBpbmcgbW9uaXRvcmluZyBhbmQgZXZh
bHVhdGlvbiBza2lsbHMgdG8gYWxsIHdobyANCnVuZGVydGFrZSBpdC4gTW9uaXRvcmluZyBh
bmQgZXZhbHVhdGlvbiBza2lsbHMgYXJlIG9uIGRlbWFuZCBpbiB0aGUgY3VycmVudCANCmNv
bXBldGl0aXZlIGJ1c2luZXNzIG1hcmtldC4gVGh1cywgb24gY29tcGxldGlvbiBvZiB0aGlz
IGNvdXJzZSB0aGUgcGFydGljaXBhbnQgDQpzaGFsbCBhY3F1aXJlIHNraWxscyBpbiBtb25p
dG9yaW5nIGFuZCBldmFsdWF0aW9uIHRoYXQgd2lsbCBnYWluIHRoZW0gYSANCmNvbXBldGl0
aXZlIGFkdmFudGFnZSBpbiB0aGUgYnVzaW5lc3MgbWFya2V0Lg0KQ09VUlNFIA0KT0JKRUNU
SVZFUw0KQnkgDQp0aGUgZW5kIG9mIHRoaXMgY291cnNlIHRoZSBwYXJ0aWNpcGFudHMgd2ls
bCBiZSBhYmxlIHRvOg0Kw5jCoCANCkRldmVsb3AgYSBtb25pdG9yaW5nIGFuZCBldmFsdWF0
aW9uIHN5c3RlbQ0Kw5jCoCANClVuZGVyc3RhbmQgbWFuYWdlbWVudCBvZiBvcGVyYXRpb25z
IGZyb20gaW5zaWdodCBpbnRvIA0KbXVsdGlsYXRlcmFsIGNvcnBvcmF0aW9uDQrDmMKgIA0K
R2FpbiBmYW1pbGlhcml0eSBpbnRvIG1lYXN1cmVzIHN1Y2ggYXMgY3JlZGliaWxpdHksIA0K
cmVsaWFiaWxpdHksIHZhbGlkaXR5LCBhbmQgcHJlY2lzaW9uLg0Kw5jCoCANCkxlYXJuIHRo
ZSB1c2FnZSBvZiBkYXRhIGFuYWx5c2lzIHNvZnR3YXJlIHBhY2thZ2UgDQooU3RhdGEpDQrD
mMKgIA0KRXN0YWJsaXNoIHN0cmF0ZWdpZXMgaW4gZGF0YSBjb2xsZWN0aW9uDQrDmMKgIA0K
VW5kZXJzdGFuZCB0aGUgdXNlIG9mIEdJUyBhbmQgR1BTIGluwqBkYXRhIA0KY29sbGVjdGlv
bg0Kw5jCoCANCkludGVyYWN0IHdpdGggaW5kaXZpZHVhbCBmcm9tIGFsbCBvdmVyIHRoZSB3
b3JsZCB3aXRoIA0Kc2ltaWxhciBnb2FscyBvZiBvYnRhaW5pbmcgbW9uaXRvcmluZyBhbmQg
ZXZhbHVhdGlvbiBza2lsbHMNCkRVUkFUSU9ODQoxMCANCkRheXMNCldITyANClNIT1VMRCBB
VFRFTkQNClRoZSANCmNvdXJzZSB0YXJnZXRzIHJlc2VhcmNoZXJzLCBOR09zIHByb2plY3Qg
bWFuYWdlbWVudCBvZmZpY2lhbHMsIG1pbmlzdHJpZXMgaW4gDQpnb3Zlcm5tZW50cywgZmlu
YW5jaWFsIGluc3RpdHV0aW9ucywgYW5kIG5hdGlvbmFsIHN0YXRpc3RpY3Mgb2ZmaWNlcnMg
YW5kIA0Kdm9sdW50ZWVycyB3aG8gd2FudCB0byBhY3F1aXJlIG1vbml0b3JpbmcgYW5kIGV2
YWx1YXRpb24gDQpza2lsbHMuDQpDT1VSU0UgDQpPVVRMSU5FDQpNIA0KJiBFIGZ1bmRhbWVu
dGFscw0Kw5jCoCANCk0gJiBFIGludHJvZHVjdGlvbg0Kw5jCoCANCk0gJkUgY29yZSBjb21w
b25lbnRzDQrDmMKgIA0KSW50ZWdyYXRpbmcgTSAmIEUgaW4gdGhlIHByb2plY3QgY3ljbGUN
CsOYwqAgDQpEZXRlcm1pbmluZyB0aGUgc2hvcnRjb21pbmdzIGZhY2VkIGJ5IE0gJiBFIA0K
cHJvZmVzc2lvbmFscw0KVHJlbmRzIA0KdG93YXJkcyByZXN1bHQgYmFzZWQgTSAmIEUNCsOY
wqAgDQpJbnRyb2R1Y3Rpb24gdG8gTWFuYWdpbmcgZm9yIERldmVsb3BtZW50IHJlc3VsdHMg
DQooTUZEUikNCsOYwqAgDQpQcmluY2lwbGVzIG9mIE1ERlINCsOYwqAgDQpSZXN1bHRzIGJh
c2VkIG1hbmFnZW1lbnQNClJlc3VsdCANCmJhc2VkIE0gJiBFIGludHJvZHVjdGlvbg0Kw5jC
oCANClVuZGVyc3RhbmRpbmcgcmVzdWx0cyBiYXNlZCBtYW5hZ2VtZW50IChSQk0pDQrDmMKg
IA0KRWxlbWVudHMgb2YgcmVzdWx0IGJhc2VzIE0gJiBFIGNyZWF0aW9uDQrDmMKgIA0KQ3lj
bGUgb2YgcmVzdWx0IGJhc2VkIE0gJiBFDQrDmMKgIA0KTWVhc3VyaW5nIHJlc3VsdHMNCsOY
wqAgDQpQZXJmb3JtYW5jZSBtZWFzdXJlbWVudCwgaW5kaWNhdG9ycywgYW5kIA0KbW9uaXRv
cmluZw0KU2l0dWF0aW9uIA0KYXNzZXNzbWVudA0Kw5jCoCANCkZvcm1hdGl2ZSBzdHVkeSBh
bmQgYW5hbHlzaXMNCsOYwqAgDQpJbGx1c3RyYXRpdmUgZXhhbXBsZXMNCsOYwqAgDQpTaXR1
YXRpb24gYXNzZXNzbWVudCB0b29scw0KQXNzZXNzbWVudCANCm9mIGJhc2VsaW5lDQrDmMKg
IA0KVW5kZXJzdGFuZGluZyBiYXNlbGluZSBzdHVkeQ0Kw5jCoCANCkJhc2VsaW5lIHN0dWR5
IGltcG9ydGFuY2UNCsOYwqAgDQpCYXNlbGluZSBkYXRhIGFuZCBjb2xsZWN0aW9uIG1ldGhv
ZHMNCsOYwqAgDQpEaWZmZXJlbmNlIGJldHdlZW4gc2l0dWF0aW9uIGFzc2Vzc21lbnQgYW5k
IGJhc2VsaW5lIA0Kc3R1ZHkNCk0gDQomIEUgc3lzdGVtIGRlc2lnbmluZw0Kw5jCoCANCkZy
YW1ld29ya3Mgb2YgTSAmIEUNCsOYwqAgDQpJbXBhY3QgcGF0aHdheXMNCsOYwqAgDQpUaGUg
Y2hhbmdlIHRoZW9yeQ0KTW9uaXRvcmluZyANCnBlcmZvcm1hbmNlDQrDmMKgIA0KUHJvY2Vz
cyBvZiBwZXJmb3JtYW5jZSBtb25pdG9yaW5nDQrDmMKgIA0KVG9vbHMgdXNlZCBpbiBwZXJm
b3JtYW5jZSBtb25pdG9yaW5nDQpUZWNobmlxdWVzIA0Kb2YgZXZhbHVhdGlvbg0Kw5jCoCAN
CkNhc2Ugc3R1ZHkNCsOYwqAgDQpFY29ub21pY2FsIGV2YWx1YXRpb24NCsOYwqAgDQpDb21t
dW5pY2F0aW9uIG9mIGZpbmRpbmdzDQpHSVMgDQp0ZWNobmlxdWVzIGZvciBNICYgRSBvZiBk
ZXZlbG9wbWVudCBwcm9ncmFtcw0Kw5jCoCANCkdlb2dyYXBoaWNhbCBhcHByb2FjaGVzDQrD
mMKgIA0KQWR2YW50YWdlcyBvZiBHSVMgdG8gTSAmIEUNCsOYwqAgDQpBbmFseXNpcyBhbmQg
bWFwcGluZyBvZiBHSVMNCsOYwqAgDQpHSVMgc29mdHdhcmUgYW5kIGRhdGENCkdFTkVSQUwg
DQpOT1RFUw0Kw5jCoCANClRoaXMgY291cnNlIGlzIGRlbGl2ZXJlZCBieSBvdXIgc2Vhc29u
ZWQgdHJhaW5lcnMgd2hvIGhhdmUgDQp2YXN0IGV4cGVyaWVuY2UgYXMgZXhwZXJ0IHByb2Zl
c3Npb25hbHMgaW4gdGhlIHJlc3BlY3RpdmUgZmllbGRzIG9mIHByYWN0aWNlLiANClRoZSBj
b3Vyc2UgaXMgdGF1Z2h0IHRocm91Z2ggYSBtaXggb2YgcHJhY3RpY2FsIGFjdGl2aXRpZXMs
IHRoZW9yeSwgZ3JvdXAgd29ya3MgDQphbmQgY2FzZSBzdHVkaWVzLg0Kw5jCoCANClRyYWlu
aW5nIG1hbnVhbHMgYW5kIGFkZGl0aW9uYWwgcmVmZXJlbmNlIG1hdGVyaWFscyBhcmUgDQpw
cm92aWRlZCB0byB0aGUgcGFydGljaXBhbnRzLg0Kw5jCoCANClVwb24gc3VjY2Vzc2Z1bCBj
b21wbGV0aW9uIG9mIHRoaXMgY291cnNlLCBwYXJ0aWNpcGFudHMgDQp3aWxsIGJlIGlzc3Vl
ZCB3aXRoIGEgY2VydGlmaWNhdGUuDQrDmMKgIA0KV2UgY2FuIGFsc28gZG8gdGhpcyBhcyB0
YWlsb3ItbWFkZSBjb3Vyc2UgdG8gbWVldCANCm9yZ2FuaXphdGlvbi13aWRlIG5lZWRzLiBD
b250YWN0IHVzIHRvIGZpbmQgb3V0IA0KbW9yZTrCoHRyYWluaW5nQHNraWxsc2ZvcmFmcmlj
YS5vcmcNCsOYwqAgDQpUaGUgdHJhaW5pbmcgd2lsbCBiZSBjb25kdWN0ZWQgYXTCoFNraWxs
cyBmb3IgDQpBZnJpY2HCoFRyYWluaW5nIEluc3RpdHV0ZSBpbiBOYWlyb2JpIEtlbnlhLg0K
w5jCoCANClRoZSB0cmFpbmluZyBmZWUgY292ZXJzIHR1aXRpb24gZmVlcywgdHJhaW5pbmcg
bWF0ZXJpYWxzLCANCmx1bmNoIGFuZCB0cmFpbmluZyB2ZW51ZS4gQWNjb21tb2RhdGlvbiBh
bmQgYWlycG9ydCB0cmFuc2ZlciBhcmUgYXJyYW5nZWQgZm9yIA0Kb3VyIHBhcnRpY2lwYW50
cyB1cG9uIHJlcXVlc3QuDQrDmMKgIA0KUGF5bWVudCBzaG91bGQgYmUgc2VudCB0byBvdXIg
YmFuayBhY2NvdW50IGJlZm9yZSBzdGFydCBvZiANCnRyYWluaW5nIGFuZCBwcm9vZiBvZiBw
YXltZW50IHNlbnQgDQp0bzrCoHRyYWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmcNCjxodHRw
czovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9
WHE0SFpGdlgyU1NKbWNEWEZka0Z0a2M2VlZ0azNFdnJOM19ycUM5a2tKaV80UjYtY2xLRVlp
RDhmSjViMkJMSDhvMlZ5cWRpZk9Nc2hVTzJBSEQ5eHJZVnB6aDZFT2QtcWRUdzVKc3hrRnZm
MD4NClVOU1VCU0NSSUJF

--=-eZCfEkrz0zLYCpW1Xfx/eXDZ+CpgxK527XWKzQ==
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
solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0pt 0cm"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28JUalijMXiRKnR6mRL_a4RmrzsP5ItUgHcMPi=
SK9-udJcX5TozQ2aljGUMCHxMyiaLB03ZmEK-X1A1qLZv9AYXtP-rokv-RI0Pwr6W7u592=
YMU1">INTERNATIONAL TRAINING WORKSHOP ON=20
MONITORING AND EVALUATION FOR DEVELOPMENT RESULTS 4<SUP>TH</SUP> &#821=
1;=20
15<SUP>TH</SUP> APRIL 2022</A><?xml:namespace prefix =3D "o" ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></B></P>=
</DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOB8BV-iyOR4vVQx0oPm2EcFkFga806OlZAgC=
NHrnEt6m12WIM3t1W8_9XqFUM2QPzMCnUWw8tEGruFtFIGVX6lK1JY2vQYDmRSnpqX3Mwp=
cF3FpTv5LxuXbXvuWH8mVXh_0" target=3D_blank>Register for=20
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
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtObCqCGsqLYS6t8-buWbgvDEJSM02SHwq1oTf=
jO-fHtu5Qu8rStoHCy9OHRBCgEoR5aCNrIX6D6Eyv3Cchp3aC1h0dP5gD03b5kmHnBeUDq=
GgIp6ggKedyHOpfXgdw0T7OJ0" target=3D_blank>Register to=20
attend the workshop<o:p></o:p></A></SPAN></U></P>
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
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KM89mPoczRFiJ0YISF-aVuTfn5Scrg7y1BwAJ=
UOFWrNMEz0DB6WaLVk5tYXdvLrSAAB-QpDU_0PuhLwWuxzkqodaGdPW96XDniY02EVttvW=
nU81" target=3D_blank>Calendar for 2022=20
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
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KPRbwcUidkvBUxxASjK5PJ8PvKNyW5M0tbmlh=
PthIeFCo4iWUSbv2XvpkM5lX8_FG6vNK8WXIB3cHnFROqB2RE7RltKns_KkfzClBo8FmbO=
-ng1" target=3D_blank>Contact=20
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
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_eji_lprlQbhbM4TgLtx9fB2cv3IIYmTfysKfI_=
c8uYunuDSowbnZDUnSrcIUGEbY4d0K0Xv15o0SWMNB7l05Ix6EY2xncmN_RkwFm4GKh7Mx=
kwI1" target=3D_blank>Whatapp<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></A></SPAN></U></=
P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_eji_lprlQbhbM4TgLtx9fB2cGeuR_Rldi_RTYo=
e9tU_Gb-yYHF310Oq9LLVrxtfRBLoVJWygJ8JB9zWsYcYsnVu1kFkXEcZ2OwKImD7TO2jD=
b2HS_oPOxqnpO5ZTr4hizJto0" target=3D_blank><o:p><SPAN=20
style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; BACKGR=
OUND: lime; mso-fareast-font-family: "Times New Roman"; mso-highlight:=
 lime'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_eji_lprlQbhbM4TgLtx9fB2cI1a0b7cRl2mkmH=
CfvUQ-y_5gySnt7Q01nvVC4-HxJVEdDz686y3RqI10Oo_mRwGu-uTWuoyi_taXFNCISLuC=
wtN1hiyyWgrIOCDU6QQmZct70" target=3D_blank>PARTICIPATION FEES:=20
2400USD<SPAN=20
style=3D"BACKGROUND: windowtext; mso-highlight: windowtext"><o:p></o:p=
></SPAN></A></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>VENUE:=20
VILLA ROSA KEMPINSKI, NAIROBI, KENYA<o:p></o:p></SPAN></B></P>
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
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DoBHFS1N=
GJpGwZLQDGP2vG2ToDw_rJ_1Sa8HEvgFpHUQzdx2c1V2h03mdohnJZANa3O9h32RCGGfED=
1DVabnAdNTWp-vNLi3_KmDR-oEvca6iNtG6tWkxm2yn4-UdHdS53HM6TXTbv_6YYgaNGAb=
63WhpYA-q4hUIpafej1OTPYJIUPNgAllXtHwJDiiN1VdpMA2" >training@skillsfora=
frica.org&nbsp;</A>or=20
call +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>INTRODUCTION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>This=20
course focuses on equipping monitoring and evaluation skills to all wh=
o=20
undertake it. Monitoring and evaluation skills are on demand in the cu=
rrent=20
competitive business market. Thus, on completion of this course the pa=
rticipant=20
shall acquire skills in monitoring and evaluation that will gain them =
a=20
competitive advantage in the business market.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>By=20
the end of this course the participants will be able to:<o:p></o:p></S=
PAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Develop a monitoring and evaluation system<o:p></=
o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Understand management of operations from insight =
into=20
multilateral corporation<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Gain familiarity into measures such as credibilit=
y,=20
reliability, validity, and precision.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Learn the usage of data analysis software package=
=20
(Stata)<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Establish strategies in data collection<o:p></o:p=
></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Understand the use of GIS and GPS in&nbsp;data=20
collection<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 27pt; TEXT-INDENT: -18pt; mso-list: l10 l=
evel1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Interact with individual from all over the world =
with=20
similar goals of obtaining monitoring and evaluation skills<o:p></o:p>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>DURATION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>10=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>The=20
course targets researchers, NGOs project management officials, ministr=
ies in=20
governments, financial institutions, and national statistics officers =
and=20
volunteers who want to acquire monitoring and evaluation=20
skills.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>COURSE=20
OUTLINE</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>M=20
&amp; E fundamentals</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l2 =
level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>M &amp; E introduction<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l2 =
level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>M &amp;E core components<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l2 =
level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Integrating M &amp; E in the project cycle<o:p></=
o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l2 =
level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Determining the shortcomings faced by M &amp; E=20
professionals<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Trends=20
towards result based M &amp; E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo3"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Introduction to Managing for Development results=20
(MFDR)<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo3"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Principles of MDFR<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo3"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Results based management<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Result=20
based M &amp; E introduction</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l4 =
level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Understanding results based management (RBM)<o:p>=
</o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l4 =
level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Elements of result bases M &amp; E creation<o:p><=
/o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l4 =
level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Cycle of result based M &amp; E<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l4 =
level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Measuring results<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l4 =
level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Performance measurement, indicators, and=20
monitoring<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Situation=20
assessment</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l3 =
level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Formative study and analysis<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l3 =
level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Illustrative examples<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l3 =
level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Situation assessment tools<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Assessment=20
of baseline</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo6"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Understanding baseline study<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo6"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Baseline study importance<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo6"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Baseline data and collection methods<o:p></o:p></=
P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo6"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Difference between situation assessment and basel=
ine=20
study<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>M=20
&amp; E system designing</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l5 =
level1 lfo7"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Frameworks of M &amp; E<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l5 =
level1 lfo7"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Impact pathways<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l5 =
level1 lfo7"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>The change theory<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Monitoring=20
performance</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l8 =
level1 lfo8"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Process of performance monitoring<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l8 =
level1 lfo8"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Tools used in performance monitoring<o:p></o:p></=
P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Techniques=20
of evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l6 =
level1 lfo9"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Case study<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l6 =
level1 lfo9"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Economical evaluation<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l6 =
level1 lfo9"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Communication of findings<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>GIS=20
techniques for M &amp; E of development programs</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l9 =
level1 lfo10"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Geographical approaches<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l9 =
level1 lfo10"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Advantages of GIS to M &amp; E<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l9 =
level1 lfo10"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Analysis and mapping of GIS<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l9 =
level1 lfo10"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>GIS software and data<o:p></o:p></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
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
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Training manuals and additional reference materia=
ls are=20
provided to the participants.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Upon successful completion of this course, partic=
ipants=20
will be issued with a certificate.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>We can also do this as tailor-made course to meet=
=20
organization-wide needs. Contact us to find out=20
more:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>The training will be conducted at&nbsp;Skills for=
=20
Africa&nbsp;Training Institute in Nairobi Kenya.<o:p></o:p></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
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
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l7 =
level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; m=
so-bidi-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN>Payment should be sent to our bank account before=
 start of=20
training and proof of payment sent=20
to:&nbsp;<A>training@skillsforafrica.org</A><o:p></o:p></P></BODY></HT=
ML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Dv=
HFMwtM2KWU0p9xJNbq03A2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DXq4HZFvX2SSJmcDXFdkFtkc6VVtk3EvrN3_rqC9kkJi_4R6-clKEYiD8fJ=
5b2BLH8o2VyqdifOMshUO2AHD9xrYVpzh6EOd-qdTw5JsxkFvf0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfEkrz0zLYCpW1Xfx/eXDZ+CpgxK527XWKzQ==--
