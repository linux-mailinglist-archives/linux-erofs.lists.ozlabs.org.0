Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D04DD6C2F64
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Mar 2023 11:48:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PgpGz6hhnz3cd9
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Mar 2023 21:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=mb46ru3m;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=Id+bVbXD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.85.231; helo=m231.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=mb46ru3m;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=Id+bVbXD;
	dkim-atps=neutral
X-Greylist: delayed 75823 seconds by postgrey-1.36 at boromir; Tue, 21 Mar 2023 21:48:02 AEDT
Received: from m231.mxout.mta4.net (m231.mxout.mta4.net [67.227.85.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PgpGp2C3Fz3byj
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Mar 2023 21:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1679395658;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=HjnjCAJOcAHfbmA1PmyY+8jW+cbUuZ715YQi85JAM74=;
	b=mb46ru3m06sczKyXcGqH+kWWTHJmCSzZOTIHxs7cYuPFYzKyc/cScyPe5d/j+xGjs9pqId4tBhy
	6d0mMZkOewtLApJxpelebeAse4jmbvsrAlPxSdD2MnmHmfILMIYRvboT9zpAOilewsJRLSySk1MIp
	9LkIo+svVug6NJxEo5E=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1679395658;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=HjnjCAJOcAHfbmA1PmyY+8jW+cbUuZ715YQi85JAM74=;
	b=Id+bVbXDtfFwdAreH0Z1kO3ub8zWRrEt5q0qk4JivyZSQkp1Harhcl/VgYYKzW7BS3Q0N3OUIqS
	aaXb1lNlJUaM6ZoKOerVTjl9bbzxckHDMTSGcickPlJA+wV1Y7z00/tKhFPCXdyp3GUP5h16pTVkP
	0ZPU8DHUWhLCwGgQfxo=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Tue, 21 Mar 2023 10:47:38 +0000
Subject: TRAINING COURSE ON ADVANCED CYBER SECURITY, SYSTEMS AUDIT AND ICT
 COUNTER INTELLIGENCE SOLUTIONS
Message-Id: <4ujh9o71r86h.lYio8OdJKEISFgsgc-w5kQ2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: lYio8OdJKEISFgsgc-w5kQ2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfCFvc8X3jI+21T+AcTy7S1Qcvwqsu/XWKzQ=="
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

--=-eZCfCFvc8X3jI+21T+AcTy7S1Qcvwqsu/XWKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9k
PTRSU09HZVM1SEk2S0ZKaXhRcHlrVUg3U0JEU2owQTJFZEhkY3FxRWstS09LVEVMZUxzSllo
Zmd0OVRoMDZJTVB0cGxLT3U4Q29RTzFDTk1aay1QLUJnaGM4emExN0hsbU8xTHBDTTk4SnM2
cElsUTdWNmsyNU9HN1hlVmRIWmxpTjVrajhpcTY1OGF1enRiN2VHaC1lVEkxPg0KVFJBSU5J
TkcgQ09VUlNFIE9OIEFEVkFOQ0VEIENZQkVSIFNFQ1VSSVRZLCBTWVNURU1TIEFVRElUIA0K
QU5EIElDVCBDT1VOVEVSIElOVEVMTElHRU5DRSBTT0xVVElPTlMNCg0KRGF0ZXMNCkZlZXMN
CkxvY2F0aW9uDQpBcHBseQ0KMDMvMDQvMjAyM8KgLcKgMTQvMDQvMjAyMw0KJDI3MDANCk5h
aXJvYmkNCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcv
Y2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRPcXBt
TEJ4WHkweUJGYkhYcGdyZG9QejFYU1J2eUlBa2hVQi1Hb2NVS1ZnV3Vwd0hfVVhGVnp0ejZ0
RlFfb1psYmU0UjRic25Kd1hEVmJpVHRHWHRreTh5TndfV3gzR3B1aFZneDNpc3NXNi1HZnQ0
eWdkWmstWGFkMEc5LXVxdjVGMD4NClBoeXNpY2FsIENsYXNzDQoNCg0KPGh0dHBzOi8vMTMz
SUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmho
NzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRNTnJ5RnU1cVc3S25ueXVvUld4VE11LXdv
N2RFWlgxN1BSUWE0VzI0TXNyRjhSZzMxSnlPeDczbkctbGVrWHBaY3E0cUtYa3lVZl9fcUxh
ZlMzR0RROTBRQXpReDBha3JPeGJjN2o0QU02cThQemtBdHM0T1k0cHRoaFZyM3NNSlhsMD4N
Ck9ubGluZSANCiAgICBDbGFzcw0KMDEvMDUvMjAyM8KgLcKgMTIvMDUvMjAyMw0KJDQ1MDAN
CkR1YmFpDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5n
L2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0T3Fw
bUxCeFh5MHlCRmJIWHBncmRvUE1vcHM3eXVaRlN2V01NMU95ejM4SGZHQ3dHRXcxcGdlTnV3
RDF6WVlNdW44VXpmcVhsUHIzY0Y2VWc0YzVTLTBmZ0xxOUZTQVhjYkFjZWRfSkFubDBSU3Bm
dnF4M1dfX3BjZk9wTjdXVGZmYzA+DQpQaHlzaWNhbCBDbGFzcw0KDQoNCjxodHRwczovLzEz
M0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBUckZo
aDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TU5yeUZ1NXFXN0tubnl1b1JXeFRNdTY2
aHF6LVl6OW1Sd3UzdUZ2NEp5V2tNcGcxWTRwVlZnZTgtSUtIQTJ6VHdEUG9QOXhWaWdQSEd5
dUJwRnB3a0laRlJNNU9Wc0g3X0VoSGhpMWZhS1RsdnVtUkJzZWs2VkJ3b2VJNlVzUHdMaDA+
DQpPbmxpbmUgDQogICAgQ2xhc3MNCjA1LzA2LzIwMjPCoC3CoDE2LzA2LzIwMjMNCiQzMDAw
DQpNb21iYXNhDQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNr
aW5nL2NsaWNrP2Q9V29hcG95LXBUckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0
T3FwbUxCeFh5MHlCRmJIWHBncmRvUEQ2V2pJUWVvbTZ5RnZiU1NYUnJsUF9PU3l5MUtld1ZU
a0JOYWl5Q3BIamRPcmNtZVUtTVZELURXbmV3aFNkblhRRTJ1SmZrWUdqUHh0R3J6cGlVbFI5
UG1SLVE3X21SUEQ3S08zLVdTbi05czA+DQpQaHlzaWNhbCBDbGFzcw0KDQoNCjxodHRwczov
LzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9V29hcG95LXBU
ckZoaDc5MlJIZUo5LVJ0MjI1WVlzUG1Xak5Xc3FxclR0TU5yeUZ1NXFXN0tubnl1b1JXeFRN
dTJTVVRMaXZuS05FSVRvN0NhMFJsdzhNd3UtUlZLWmt2WGRIWUpGME1WVXVWcWw5YTB3czBW
WlpFQWRCZ010bVZCRUFaVXFodm5qc1lrc3ZOWmhBMWxJUGd4YTZjTWxlck9yNnZ2bm5sRlhF
dTA+DQpPbmxpbmUgDQogICAgQ2xhc3MNCjAzLzA3LzIwMjPCoC3CoDE0LzA3LzIwMjMNCiQz
NTAwDQpLaWdhbGkNCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJh
Y2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFy
VHRPcXBtTEJ4WHkweUJGYkhYcGdyZG9QSExZRWxoM3JWdG14d1RjVm9IVDBBeUp2ZVNLZ3pS
SXJZNDBBYnB3anRySjZVM2g1M01kSVpVc1lDQWJIemFORnB5d3loaTBGZlRUYWhwd1pVb1g3
dGNCR2psMG1PbTAzTXJMU0VFRGxVUWVRMD4NClBoeXNpY2FsIENsYXNzDQoNCg0KPGh0dHBz
Oi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3kt
cFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRNTnJ5RnU1cVc3S25ueXVvUld4
VE11c3pGN2kyZXlMekJtZ1dxeGJ6M2pHNC1IQ2ZPSnlxSmZ0dnJ0QnhlTTVHSmotQ29XQk5J
ZG8ySFdTTEctT1ZHT1JfZVAxQ05ONzMtTDdSUFBYVTB0Q1R5MkgzZU5zYlp3RGVjQTNvSXNn
TDdlMD4NCk9ubGluZSANCiAgICBDbGFzcw0KMDcvMDgvMjAyM8KgLcKgMTgvMDgvMjAyMw0K
JDI3MDANCk5haXJvYmkNCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20v
dHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldz
cXFyVHRPcXBtTEJ4WHkweUJGYkhYcGdyZG9QWlVSbWxBdjZUV1haZEkzdmk4VzF2bjl6V2Z3
RkJSS3ZoUGt0RmVHS3BMNEhmdFN1MTNkcnZiejM0TlR3R2p4OV8wNXNjZmhyV0xicjBCTlRw
NGxkNWJSbHlqcDdzSlNfSGM5ZktZLTJCRk9RMD4NClBoeXNpY2FsIENsYXNzDQoNCg0KPGh0
dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fw
b3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRNTnJ5RnU1cVc3S25ueXVv
Uld4VE11eTd0Nzg1Mlp2UllDY2JvSHd1NjM5b3lGY21hTlpXS3dpaHJENnJISVNIX0lZT0J4
Nk1VcE02aTBRV1NLa2ZHV1lHMXRtckZsdW1fRFJFZW5pNGpMNEJXY2ZNR2RWUjRTUDJNckM4
TkxFVW1LMD4NCk9ubGluZSANCiAgICBDbGFzcw0KMDQvMDkvMjAyM8KgLcKgMTUvMDkvMjAy
Mw0KJDMwMDANCk1vbWJhc2ENCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5j
b20vdHJhY2tpbmcvY2xpY2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdq
TldzcXFyVHRPcXBtTEJ4WHkweUJGYkhYcGdyZG9QN0x2eGFTdU5NU0VqeTh4QktDT0wzdl9J
TVFYUVo4ZXBoS3lGY0V6MzBQVFZEcGNURE91dUlhQW5LblBkb29sUVFES0J6SEdLd01BVGhX
RXpKa25kYk5objNuVXhLUlJ2YTYteV9uYjJXN2o3MD4NClBoeXNpY2FsIENsYXNzDQoNCg0K
PGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1X
b2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRNTnJ5RnU1cVc3S25u
eXVvUld4VE11RW5ZZWpqWVZwQlgzdXg3MWJOU2N5QXYyWDJpenpMZGxfekZ2VW9jSHkxQV9H
bGpEblkxVHhITmljUDdlN0xMOXJaeEE0dE1sa0IzNEptTmdoNXVUWVY3S2xUMXNzMm1iQ1gy
LVRLTlNzQ1BPMD4NCk9ubGluZSANCiAgICBDbGFzcw0KMDIvMTAvMjAyM8KgLcKgMTMvMTAv
MjAyMw0KJDM1MDANCktpZ2FsaQ0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWls
LmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1Bt
V2pOV3NxcXJUdE9xcG1MQnhYeTB5QkZiSFhwZ3Jkb1BueG1rTktsXzduT2lBM3VfOFc5NkNq
LXhFSHotWlFkY2NRRi1mMG9ZbkYwcVdCaEFURm5WZzNNcHRnemRmclFOUk5Qay1uMUhIUXBN
Y0VPTXdkYm5rZVU0dzBwVzJPMHc1Zml6cm1ROUhYa3AwPg0KUGh5c2ljYWwgQ2xhc3MNCg0K
DQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9k
PVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE1OcnlGdTVxVzdL
bm55dW9SV3hUTXVSTjFBcGhBMGRTQjlFN0dUbWhMVnZaSGw3czRsaWZXM280bjk5eC1iUmV2
YkNMZ24xdFBLX3NnZDNvN09JczJiclhSdE8zQ3pHREFFdUhNT1hUUEZLVUE1QW4tSkRrTEJO
WmlYbHJfZExEY2owPg0KT25saW5lIA0KICAgIENsYXNzDQowNi8xMS8yMDIzwqAtwqAxNy8x
MS8yMDIzDQokMzAwMA0KTW9tYmFzYQ0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2Vt
YWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZ
c1BtV2pOV3NxcXJUdE9xcG1MQnhYeTB5QkZiSFhwZ3Jkb1BYQ055U2lmNEtOOGF3cXVyVUgy
cHFiUGN5QlNZYzhmZlg1N2w0N3UtRWZuZkxBSWJWMU9xTHlaZUg2LTVpVlYwWG9RUVBWWkgw
amd3RkpLYlRzd3pmVDdkNVIwMFlFd25aWmZOcVB5VC1tZEEwPg0KUGh5c2ljYWwgQ2xhc3MN
Cg0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGlj
az9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE1OcnlGdTVx
VzdLbm55dW9SV3hUTXU1bllxZk5SeXJJUDNNZWFobkR6SmwzMjZKY2ZYWDJ1N2kwT0h0XzZO
V1YyQVExY01TUzNiVkY4dHNSdUcxOHphdWFsc0pwSWxQZDVTaW8tRUM5TWtYRnFuektaNXln
ZmN2c25ZSzVwcXUxemswPg0KT25saW5lIA0KICAgIENsYXNzDQowNC8xMi8yMDIzwqAtwqAx
NS8xMi8yMDIzDQokMjcwMA0KTmFpcm9iaQ0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3Rp
Y2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIy
NVlZc1BtV2pOV3NxcXJUdE9xcG1MQnhYeTB5QkZiSFhwZ3Jkb1AtY2Z2dnkyTjZtQUp1d1ho
aU9MYUFmZHI4dTVrcWtTWWZqeXppSTlIVVk0MUZPc3dWaWlEN2hoUjFGMkRzVnpQeEF6QV8x
dkd5M3lOZkZ5Uk04cGl2Ym5BcXhPZE1HbkJzcm9nUXpyVVB4aDYwPg0KUGh5c2ljYWwgQ2xh
c3MNCg0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9j
bGljaz9kPVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE1OcnlG
dTVxVzdLbm55dW9SV3hUTXVJZzA3Nm1LbmZwSnV4QVloQUQ2X01GN2ljRW9wZlFLTXg2LUpw
bHd3b21WNWpkVGM4YmdLOC1zajRrdHk1ZXN0ZVNsdlhBcjZUMjVfLU9Na2ZlMXloMXlWMGU5
dHBWY2dfSlJTY1RUSTJuZUwwPg0KT25saW5lIA0KICAgIENsYXNzDQoNCjxodHRwczovLzEz
M0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9NFJTT0dlUzVISTZL
RkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTlRGRk5ZNmpMVGxhbm5Uc0ZOcDEtZTF6
NWc2ckVVSGJ0NTVtd2x3WkRVaG45dXNlbFFPazQyVG90REZuWFdZU3UyWk5vMEh3QVV0cDJ0
QktMYjJpMWJVeThfQW82YmVHbTJXUEJhUmYzWXpCMDE+DQpDYWxlbmRhciBmb3IgMjAyMyAN
CldvcmtzaG9wcw0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20v
dHJhY2tpbmcvY2xpY2s/ZD00UlNPR2VTNUhJNktGSml4UXB5a1VIN1NCRFNqMEEyRWRIZGNx
cUVrLUtNLWNnZGQ5M2VyOG9pREQ5UlZXc2hpWE1uaWIzY25vdEdtb3dGcDdFenc2QlVnY2I0
R2twcTdPUnN5R2VINDhzcWRTVUFOM3VHTWdOOV9vSU1WRzdfam9IOWxldFdZRzQwWmFidEhm
dV9wQ25ZMT4NCkNvbnRhY3QgDQp1cw0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0
aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1UZE8xZ0N1UTcxaHBXTDYwQldObnR1d2Yy
SVdKZmtfa0pRX09leDVfZWpqeEt3TzllOFhHc0tuYklpSTZ1WjlQbkNRMzV6UldjYzV4Q1lO
RFBldmZVTHhtV3YxRmF6TXl5ME5kRXhMWEdjSDhYc0JoMC15SjUxQWN5QUhwTmZ0MVBoNkpf
Vm1CQmNXVWpsZ2NoeDV0SVlFMT4NCldoYXRhcHANCsKgDQpJTlRST0RVQ1RJT04NCkluZm9y
bWF0aW9uIA0KYW5kIGtub3ctaG93IGFyZSB2YWx1YWJsZSBjb21wYW55IGFzc2V0cywgYW5k
IGluIHRpbWVzIG9mIGZpZXJjZSBjb21wZXRpdGlvbiwgDQpvcmdhbml6YXRpb25zIG5lZWQg
dG8gcHJvdGVjdCB0aGVpciBpbmZvcm1hdGlvbiBhbmQgc3lzdGVtcyBhZ2FpbnN0IHRoZSB0
aHJlYXQgDQpvZiBjb3Jwb3JhdGUgZXNwaW9uYWdlLiBNYW55IG9yZ2FuaXphdGlvbnMgYXJl
IHVuYXdhcmUgb2YgcG90ZW50aWFsIGluZm9ybWF0aW9uIA0KbGVha3MsIGFuZCBhcyBhIHJl
c3VsdCBjb3VudGVyaW50ZWxsaWdlbmNlIG9wZXJhdGlvbnMgYXJlIG5lZ2xlY3RlZCBvciBh
cmUgDQpzaW1wbHkgYSBzZXJpZXMgb2Ygcm91dGluZSB0ZWNobmljYWwgbWVhc3VyZXMuIEhv
d2V2ZXIsIGVtcGxveWVlcyB0eXBpY2FsbHkgDQpyZXByZXNlbnQgYSBtYWpvciB3ZWFrIHNw
b3QgZm9yIG9yZ2FuaXphdGlvbnMg4oCTIHdoaWNoIG1lYW5zIHRoYXQgZXhpc3RpbmcgDQpw
cm9jZXNzZXMgYW5kIHN0cnVjdHVyZXMgZm9yIGluZm9ybWF0aW9uIGZsb3dzIG5lZWQgdG8g
YmUgDQpjaGFsbGVuZ2VkLg0KRW1waXJpY2FsIA0KcmVzZWFyY2ggaW5kaWNhdGVzIHRoYXQg
bW9zdCBpbmZvcm1hdGlvbiBsb3NzZXMgYXJlIHRyYWNlZCBiYWNrIHRvIGEgY29tcGFueeKA
mXMgDQplbXBsb3llZXMsIG9yIHRoZSBwZXJzb25uZWwgb2YgaXRzIHN1cHBsaWVycywgY3Vz
dG9tZXJzLCBvciBwYXJ0bmVycyDigJMgYWxsIG9mIA0Kd2hvbSBoYXZlIGFjY2VzcyB0byBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24uDQpUaGUgDQp0cmFpbmluZyB3aWxsIGxvb2sgYXQg
dGhlIGRpZmZlcmVudCB0aHJlYXRzIG9yZ2FuaXphdGlvbnMgbWlnaHQgZmFjZSBhbmQgd2F5
cyBpbiANCndoaWNoIHRoZXkgY2FuIHByb3RlY3QgYW5kIHNlY3VyZSBpdCBhZ2FpbnN0IGF0
dGFja3MuIFBhcnRpY2lwYW50cyB3aWxsIGFsc28gDQpsZWFybiBob3cgdG8gc2V0IHVwIGNv
dW50ZXJpbnRlbGxpZ2VuY2UgcHJvY2Vzc2VzIHRoYXQgaW52b2x2ZSBjb2xsZWN0aW5nIA0K
aW5mb3JtYXRpb24gYW5kIGNvbmR1Y3RpbmcgY291bnRlcmludGVsbGlnZW5jZSBhY3Rpdml0
aWVzLg0KQ291cnNlIA0KT2JqZWN0aXZlcw0KQnkgDQp0aGUgZW5kIG9mIHRoaXMgY291cnNl
LCBwYXJ0aWNpcGFudHMgc2hvdWxkIGJlIGFibGUgdG86DQrCt8KgwqDCoMKgwqDCoCANCktu
b3cgdGhlIHB1cnBvc2Ugb2YgYSANCmN5YmVyc2VjdXJpdHkgYXVkaXQNCsK3wqDCoMKgwqDC
oMKgIA0KRGVmaW5lIGN5YmVyc2VjdXJpdHkgYXVkaXQgDQpjb250cm9scw0KwrfCoMKgwqDC
oMKgwqAgDQpJZGVudGlmeSBjeWJlcnNlY3VyaXR5IGF1ZGl0IA0KZnJhbWV3b3Jrcw0KwrfC
oMKgwqDCoMKgwqAgDQpFeHBsYWluIHByb3BlciBhdWRpdCB0ZWFtIA0KcGVyZm9ybWFuY2UN
CsK3wqDCoMKgwqDCoMKgIA0KRGVmaW5lIHRoZSBiZW5lZml0cyBvZiBhIA0KY3liZXJzZWN1
cml0eSBhdWRpdA0KwrfCoMKgwqDCoMKgwqAgDQpMZWFybiBob3cgdG8gaWRlbnRpZnkgdnVs
bmVyYWJsZSANCnBvaW50cyB3aXRoaW4geW91ciBvcmdhbml6YXRpb24gYW5kIGhvdyB0byBz
ZWN1cmUgdGhlbS4NClJ1biANCiAgYXdhcmVuZXNzIGNhbXBhaWducyBhbW9uZyB5b3VyIGNv
bGxlYWd1ZXMgaW4gb3JkZXIgdG8gcmFpc2UgYXdhcmVuZXNzIG9mIA0KICBlc3Bpb25hZ2Ug
dGhyZWF0cyBhbmQgcHJvdGVjdCB0aGVtIGZyb20gYXR0YWNrcy4NCkRldmVsb3AgDQogIGlu
LWRlcHRoIGtub3dsZWRnZSBvZiB0aGUgdmFyaW91cyBmb3JtcyBvZiBjb250ZW1wb3Jhcnkg
ZXNwaW9uYWdlIA0KICB0aHJlYXRzLg0KTWFzdGVyIA0KICBob3cgdG8gaWRlbnRpZnksIG1v
bml0b3IsIGFuZCBldmFsdWF0ZSBpbmZvcm1hdGlvbiANCiAgcmlza3MuDQpCZWNvbWUgDQog
IGZhbWlsaWFyIHdpdGggZXRoaWNhbCBhbmQgbGVnYWwgY291bnRlcmludGVsbGlnZW5jZSBh
Y3Rpdml0aWVzIGFuZCANCiAgdGVjaG5pcXVlcy4NClNlaXplIA0KICB0aGUgb3Bwb3J0dW5p
dHkgdG8gc2hhcmUgZXhwZXJpZW5jZSBhbmQga25vd2xlZGdlIHdpdGggY29tcGV0aXRpdmUv
bWFya2V0IA0KICBpbnRlbGxpZ2VuY2UgZXhwZXJ0cyBhbmQgcGVlcnMgZnJvbSBhIHJhbmdl
IG9mIGluZHVzdHJpZXMuDQpEdXJhdGlvbg0KMTQgDQpEYXlzDQpXaG8gDQpzaG91bGQgQXR0
ZW5kDQrCt8KgwqDCoMKgwqDCoCANCkluZGl2aWR1YWxzIGludm9sdmVkIGluIA0KY3liZXJz
ZWN1cml0eSBtYW5hZ2VtZW50DQrCt8KgwqDCoMKgwqDCoCANCkxlYXJuaW5nIGFuZCBkZXZl
bG9wbWVudCANCnByb2Zlc3Npb25hbHMNCsK3wqDCoMKgwqDCoMKgIA0KSW50ZXJuYWwgDQph
dWRpdG9ycw0KSVQgDQogIHByb2Zlc3Npb25hbHMgYW5kIG1hbmFnZXJzIHdvcmtpbmcgd2l0
aCBpbmZvcm1hdGlvbiBzeXN0ZW1zLCB3aG8gbmVlZCB0byANCiAgdW5kZXJzdGFuZCBiZXN0
IHByYWN0aWNlcyBhbmQgc3RhbmRhcmRzIHRvIGVuc3VyZSBzZWN1cml0eSBhbmQgaW50ZWdy
aXR5IG9mIA0KICB0aGVzZSBzeXN0ZW1zDQrCt8KgwqDCoMKgwqDCoCANCkluZGl2aWR1YWxz
IHNlZWtpbmcgdG8gZ2FpbiANCmtub3dsZWRnZSBhYm91dCB0aGUgbWFpbiBwcm9jZXNzZXMg
b2YgYXVkaXRpbmcgYSBjeWJlcnNlY3VyaXR5IA0KcHJvZ3JhbQ0KwrfCoMKgwqDCoMKgwqAg
DQpJbmRpdmlkdWFscyBpbnRlcmVzdGVkIHRvIHB1cnN1ZSANCmEgY2FyZWVyIGluIGN5YmVy
c2VjdXJpdHkgYXVkaXQNCkNvbXBldGl0aXZlL01hcmtldCANCiAgSW50ZWxsaWdlbmNlIEFu
YWx5c3RzIGFuZCBNYW5hZ2Vycw0KS25vd2xlZGdlIA0KICBhbmQgSW5mb3JtYXRpb24gTWFu
YWdlcnMNClNwZWNpYWxpc3RzIA0KICBmcm9tIFImRCwgVGVjaG5vbG9neSBhbmQgUmlzayBN
YW5hZ2VtZW50DQpDT1VSU0UgDQpDT05URU5UDQpXaGF0IA0KaXMgYSBDeWJlcnNlY3VyaXR5
IEF1ZGl0Pw0KwrfCoMKgwqDCoMKgwqAgDQpJbnRyb2R1Y3Rpb24NCsK3wqDCoMKgwqDCoMKg
IA0KV2hhdCBpcyBhIEN5YmVyc2VjdXJpdHkgDQpBdWRpdD8NCsK3wqDCoMKgwqDCoMKgIA0K
V2hlbiB0byBQZXJmb3JtIGEgQ3liZXJzZWN1cml0eSANCkF1ZGl0DQpDb250cm9scyANCmFu
ZCBGcmFtZXdvcmtzDQrCt8KgwqDCoMKgwqDCoCANCkN5YmVyc2VjdXJpdHkgQXVkaXQgDQpD
b250cm9scw0KwrfCoMKgwqDCoMKgwqAgDQpDeWJlcnNlY3VyaXR5IEF1ZGl0IA0KRnJhbWV3
b3Jrcw0KQ29tcGxldGluZyANCnRoZSBBdWRpdA0KwrfCoMKgwqDCoMKgwqAgDQpUaGUgQXVk
aXQNCsK3wqDCoMKgwqDCoMKgIA0KQXVkaXQgDQpDb21wbGV0aW9uDQpVbmRlcnN0YW5kaW5n
IA0KQ3liZXIgVGhyZWF0IEludGVsbGlnZW5jZQ0KwrfCoMKgwqDCoMKgwqAgDQpEZWZpbmlu
ZyANClRocmVhdHMNCsK3wqDCoMKgwqDCoMKgIA0KVW5kZXJzdGFuZGluZyANClJpc2sNCsK3
wqDCoMKgwqDCoMKgIA0KQ3liZXIgVGhyZWF0IEludGVsbGlnZW5jZSBhbmQgDQpJdHMgUm9s
ZQ0KwrfCoMKgwqDCoMKgwqAgDQpFeHBlY3RhdGlvbiBvZiBPcmdhbml6YXRpb25zIGFuZCAN
CkFuYWx5c3RzDQrCt8KgwqDCoMKgwqDCoCANCkRpYW1vbmQgTW9kZWwgYW5kIEFjdGl2aXR5
IA0KR3JvdXBzDQrCt8KgwqDCoMKgwqDCoCANCkZvdXIgVHlwZXMgb2YgVGhyZWF0IA0KRGV0
ZWN0aW9uDQrCt8KgwqDCoMKgwqDCoCANClByb2Nlc3Mgb2YgYXVkaXRpbmcgaW5mb3JtYXRp
b24gDQpzeXN0ZW1zDQrCt8KgwqDCoMKgwqDCoCANCkdvdmVybmFuY2UgYW5kIG1hbmFnZW1l
bnQgb2YgDQpJVA0KwrfCoMKgwqDCoMKgwqAgDQpJbmZvcm1hdGlvbiBzeXN0ZW1z4oCZIA0K
YWNxdWlzaXRpb24sIGRldmVsb3BtZW50IGFuZCBpbXBsZW1lbnRhdGlvbg0KwrfCoMKgwqDC
oMKgwqAgDQpQcm90ZWN0aW9uIG9mIGluZm9ybWF0aW9uIA0KYXNzZXRzDQrCt8KgwqDCoMKg
wqDCoCANCkluZm9ybWF0aW9uIHN5c3RlbXPigJkgb3BlcmF0aW9uLCANCm1haW50ZW5hbmNl
IGFuZCBzZXJ2aWNlIG1hbmFnZW1lbnQNClRocmVhdCANCkludGVsbGlnZW5jZSBDb25zdW1w
dGlvbg0KwrfCoMKgwqDCoMKgwqAgDQpTbGlkaW5nIFNjYWxlIG9mIA0KQ3liZXJzZWN1cml0
eQ0KwrfCoMKgwqDCoMKgwqAgDQpDb25zdW1pbmcgSW50ZWxsaWdlbmNlIGZvciANCkRpZmZl
cmVudCBHb2Fscw0KwrfCoMKgwqDCoMKgwqAgDQpFbmFibGluZyBPdGhlciBUZWFtcyB3aXRo
IA0KSW50ZWxsaWdlbmNlDQpQb3NpdGlvbmluZyANCnRoZSBUZWFtIHRvIEdlbmVyYXRlIElu
dGVsbGlnZW5jZQ0KwrfCoMKgwqDCoMKgwqAgDQpCdWlsZGluZyBhbiBJbnRlbGxpZ2VuY2Ug
DQpUZWFtDQrCt8KgwqDCoMKgwqDCoCANClBvc2l0aW9uaW5nIHRoZSBUZWFtIGluIHRoZSAN
Ck9yZ2FuaXphdGlvbg0KwrfCoMKgwqDCoMKgwqAgDQpQcmVyZXF1aXNpdGVzIGZvciBJbnRl
bGxpZ2VuY2UgDQpHZW5lcmF0aW9uDQpQbGFubmluZyANCmFuZCBEaXJlY3Rpb24gKERldmVs
b3BpbmcgUmVxdWlyZW1lbnRzKQ0KwrfCoMKgwqDCoMKgwqAgDQpJbnRlbGxpZ2VuY2UgDQpS
ZXF1aXJlbWVudHMNCsK3wqDCoMKgwqDCoMKgIA0KUHJpb3JpdHkgSW50ZWxsaWdlbmNlIA0K
UmVxdWlyZW1lbnRzDQrCt8KgwqDCoMKgwqDCoCANCkJlZ2lubmluZyB0aGUgSW50ZWxsaWdl
bmNlIA0KTGlmZWN5Y2xlDQrCt8KgwqDCoMKgwqDCoCANClRocmVhdCANCk1vZGVsaW5nDQpS
ZWNlbnQgDQpjeWJlcmNyaW1lIHRyZW5kcw0KwrfCoMKgwqDCoMKgwqAgDQpDeWJlcndhciBh
dHRhY2tzIGxlYWRpbmcgdG8gdGhlIA0Kc2h1dGRvd24gb2YgcHJvZHVjdGlvbiBmYWNpbGl0
aWVzIG9yIHV0aWxpdGllcyAoZS5nLiBTdHV4bmV0LCANCkVtb3RldCkuDQrCt8KgwqDCoMKg
wqDCoCANClJhbnNvbXdhcmUgdHJvamFucyBhbmQgc21hcnQgDQp2aXJ1c2VzLg0KUmVjZW50
IA0KZXNwaW9uYWdlIHRocmVhdHMgYW5kIHByb3RlY3Rpb24NCsK3wqDCoMKgwqDCoMKgIA0K
UmlzayBhdWRpdHM6IElkZW50aWZpY2F0aW9uLCANCm1vbml0b3JpbmcsIGFuZCBldmFsdWF0
aW9uIG9mIHJpc2tzIGZvciBpbmZvcm1hdGlvbiB0aGVmdC4NCsK3wqDCoMKgwqDCoMKgIA0K
RWxlY3Ryb25pYyBlYXZlc2Ryb3BwaW5nIOKAlCANCnJlYWxpdHkgb3IgZmljdGlvbj8NCsK3
wqDCoMKgwqDCoMKgIA0KQXVkaW8tdmlzdWFsIGluZm9ybWF0aW9uIA0KZ2F0aGVyaW5nLg0K
wrfCoMKgwqDCoMKgwqAgDQpQcm9kdWN0IHBpcmFjeS4NCkluZm9ybWF0aW9uIA0KZHJhaW5h
Z2UgdGhyb3VnaCBzb2NpYWwgZW5naW5lZXJpbmcNCsK3wqDCoMKgwqDCoMKgIA0KVGhyZWF0
czogRWxpY2l0YXRpb24sIGJhY2stZG9vciANCnJlY3J1aXRtZW50LCBleHRlcm5hbCBwZXJz
b25uZWwsIFJvbWVvIGFwcHJvYWNoZXMsIHNvY2lhbCBtZWRpYSBhY3Rpdml0aWVzIA0KKHNv
Y2twdXBwZXRzKSwgYW5kIHByZXRleHQgY2FsbHMuDQrCt8KgwqDCoMKgwqDCoCANClByb3Rl
Y3Rpb246IFZ1bG5lcmFiaWxpdHkgDQphbmFseXNpcywgZW1wbG95ZWUgdHJhaW5pbmcsIGFu
ZCBuZXZlci10YWxrLXRvLXN0cmFuZ2VycyANCnBvbGljaWVzLg0KU2VjdXJpdHkgDQpvZiBk
YXRhIGFuZCBjb21tdW5pY2F0aW9uIG5ldHdvcmtzDQrCt8KgwqDCoMKgwqDCoCANClByb3Rl
Y3Rpb24gYWdhaW5zdCBoYWNraW5nIGFuZCANCm9yY2hlc3RyYXRlZCBhdHRhY2tzLg0KwrfC
oMKgwqDCoMKgwqAgDQpUaGUgd2VhayBzcG90IOKAlCBleHBsb2l0aW5nIHRoZSANCmh1bWFu
IGZhY3Rvci4NCsK3wqDCoMKgwqDCoMKgIA0KT3Bwb3J0dW5pdGllcyBhbmQgbGltaXRhdGlv
bnMgDQpmb3IgdGVjaG5pY2FsIGNvdW50ZXJpbnRlbGxpZ2VuY2Ugc29sdXRpb25zLg0KwrfC
oMKgwqDCoMKgwqAgDQpTZWN1cmUgY29tbXVuaWNhdGlvbjogU2FmZSBkYXRhIA0KdHJhbnNm
ZXIgbWV0aG9kcywgbWluaW1pemF0aW9uIG9mIGNvbW11bmljYXRpb24gcmlza3MsIGFuZCBw
cm90ZWN0aW9uIG9mIA0KY29ycG9yYXRlIGNvbW11bmljYXRpb24gc3RydWN0dXJlcy4NCsK3
wqDCoMKgwqDCoMKgIA0KSW50ZXJuZXQ6IEhvdyB0byBzZWN1cmVseSANCmNvbmR1Y3QgcmVz
ZWFyY2gsIHRyYW5zZmVyIGRhdGEsIGFuZCBhdm9pZCBoYXJtZnVsIA0Kc29mdHdhcmUuDQrC
t8KgwqDCoMKgwqDCoCANCklsbHVzdHJhdGlvbiBvZiBhdHRhY2tzIHdpdGggDQpudW1lcm91
cyBzbWFsbCBjYXNlIHN0dWRpZXMuDQpDb3VudGVyaW50ZWxsaWdlbmNlOiANClRoZSByb2xl
IG9mIENJL01JIHByb2Zlc3Npb25hbHMgaW4gZXNwaW9uYWdlIA0KcHJvdGVjdGlvbi4NCsK3
wqDCoMKgwqDCoMKgIA0KUHJldmVudGlvbiANCmNhbXBhaWducy4NCsK3wqDCoMKgwqDCoMKg
IA0KUGVuZXRyYXRpb24gdGVzdHMgZm9yIGFuIA0Kb3V0c2lkZS1pbiBwZXJzcGVjdGl2ZS4N
CsK3wqDCoMKgwqDCoMKgIA0KQnJpZWZpbmcvZGUtYnJpZWZpbmcgb2YgDQpjb2xsZWFndWVz
IHdpdGggc2Vuc2l0aXZlIGV4dGVybmFsIGNvbnRhY3RzLg0KwqANCsKgDQpUSEUgDQpFTkQN
CsKgDQrCoA0KwqANCsKgDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90
cmFja2luZy91bnN1YnNjcmliZT9kPWwycUk3bVZ6bVdsbS1qZThzcGc2TjBxTDlDNllicHN1
QWh2dWtFUmxUQWlrVmJMczk0SC1aOXdrZTQwcXFEMHlqZzc1RFlFNXpGcjZnWWoyZFFiRlZU
SkpReE5FdmdHOGJXd1A1LVVsc29zdzA+DQpVTlNVQlNDUklCRQ==

--=-eZCfCFvc8X3jI+21T+AcTy7S1Qcvwqsu/XWKzQ==
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
<H2=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: medium none; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT=
: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 18.=
75pt; PADDING-RIGHT: 0cm; mso-border-bottom-alt: solid #15B055 1.5pt; =
mso-padding-alt: 0cm 0cm 4.0pt 0cm"><SPAN=20
style=3D'FONT-SIZE: 16pt; FONT-FAMILY: "Calibri",sans-serif; COLOR: #5=
55555; FONT-STYLE: normal; mso-bidi-font-weight: normal; mso-bidi-font=
-style: italic'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KOKTELeLsJYhfgt9Th06IMPtplKOu8CoQO1CN=
MZk-P-Bghc8za17HlmO1LpCM98Js6pIlQ7V6k25OG7XeVdHZliN5kj8iq658auztb7eGh-=
eTI1"><SPAN=20
style=3D"mso-bidi-font-family: Calibri"><FONT color=3D#410082=20
face=3D"Times New Roman">TRAINING COURSE ON ADVANCED CYBER SECURITY, S=
YSTEMS AUDIT=20
AND ICT COUNTER INTELLIGENCE SOLUTIONS</FONT></SPAN></A> <?xml:namespa=
ce prefix=20
=3D "o" ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></H2></DIV>
<P>
<TABLE class=3DMsoNormalTable=20
style=3D"WIDTH: 485.4pt; BACKGROUND: #202c45; BORDER-COLLAPSE: collaps=
e; mso-yfti-tbllook: 1184"=20
cellSpacing=3D0 cellPadding=3D0 width=3D809 border=3D0>
  <THEAD>
  <TR style=3D"HEIGHT: 23.6pt; mso-yfti-irow: 0; mso-yfti-firstrow: ye=
s">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.6pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-TO=
P: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; B=
ACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: white'>Dates<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.6pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-TO=
P: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; B=
ACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: white'>Fees<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.6pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-TO=
P: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; B=
ACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: white'>Location<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 23.6pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #dddddd 1.5pt solid; PADDING-BOTTOM: 6pt; PADDING-TO=
P: 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; B=
ACKGROUND-COLOR: transparent"=20
    vAlign=3Dbottom>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"><B><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: white'>Apply<o:p></o:p></SPAN></B></P></TD></TR></THEAD>
  <TBODY>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 1">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.8pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP: 6pt; PADD=
ING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BACKGROUND-CO=
LOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>03/04/2023<B>&nbsp;-</B>&nbsp;14/04/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.8pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP: 6pt; PADD=
ING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BACKGROUND-CO=
LOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$2700<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.8pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP: 6pt; PADD=
ING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BACKGROUND-CO=
LOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Nairobi<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 50.8pt; BORDER-RIGHT: #f0f0f=
0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP: 6pt; PADD=
ING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BACKGROUND-CO=
LOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPz1XSRvyI=
AkhUB-GocUKVgWupwH_UXFVztz6tFQ_oZlbe4R4bsnJwXDVbiTtGXtky8yNw_Wx3GpuhVg=
x3issW6-Gft4ygdZk-Xad0G9-uqv5F0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMu-wo7dEZX=
17PRQa4W24MsrF8Rg31JyOx73nG-lekXpZcq4qKXkyUf__qLafS3GDQ90QAzQx0akrOxbc=
7j4AM6q8PzkAts4OY4pthhVr3sMJXl0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 2">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>01/05/2023<B>&nbsp;-</B>&nbsp;12/05/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$4500<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Dubai<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPMops7yuZ=
FSvWMM1Oyz38HfGCwGEw1pgeNuwD1zYYMun8UzfqXlPr3cF6Ug4c5S-0fgLq9FSAXcbAce=
d_JAnl0RSpfvqx3W__pcfOpN7WTffc0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMu66hqz-Yz=
9mRwu3uFv4JyWkMpg1Y4pVVge8-IKHA2zTwDPoP9xVigPHGyuBpFpwkIZFRM5OVsH7_EhH=
hi1faKTlvumRBsek6VBwoeI6UsPwLh0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 51.4pt; mso-yfti-irow: 3">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>05/06/2023<B>&nbsp;-</B>&nbsp;16/06/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$3000<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Mombasa<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPD6WjIQeo=
m6yFvbSSXRrlP_OSyy1KewVTkBNaiyCpHjdOrcmeU-MVD-DWnewhSdnXQE2uJfkYGjPxtG=
rzpiUlR9PmR-Q7_mRPD7KO3-WSn-9s0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMu2SUTLivn=
KNEITo7Ca0Rlw8Mwu-RVKZkvXdHYJF0MVUuVql9a0ws0VZZEAdBgMtmVBEAZUqhvnjsYks=
vNZhA1lIPgxa6cMlerOr6vvnnlFXEu0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 4">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>03/07/2023<B>&nbsp;-</B>&nbsp;14/07/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$3500<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Kigali<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPHLYElh3r=
VtmxwTcVoHT0AyJveSKgzRIrY40AbpwjtrJ6U3h53MdIZUsYCAbHzaNFpywyhi0FfTTahp=
wZUoX7tcBGjl0mOm03MrLSEEDlUQeQ0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMuszF7i2ey=
LzBmgWqxbz3jG4-HCfOJyqJftvrtBxeM5GJj-CoWBNIdo2HWSLG-OVGOR_eP1CNN73-L7R=
PPXU0tCTy2H3eNsbZwDecA3oIsgL7e0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 51.4pt; mso-yfti-irow: 5">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>07/08/2023<B>&nbsp;-</B>&nbsp;18/08/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$2700<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Nairobi<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPZURmlAv6=
TWXZdI3vi8W1vn9zWfwFBRKvhPktFeGKpL4HftSu13drvbz34NTwGjx9_05scfhrWLbr0B=
NTp4ld5bRlyjp7sJS_Hc9fKY-2BFOQ0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMuy7t7852Z=
vRYCcboHwu639oyFcmaNZWKwihrD6rHISH_IYOBx6MUpM6i0QWSKkfGWYG1tmrFlum_DRE=
eni4jL4BWcfMGdVR4SP2MrC8NLEUmK0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 6">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>04/09/2023<B>&nbsp;-</B>&nbsp;15/09/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$3000<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Mombasa<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoP7LvxaSuN=
MSEjy8xBKCOL3v_IMQXQZ8ephKyFcEz30PTVDpcTDOuuIaAnKnPdoolQQDKBzHGKwMAThW=
EzJkndbNhn3nUxKRRva6-y_nb2W7j70"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMuEnYejjYV=
pBX3ux71bNScyAv2X2izzLdl_zFvUocHy1A_GljDnY1TxHNicP7e7LL9rZxA4tMlkB34Jm=
Ngh5uTYV7KlT1ss2mbCX2-TKNSsCPO0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 7">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>02/10/2023<B>&nbsp;-</B>&nbsp;13/10/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$3500<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Kigali<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPnxmkNKl_=
7nOiA3u_8W96Cj-xEHz-ZQdccQF-f0oYnF0qWBhATFnVg3MptgzdfrQNRNPk-n1HHQpMcE=
OMwdbnkeU4w0pW2O0w5fizrmQ9HXkp0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMuRN1AphA0=
dSB9E7GTmhLVvZHl7s4lifW3o4n99x-bRevbCLgn1tPK_sgd3o7OIs2brXRtO3CzGDAEuH=
MOXTPFKUA5An-JDkLBNZiXlr_dLDcj0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 51.4pt; mso-yfti-irow: 8">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>06/11/2023<B>&nbsp;-</B>&nbsp;17/11/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$3000<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Mombasa<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 51.4pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoPXCNySif4=
KN8awqurUH2pqbPcyBSYc8ffX57l47u-EfnfLAIbV1OqLyZeH6-5iVV0XoQQPVZH0jgwFJ=
KbTswzfT7d5R00YEwnZZfNqPyT-mdA0"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMu5nYqfNRy=
rIP3MeahnDzJl326JcfXX2u7i0OHt_6NWV2AQ1cMSS3bVF8tsRuG18zaualsJpIlPd5Sio=
-EC9MkXFqnzKZ5ygfcvsnYK5pqu1zk0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 50.8pt; mso-yfti-irow: 9; mso-yfti-lastrow: yes=
">
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>04/12/2023<B>&nbsp;-</B>&nbsp;15/12/=
2023<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>$2700<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'>Nairobi<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #dddddd 1pt solid; HEIGHT: 50.8pt; BORDER-RIG=
HT: #f0f0f0; BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 6pt; PADDING-TOP:=
 6pt; PADDING-LEFT: 6pt; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 6pt; BAC=
KGROUND-COLOR: transparent; mso-border-top-alt: solid #DDDDDD .75pt"=20
    vAlign=3Dtop>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
      style=3D'FONT-SIZE: 10.5pt; FONT-FAMILY: "Arial",sans-serif; COL=
OR: aliceblue; LINE-HEIGHT: 115%'><A=20
      style=3D"OUTLINE-WIDTH: 0px; PADDING-TOP: 0px; OUTLINE-STYLE: no=
ne; PADDING-LEFT: 0px; OUTLINE-COLOR: invert; PADDING-RIGHT: 0px; -web=
kit-font-smoothing: antialiased; border-radius: 0.2rem"=20
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtOqpmLBxXy0yBFbHXpgrdoP-cfvvy2N=
6mAJuwXhiOLaAfdr8u5kqkSYfjyziI9HUY41FOswViiD7hhR1F2DsVzPxAzA_1vGy3yNfF=
yRM8pivbnAqxOdMGnBsrogQzrUPxh60"><SPAN=20
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
      href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWo=
apoy-pTrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtMNryFu5qW7KnnyuoRWxTMuIg076mKn=
fpJuxAYhAD6_MF7icEopfQKMx6-JplwwomV5jdTc8bgK8-sj4kty5esteSlvXAr6T25_-O=
Mkfe1yh1yV0e9tpVcg_JRScTTI2neL0"><SPAN=20
      style=3D"BORDER-TOP: windowtext 1pt; BORDER-RIGHT: windowtext 1p=
t; BACKGROUND: #dc3545; BORDER-BOTTOM: windowtext 1pt; COLOR: white; P=
ADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: =
windowtext 1pt; PADDING-RIGHT: 0cm; mso-bidi-font-family: Arial; mso-b=
order-alt: none windowtext 0cm"><FONT=20
      face=3D"Times New Roman">Online=20
    Class</FONT></SPAN></A><o:p></o:p></SPAN></P></TD></TR></TBODY></T=
ABLE><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #555555"><o:p><FONT=20
face=3DCalibri></FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KNTFFNY6jLTlannTsFNp1-e1z5g6rEUHbt55m=
wlwZDUhn9uselQOk42TotDFnXWYSu2ZNo0HwAUtp2tBKLb2i1bUy8_Ao6beGm2WPBaRf3Y=
zB01" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Calendar fo=
r 2023=20
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
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KM-cgdd93er8oiDD9RVWshiXMnib3cnotGmow=
Fp7Ezw6BUgcb4Gkpq7ORsyGeH48sqdSUAN3uGMgN9_oIMVG7_joH9letWYG40ZabtHfu_p=
CnY1" target=3D_blank><SPAN=20
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
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejjxKwO9e8XGsKnbIiI6uZ9PnCQ35zRWcc5xCY=
NDPevfULxmWv1FazMyy0NdExLXGcH8XsBh0-yJ51AcyAHpNft1Ph6J_VmBBcWUjlgchx5t=
IYE1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri">Whatapp<o:p=
></o:p></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; mso-line-height-al=
t: 11.2pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #555555"><o:p><FONT=20
face=3DCalibri>&nbsp;</FONT></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt; mso-line-height-al=
t: 11.2pt"><FONT=20
face=3DCalibri><B><SPAN=20
style=3D"FONT-SIZE: 12pt; COLOR: #555555">INTRODUCTION</SPAN></B><SPAN=
=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Helvetica",sans-serif; COLOR: =
#555555'><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 12pt 0cm"><SP=
AN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Information=20
and know-how are valuable company assets, and in times of fierce compe=
tition,=20
organizations need to protect their information and systems against th=
e threat=20
of corporate espionage. Many organizations are unaware of potential in=
formation=20
leaks, and as a result counterintelligence operations are neglected or=
 are=20
simply a series of routine technical measures. However, employees typi=
cally=20
represent a major weak spot for organizations &#8211; which means that=
 existing=20
processes and structures for information flows need to be=20
challenged.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 12pt 0cm"><SP=
AN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Empirical=20
research indicates that most information losses are traced back to a c=
ompany&rsquo;s=20
employees, or the personnel of its suppliers, customers, or partners &=
#8211; all of=20
whom have access to confidential information.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 12pt 0cm"><SP=
AN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>The=20
training will look at the different threats organizations might face a=
nd ways in=20
which they can protect and secure it against attacks. Participants wil=
l also=20
learn how to set up counterintelligence processes that involve collect=
ing=20
information and conducting counterintelligence activities.<o:p></o:p><=
/SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Course=20
Objectives<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>By=20
the end of this course, participants should be able to:<o:p></o:p></SP=
AN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Know the purpose of =
a=20
cybersecurity audit<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Define cybersecurity=
 audit=20
controls<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Identify cybersecuri=
ty audit=20
frameworks<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Explain proper audit=
 team=20
performance<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Define the benefits =
of a=20
cybersecurity audit<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l8 level1 lfo7=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Learn how to identif=
y vulnerable=20
points within your organization and how to secure them.<o:p></o:p></SP=
AN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l8 level1 lfo7"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Run=20
  awareness campaigns among your colleagues in order to raise awarenes=
s of=20
  espionage threats and protect them from attacks.<o:p></o:p></SPAN></=
LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l8 level1 lfo7"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Develop=20
  in-depth knowledge of the various forms of contemporary espionage=20
  threats.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l8 level1 lfo7"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Master=20
  how to identify, monitor, and evaluate information=20
  risks.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l8 level1 lfo7"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Become=20
  familiar with ethical and legal counterintelligence activities and=20
  techniques.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l8 level1 lfo7"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Seize=20
  the opportunity to share experience and knowledge with competitive/m=
arket=20
  intelligence experts and peers from a range of industries.</SPAN></L=
I></UL>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Duration<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>14=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Who=20
should Attend<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l11 level1 lfo=
6"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Individuals involved=
 in=20
cybersecurity management<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l11 level1 lfo=
6"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Learning and develop=
ment=20
professionals<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l11 level1 lfo=
6"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Internal=20
auditors<o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 107%; mso-l=
ist: l11 level1 lfo6"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>IT=20
  professionals and managers working with information systems, who nee=
d to=20
  understand best practices and standards to ensure security and integ=
rity of=20
  these systems<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l11 level1 lfo=
6"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Individuals seeking =
to gain=20
knowledge about the main processes of auditing a cybersecurity=20
program<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l11 level1 lfo=
6"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Individuals interest=
ed to pursue=20
a career in cybersecurity audit<o:p></o:p></SPAN></P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l11 level1 lfo6"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Competitive/Market=20
  Intelligence Analysts and Managers<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l11 level1 lfo6"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Knowledge=20
  and Information Managers<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"BACKGROUND: white; COLOR: black; TEXT-ALIGN: justify; MARGI=
N: 0cm 0cm 10pt; mso-margin-top-alt: auto; mso-margin-bottom-alt: auto=
; mso-list: l11 level1 lfo6"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 115%'>Specialists=20
  from R&amp;D, Technology and Risk Management<o:p></o:p></SPAN></LI><=
/UL>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>COURSE=20
CONTENT<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt=
"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>What=20
is a Cybersecurity Audit?<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo8=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"COLOR: black">Introduction<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo8=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">What is a Cybersecur=
ity=20
Audit?<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo8=
"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">When to Perform a Cy=
bersecurity=20
Audit<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Controls=20
and Frameworks<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l12 level1 lfo=
9"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Cybersecurity Audit=20
Controls<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l12 level1 lfo=
9"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Cybersecurity Audit=20
Frameworks<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Completing=20
the Audit<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l7 level1 lfo1=
0"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">The Audit<o:p></o:p>=
</SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 8pt 36pt; LINE-HEIGHT: 1=
15%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-list: l7 level1 lfo1=
0"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Audit<SPAN=20
style=3D"BORDER-TOP: whitesmoke 1pt solid; BORDER-RIGHT: whitesmoke 1p=
t solid; BORDER-BOTTOM: whitesmoke 1pt solid; PADDING-BOTTOM: 0cm; PAD=
DING-TOP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: whitesmoke 1pt solid; P=
ADDING-RIGHT: 0cm; mso-border-alt: solid whitesmoke .25pt">=20
Completion</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 3.75p=
t; mso-margin-top-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Understanding=20
Cyber Threat Intelligence</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Defining=20
Threats<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Understanding=20
Risk<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Cyber Threat Intelli=
gence and=20
Its Role<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Expectation of Organ=
izations and=20
Analysts<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Diamond Model and Ac=
tivity=20
Groups<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Four Types of Threat=
=20
Detection</SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Process of auditing =
information=20
systems<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Governance and manag=
ement of=20
IT<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Information systems&=
rsquo;=20
acquisition, development and implementation<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Protection of inform=
ation=20
assets<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l2 level1 lfo11"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Information systems&=
rsquo; operation,=20
maintenance and service management<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 3.75p=
t; mso-margin-top-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Threat=20
Intelligence Consumption</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l6 level1 lfo12"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Sliding Scale of=20
Cybersecurity<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l6 level1 lfo12"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Consuming Intelligen=
ce for=20
Different Goals<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l6 level1 lfo12"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Enabling Other Teams=
 with=20
Intelligence<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 3.75p=
t; mso-margin-top-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Positioning=20
the Team to Generate Intelligence</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l1 level1 lfo13"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Building an Intellig=
ence=20
Team<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l1 level1 lfo13"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Positioning the Team=
 in the=20
Organization<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l1 level1 lfo13"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Prerequisites for In=
telligence=20
Generation<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 3.75p=
t; mso-margin-top-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Planning=20
and Direction (Developing Requirements)</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l9 level1 lfo14"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Intelligence=20
Requirements<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l9 level1 lfo14"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Priority Intelligenc=
e=20
Requirements<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l9 level1 lfo14"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Beginning the Intell=
igence=20
Lifecycle<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 5pt 0cm 3.75p=
t 36pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; ms=
o-list: l9 level1 lfo14"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Threat=20
Modeling<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt;=
 mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Recent=20
cybercrime trends<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l5 level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Cyberwar attacks lea=
ding to the=20
shutdown of production facilities or utilities (e.g. Stuxnet,=20
Emotet).<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l5 level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Ransomware trojans a=
nd smart=20
viruses.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt;=
 mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Recent=20
espionage threats and protection<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l4 level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Risk audits: Identif=
ication,=20
monitoring, and evaluation of risks for information theft.<o:p></o:p><=
/SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l4 level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Electronic eavesdrop=
ping &#8212;=20
reality or fiction?<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l4 level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Audio-visual informa=
tion=20
gathering.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l4 level1 lfo2"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Product piracy.</SPA=
N></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt;=
 mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Information=20
drainage through social engineering<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l13 level1 lfo3"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Threats: Elicitation=
, back-door=20
recruitment, external personnel, Romeo approaches, social media activi=
ties=20
(sockpuppets), and pretext calls.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l13 level1 lfo3"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Protection: Vulnerab=
ility=20
analysis, employee training, and never-talk-to-strangers=20
policies.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt;=
 mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Security=20
of data and communication networks<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Protection against h=
acking and=20
orchestrated attacks.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">The weak spot &#8212=
; exploiting the=20
human factor.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Opportunities and li=
mitations=20
for technical counterintelligence solutions.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Secure communication=
: Safe data=20
transfer methods, minimization of communication risks, and protection =
of=20
corporate communication structures.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Internet: How to sec=
urely=20
conduct research, transfer data, and avoid harmful=20
software.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l3 level1 lfo5"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Illustration of atta=
cks with=20
numerous small case studies.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10pt;=
 mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>Counterintelligence:=20
The role of CI/MI professionals in espionage=20
protection.<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l10 level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Prevention=20
campaigns.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l10 level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Penetration tests fo=
r an=20
outside-in perspective.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 5pt 3=
6pt; LINE-HEIGHT: 115%; TEXT-INDENT: -18pt; mso-add-space: auto; mso-l=
ist: l10 level1 lfo4"><SPAN=20
style=3D"FONT-FAMILY: Symbol; COLOR: black; mso-bidi-font-family: Symb=
ol; mso-fareast-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"COLOR: black">Briefing/de-briefing=
 of=20
colleagues with sensitive external contacts.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 10p=
t"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 115%'>THE=20
END<o:p></o:p></SPAN></B></P>
<P class=3DMsoListParagraph=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-INDENT: -18pt;=
 mso-line-height-alt: 11.2pt"><SPAN=20
style=3D"COLOR: #555555"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; TEXT-INDENT: -18pt;=
 mso-line-height-alt: 11.2pt"><SPAN=20
style=3D"COLOR: #555555"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: center; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal=
"=20
align=3Dcenter><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Open Sans",serif'><o:p>&nbsp;<=
/o:p></SPAN></P>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Dl=
Yio8OdJKEISFgsgc-w5kQ2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3Dl2qI7mVzmWlm-je8spg6N0qL9C6YbpsuAhvukERlTAikVbLs94H-Z9wke4=
0qqD0yjg75DYE5zFr6gYj2dQbFVTJJQxNEvgG8bWwP5-Ulsosw0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfCFvc8X3jI+21T+AcTy7S1Qcvwqsu/XWKzQ==--
