Return-Path: <linux-erofs+bounces-2980-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N7jKyRzw2mxqwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2980-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 06:31:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B661731FDD6
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 06:31:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgb9V1FTpz2yRl;
	Wed, 25 Mar 2026 16:31:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.183.224.105
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774416670;
	cv=none; b=GYkcTu3IONtpF4Rbjq/wRzMieV8yFpPFA7kAzpqSgktYvyy9aqERvET7ZmuQ8e/qaPXoCV7OddGt1Z1UAPbk8qHZ/sfkml5w3EpKHZkGHbLtfmo+PWhMUJ0geWzU2dKJ/dWaoM3V000PNGKPx9jcIo4ShGW3fJhDaxW3PhPuUK6170rFMv2C1O/tsbBl5hlzPvrlVhtvlbZiTl7BNv3B88r5s5oVzmJj/Bo4vQ4npDcg+CovLtYOL1kcFboqi+gJfJIZV/YqLF1SKCDa6dITPZSW4DQPTkD8gfFJ80efBAzr1zY1jipCTmgWxfRgl+bx6J51HUMZcqQn0DdRfUicSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774416670; c=relaxed/relaxed;
	bh=kt/GFgwjpu/bACuEncwC/INqjObGmzghlzpTCOAQfaU=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=W5p5q2UDK3kQY95E+AZpTrx8Hmbbf9ztGtVAVgp3D8tNOsa0rlJ1wQba02UVMOr8AaO8wk0SVilKr/pL5fs66VFa6CqvGI1gFhH3qn5NlCFnIUU79JXaRl6j0nxawvIXQq5QGs5evVx34NrDpts3iG6Bs+EnJ2Vi+cjNxgQtO2lS5L/webJUJqU7JBhFR5SnszoeFX0jCzxEwEvTA56LvS1Xpi8Zj6diz1MsQzP6oqFIB7exjYjBVHC7Xpf1sXVRH8f/ZIRkEvnyQIvg767rnsFNzxlNy/2TSDc9uiRgqJYEkzlPfPaM644oTklXpSIQtpTJoHA+TQ5Z7e665F8/Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=front-migu.com; dkim=pass (2048-bit key; unprotected) header.d=front-migu.com header.i=@front-migu.com header.a=rsa-sha256 header.s=s1 header.b=Wtdfk1U4; dkim-atps=neutral; spf=pass (client-ip=159.183.224.105; helo=s.wfbtzhsw.outbound-mail.sendgrid.net; envelope-from=bounces+61355434-fa4e-linux-erofs=lists.ozlabs.org@em5515.front-migu.com; receiver=lists.ozlabs.org) smtp.mailfrom=em5515.front-migu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=front-migu.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=front-migu.com header.i=@front-migu.com header.a=rsa-sha256 header.s=s1 header.b=Wtdfk1U4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=em5515.front-migu.com (client-ip=159.183.224.105; helo=s.wfbtzhsw.outbound-mail.sendgrid.net; envelope-from=bounces+61355434-fa4e-linux-erofs=lists.ozlabs.org@em5515.front-migu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 203 seconds by postgrey-1.37 at boromir; Wed, 25 Mar 2026 16:31:05 AEDT
Received: from s.wfbtzhsw.outbound-mail.sendgrid.net (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgb9P0nQPz2yF1
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 16:31:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=front-migu.com;
	h=content-type:date:from:mime-version:subject:to:cc:content-type:date:
	from:subject:to;
	s=s1; t=1774416389; bh=kt/GFgwjpu/bACuEncwC/INqjObGmzghlzpTCOAQfaU=;
	b=Wtdfk1U4UlCW5i9E1eq3JmS6GBLCVMAWMSTGGB0yA49VCLN6WBG4zoC9vehRLNflgHC8
	itMr99C8kCvHVymKCI/II8uQrPfNgWt2k1PfZi3s24K13H0AjDJVMy2U7d/+EWzuppPV6C
	AUrhF10OZiH3qlKTH0/a6ouK0K5TtFAqnPfQVvQF51NVU2F71RY6Xm96Q5udNz3bRLTldW
	/pi4goo+bPHGMSyJdi+HcFhN/kfMskEDcD6fD4xgLJmUHxiZydZCtMJqgnsQQuNvtHyElt
	bz4kZxZxChopaTM31Q8ccGiuox8B2lXQFo2eJ60AQMzce8KwhbhXb8ted+7ek9JA==
Received: by recvd-759c44dc58-m7drh with SMTP id recvd-759c44dc58-m7drh-1-69C37205-16
	2026-03-25 05:26:29.633048595 +0000 UTC m=+1332639.652980564
Received: from NjEzNTU0MzQ (unknown)
	by geopod-ismtpd-49 (SG) with HTTP
	id 8gGNQLHLQRqeJovQrKuqig
	Wed, 25 Mar 2026 05:26:29.600 +0000 (UTC)
Content-Type: multipart/alternative; boundary=95fa3b5211ea5b262a3ad94b2fdbbf221a027836b3a6471112c00b32ca91
Date: Wed, 25 Mar 2026 05:26:29 +0000 (UTC)
From: Nintendo <geraldgarcia11@front-migu.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Message-ID: <8gGNQLHLQRqeJovQrKuqig@geopod-ismtpd-49>
Subject: Nintendo Switch
 =?UTF-8?B?T25saW5l5a6a5pyf6LO85YWl44K144O844OT44K544Gu6Ieq5YuV57aZ57aa57WC5LqG44Gr44Gk44GE44Gm?=
X-SG-EID: 
 =?us-ascii?Q?u001=2E8YGmbC6oDEwrlAi4zAMIFNnqrmQQbPlYT9jXK16mmhdUBTph38NV0Ghl4?=
 =?us-ascii?Q?xdf2J92bUrJkeXz3ORZSVpVvxqaUZroZzzzRgvP?=
 =?us-ascii?Q?OV63AZ6Yh1xYpGR4FxLYUol6te=2FU1OVBiusKws=2F?=
 =?us-ascii?Q?bpvef+8541WQYQY9fwPHQG1RN9Dhpt777N+HHuU?=
 =?us-ascii?Q?UZFmMBvQCDFTNRyLly4KwRUUxwExOdycohF6Sto?=
 =?us-ascii?Q?zn1RAIjwvPt6wFXFOw2VxqKy42oVb8J8MSwV3AK?=
 =?us-ascii?Q?mG+TxfXc45itU6TTPp=2FjjwLZDw=3D=3D?=
To: linux-erofs@lists.ozlabs.org
X-Entity-ID: u001.s2iXBxJtDD/mkthou9uFRA==
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HTML_IMAGE_ONLY_24,HTML_MESSAGE,MPART_ALT_DIFF,
	SPF_HELO_NONE,SPF_PASS,T_REMOTE_IMAGE autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.75 / 15.00];
	URI_COUNT_ODD(1.00)[1];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_PARTS_DIFFER(0.94)[97.2%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[front-migu.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[front-migu.com:s=s1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-2980-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geraldgarcia11@front-migu.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[front-migu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nintendo.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,front-migu.com:dkim]
X-Rspamd-Queue-Id: B661731FDD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--95fa3b5211ea5b262a3ad94b2fdbbf221a027836b3a6471112c00b32ca91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0

=E6=B5=8B=E8=AF=95=E6=B5=8B=E8=AF=95=EF=BC=81=EF=BC=81
--95fa3b5211ea5b262a3ad94b2fdbbf221a027836b3a6471112c00b32ca91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8
Mime-Version: 1.0

<html>
<head>
<meta charset=3Dutf-8>
<meta content=3D"text/html; charset=3DUTF-8" http-equiv=3DContent-Type>
</head>
<body>
<table width=3D600 align=3Dcenter bgColor=3D#ffffff>
  <tbody>
  <tr>
    <td style=3D"font-size:10px;color:#666;" align=3Dright>=E2=80=BB=E8=A1=
=A8=E7=A4=BA=E3=81=95=E3=82=8C=E3=81=AA=E3=81=84=E6=96=B9=E3=81=AF<a style=
=3D"color:#666;" href=3D"https://view.ccg.nintendo.com/?qs=3D3c93a1dff345ef=
5692411c69de298fa517b4648667ce0a0aacd121bb701a53e879cbdc9b16c3030227fb1737e=
8b2ebf14198a2c5f98075d095d19e474fa02f03e5c2211a6a64da0e175f59f0ec7da0e1">=
=E3=81=93=E3=81=A1=E3=82=89</a>=20
    </td></tr>
  <tr>
    <td><img alt=3DNintendo=E3=83=AD=E3=82=B4 src=3D"https://ci3.googleuser=
content.com/meips/ADKq_NZ6nqYn1fxppR7jMAbLOUdfk9-HFQRjkzXYVgdVxMkWDxeQonTxw=
l8Vlym0BAFOPhWA-HKNauBUAiWfuMqU0aeDKekG4kNQBHyS0pf3Mr_QCPqjUrnp2YkyhJmsHas=
=3Ds0-d-e1-ft#https://www.nintendo.co.jp/mailimg/20211206_wqYgE8yM/202111_2=
_logo01.jpg" width=3D600></td></tr>
  <tr>
    <td style=3D"font-size:14px;font-family:=E3=83=A1=E3=82=A4=E3=83=AA=E3=
=82=AA;color:#333;padding-bottom:20px;padding-top:20px;padding-left:0px;pad=
ding-right:0px;">=E2=80=BB=E6=9C=AC=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E3=
=80=81Nintendo=20
      Switch Online=E3=81=AE=E8=87=AA=E5=8B=95=E7=B6=99=E7=B6=9A=E8=B3=BC=
=E5=85=A5=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=A7=E3=81=8D=E3=81=AA=E3=81=8B=E3=
=81=A3=E3=81=9F=E6=96=B9=E3=81=AB=E9=80=81=E4=BB=98=E3=81=97=E3=81=A6=E3=81=
=8A=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=20
      <p>=E4=B8=8B=E8=A8=98=E3=81=AE=E3=81=84=E3=81=9A=E3=82=8C=E3=81=8B=E3=
=81=AE=E7=90=86=E7=94=B1=E3=81=AB=E3=82=88=E3=82=8A=E3=80=81=E6=B1=BA=E6=B8=
=88=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=
=E3=81=A7=E3=81=97=E3=81=9F=E3=80=82</p>
      <div style=3D"margin-top:24px;font-weight:bold;">=E3=80=90=E3=81=8A=
=E6=94=AF=E6=89=95=E3=81=84=E6=96=B9=E6=B3=95=E3=82=92=E8=A8=AD=E5=AE=9A=E6=
=B8=88=E3=81=BF=E3=81=AE=E5=A0=B4=E5=90=88=E3=80=91</div>
      <ul>
        <li>=E3=82=AF=E3=83=AC=E3=82=B8=E3=83=83=E3=83=88=E3=82=AB=E3=83=BC=
=E3=83=89=E3=81=BE=E3=81=9F=E3=81=AFPayPal=E3=81=8C=E6=B1=BA=E6=B8=88=E3=81=
=AB=E5=88=A9=E7=94=A8=E3=81=A7=E3=81=8D=E3=81=AA=E3=81=84=E3=80=82 </li></u=
l>
      <p>=EF=BC=BB=E4=BE=8B=EF=BC=BD</p>
      <ul>
        <li>=E7=99=BB=E9=8C=B2=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B=
=E3=82=AF=E3=83=AC=E3=82=B8=E3=83=83=E3=83=88=E3=82=AB=E3=83=BC=E3=83=89=E3=
=81=AE=E6=9C=89=E5=8A=B9=E6=9C=9F=E9=99=90=E3=81=8C=E5=88=87=E3=82=8C=E3=81=
=A6=E3=81=84=E3=82=8B=E3=80=82=20
        <li>=E3=81=9D=E3=81=AE=E4=BB=96=E3=81=AE=E7=90=86=E7=94=B1=E3=81=A7=
=E3=82=AF=E3=83=AC=E3=82=B8=E3=83=83=E3=83=88=E3=82=AB=E3=83=BC=E3=83=89=E3=
=81=8C=E4=BD=BF=E7=94=A8=E3=81=A7=E3=81=8D=E3=81=AA=E3=81=84=E3=80=82 </li>=
</ul>
      <div style=3D"margin-top:24px;font-weight:bold;">=E3=80=90=E3=81=8A=
=E6=94=AF=E6=89=95=E3=81=84=E6=96=B9=E6=B3=95=E3=82=92=E6=9C=AA=E8=A8=AD=E5=
=AE=9A=E3=81=AE=E5=A0=B4=E5=90=88=E3=80=91</div>
      <ul>
        <li>=E3=83=8B=E3=83=B3=E3=83=86=E3=83=B3=E3=83=89=E3=83=BCe=E3=82=
=B7=E3=83=A7=E3=83=83=E3=83=97=E3=81=AE=E6=AE=8B=E9=AB=98=E3=81=8C=E4=B8=8D=
=E8=B6=B3=E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=80=82 </li></ul>
      <p>=E5=BC=95=E3=81=8D=E7=B6=9A=E3=81=8DNintendo Switch=20
      Online=E3=81=AE=E3=82=B5=E3=83=BC=E3=83=93=E3=82=B9=E3=82=92=E3=81=94=
=E5=88=A9=E7=94=A8=E3=81=84=E3=81=9F=E3=81=A0=E3=81=8F=E3=81=AB=E3=81=AF=E3=
=80=81<strong>=E3=83=8B=E3=83=B3=E3=83=86=E3=83=B3=E3=83=89=E3=83=BCe=E3=82=
=B7=E3=83=A7=E3=83=83=E3=83=97</strong>=E3=81=BE=E3=81=9F=E3=81=AF=E4=B8=8B=
=E8=A8=98=E3=81=AE=E3=83=AA=E3=83=B3=E3=82=AF=E3=82=88=E3=82=8A=E3=80=81=E5=
=86=8D=E5=BA=A6=E5=88=A9=E7=94=A8=E5=88=B8=E3=82=92=E3=81=94=E8=B3=BC=E5=85=
=A5=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82</p><a style=3D"text-decora=
tion:none;margin-top:16px;font-weight:bold;color:#fff;padding-bottom:12px;p=
adding-top:12px;padding-left:24px;display:inline-block;padding-right:24px;b=
ackground-color:#e60012;border-radius:4px;" href=3D"https://signin-hth.com/=
EQQ5Md">=E2=96=BC =E5=88=A9=E7=94=A8=E5=88=B8=E3=82=92=E5=86=8D=E5=BA=A6=E8=
=B3=BC=E5=85=A5=E3=81=99=E3=82=8B</a> </td></tr></tbody></table>
<table width=3D600 align=3Dcenter bgColor=3D#f5f5f5>
  <tbody>
  <tr>
    <td style=3D"font-size:12px;color:#666;padding-bottom:20px;text-align:c=
enter;padding-top:20px;padding-left:20px;padding-right:20px;">=E9=85=8D=E4=
=BF=A1=E5=85=83=EF=BC=9A=E4=BB=BB=E5=A4=A9=E5=A0=82=E6=A0=AA=E5=BC=8F=E4=BC=
=9A=E7=A4=BE<br>=C2=A9=20
      Nintendo </td></tr></tbody></table>
</body>
</html>
--95fa3b5211ea5b262a3ad94b2fdbbf221a027836b3a6471112c00b32ca91--

