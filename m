Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B668B0722
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 12:20:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=skillsforafrica.co.ke header.i=@skillsforafrica.co.ke header.a=rsa-sha256 header.s=api header.b=WBG7UUq+;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=QLun+ret;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPZkY3L5yz3cTp
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 20:20:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=skillsforafrica.co.ke header.i=@skillsforafrica.co.ke header.a=rsa-sha256 header.s=api header.b=WBG7UUq+;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=QLun+ret;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.skillsforafrica.co.ke (client-ip=67.227.87.214; helo=n214.mxout.mta4.net; envelope-from=training=skillsforafrica.co.ke@bounces.skillsforafrica.co.ke; receiver=lists.ozlabs.org)
X-Greylist: delayed 70325 seconds by postgrey-1.37 at boromir; Wed, 24 Apr 2024 20:20:24 AEST
Received: from n214.mxout.mta4.net (n214.mxout.mta4.net [67.227.87.214])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPZkJ5VQLz3bsT
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:20:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=skillsforafrica.co.ke; s=api;
	c=relaxed/simple; t=1713953999;
	h=from:date:subject:reply-to:to:list-unsubscribe:list-unsubscribe-post:
	mime-version;
	bh=2SlGVNVVF/wJXFSZ0zNA3dZx99oVV2QKyeP6H5/tCtE=;
	b=WBG7UUq+WqyTdnNpLcaaa+qTY0hEY5Karrph59VB18lpa7TTgfKDA3EfkGaN3N49yBoPGunEaJk
	GzR+hUmLyfTe8kIWtyfMs8ZjoAHNzbu/HhxePkvd8vKs6HHMq2DUkjwEJZJw6NwOcSJtjxqXqBBAD
	fKIuLNt0hpbHfA1jV9Y=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1713953999;
	h=from:date:subject:reply-to:to:list-unsubscribe:list-unsubscribe-post;
	bh=2SlGVNVVF/wJXFSZ0zNA3dZx99oVV2QKyeP6H5/tCtE=;
	b=QLun+ret+nlWkR2xSJP2A8q9jcUp98SBEpO/rVIXvH+ABdgiJ1tpm9KloAqrVGonhK/oJvPH1HP
	rClWJKwP3VDU7Corj5bqi0Os5j5eCywuhNn74B9ycGBywCPl2oR9uura9cw1cY2/3QHFdF8wXXFnC
	0hOmdOMrkURFZS4JSZM=
From: "training@skillsforafrica.co.ke" <training@skillsforafrica.co.ke>
Date: Wed, 24 Apr 2024 10:19:59 +0000
Subject: Seminar On Artificial Intelligence Essentials
Message-Id: <4umvrn11np18.4Pk3YVpEWbu_7Ghb0JqE4A2@tracking.skillsforafrica.co.ke>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Msg-EID: 4Pk3YVpEWbu_7Ghb0JqE4A2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfUFLerRz6N+KpaNwQPg7J0FRIxNtx7XWKzQ=="
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
Reply-To: training@skillsforafrica.co.ke
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfUFLerRz6N+KpaNwQPg7J0FRIxNtx7XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2Ns
aWNrP2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTUFXWXBr
ektqNzFjRDFscTBzcU1MVHVHS3RIT3hhMFZXeHdGS1QwZm50OXdiSkNyUzhJdG1tbWZwUXgz
OG8tZ09yVkpxdHFWSVpTVGNzUEVNcEx5VUxEV1JLdXhIbzBVdFcyejZTQV9COG1wSTE+DQrC
oFNlbWluYXIgT24gQXJ0aWZpY2lhbCBJbnRlbGxpZ2VuY2UgDQpFc3NlbnRpYWxzIA0KwqAN
Cg0KRGF0ZXMNCkZlZXMNCkxvY2F0aW9uDQpBcHBseQ0KMTMvMDUvMjAyNMKgLcKgMTcvMDUv
MjAyNA0KJDQ1MDANCkR1YmFpDQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNh
LmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlz
UG1Xak5Xc3FxclR0TmhxVi1CVzUtVl95SWlEVExZSDNRQUkxSHo2T3YweTlKaXR0RW1UeEpE
TXUybTVacHNObnhYZ2pzblpMTEEwdkVpNGpYa3B5ejdlTmllZ1FCRWRydTRobUtJMlNPaEU2
UUM0N1BYczYxT0FuVTF5b3J2Qkx3NHBhYjRmS29iUWhDaTA+DQpQaHlzaWNhbCBDbGFzcw0K
DQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2Ns
aWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0T1pwNjM4
RkhURi15cEg5aXoxX21JQl9Oc1VfN0NrWkZ3NE5Sbk1CY3BaNjBCN05EeVpZS2dWOENpV2U5
VDZVdVNXdlY0Zmc0d0M3ZkFFMUhWd29KZC1BVHlXMThNUWtTaElteVFreHRneWFxM2dBVF90
TWdfc3BLOHVXdVpXeXdxTTA+DQpPbmxpbmUgDQogICAgQ2xhc3MNCjEwLzA2LzIwMjTCoC3C
oDE0LzA2LzIwMjQNCiQxNTAwDQpOYWlyb2JpDQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxz
Zm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5
LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TmhxVi1CVzUtVl95SWlEVExZSDNRQXRreVhnTC1BcVhJ
TkFGRXVOajE2bzZPaFlkWjhXSWJYeG1BNHRJZXNaakROdF9MalQ4cjRFNU03eVVpMGtHRGkz
cmpSZUl3OFlqaG1kc0ZoQ1ExR0JtVnFWdW5FU2NvNGNHYXVuVWxTM05qdjA+DQpQaHlzaWNh
bCBDbGFzcw0KDQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3Ry
YWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3Fx
clR0T1pwNjM4RkhURi15cEg5aXoxX21JQlVyMS1ZU3luMW1pMnU3ZzdZWkJ5WS1FZHFlVlpZ
OExlS1EzamVIT2hmcTNQZkN4VEtzOFFBVWcxX0N3X25RZlFXcEFTSEUzNS1uWXRXWmNENWpI
cjUtT3hwaG91cjlRSy03VXR4QVlQWlpZaDA+DQpPbmxpbmUgDQogICAgQ2xhc3MNCjA4LzA3
LzIwMjTCoC3CoDEyLzA3LzIwMjQNCiQxNTAwDQpOYWlyb2JpDQoNCjxodHRwOi8vdHJhY2tp
bmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZo
aDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TmhxVi1CVzUtVl95SWlEVExZSDNRQXF4
UWFYSDVhbXp0VmQzdTJiRW0xamR6TnBOTmRXVVViNlJKQ1AyQklJQWxDRVU5MFZ0aVZ6ajd2
NFVmRm1yWVVraTBuSnRQRmRzM3g1NGxKRnp1WHdhbE5fQlhwVE51VnNOZ3J4T0tfLWxlWTA+
DQpQaHlzaWNhbCBDbGFzcw0KDQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNh
LmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlz
UG1Xak5Xc3FxclR0T1pwNjM4RkhURi15cEg5aXoxX21JQmtVdGgxVG1GUGp1UnFUM0pKbnpo
VDUtWnZkSFlPVGM1SE8xQVE5MlNFQ3ZzbmpLSktQRjVNd1ZSZEZ3RW5BcHFyZ0ltb3FVQVhY
VjJudG9pYUREdDFsWHFMLUIySldoZndYcE5Bb1k2SHpJLTA+DQpPbmxpbmUgDQogICAgQ2xh
c3MNCjEyLzA4LzIwMjTCoC3CoDE2LzA4LzIwMjQNCiQxNTAwDQpOYWlyb2JpDQoNCjxodHRw
Oi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29h
cG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TmhxVi1CVzUtVl95SWlE
VExZSDNRQUxzc3RJQWRSUlM2eklpQkJxODMtQjFIN1VVcWU1LUVrLV81dF80SVhTTWJuaHRC
eFpMNjh1SnJla0JTbkQzV2c0cGVBY3FBZTZsLUh6U1JEWGVZM2p2Ny1ZVXVfRE4yZEw3dUVX
Z3VHeEZ6UTA+DQpQaHlzaWNhbCBDbGFzcw0KDQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxz
Zm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5
LVJ0MjI1WVlzUG1Xak5Xc3FxclR0T1pwNjM4RkhURi15cEg5aXoxX21JQlNaTXBjcUpuNGNn
R1l0Vnlqc3pBSmN2TVh6b1BUeHdDei03TmpyVmZTMV9KV3AwTk9wcGVON1FWWXpGR0QyU3dv
VmxjTGc2dVZWTjNmWmUtZXNuRWpERW5TWW5qRjFoRXFybFhhR29xbUxxZTA+DQpPbmxpbmUg
DQogICAgQ2xhc3MNCjA5LzA5LzIwMjTCoC3CoDEzLzA5LzIwMjQNCiQxNTAwDQpOYWlyb2Jp
DQoNCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2Ns
aWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TmhxVi1C
VzUtVl95SWlEVExZSDNRQWJXdkRQRmZrNV90MFFkV2xVSGVHY2hPcWNLQUFwMXNxeHVyVVdX
eGZxaUF6M2czdF9iaTRxUTF1bkxHcjlOMk40bldhWWU3LXhqUUc5RXd6dWlYZHZoRkZnaExO
T2ppbFdvUER5OWN2YWtZaTA+DQpQaHlzaWNhbCBDbGFzcw0KDQoNCjxodHRwOi8vdHJhY2tp
bmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZo
aDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0T1pwNjM4RkhURi15cEg5aXoxX21JQkNI
VDgxQ3pjekhWZ05vN0NqbDdyNjVaaEQxbjV1d183LTRMeWFVQzNjNnU2SVgycWpwQlU2V01J
Um9WMERxRlJPcEVrMlI5TGx3VGpULW01QUIzMGtDZ0h6Q3c2WVA5d0hBeWJlSGxJdjk3VzA+
DQpPbmxpbmUgDQogICAgQ2xhc3MNCjE0LzEwLzIwMjTCoC3CoDE4LzEwLzIwMjQNCiQyOTUw
DQpLaWdhbGkNCg0KPGh0dHA6Ly90cmFja2luZy5za2lsbHNmb3JhZnJpY2EuY28ua2UvdHJh
Y2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFy
VHROaHFWLUJXNS1WX3lJaURUTFlIM1FBaU43d0ZjU1ZLMVAyZTA0YkNQQUNyZ3JpVHBadjcy
V2pYMnRsWi1TaUJvQTZxb2ZYMG1KMGx0LVN6ZnUyX09CeVcwM3J1NWFnZ3FTalpHOEpMMm9Z
RmR3VFdjMkMxczRBbXBMclZmVjJnbUFGMD4NClBoeXNpY2FsIENsYXNzDQoNCg0KPGh0dHA6
Ly90cmFja2luZy5za2lsbHNmb3JhZnJpY2EuY28ua2UvdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fw
b3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRPWnA2MzhGSFRGLXlwSDlp
ejFfbUlCQVF2U2FFcloxbzZtWE44bVJCXzRTNEdiVVlraVQxakZzSXEweHY5ME42QUV1cUo5
MWVjN0pkZ2wyU3hoQmlvMWdqaVVIUzdIcHBJNHYwTE9JNEpoUWFoeVBBYVd4Zk5GajdLQ0o4
Q3BlRVVmMD4NCk9ubGluZSANCiAgICBDbGFzcw0KMTEvMTEvMjAyNMKgLcKgMTUvMTEvMjAy
NA0KJDE1MDANCk1vbWJhc2ENCg0KPGh0dHA6Ly90cmFja2luZy5za2lsbHNmb3JhZnJpY2Eu
Y28ua2UvdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQ
bVdqTldzcXFyVHROaHFWLUJXNS1WX3lJaURUTFlIM1FBTDJ1VlJaeGdHaW80OXQ4XzhCMmph
VHJlU1BnT1N5Qi1GNkxEVkNLSEYyS1g1X2xZZDg3cTlBOXpkRkpldHB1aUVtWGhZUllYMkhO
eGJfYkU5bGVfOFlxUTBnV1A4N1JfX1pOaTkzanRhYnlQMD4NClBoeXNpY2FsIENsYXNzDQoN
Cg0KPGh0dHA6Ly90cmFja2luZy5za2lsbHNmb3JhZnJpY2EuY28ua2UvdHJhY2tpbmcvY2xp
Y2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRPWnA2MzhG
SFRGLXlwSDlpejFfbUlCcTFJdmJXYTF5Z0VObWlFdnBxXzljWTItY1Qzcl9DU1dESHpoTGky
M0h5QUVVTWQ3T2tQOUEwd1Zoa0ZLTDRFejc3dDlZX0NpTXRXTERMUHRxQm9XQTFvSnlmTnBN
UmxPUzlJeFpnTHNiMVl1MD4NCk9ubGluZSANCiAgICBDbGFzcw0KwqANCsKgDQoNCjxodHRw
Oi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9NFJT
T0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTVNhOTBUbEdDS0tKNWhJ
SDRpX2l3UWtSY0pvYnpnZ1REaE5XX2xiRlJodDFvMGdYRW1LdzVMUXJJb2ZDMTlSQU9icGV3
VzFWSUp3dmRDLWJrdEFFaWtJTXY3M0ltNlhpVTJNeVhtZWhvQnZaODE+DQpDYWxlbmRhciBm
b3IgMjAyNCANCldvcmtzaG9wcw0KwqANCg0KPGh0dHA6Ly90cmFja2luZy5za2lsbHNmb3Jh
ZnJpY2EuY28ua2UvdHJhY2tpbmcvY2xpY2s/ZD00UlNPR2VTNUhJNktGSml4UXB5a1VIN1NC
RFNqMEEyRWRIZGNxcUVrLUtOZU10QlZxd3IwT2I4RXRRRThFdFZFVE9jX2puTi1rczZra3dJ
T3ZlMzZZTUs0bTVFZXVHRFpjeEhvNFRNckFueUt4S25HYXdyelFyb2ZibWwtazdJMVhpaVpX
dnFncEg1VzI5WmprV3pOdjZFMT4NCkNvbnRhY3QgdXMNCsKgDQoNCjxodHRwOi8vdHJhY2tp
bmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL2NsaWNrP2Q9VGRPMWdDdVE3MWhw
V0w2MEJXTm50dXdmMklXSmZrX2tKUV9PZXg1X2VqaG80NURycklmdDZzSWdUWGhiVzR1QXlj
VHdVVzNMS3RtRWt3bTFDNFVNSFRMeHQ5M28wbG1PNjY0aEtSdUpuU3ZpUHViWVA1bkVBZjF0
LW1zQkMyQ1ZWSk84VFlPdUoxbFdxamVTWVNHcy1NNDE+DQpXaGF0YXBwDQrCoA0KT2ZmaWNl
IA0KVGVsZXBob25lOiArMjU0LTcwMi0yNDktNDQ5DQpSZWdpc3RlciANCmFzIGEgZ3JvdXAg
b2YgNSBmb3IgdGhlIHByaWNlIG9mIDQgb24gdGhlIGNvdXJzZSBmZWUuIA0KU2VuZCANCnVz
IGFuIGVtYWlsOiANCjxodHRwOi8vdHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3Ry
YWNraW5nL2NsaWNrP2Q9cmFfS3JxdXltX3ZBSDdhMHhmeWlSUlJKMG1tTW9nbnlnNTZrbVBl
SkRjT0FUZzVoUmtONGptSE13RXpGMHpndE80OEtOTnVMR1Vkd2xHMXFLalVuYlVNMkllVDBJ
Y09XYmZKbGxUNDJKc1hmNlkxOVFoV0M4b0tDZzB3R1ZoTU1zUGVvRXhKbFZUT01hclc0V0VS
c2prQTdmV0dQN0xaelNveVYyakoza2R5T0NTdGpncDYzNUVIZDRWbEswSndjNXE1MmNyc180
N3RPQWQyZlptUVVOVlowTzlrbENHcEZmNm1XY3hCcDNOc2MwPg0KdHJhaW5pbmdAc2tpbGxz
Zm9yYWZyaWNhLm9yZ8Kgb3IgDQpjYWxsICsyNTQtNzAyLTI0OS00NDkNCsKgDQpJTlRST0RV
Q1RJT04NCk1vZGVybiANCm9yZ2FuaXphdGlvbiBpbiB0aGVpciBkYWlseSBidXNpbmVzcyBm
YWNlIG1hbnkgYW5kIHNldmVyYWwgb2JzdGFjbGVzLiBUaGUgZWZmb3J0IA0KYW5kIGNvc3Qg
dGhhdCBhcmUgbmVlZGVkIHRvIG92ZXJjb21lIGlzIGNvbnNpZGVyZWQgbGFyZ2UuIFNtYXJ0
IE9yZ2FuaXphdGlvbiANCmVzc2VudGlhbGx5IG5lZWRzIGludGVsbGlnZW5jZSB0byBhY2hp
ZXZlIG1vcmUgaW4gbGVzcyB0aW1lIGFuZCB3aXRoIGxlc3MgDQpjb3N0LsKgQXJ0aWZpY2lh
bCBJbnRlbGxpZ2VuY2UgKEFJKcKgaXMgYSBmaWVsZCB0aGF0IGltaXRhdGVzIA0KaHVtYW4g
aW50ZWxsaWdlbmNlLiBBSSBoYXMgZ2FpbmVkIHJlcHV0YXRpb24gaW4gbWFueSBmaWVsZHMg
YnV0IGlzIHN0aWxsIGdyb3dpbmcgDQphbmQgaW1wcm92aW5nLg0KSW4gDQp0aGlzIHRyYWlu
aW5nIGNvdXJzZSwgeW914oCZbGwgbGVhcm4gdGhlIGJhc2ljcyBvZiBBSSBhbmQgdGhlIG1v
ZGVybiBhcHBsaWNhdGlvbnMgDQpvZiBBSS4gQUkgdGVjaG5vbG9neSBoYXMgdXNlcyBpbiBh
IHZhcmlldHkgb2YgaW5kdXN0cmllcyBmcm9tIGRlY2lzaW9uIG1ha2luZywgDQpnYW1pbmcs
IGpvdXJuYWxpc20vIG1lZGlhLCB0byBmaW5hbmNlLCBhcyB3ZWxsIGFzIGluIHRoZSBidXNp
bmVzcyBwcm9jZXNzZXMsIA0KbWVkaWNhbCBkaWFnbm9zaXMsIGFuZCBzY2llbmNlLiBNb2Rl
cm4gQUkgaW5jbHVkZSBmdXp6eSBsb2dpYywgaW50ZWxsaWdlbnQgDQphZ2VudHMsIGV4cGVy
dCBzeXN0ZW1zLCBuZXVyYWwgbmV0d29yayBhbmQgZ2VuZXRpYyBhbGdvcml0aG0uIERlbGVn
YXRlcyB3aWxsIA0KZ2FpbiBza2lsbHMgYWJvdXQgdGhlIGZ1bmRhbWVudGFscyBhbmQgYXBw
bGljYXRpb25zIG9mIEFJLg0KQ09VUlNFIA0KT0JKRUNUSVZFUw0KQnnCoHRoZcKgZW5kwqBv
ZsKgdGhlwqBjb3Vyc2UsIA0KICBwYXJ0aWNpcGFudHPCoHNob3VsZCBiZSBhYmxlIHRvOg0K
RGV2ZWxvcCANCiAgbmVjZXNzYXJ5IEFJDQpVbmRlcnN0YW5kIA0KICBob3cgdG8gcGxhbiBh
bmQgYW5hbHl6ZSB1c2luZyBsb2dpYw0KRXhwbGFpbiANCiAgaG93IHRvIGltaXRhdGUgaHVt
YW4gaW4gY2x1c3RlcmluZyBhbmQgY2xhc3NpZmljYXRpb24NClVuZGVyc3RhbmQgDQogIGhv
dyB0byBkZXNpZ24gYSBNYWNoaW5lIExlYXJuaW5nIGJhc2VkIGFwcGxpY2F0aW9ucw0KQW5h
bHlzaXMgDQogIGFuZCBEZXNpZ24gQUkgQXBwbGljYXRpb25zDQpEVVJBVElPTg0KwqDCoMKg
wqAgNSANCkRheXMNCsKgwqAgwqBXSE8gU0hPVUxEIEFUVEVORA0KVGhpcyANCmNvdXJzZSBp
cyBzdWl0YWJsZSB0byBhIHdpZGUgcmFuZ2Ugb2YgcHJvZmVzc2lvbmFscyBidXQgd2lsbCBn
cmVhdGx5IA0KYmVuZWZpdDoNClByb2plY3QgDQogIE1hbmFnZXJzDQpPZmZpY2UgDQogIE1h
bmFnZXJzDQpMZWFkZXJzDQpBbGwgDQogIHByb2Zlc3Npb25hbHMgd2hvIG5lZWQgdG8gZmls
bCB0aGUgZ2FwIGJldHdlZW4gdGhlIGN1cnJlbnQgYnVzaW5lc3Mgc2l0dWF0aW9uIA0KICBh
bmQgdGhlIEFydGlmaWNpYWwgSW50ZWxsaWdlbmNlIGNvbWluZyBlcmENCkFueW9uZSANCiAg
d2hvIGlzIGludGVyZXN0ZWQgaW4gZW5oYW5jaW5nIHRoZSBjdXJyZW50IGJ1c2luZXNzIHVz
aW5nIHdpZGUgDQogIHN0ZXBzDQpDT1VSU0UgDQpDT05URU5UDQpEYXkgDQpPbmU6IEFuIE92
ZXJ2aWV3IG9mIEFydGlmaWNpYWwgSW50ZWxsaWdlbmNlDQpJbnRyb2R1Y3Rpb24gDQogIHRv
IEFJIGFuZCBTdWNjZXNzIFN0b3JpZXMNCkh1bWFuIA0KICBJbnRlbGxpZ2VuY2UgdnMgQXJ0
aWZpY2lhbCBJbnRlbGxpZ2VuY2UNCkhpc3RvcnkgDQogIG9mIEFJDQpJbnRlbGxpZ2VudCAN
CiAgQWdlbnRzIGFuZCBUaGVpciBSb2xlcw0KTGltaXRzIA0KICBvZiBBcnRpZmljaWFsIElu
dGVsbGlnZW5jZQ0KSW50ZWxsaWdlbnQgDQogIERlY2lzaW9uIE1ha2luZ8KgDQpEYXkgDQpU
d286IEludGVsbGlnZW50IEFnZW50cw0KSW50cm9kdWN0aW9uIA0KICB0byBBZ2VudHMNCkRp
ZmZlcmVudCANCiAgVHlwZXMgb2YgQWdlbnRzDQpLbm93bGVkZ2UtYmFzZSANCiAgYW5kIERh
dGEgQmFzZQ0KTG9naWMgDQogIFJlYXNvbmluZw0KVW5pZmljYXRpb24NCkRlZHVjdGlvbiAN
CiAgUHJvY2Vzc2VzDQpEYXkgDQpUaHJlZTogTWFjaGluZSBMZWFybmluZw0KU3VwZXJ2aXNl
ZCANCiAgYW5kIFVuc3VwZXJ2aXNlZCBMZWFybmluZw0KQ2xhc3NpZmljYXRpb24gDQogIGFu
ZCBDbHVzdGVyaW5nDQpBcnRpZmljaWFsIA0KICBOZXVyYWwgTmV0d29ya3MNCkxlYXJuIA0K
ICBieSBFeGFtcGxlcw0KT2JqZWN0IA0KICBSZWNvZ25pdGlvbg0KRmVhdHVyZXMgDQogIGFu
ZCBDbGFzc2VzDQpEYXkgDQpGb3VyOiBGdXp6eSBMb2dpYw0KSW50cm9kdWN0aW9uIA0KICB0
byBGdXp6eSBUaGlua2luZw0KRnV6emluZXNzIA0KICB2cyBQcm9iYWJpbGl0eQ0KRnV6enkg
DQogIHNldCBhbmQgRnV6enkgUnVsZXMNCkltcG9ydGFuY2UgDQogIG9mIEZ1enp5IGxvZ2lj
DQpSZWFsIA0KICBleGFtcGxlIG9mIEZ1enp5IENvbnRyb2xsZXJzDQpCdWlsZGluZyANCiAg
YSBUaW55IE1hY2hpbmUgTGVhcm5pbmcgQXBwbGljYXRpb24NCkRheSANCkZpdmU6IEdlbmV0
aWMgQWxnb3JpdGhtDQpPdmVydmlldyANCiAgb2YgR2VuZXRpYyBBbGdvcml0aG1zDQpUaGUg
DQogIE5lZWQgZm9yIE9wdGltaXphdGlvbiwgTWF4aW1pemF0aW9uLCBhbmQgTWluaW1pemF0
aW9uDQpIb3cgDQogIEdBIFdvcmsgYW5kIEV2b2x2ZQ0KR2VuZXRpYyANCiAgQWxnb3JpdGht
IENocm9tb3NvbWVzLCBHZW5lcywgU2VsZWN0aW9uLCBNdXRhdGlvbiBhbmQgDQogIENyb3Nz
b3Zlcg0KRGltZW5zaW9uIA0KICB0byBVc2UgR2VuZXRpYyBBbGdvcml0aG0NClJlYWwgDQog
IEdlbmV0aWMgQWxnb3JpdGhtIEV4YW1wbGVzIHRvIE9wdGltaXplIEJ1c2luZXNzIA0KICBQ
cm9jZXNzZXMNCk1ldGhvZG9sb2d5DQpUaGUgDQppbnN0cnVjdG9yIGxlZCB0cmFpbmluZ3Mg
YXJlIGRlbGl2ZXJlZCB1c2luZyBhIGJsZW5kZWQgbGVhcm5pbmcgYXBwcm9hY2ggYW5kIA0K
Y29tcHJpc2VzIG9mIHByZXNlbnRhdGlvbnMsIGd1aWRlZCBzZXNzaW9ucyBvZiBwcmFjdGlj
YWwgZXhlcmNpc2UsIHdlYi1iYXNlZCANCnR1dG9yaWFscyBhbmQgZ3JvdXAgd29yay4gT3Vy
IGZhY2lsaXRhdG9ycyBhcmUgc2Vhc29uZWQgaW5kdXN0cnkgZXhwZXJ0cyB3aXRoIA0KeWVh
cnMgb2YgZXhwZXJpZW5jZSwgd29ya2luZyBhcyBwcm9mZXNzaW9uYWwgYW5kIHRyYWluZXJz
IGluIHRoZXNlIA0KZmllbGRzLg0KS2V5IA0KTm90ZXMNCmEuIA0KVGhlIHBhcnRpY2lwYW50
IG11c3QgYmUgY29udmVyc2FudCB3aXRoIEVuZ2xpc2guDQpiLiANCkNvdXJzZSBkdXJhdGlv
biBpcyBmbGV4aWJsZSBhbmQgdGhlIGNvbnRlbnRzIGNhbiBiZSBtb2RpZmllZCB0byBmaXQg
YW55IG51bWJlciANCm9mIGRheXMuDQpjLiANClRoZSBjb3Vyc2UgZmVlIGluY2x1ZGVzIGZh
Y2lsaXRhdGlvbiB0cmFpbmluZyBtYXRlcmlhbHMgYW5kIGEgDQpjZXJ0aWZpY2F0ZSANCnVw
b24gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIFRyYWluaW5nLg0KZC4gDQpPbmUteWVhciBw
b3N0LXRyYWluaW5nIHN1cHBvcnQgQ29uc3VsdGF0aW9uIGFuZCBDb2FjaGluZyBwcm92aWRl
ZCBhZnRlciB0aGUgDQpjb3Vyc2UuDQpUSEUgDQpFTkQNCsKgDQrCoA0KwqANCjxodHRwOi8v
dHJhY2tpbmcuc2tpbGxzZm9yYWZyaWNhLmNvLmtlL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9
THQwb3FFWEItNUlheVBVLUFwV3JuWnYtaXNITDNPbi1YRDdaSXpzQmdkdkVWdEo2UnM1WW54
S2tNVEZJcEIyYzJ3WDhiUnFwQ3FLV0RHOXpwdVd6VXcwWEx4aDRnSHNmYm1JWFlRa1Bxc0xH
MD4NClVOU1VCU0NSSUJFDQo8aHR0cDovL3RyYWNraW5nLnNraWxsc2ZvcmFmcmljYS5jby5r
ZS90cmFja2luZy9ib3RjbGljaz9tc2dpZD00UGszWVZwRVdidV83R2hiMEpxRTRBMiZjPTE0
OTM0MzA1MzQxNDYzMTU2OTk+DQo=

--=-eZCfUFLerRz6N+KpaNwQPg7J0FRIxNtx7XWKzQ==
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
style=3D'FONT-SIZE: 18pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><A=20
href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D4RSOG=
eS5HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMAWYpkzKj71cD1lq0sqMLTuGKtHOxa0VW=
xwFKT0fnt9wbJCrS8ItmmmfpQx38o-gOrVJqtqVIZSTcsPEMpLyULDWRKuxHo0UtW2z6SA=
_B8mpI1"><FONT face=3D"Times New Roman"><SPAN=20
style=3D"TEXT-DECORATION: none; FONT-WEIGHT: normal; COLOR: windowtext=
; text-underline: none"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN></SPAN><FONT color=3D#410082>=
<SPAN=20
style=3D"mso-bidi-font-family: Calibri">Seminar On Artificial Intellig=
ence=20
Essentials </SPAN><SPAN style=3D"FONT-WEIGHT: normal"><?xml:namespace =
prefix =3D "o"=20
ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></FONT></FONT></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p><SPAN=20
style=3D"TEXT-DECORATION: none"><FONT=20
face=3DCalibri></FONT></SPAN></o:p></SPAN></U>&nbsp;</P>
<P>
<TABLE class=3DMsoNormalTable=20
style=3D"WIDTH: 442.75pt; BACKGROUND: #202c45; BORDER-COLLAPSE: collap=
se; mso-yfti-tbllook: 1184"=20
cellSpacing=3D0 cellPadding=3D0 width=3D738 border=3D0>
  <THEAD>
  <TR style=3D"HEIGHT: 23.65pt; mso-yfti-irow: 0; mso-yfti-firstrow: y=
es">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.65pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-T=
OP: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; =
BACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: w=
hite'>Dates<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.65pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-T=
OP: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; =
BACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: w=
hite'>Fees<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.65pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-T=
OP: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; =
BACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: w=
hite'>Location<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.65pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-T=
OP: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; =
BACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: w=
hite'>Apply<o:p></o:p></SPAN></B></P></TD></TR></THEAD>
  <TBODY>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 1">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: =
normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>13/05/2024<B>&nbsp;-</B>&nbsp;1=
7/05/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$4500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Dubai<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAI1Hz6O=
v0y9JittEmTxJDMu2m5ZpsNnxXgjsnZLLA0vEi4jXkpyz7eNiegQBEdru4hmKI2SOhE6QC=
47PXs61OAnU1yorvBLw4pab4fKobQhCi0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIB_NsU_7=
CkZFw4NRnMBcpZ60B7NDyZYKgV8CiWe9T6UuSWvV4fg4wC7fAE1HVwoJd-ATyW18MQkShI=
myQkxtgyaq3gAT_tMg_spK8uWuZWywqM0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 2">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>10/06/2024<B>&nbsp;-</B>&nbsp;1=
4/06/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$1500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Nairobi<o:p></o:p></SPAN></P></=
TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAtkyXgL=
-AqXINAFEuNj16o6OhYdZ8WIbXxmA4tIesZjDNt_LjT8r4E5M7yUi0kGDi3rjReIw8Yjhm=
dsFhCQ1GBmVqVunESco4cGaunUlS3Njv0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBUr1-YS=
yn1mi2u7g7YZByY-EdqeVZY8LeKQ3jeHOhfq3PfCxTKs8QAUg1_Cw_nQfQWpASHE35-nYt=
WZcD5jHr5-Oxphour9QK-7UtxAYPZZYh0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 3">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>08/07/2024<B>&nbsp;-</B>&nbsp;1=
2/07/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$1500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Nairobi<o:p></o:p></SPAN></P></=
TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAqxQaXH=
5amztVd3u2bEm1jdzNpNNdWUUb6RJCP2BIIAlCEU90VtiVzj7v4UfFmrYUki0nJtPFds3x=
54lJFzuXwalN_BXpTNuVsNgrxOK_-leY0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBkUth1T=
mFPjuRqT3JJnzhT5-ZvdHYOTc5HO1AQ92SECvsnjKJKPF5MwVRdFwEnApqrgImoqUAXXV2=
ntoiaDDt1lXqL-B2JWhfwXpNAoY6HzI-0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 4">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>12/08/2024<B>&nbsp;-</B>&nbsp;1=
6/08/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$1500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Nairobi<o:p></o:p></SPAN></P></=
TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QALsstIA=
dRRS6zIiBBq83-B1H7UUqe5-Ek-_5t_4IXSMbnhtBxZL68uJrekBSnD3Wg4peAcqAe6l-H=
zSRDXeY3jv7-YUu_DN2dL7uEWguGxFzQ0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBSZMpcq=
Jn4cgGYtVyjszAJcvMXzoPTxwCz-7NjrVfS1_JWp0NOppeN7QVYzFGD2SwoVlcLg6uVVN3=
fZe-esnEjDEnSYnjF1hEqrlXaGoqmLqe0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 5">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>09/09/2024<B>&nbsp;-</B>&nbsp;1=
3/09/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$1500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Nairobi<o:p></o:p></SPAN></P></=
TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAbWvDPF=
fk5_t0QdWlUHeGchOqcKAAp1sqxurUWWxfqiAz3g3t_bi4qQ1unLGr9N2N4nWaYe7-xjQG=
9EwzuiXdvhFFghLNOjilWoPDy9cvakYi0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBCHT81C=
zczHVgNo7Cjl7r65ZhD1n5uw_7-4LyaUC3c6u6IX2qjpBU6WMIRoV0DqFROpEk2R9LlwTj=
T-m5AB30kCgHzCw6YP9wHAybeHlIv97W0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 6">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>14/10/2024<B>&nbsp;-</B>&nbsp;1=
8/10/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$2950<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Kigali<o:p></o:p></SPAN></P></T=
D>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAiN7wFc=
SVK1P2e04bCPACrgriTpZv72WjX2tlZ-SiBoA6qofX0mJ0lt-Szfu2_OByW03ru5aggqSj=
ZG8JL2oYFdwTWc2C1s4AmpLrVfV2gmAF0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBAQvSaE=
rZ1o6mXN8mRB_4S4GbUYkiT1jFsIq0xv90N6AEuqJ91ec7Jdgl2SxhBio1gjiUHS7HppI4=
v0LOI4JhQahyPAaWxfNFj7KCJ8CpeEUf0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.85pt; mso-yfti-irow: 7; mso-yfti-lastrow: ye=
s">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>11/11/2024<B>&nbsp;-</B>&nbsp;1=
5/11/2024<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>$1500<o:p></o:p></SPAN></P></TD=
>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'>Mombasa<o:p></o:p></SPAN></P></=
TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.85pt; BORDER-RIGHT: #f0f0=
f0; BORDER-BOTTOM: #dddddd 1pt solid; PADDING-BOTTOM: 6pt; PADDING-TOP=
: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BA=
CKGROUND-COLOR: transparent; mso-border-bottom-alt: solid #DDDDDD .75p=
t; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT:=
 normal"><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; COLOR: a=
liceblue; mso-bidi-font-family: Arial'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtNhqV-BW5-V_yIiDTLYH3QAL2uVRZ=
xgGio49t8_8B2jaTreSPgOSyB-F6LDVCKHF2KX5_lYd87q9A9zdFJetpuiEmXhYRYX2HNx=
b_bE9le_8YqQ0gWP87R__ZNi93jtabyP0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #ffc107; BORDER-BOTTOM: windowtext 1pt; COLOR: #212529;=
 PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT=
: windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso=
-border-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Physical Class</FONT></SPAN></A><BR><BR=
><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D=
Woapoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOZp638FHTF-ypH9iz1_mIBq1IvbW=
a1ygENmiEvpq_9cY2-cT3r_CSWDHzhLi23HyAEUMd7OkP9A0wVhkFKL4Ez77t9Y_CiMtWL=
DLPtqBoWA1oJyfNpMRlOS9IxZgLsb1Yu0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR></TBODY></T=
ABLE></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><o:p><SPAN=20
style=3D"TEXT-DECORATION: none"><FONT=20
face=3DCalibri>&nbsp;</FONT></SPAN></o:p></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p><SPAN=20
style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><A=20
href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D4RSOG=
eS5HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMSa90TlGCKKJ5hIH4i_iwQkRcJobzggTD=
hNW_lbFRht1o0gXEmKw5LQrIofC19RAObpewW1VIJwvdC-bktAEikIMv73Im6XiU2MyXme=
hoBvZ81" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Calendar for 2024=20
Workshops<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><A=20
href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3D4RSOG=
eS5HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KNeMtBVqwr0Ob8EtQE8EtVETOc_jnN-ks6=
kkwIOve36YMK4m5EeuGDZcxHo4TMrAnyKxKnGawrzQrofbml-k7I1XiiZWvqgpH5W29Zjk=
WzNv6E1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Contact us<o:p></o:p></FONT></SPAN></A></SPAN=
></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><A=20
href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3DTdO1g=
CuQ71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejho45DrrIft6sIgTXhbW4uAycTwUW3LKtm=
Ekwm1C4UMHTLxt93o0lmO664hKRuJnSviPubYP5nEAf1t-msBC2CVVJO8TYOuJ1lWqjeSY=
SGs-M41" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri"><FONT=20
face=3D"Times New Roman">Whatapp<o:p></o:p></FONT></SPAN></A></SPAN></=
U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 14pt; mso-bidi-font-family: Calibri"><FONT=20
face=3DCalibri>&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>Office=20
Telephone: +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>Register=20
as a group of 5 for the price of 4 on the course fee. <o:p></o:p></SPA=
N></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>Send=20
us an email: <A=20
 href=3D"http://tracking.skillsforafrica.co.ke/tracking/click?d=3Dra_K=
rquym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGU=
dwlG1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMsPeoExJlVTOMarW4=
WERsjkA7fWGP7LZzSoyV2jJ3kdyOCStjgp635EHd4VlK0Jwc5q52crs_47tOAd2fZmQUNV=
Z0O9klCGpFf6mWcxBp3Nsc0" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082=20
face=3D"Times New Roman">training@skillsforafrica.org&nbsp;</FONT></SP=
AN></A>or=20
call +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-AUTOSPACE: ; m=
so-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-AUTOSPACE: ; m=
so-layout-grid-align: none"><B><SPAN=20
lang=3DEN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LINE-HEIGHT: 1=
15%; mso-bidi-font-family: Calibri; mso-ansi-language: EN'>INTRODUCTIO=
N</SPAN></B><SPAN=20
lang=3DEN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 17.15pt"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Modern=20
organization in their daily business face many and several obstacles. =
The effort=20
and cost that are needed to overcome is considered large. Smart Organi=
zation=20
essentially needs intelligence to achieve more in less time and with l=
ess=20
cost.&nbsp;<B>Artificial Intelligence (AI)</B>&nbsp;is a field that im=
itates=20
human intelligence. AI has gained reputation in many fields but is sti=
ll growing=20
and improving.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 17.15pt"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>In=20
this training course, you&rsquo;ll learn the basics of AI and the mode=
rn applications=20
of AI. AI technology has uses in a variety of industries from decision=
 making,=20
gaming, journalism/ media, to finance, as well as in the business proc=
esses,=20
medical diagnosis, and science. Modern AI include fuzzy logic, intelli=
gent=20
agents, expert systems, neural network and genetic algorithm. Delegate=
s will=20
gain skills about the fundamentals and applications of AI.<o:p></o:p><=
/SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>By&nbsp;the&nbsp;end&nbsp;of&nbsp;the&nbsp;course,=20
  participants&nbsp;should be able to:<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Develop=20
  necessary AI<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Understand=20
  how to plan and analyze using logic<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Explain=20
  how to imitate human in clustering and classification<o:p></o:p></SP=
AN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Understand=20
  how to design a Machine Learning based applications<o:p></o:p></SPAN=
></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Analysis=20
  and Design AI Applications<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>DURATION</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 17.15pt"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>5=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt;=
 LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>WHO SHOULD ATTEND</SPAN></B><=
SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
36pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>This=20
course is suitable to a wide range of professionals but will greatly=20
benefit:</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Project=20
  Managers<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Office=20
  Managers<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Leaders<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>All=20
  professionals who need to fill the gap between the current business =
situation=20
  and the Artificial Intelligence coming era<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Anyone=20
  who is interested in enhancing the current business using wide=20
  steps<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>COURSE=20
CONTENT</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Day=20
One: An Overview of Artificial Intelligence</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Introduction=20
  to AI and Success Stories<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Human=20
  Intelligence vs Artificial Intelligence<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>History=20
  of AI<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Intelligent=20
  Agents and Their Roles<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Limits=20
  of Artificial Intelligence<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Intelligent=20
  Decision Making<B>&nbsp;</B><o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Day=20
Two: Intelligent Agents</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Introduction=20
  to Agents<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Different=20
  Types of Agents<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Knowledge-base=20
  and Data Base<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Logic=20
  Reasoning<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Unification<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Deduction=20
  Processes<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Day=20
Three: Machine Learning</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Supervised=20
  and Unsupervised Learning<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Classification=20
  and Clustering<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Artificial=20
  Neural Networks<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Learn=20
  by Examples<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Object=20
  Recognition<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Features=20
  and Classes<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Day=20
Four: Fuzzy Logic</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Introduction=20
  to Fuzzy Thinking<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Fuzziness=20
  vs Probability<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Fuzzy=20
  set and Fuzzy Rules<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Importance=20
  of Fuzzy logic<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Real=20
  example of Fuzzy Controllers<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Building=20
  a Tiny Machine Learning Application<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12pt =
18pt; LINE-HEIGHT: 17.15pt"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'>Day=20
Five: Genetic Algorithm</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACING=
: 0.7pt'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Overview=20
  of Genetic Algorithms<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>The=20
  Need for Optimization, Maximization, and Minimization<o:p></o:p></SP=
AN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>How=20
  GA Work and Evolve<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Genetic=20
  Algorithm Chromosomes, Genes, Selection, Mutation and=20
  Crossover<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Dimension=20
  to Use Genetic Algorithm<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 12p=
t; LINE-HEIGHT: 17.15pt; mso-list: l0 level1 lfo1; tab-stops: list 36.=
0pt"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; LETTER-SPACI=
NG: 0.7pt'>Real=20
  Genetic Algorithm Examples to Optimize Business=20
  Processes<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: 15pt"><B><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>Methodology</SPAN></B><SPAN=
=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>The=20
instructor led trainings are delivered using a blended learning approa=
ch and=20
comprises of presentations, guided sessions of practical exercise, web=
-based=20
tutorials and group work. Our facilitators are seasoned industry exper=
ts with=20
years of experience, working as professional and trainers in these=20
fields.</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><B><U><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>Key=20
Notes</SPAN></U></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>a.=20
The participant must be conversant with English</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>b.=20
Course duration is flexible and the contents can be modified to fit an=
y number=20
of days.</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>c</SPAN><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>.=20
The course fee includes facilitation training materials and </SPAN><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>a=20
c</SPAN><SPAN lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>ertificate=20
upon successful completion of Training.</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 7.5pt=
; LINE-HEIGHT: normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>d</SPAN><SPAN=20
lang=3Den-KE=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri; mso-ansi-language: #0C00'>.=20
One-year post-training support Consultation and Coaching provided afte=
r the=20
course.</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt =
36pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; mso-line-=
height-alt: 11.2pt"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Cambria",serif; mso-bidi-font-=
family: Calibri'>THE=20
END<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><SPAN=
=20
style=3D'FONT-FAMILY: "Calibri",sans-serif'><o:p>&nbsp;</o:p></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-bidi-font-family: Cal=
ibri"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"http://tracking.skillsforafrica.co.ke/tracking/open?msgid=3D=
4Pk3YVpEWbu_7Ghb0JqE4A2&c=3D1493430534146315699" style=3D"width:1px;he=
ight:1px" alt=3D"" /><div style=3D"text-align:center; background-color=
:#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:s=
ans-serif;"><a href=3D"http://tracking.skillsforafrica.co.ke/tracking/=
unsubscribe?d=3DLt0oqEXB-5IayPU-ApWrnZv-isHL3On-XD7ZIzsBgdvEVtJ6Rs5Ynx=
KkMTFIpB2c2wX8bRqpCqKWDG9zpuWzUw0XLxh4gHsfbmIXYQkPqsLG0" style=3D"text=
-align:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div><=
a style=3D "display : none;" href=3D"http://tracking.skillsforafrica.c=
o.ke/tracking/botclick?msgid=3D4Pk3YVpEWbu_7Ghb0JqE4A2&c=3D14934305341=
46315699"></a>
--=-eZCfUFLerRz6N+KpaNwQPg7J0FRIxNtx7XWKzQ==--
