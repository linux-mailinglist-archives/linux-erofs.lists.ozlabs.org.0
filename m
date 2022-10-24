Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E64609BA3
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Oct 2022 09:43:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mwn9h3jP1z2xtt
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Oct 2022 18:43:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=S7E3vmtH;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=bJmMCyJB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=104.243.65.27; helo=na27.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=S7E3vmtH;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=bJmMCyJB;
	dkim-atps=neutral
Received: from na27.mxout.mta4.net (na27.mxout.mta4.net [104.243.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mwn9Q64Nmz3bck
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Oct 2022 18:42:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1666597343;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=1fCHGJFsziid38rnSdZkGLJsIAR7DCbDZUsdCoMmUno=;
	b=S7E3vmtHHjsSzzh72yBH4PPfTN1cnJuO0FlB0cKMhNDTvP9o0NAlVXGUmjF79GevUXNNOagzBNd
	M5SCk7r66vpZDhGsR8MEYQ1/v+tBovs3k5VkDt9dF5Oefoh3x3oHyZ/pIpkjSP+z9JmJTNu2gg75s
	CBM3e0O/yfBXgao96qQ=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1666597343;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=1fCHGJFsziid38rnSdZkGLJsIAR7DCbDZUsdCoMmUno=;
	b=bJmMCyJB/m/edYevgPtSlf4BmG9wpwQnWrmP6KJ8noXWnKgTHv/RyR5HQNvlM431hwnNHs/LNZF
	poz/+U5AMYk8fUg/WNP8OcXDoTUJvjZvG/qz9Tcyv9Wa/tGEVKPbsNC2ewDy4q2taeuvCM6loj4Ao
	hb02G27uzbkW4vBfVio=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Mon, 24 Oct 2022 07:42:23 +0000
Subject: Training on Monitoring Evaluation And Data Analysis For Community
 Based Projects On 7th To 18th November 2022 in Nairobi, Kenya
Message-Id: <4ui7whk43gsi.lrWj2X-QA_SvhztBr0c2LQ2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: lrWj2X-QA_SvhztBr0c2LQ2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfCHDi9Hf0ava/Vfo5YTPV8BYy1qwJ/XWKzQ=="
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

--=-eZCfCHDi9Hf0ava/Vfo5YTPV8BYy1qwJ/XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9MVJ1VVMtaGtleTFFcFl0Q3JQSFJXUnprZVczRC1PSHJza1NEZHRVVDI4SlRYYTRnYjJB
TEJQUHprdmZzejJibkFHQjQtdEIwbEg3OWYzVml3ZXlwVEtVRml4Z1N6TGNiLUZYUllBcG5S
aVVzcEE0V3dLSmlfUnVOOTVIaFdIRmozTXF3Z3F0ZmtEWHU1aFJfQmZWVnZITTE+DQpNb25p
dG9yaW5nIEV2YWx1YXRpb24gQW5kIERhdGEgQW5hbHlzaXMgRm9yIENvbW11bml0eSBCYXNl
ZCANClByb2plY3RzIE9uIDd0aCBUbyAxOHRoIE5vdmVtYmVyIDIwMjIgaW4gTmFpcm9iaSwg
S2VueWENCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcv
Y2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRQcThr
U0ZfVG5mVlFOa0JpdElQa3N2TmFjeGJJZVZZdVUyZ01NNXA0WjN1WEZIRXlLRU9nMWZkZTBm
T3ViV29CTUUwd0djYzVCQ1R0bXJWcnkyOGhKVEE4aEt5dUdKckxQdlNuMjVFQzJqMVlpbUhZ
N3ZCb0xyTTVGZ1ltTmhDYURhMD4NClJlZ2lzdGVyIGZvciBvbmxpbmUgdHJhaW5pbmcgDQoN
CjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9
V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0UHE4a1NGX1RuZlZR
TmtCaXRJUGtzdk5hY3hiSWVWWXVVMmdNTTVwNFozdWNkSVlTR0V6LUVVX1BaeFplOVZPR3Rj
UXFuNGZRMnlMcUlKdVE1bW5YQzEzbHpGNzUtaTJRZFRGeHV2b01feWxpVm14MEN2VmtHU3VS
cVhTTkhfc05sdjA+DQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNv
bS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pO
V3NxcXJUdFBxOGtTRl9UbmZWUU5rQml0SVBrc3ZOYWN4YkllVll1VTJnTU01cDRaM3VUWnB5
ZEZWQXdYX2haMTlfMVZGMHFqSnFLNVIwZkg3MVZ3cUwtQmlOckEtYWpZemZNY1hFZkRBOFpB
YlVuUjlmVWtQcFAyZTdGVzY0YjFnUEpLVVVjZXQwPg0KUmVnaXN0ZXIgdG8gYXR0ZW5kIHRo
ZSANCnRyYWluaW5nDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3Ry
YWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3Fx
clR0UHE4a1NGX1RuZlZRTmtCaXRJUGtzdk5hY3hiSWVWWXVVMmdNTTVwNFozdVlIM2w0bW1O
ejlXTTBmNmFnREx6R25Qa3VlMDdYbUcwRWtpOVlvT2NmbXpqbHQzMFpmSHhFOEJlem93dlNU
M21Ub0Z1MDJXMEVEM3MxemhiYUtLQV80UjA+DQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsu
ZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPTRSU09HZVM1SEk2S0ZKaXhRcHlr
VUg3U0JEU2owQTJFZEhkY3FxRWstS01MZFlHdEsycm5UR0VPcEZPemNkanhqXzRicHpOWnk4
cHBncVB0Wnp4dHJmeFhZSEdBb3lXeU1TZnBNck55VnhmUHVrSmNzZGtxNmRscEhCcHVFSXYt
SS0weUFBbkI4YnBOcWNEcm9TajJqdlkxPg0KQ2FsZW5kYXIgDQpmb3IgMjAyMi8yMDIzIFdv
cmtzaG9wcw0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJh
Y2tpbmcvY2xpY2s/ZD00UlNPR2VTNUhJNktGSml4UXB5a1VIN1NCRFNqMEEyRWRIZGNxcUVr
LUtNY0tCVzVHeGpidVhGaVZvNEVEUURBOU9EbEZSMW5VbGdselRtdi12Qk41S1VKcmpZaTRH
eTRsVGdNR2ZyX0JIRHJkbXI1dUJBSmNxNy03ZWxhblZBM1lkUkRTRDczNWVnSVEtMzRuWVB5
WFVvMT4NCkNvbnRhY3QgDQp1cw0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNl
bWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1UZE8xZ0N1UTcxaHBXTDYwQldObnR1d2YySVdK
Zmtfa0pRX09leDVfZWpqemlvWk5vNl9xbHVaS1hPZ0trd2JsVzVIQnZwTV9reHF4cHF6TWNk
ZjVTYWFZQ3hyMjhzandFNzVTZ0xZdGl1UUxkbU9McFBTMjRiRHpEM0k3Y3p5NXB4bURfNEtJ
V0NUTDVpVXpCUG1POG9nMT4NCldoYXRhcHANCsKgDQpWRU5VRTogQkVTVCBXRVNURVJOIE1F
UklESUFOIEhPVEVMLCBOQUlST0JJLCANCktFTllBDQpDT1VSU0UgRkVFOiAyLDQwMFVTRA0K
T2ZmaWNlIFRlbGVwaG9uZTogKzI1NC03MDItMjQ5LTQ0OQ0KUmVnaXN0ZXIgYXMgYSBncm91
cCBvZiA1IG9yIG1vcmUgcGFydGljaXBhbnRzIGFuZCBnZXQgMjUlIGRpc2NvdW50IA0Kb24g
dGhlIGNvdXJzZSBmZWUuIA0KU2VuZCB1cyBhbiBlbWFpbDogDQo8aHR0cHM6Ly8xMzNJSy50
cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPXJhX0tycXV5bV92QUg3YTB4
ZnlpUlJSSjBtbU1vZ255ZzU2a21QZUpEY09BVGc1aFJrTjRqbUhNd0V6RjB6Z3RPNDhLTk51
TEdVZHdsRzFxS2pVbmJVTTJJZVQwSWNPV2JmSmxsVDQySnNYZjZZMTlRaFdDOG9LQ2cwd0dW
aE1NRHpPT1lDSE94NzZnc29XMVRha0JfVE55Q3lSZW9ET1RMRnFrUXNwNFpySFlMQWw5a0Rq
UElrOWFvdEdxTkJmeVE0dUx2TnFEQVZGY2w4SmhCamhnZU9DeWlpMkFVa2VYNHNIeU84MlRi
RFRUMD4NCnRyYWluaW5nQHNraWxsc2ZvcmFmcmljYS5vcmfCoG9yIGNhbGwgKzI1NC03MDIt
MjQ5LTQ0OQ0KSU5UUk9EVUNUSU9ODQpUaGlzIGNvdXJzZSBmb2N1c2VzIG9uIHRoZSBvcGVy
YXRpb25zIG9mIGNvbW11bml0eSBwcm9qZWN0cy4gVGhlIA0KY291cnNlIGFpbXMgYXQgZWR1
Y2F0aW5nIHBhcnRpY2lwYW50cyBvbiB0aGUgcHJvZ3JhbW1lcyBvZiBtb25pdG9yaW5nIGFu
ZCANCmV2YWx1YXRpb24gaW1wbGVtZW50ZWQgdG8gZW5zdXJlIHN1Y2Nlc3NmdWwgY29tbXVu
aXR5IHByb2plY3RzLiBUaGUgY291cnNlIA0KYWNrbm93bGVkZ2VzIHRoZSBuZWVkIGZvciBh
biBpbXByb3ZlZCBtb25pdG9yaW5nIGFuZCBldmFsdWF0aW9uIHN5c3RlbSwgdGh1cyANCmFp
bXMgdG8gZXF1aXAgcGFydGljaXBhbnRzIHdpdGggc2tpbGxzIGluIHRoZSBjcmVhdGlvbiBv
ZiBlZmZlY3RpdmUgbW9uaXRvcmluZyANCmFuZCBldmFsdWF0aW9uIHN5c3RlbXMNCkNPVVJT
RSANCk9CSkVDVElWRVMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KUHJvY2Vzc2VzIG9mIHBy
b2plY3QgbWFuYWdlbWVudA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpLbm93bGVkZ2UgYXJl
YXMgb2YgcHJvamVjdCBtYW5hZ2VtZW50DQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClByb2pl
Y3QgbWFuYWdlbWVudCBmb3JtdWxhcywgdGhlb3JpZXMgYW5kIA0KY2hhcnRzDQrCt8KgwqDC
oMKgwqDCoMKgwqDCoCANCkNvbXBsZXggcHJvamVjdCBuZXR3b3JrIGRpYWdyYW1zDQrCt8Kg
wqDCoMKgwqDCoMKgwqDCoCANClVzZSBvZiBkYXRhIGFuYWx5c2lzIHNvZnR3YXJlIChOVml2
bywgU3RhdGEsIEV4Y2VsLCANClNBUykNCkRVUkFUSU9ODQoxMCBEYXlzDQpXSE8gDQpTSE9V
TEQgQVRURU5EDQpUaGlzIGNvdXJzZSB0YXJnZXRzIHByb2plY3QgbWFuYWdlbWVudCBvZmZp
Y2lhbCBmcm9tIA0Kbm9uLWdvdmVybm1lbnRhbCBvcmdhbml6YXRpb25zLMKgIE5hdGlvbmFs
IHN0YXRpc3RpY3Mgb2ZmaWNlcywgcmVzZWFyY2hlcnMsIA0KZ292ZXJubWVudGFsIG1pbmlz
dHJpZXMsIFBsYW5uaW5nIG1pbmlzdHJpZXMsIGFuZCBmaW5hbmNpYWwgaW5zdGl0dXRpb25z
LCBhbW9uZyANCm90aGVycy4NCkNPVVJTRSANCk9VVExJTkUNCsK3wqDCoMKgwqDCoMKgwqDC
oMKgIA0KUHJpbmNpcGxlc8KgIGFuZCBjb25jZXB0cyBvZiBwcm9qZWN0IA0KbWFuYWdlbWVu
dA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpEZXZlbG9wbWVudCBhbmQgZGV2ZWxvcG1lbnQg
ZnJhbWV3b3JrcyANCmlzc3Vlcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpDb21tdW5pdHkg
dHlwZXMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KQ29tbXVuaXR5IGRldmVsb3BtZW50IGFu
ZCBlbXBvd2VybWVudA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpEaXN0cmlidXRpb24gb2Yg
ZGV2ZWxvcG1lbnQgcmVzb3VyY2VzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkNvbW11bml0
eSBwcm9qZWN0cyBkZXNpZ25pbmcNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KSW52b2x2ZW1l
bnQgb2YgY29tbXVuaXR5IGluIGRldmVsb3BtZW50IA0KcHJvamVjdHMNCsK3wqDCoMKgwqDC
oMKgwqDCoMKgIA0KTWFuYWdlbWVudCBvZiBwcm9qZWN0IGN5Y2xlDQrCt8KgwqDCoMKgwqDC
oMKgwqDCoCANCk5lZWQgYW5kIHByb2plY3Qgc3Rha2Vob2xkZXJz4oCZIA0KYW5hbHlzaXMN
CsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KSW5mbHVlbmNlIG1hcHBpbmcNCsK3wqDCoMKgwqDC
oMKgwqDCoMKgIA0KQ29udHJvbCBhbmQgaW1wbGVtZW50YXRpb24NCsK3wqDCoMKgwqDCoMKg
wqDCoMKgIA0KRGV2ZWxvcG1lbnQgc3Rha2Vob2xkZXJzIG1hbmFnZW1lbnQNCsK3wqDCoMKg
wqDCoMKgwqDCoMKgIA0KTW9uaXRvcmluZyBhbmQgZXZhbHVhdGlvbg0KwrfCoMKgwqDCoMKg
wqDCoMKgwqAgDQpQcm9qZWN0IG1vbml0b3JpbmcgYXVkaXRpbmcgdGVjaG5pcXVlcw0KwrfC
oMKgwqDCoMKgwqDCoMKgwqAgDQpFdmFsdWF0aW9uIG9mIHByb2plY3QgbWFuYWdlbWVudCBz
eXN0ZW1zIGFuZCANCnByYWN0aWNlcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpNb25pdG9y
aW5nIGluZGljYXRvcnMgYW5kIHN5c3RlbXMgDQpkZXNpZ25pbmcNCsK3wqDCoMKgwqDCoMKg
wqDCoMKgIA0KQ29sbGFib3JhdGlvbiB3aXRoIG5hdGlvbmFsIGJvZGllcywgYW5kIHByb2pl
Y3QgDQpzdGFmZg0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpTb2NpYWwgYW5kIGluc3RpdHV0
aW9uYWwgY2hhbmdlIA0KZXZhbHVhdGlvbg0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpSZXN1
bHRzIGFuZCBpbXBhY3QgbWVhc3VyaW5nDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkVjb25v
bWljLCBzb2NpYWwsIGFuZCBlbnZpcm9ubWVudGFsIGltcGFjdCANCmFzc2Vzc21lbnQNCsK3
wqDCoMKgwqDCoMKgwqDCoMKgIA0KVmFyaWFibGVzIGFuZCBpbmRpY2F0b3JzDQrCt8KgwqDC
oMKgwqDCoMKgwqDCoCANClRoZSBMT0dGUkFNRSBhcHByb2FjaA0KwrfCoMKgwqDCoMKgwqDC
oMKgwqAgDQpUZWNobmlxdWVzIG9mIHNhbXBsaW5nIGFuZCBzdXJ2ZXlzDQrCt8KgwqDCoMKg
wqDCoMKgwqDCoCANCkNoYXJhY3RlcmlzdGljcyBvZiBkYXRhIGFuZCBzb3VyY2VzDQrCt8Kg
wqDCoMKgwqDCoMKgwqDCoCANClRlY2huaXF1ZXMgb2YgYXBwcmFpc2Fscw0KwrfCoMKgwqDC
oMKgwqDCoMKgwqAgDQpTeXN0ZW1zIGFuZCB0b29scyBvZiBtb25pdG9yaW5nIGFuZCANCmV2
YWx1YXRpb24NCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KRGF0YSBtYW5hZ2VtZW50IHN0YW5k
YXJkcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpJZGVudGlmaWNhdGlvbiBhbmQgcHJlc2Vu
dGF0aW9uIG9mIGRhdGEgDQpvdXRwdXRzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkNvbnN1
bHRpbmcgc3Rha2Vob2xkZXJzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkRldmVsb3BtZW50
IG9mIHRoZSBwcm9qZWN0IHBlcmZvcm1hbmNlIGF1ZGl0IA0KcmVwb3J0DQrCoA0KwqANCkdF
TkVSQUwgDQpOT1RFUw0Kw5jCoCANClRoaXMgDQpjb3Vyc2UgaXMgZGVsaXZlcmVkIGJ5IG91
ciBzZWFzb25lZCB0cmFpbmVycyB3aG8gaGF2ZSB2YXN0IGV4cGVyaWVuY2UgYXMgZXhwZXJ0
IA0KcHJvZmVzc2lvbmFscyBpbiB0aGUgcmVzcGVjdGl2ZSBmaWVsZHMgb2YgcHJhY3RpY2Uu
IFRoZSBjb3Vyc2UgaXMgdGF1Z2h0IHRocm91Z2ggDQphIG1peCBvZiBwcmFjdGljYWwgYWN0
aXZpdGllcywgdGhlb3J5LCBncm91cCB3b3JrcyBhbmQgY2FzZSANCnN0dWRpZXMuDQrDmMKg
IA0KVHJhaW5pbmcgDQptYW51YWxzIGFuZCBhZGRpdGlvbmFsIHJlZmVyZW5jZSBtYXRlcmlh
bHMgYXJlIHByb3ZpZGVkIHRvIHRoZSANCnBhcnRpY2lwYW50cy4NCsOYwqAgDQpVcG9uIA0K
c3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMgY291cnNlLCBwYXJ0aWNpcGFudHMgd2ls
bCBiZSBpc3N1ZWQgd2l0aCBhIA0KY2VydGlmaWNhdGUuDQrDmMKgIA0KV2UgDQpjYW4gYWxz
byBkbyB0aGlzIGFzIHRhaWxvci1tYWRlIGNvdXJzZSB0byBtZWV0IG9yZ2FuaXphdGlvbi13
aWRlIG5lZWRzLiBDb250YWN0IA0KdXMgdG8gZmluZCBvdXQgbW9yZTrCoHRyYWluaW5nQHNr
aWxsc2ZvcmFmcmljYS5vcmcNCsOYwqAgDQpUaGUgDQp0cmFpbmluZyB3aWxsIGJlIGNvbmR1
Y3RlZCBhdMKgU2tpbGxzIGZvciBBZnJpY2HCoFRyYWluaW5nIA0KSW5zdGl0dXRlLg0Kw5jC
oCANClRoZSANCnRyYWluaW5nIGZlZSBjb3ZlcnMgdHVpdGlvbiBmZWVzLCB0cmFpbmluZyBt
YXRlcmlhbHMsIGx1bmNoIGFuZCB0cmFpbmluZyB2ZW51ZS4gDQpBY2NvbW1vZGF0aW9uIGFu
ZCBhaXJwb3J0IHRyYW5zZmVyIGFyZSBhcnJhbmdlZCBmb3Igb3VyIHBhcnRpY2lwYW50cyB1
cG9uIA0KcmVxdWVzdC4NCsOYwqAgDQpQYXltZW50IA0Kc2hvdWxkIGJlIHNlbnQgdG8gb3Vy
IGJhbmsgYWNjb3VudCBiZWZvcmUgc3RhcnQgb2YgdHJhaW5pbmcgYW5kIHByb29mIG9mIHBh
eW1lbnQgDQpzZW50IHRvOsKgdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZw0KwqANCsKg
DQrCoA0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvdW5z
dWJzY3JpYmU/ZD1UZ19DTDU1VVBBOUV1dUFVRmYzWXk0eFVjUmFRQWJJSC05djVyNDMyMWVu
cVR6eWJwSWhhMDd0dHZ6TnhHay1famhKaHJWNi1NMkxoc1NTSV9FNjQtU1ptWEk0amVnRlZl
clE5U05aMWZaM1gwPg0KVU5TVUJTQ1JJQkU=

--=-eZCfCHDi9Hf0ava/Vfo5YTPV8BYy1qwJ/XWKzQ==
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
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D1RuUS-hk=
ey1EpYtCrPHRWRzkeW3D-OHrskSDdtUT28JTXa4gb2ALBPPzkvfsz2bnAGB4-tB0lH79f3=
ViweypTKUFixgSzLcb-FXRYApnRiUspA4WwKJi_RuN95HhWHFj3MqwgqtfkDXu5hR_BfVV=
vHM1"><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082>Monitoring Evaluation And Data Analysis For Community =
Based=20
Projects On 7th To 18th November 2022 in Nairobi, Kenya<?xml:namespace=
 prefix =3D=20
"o" ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></SPAN></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPq8kSF_TnfVQNkBitIPksvNacxbIeVYuU2gM=
M5p4Z3uXFHEyKEOg1fde0fOubWoBME0wGcc5BCTtmrVry28hJTA8hKyuGJrLPvSn25EC2j=
1YimHY7vBoLrM5FgYmNhCaDa0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082>Register for online training </FONT></SPAN></A></SPAN>=
</U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-ascii=
-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-=
theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPq8kSF_TnfVQNkBitIPksvNacxbIeVYuU2gM=
M5p4Z3ucdIYSGEz-EU_PZxZe9VOGtcQqn4fQ2yLqIJuQ5mnXC13lzF75-i2QdTFxuvoM_y=
liVmx0CvVkGSuRqXSNH_sNlv0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
face=3D"Times New Roman"><FONT=20
color=3D#410082>&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></SPAN></SPA=
N></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPq8kSF_TnfVQNkBitIPksvNacxbIeVYuU2gM=
M5p4Z3uTZpydFVAwX_hZ19_1VF0qjJqK5R0fH71VwqL-BiNrA-ajYzfMcXEfDA8ZAbUnR9=
fUkPpP2e7FW64b1gPJKUUcet0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082>Register to attend the=20
training<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-ascii=
-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-=
theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtPq8kSF_TnfVQNkBitIPksvNacxbIeVYuU2gM=
M5p4Z3uYH3l4mmNz9WM0f6agDLzGnPkue07XmG0Eki9YoOcfmzjlt30ZfHxE8BezowvST3=
mToFu02W0ED3s1zhbaKKA_4R0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxj_4bpzNZy8ppgq=
PtZzxtrfxXYHGAoyWyMSfpMrNyVxfPukJcsdkq6dlpHBpuEIv-I-0yAAnB8bpNqcDroSj2=
jvY1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin">Calendar=20
for 2022/2023 Workshops<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDA9ODlFR1nUlglzT=
mv-vBN5KUJrjYi4Gy4lTgMGfr_BHDrdmr5uBAJcq7-7elanVA3YdRDSD735egIQ-34nYPy=
XUo1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin">Contact=20
us<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejjzioZNo6_qluZKXOgKkwblW5HBvpM_kxqxpq=
zMcdf5SaaYCxr28sjwE75SgLYtiuQLdmOLpPS24bDzD3I7czy5pxmD_4KIWCTL5iUzBPmO=
8og1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin">Whatapp<o:p></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>VENUE: BEST WESTERN MERIDIAN HOTEL, NAIROBI,=20
KENYA<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>COURSE FEE: 2,400USD<o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Office Telephone: +254-702-249-449<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Register as a group of 5 or more participants and get 2=
5% discount=20
on the course fee. <o:p></o:p></FONT></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Send us an email: </FONT><A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMDzOOYCHOx76gsoW1Tak=
B_TNyCyReoDOTLFqkQsp4ZrHYLAl9kDjPIk9aotGqNBfyQ4uLvNqDAVFcl8JhBjhgeOCyi=
i2AUkeX4sHyO82TbDTT0" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082>training@skillsforafrica.org&nbsp;</FONT></SPAN></A><F=
ONT=20
face=3DCalibri>or call +254-702-249-449<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 12pt 0cm 0pt; LINE-HEIGHT: norma=
l"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">INTRODUCTION</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>This course focuses on the operations of community proj=
ects. The=20
course aims at educating participants on the programmes of monitoring =
and=20
evaluation implemented to ensure successful community projects. The co=
urse=20
acknowledges the need for an improved monitoring and evaluation system=
, thus=20
aims to equip participants with skills in the creation of effective mo=
nitoring=20
and evaluation systems<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l0 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Processes of project management<o:p></o:p></FONT></SPAN=
></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l0 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Knowledge areas of project management<o:p></o:p></FONT>=
</SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l0 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Project management formulas, theories and=20
charts<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l0 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Complex project network diagrams<o:p></o:p></FONT></SPA=
N></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l0 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Use of data analysis software (NVivo, Stata, Excel,=20
SAS)<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">DURATION</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>10 Days<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>This course targets project management official from=20
non-governmental organizations,&nbsp; National statistics offices, res=
earchers,=20
governmental ministries, Planning ministries, and financial institutio=
ns, among=20
others.<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">COURSE=20
OUTLINE</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Principles&nbsp; and concepts of project=20
management<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Development and development frameworks=20
issues<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Community types<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Community development and empowerment<o:p></o:p></FONT>=
</SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Distribution of development resources<o:p></o:p></FONT>=
</SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Community projects designing<o:p></o:p></FONT></SPAN></=
P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Involvement of community in development=20
projects<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Management of project cycle<o:p></o:p></FONT></SPAN></P=
>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Need and project stakeholders&rsquo;=20
analysis<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Influence mapping<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Control and implementation<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Development stakeholders management<o:p></o:p></FONT></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Monitoring and evaluation<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Project monitoring auditing techniques<o:p></o:p></FONT=
></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Evaluation of project management systems and=20
practices<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Monitoring indicators and systems=20
designing<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Collaboration with national bodies, and project=20
staff<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Social and institutional change=20
evaluation<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Results and impact measuring<o:p></o:p></FONT></SPAN></=
P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Economic, social, and environmental impact=20
assessment<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Variables and indicators<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>The LOGFRAME approach<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Techniques of sampling and surveys<o:p></o:p></FONT></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Characteristics of data and sources<o:p></o:p></FONT></=
SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Techniques of appraisals<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Systems and tools of monitoring and=20
evaluation<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Data management standards<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Identification and presentation of data=20
outputs<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Consulting stakeholders<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l2 level1 lf=
o3"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&#183;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><FONT=20
face=3DCalibri>Development of the project performance audit=20
report<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
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
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Training=20
manuals and additional reference materials are provided to the=20
participants.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
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
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>We=20
can also do this as tailor-made course to meet organization-wide needs=
. Contact=20
us to find out more:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; mso-bidi-theme-font: minor-latin; text-underline: none">tr=
aining@skillsforafrica.org</SPAN></A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>The=20
training will be conducted at&nbsp;Skills for Africa&nbsp;Training=20
Institute.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
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
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l1 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&#216;<SPAN style=3D'FONT: 7pt "Times New R=
oman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Payment=20
should be sent to our bank account before start of training and proof =
of payment=20
sent to:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; mso-bidi-theme-font: minor-latin; text-underline: none">tr=
aining@skillsforafrica.org</SPAN></A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><SPAN=
=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Dl=
rWj2X-QA_SvhztBr0c2LQ2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DTg_CL55UPA9EuuAUFf3Yy4xUcRaQAbIH-9v5r4321enqTzybpIha07ttvz=
NxGk-_jhJhrV6-M2LhsSSI_E64-SZmXI4jegFVerQ9SNZ1fZ3X0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfCHDi9Hf0ava/Vfo5YTPV8BYy1qwJ/XWKzQ==--
