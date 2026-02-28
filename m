Return-Path: <linux-erofs+bounces-2445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC/oIzq3ommw5AQAu9opvQ
	(envelope-from <linux-erofs+bounces-2445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Feb 2026 10:36:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDF1C1C4E
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Feb 2026 10:36:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNKpX2svPz30BR;
	Sat, 28 Feb 2026 20:36:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772271412;
	cv=pass; b=TuQTnlbfmQDHSNFS1NFUN5yWpRTu6M53eyMbVHkUevTtfS16DKfcJ8NPp3paxQfw90jdBH8uUeR9cDLJJ3VX5HmY4+O6iO2cEkJdBLVX0YZftHZ/g+7VrHtF1aT46cnHmsZGakpGRZyODcJ3ntp3LgacdLsh8psZULMUgSU+WB3uYHsldEtr/5atYAAgHGyrkWv2YEdOGkYFmxZJD9pm8OIEi3UHhqnkseHN9Vm+HyUpojphE9sAZxr9HP9NJcRZ+ACj6gv4lMO3juD8YI/A1ZOHT/xPoLh5wf2iUs7csjqk++5iPQAyefSJrBkUJmUokasp+1QcpZRxp4C6wvfjXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772271412; c=relaxed/relaxed;
	bh=JDwCmTB/AaqKZq9tyGdosEwMm5AfEG6wtdOz1OuotVY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WidNdlBfewSsZdxNr5Agq3YjeCG+Fz06BK8P/YkcpmYPMgGrBZqLgxtUeh4YqrrlEdpeuGjyDM0yUlliT0wfpXJYSUQcGCANiqfCZ0IMGr0aHzpNNYcvtNVIquJjEGAsmtOIB8GfwrZvyNgam4e7nVRLmsiIxgWwP117KUUcklBe4rhWU+YD9O4OtfEMdVOC0AIGBtRo4Tsf+Ls45QH61C9/3V2Lfu/sYfz2U/HgNTcVg4rLRhWd4jBMoTbp8O05fcrxgeDgLfuYif/5cauLOBzn7sje5hL+uVVkoq8DDiG505zKrl/rS5XH8AvPMxGuaQNqAbxZ8YZc+mgYdLzb9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gcvmaKJZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gcvmaKJZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNKpV0WPwz2ySb
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Feb 2026 20:36:48 +1100 (AEDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-389f173b91fso42132141fa.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Feb 2026 01:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772271400; cv=none;
        d=google.com; s=arc-20240605;
        b=CnkkU1KcTm5kvLoWr96ZqCkMcikn1uGC6drx9CVVq34g9ox75TjVux9JABQpGvYpdT
         Ak6eqitI+M/zl6qHeJa7VPVDQxTNmZz0NEZ54XOz6w3EWpRA37jfadpGgWJ/g0U1RmZZ
         ZulkRj1+mYahnX2oPDjcDFgZGl0J7cU9A69Pn0NzuhNKM40OjDzJ0Z6xl5PRbbobmqkn
         yo3i3u23nfcTGEk4OGNbja7OJHVePmansJg/qbkutg03b3f3kSsRnJu0RltwKbV9uIGk
         qZ4DOqQgyFsuShmHfHsLgHExRDUSpnwXKEUSTPWWqu4I79eZAxCVl/19rac79g+4BZFg
         MCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JDwCmTB/AaqKZq9tyGdosEwMm5AfEG6wtdOz1OuotVY=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=UMOU+vwMhUCGqQ32LIpwd5lfywY9t+tdP2+cgP6Mhi/g9xKmN4ZQvE1REjIH+Me8Qy
         ceg36vuw6NtEx3ArljdcRYBn+Sd7rtYokEOcIF9snC0beSRblKejqCl07uDZu/b2+zj2
         P57IJ7bx5y5EfjHolwZGuKFYhqSiumZHvjgmW5OrWzA5fwEHYqZO9aYvldh3gSrWtyvk
         /vLVMMnAKV8WnS1c/NbDrfVfiZ5G4+9H5mJtEAySYXhT4MeRxoLDRDGeeWh9ZgJ57PXp
         O9aSuJ7q/gZ6jYXwHZlJ3/iDTAMcUnFD50qoG9FPhs4/zz2Aged0Tqr/J6QwI9lr+oVW
         0Y8A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772271400; x=1772876200; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDwCmTB/AaqKZq9tyGdosEwMm5AfEG6wtdOz1OuotVY=;
        b=gcvmaKJZo1NC/1/2aATlVzCXzfb1s+jzAmkZgWqQp0/s3cPXQ5mk1UAFvS/+P38FbC
         qCYWIPGzMoc0fowqfoFl0L2qAeG13AdeE07uo9PgtW0eQDOpLK2Ug9kals39xOjDndwa
         JEDecu1mhZ1t0s7zVEXAN3ebNQJWUMabyVOwW2hqvlX2mWtDrLL+QslKt76sM5GiiRfH
         ZOoYYz8u0tOSqduRtTA3ZNQVQ01mVTeIwKqKSy5NRZ9H88+2+L9vFB24Z50aoZo4x5/o
         x4D0YPIoiMUC0wZe2S3e0gAFoOFU3g2BT8CQxaf7643u0PgCxo1cKAKKbEO97ELGvr+7
         ppUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772271400; x=1772876200;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDwCmTB/AaqKZq9tyGdosEwMm5AfEG6wtdOz1OuotVY=;
        b=hHjlLg7O9SqLTR+h9gzFNSAFEcTv7fjnsvl2CmxrAE4aehVi6aF+/bxqEpLmWl5SH3
         E54AGlmTsSgfQ4dPSDcz38E6wdn+wrjout0dRCzsHadRXFEVmiGIuD1FdMT1ou4A/9GM
         PnkqYr46IeNXke35jOHiQyEStDJiGOevwYSocaJkQFC96u046/TWRTqPDKGVehAgmqtm
         gmI61uTasbYmADk728SavIKIzdWv/dvrzIbmnGAvLae0ONnKYST+wNRejMovwKsPUne/
         PGj27XLU7iql2fOA04DuERBTIJEqVi6MC/7QtGTaYa5ZlD1y4UdHqOyGqJP5KDTixya6
         9Pvg==
X-Gm-Message-State: AOJu0YxJiN/nBhBsK8Vuwn+dQeOM+amy04WGjsLYRDgzhC4be0E4ldbx
	Dh8SWTBtYFJ2Mn8g0cNM2spkhUuYXUc/eCmVfQrnVz8AhMzSc61tvKA05eMIIsvrEpHfoz/7eoZ
	vfKb3oxq2ohu7FaqKwuhifR5HJFJDxTDmeYgDhvs=
X-Gm-Gg: ATEYQzwh08Iur3OSNXC947HFgklBvX6/ZzBKtWJx4lYNmh5onvLPVA9MvGWWr7ZQf9M
	P6s2ryca/81C0ULEO5e79FJg7uA4AcOg27Zhdm+7HSxIkMSNj8EcEnCX6BbNiMLX2JyPjCXKvpx
	z9npEcUXrj5Ww153FcoNaIJCYYeqahfpqZpDWavovST+YvaimrNIB6aTXkxgEt7+TP5dsE1Ouzl
	4+m1TWIqC7VqQ0K7vCnct7PrAaZR5robN/qrqBl+GPIdBDjRV/MjoBMdKp8KGS5e5KFJl+5Oj1M
	EgQ79snG0T0G2wOYqg==
X-Received: by 2002:a2e:a7ca:0:b0:38a:27e:b930 with SMTP id
 38308e7fff4ca-38a027ebd3cmr28653701fa.39.1772271399923; Sat, 28 Feb 2026
 01:36:39 -0800 (PST)
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
MIME-Version: 1.0
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Sat, 28 Feb 2026 15:06:27 +0530
X-Gm-Features: AaiRm52vV_HpatU2qYSvzGB1Rhk7XifK-1zFkVllwFkCmBTR3tcNjM7ttYJ27HE
Message-ID: <CABCXVc=PYU6WBt6K1sggMT1JtX11Bu6BZAs04pNYQr3ig7c77A@mail.gmail.com>
Subject: [PATCH] README: Add Quick Start section for beginner onboarding
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="0000000000003d0901064bdf17e9"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2445-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 95BDF1C1C4E
X-Rspamd-Action: no action

--0000000000003d0901064bdf17e9
Content-Type: multipart/alternative; boundary="0000000000003d08ff064bdf17e7"

--0000000000003d08ff064bdf17e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi EROFS maintainers,

As a prospective GSoC 2026 contributor interested in low-level filesystem
work, here's a small documentation improvement to README.md:

- Added a prominent Quick Start section early for better onboarding
- Full beginner workflow: build =E2=86=92 mkfs.erofs =E2=86=92 fsck =E2=86=
=92 erofsfuse mount =E2=86=92
cleanup
- Compressed example + multithreading note
- Shields badges and upstream/community links

Patch attached (generated from my fork:
https://github.com/Aayushmaan-24/erofs-utils/tree/feature/readme-quick-star=
t
).

All commands verified locally. Happy to revise or split changes.

Thanks for considering!
Aayushmaan
GitHub: Aayushmaan-24
Location: Chengalpattu, Tamil Nadu, India

--0000000000003d08ff064bdf17e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">Hi EROFS maintainers,<br><br>As a prospective GSoC 2026 co=
ntributor interested in low-level filesystem work, here&#39;s a small docum=
entation improvement to README.md:<br><br>- Added a prominent Quick Start s=
ection early for better onboarding<br>- Full beginner workflow: build =E2=
=86=92 mkfs.erofs =E2=86=92 fsck =E2=86=92 erofsfuse mount =E2=86=92 cleanu=
p<br>- Compressed example + multithreading note<br>- Shields badges and ups=
tream/community links<br><br>Patch attached (generated from my fork: <a hre=
f=3D"https://github.com/Aayushmaan-24/erofs-utils/tree/feature/readme-quick=
-start">https://github.com/Aayushmaan-24/erofs-utils/tree/feature/readme-qu=
ick-start</a>).<br><br>All commands verified locally. Happy to revise or sp=
lit changes.<br><br>Thanks for considering!<br>Aayushmaan<br>GitHub: Aayush=
maan-24<br>Location: Chengalpattu, Tamil Nadu, India</div></div>

--0000000000003d08ff064bdf17e7--
--0000000000003d0901064bdf17e9
Content-Type: application/octet-stream; name="readme-quick-start.patch"
Content-Disposition: attachment; filename="readme-quick-start.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mm64m0tw0>
X-Attachment-Id: f_mm64m0tw0

RnJvbSBiNTBmZDdkODQ4YmIzYWQwNTA4MGQzZGVkODYyZDBiYzc0MjU0YjY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYXl1c2htYWFuIDxhYXl1c2htYWFuLmNoYWtyYWJvcnR5QGdt
YWlsLmNvbT4KRGF0ZTogU2F0LCAyOCBGZWIgMjAyNiAxNDo1MDowNSArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIFJFQURNRTogQWRkIFF1aWNrIFN0YXJ0IHNlY3Rpb24gd2l0aCBiZWdpbm5lci1mcmll
bmRseSBidWlsZCwKIHRlc3QsIHZlcmlmeSwgYW5kIG1vdW50IGd1aWRlCgotIEluc2VydGVkIGVh
cmx5IGZvciBiZXR0ZXIgb25ib2FyZGluZwotIERlYmlhbi9VYnVudHUgZGVwcyAoQ3Jvc3Rpbmkg
dGVzdGVkKQotIEVuZC10by1lbmQgZmxvdyBpbmNsLiBmc2NrIHN1Y2Nlc3MgaGludCBhbmQgY29t
cHJlc3NlZCBleGFtcGxlCi0gU2hpZWxkcyBiYWRnZXMgKyB1cHN0cmVhbS9jb21tdW5pdHkgbGlu
a3MKLSBObyBjaGFuZ2VzIHRvIGV4aXN0aW5nIHRlY2huaWNhbCBzZWN0aW9ucwotLS0KIFJFQURN
RSB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
UkVBRE1FIGIvUkVBRE1FCmluZGV4IDFjYTM3NmYuLjY4YTAwYjEgMTAwNjQ0Ci0tLSBhL1JFQURN
RQorKysgYi9SRUFETUUKQEAgLTEsNiArMSw5IEBACiBlcm9mcy11dGlscwogPT09PT09PT09PT0K
IAorWyFbTGFzdCBDb21taXRdKGh0dHBzOi8vaW1nLnNoaWVsZHMuaW8vZ2l0aHViL2xhc3QtY29t
bWl0L2Vyb2ZzL2Vyb2ZzLXV0aWxzL2RldildKGh0dHBzOi8vZ2l0aHViLmNvbS9lcm9mcy9lcm9m
cy11dGlscy9jb21taXRzL2RldikKK1shW0xpY2Vuc2VdKGh0dHBzOi8vaW1nLnNoaWVsZHMuaW8v
YmFkZ2UvTGljZW5zZS1HUEwtLTIuMCUyMG9yJTIwQXBhY2hlLS0yLjAtYmx1ZSldKENPUFlJTkcp
CisKIFVzZXJzcGFjZSB0b29scyBmb3IgRVJPRlMgZmlsZXN5c3RlbSwgY3VycmVudGx5IGluY2x1
ZGluZzoKIAogICBta2ZzLmVyb2ZzICAgIGZpbGVzeXN0ZW0gZm9ybWF0dGVyCkBAIC0xMSw2ICsx
NCw3IEBAIFVzZXJzcGFjZSB0b29scyBmb3IgRVJPRlMgZmlsZXN5c3RlbSwgY3VycmVudGx5IGlu
Y2x1ZGluZzoKICAgICAgICAgICAgICAgICBhcyBleHRyYWN0b3IKIAogCisKIEVST0ZTIGZpbGVz
eXN0ZW0gb3ZlcnZpZXcKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIApAQCAtNDksNiArNTMs
NjEgQEAgRm9yIG1vcmUgZGV0YWlscyBvbiBob3cgdG8gYnVpbGQgZXJvZnMtdXRpbHMsIHNlZSBg
ZG9jcy9JTlNUQUxMLm1kYC4KIEZvciBtb3JlIGRldGFpbHMgYWJvdXQgZmlsZXN5c3RlbSBwZXJm
b3JtYW5jZSwgc2VlCiBgZG9jcy9QRVJGT1JNQU5DRS5tZGAuCiAKK1F1aWNrIFN0YXJ0OiBCdWls
ZCwgQ3JlYXRlLCBNb3VudCwgYW5kIFZlcmlmeSBhbiBFUk9GUyBJbWFnZQorLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKKzEuIElu
c3RhbGwgZGVwZW5kZW5jaWVzOgorICAgYGBgYmFzaAorICAgc3VkbyBhcHQgdXBkYXRlCisgICBz
dWRvIGFwdCBpbnN0YWxsIC15IGF1dG9jb25mIGF1dG9tYWtlIGxpYnRvb2wgcGtnLWNvbmZpZyBc
CisgICAgICAgbGliZnVzZS1kZXYgbGlibHo0LWRldiBsaWJsem1hLWRldiBsaWJ6c3RkLWRldiB1
dWlkLWRldiB6bGliMWctZGV2CisgICBgYGAKKworMi4gQ2xvbmUgYW5kIGJ1aWxkOgorICAgYGBg
YmFzaAorICAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9lcm9mcy9lcm9mcy11dGlscy5n
aXQKKyAgIGNkIGVyb2ZzLXV0aWxzCisgICAuL2F1dG9nZW4uc2gKKyAgIC4vY29uZmlndXJlIC0t
ZW5hYmxlLWx6NCAtLWVuYWJsZS1sem1hIC0tZW5hYmxlLWZ1c2UgLS13aXRoLWxpYnpzdGQgWy0t
ZW5hYmxlLW11bHRpdGhyZWFkaW5nXQorICAgbWFrZSAtaiQobnByb2MpCisgICBgYGAKKworMy4g
Q3JlYXRlIGEgc2ltcGxlIHRlc3QgaW1hZ2U6CisgICBgYGBiYXNoCisgICBta2RpciBzcmNfZGly
CisgICBlY2hvICJIZWxsbywgRVJPRlMgd29ybGQhIiA+IHNyY19kaXIvaGVsbG8udHh0CisgICBl
Y2hvICJUaGlzIGlzIGEgdGVzdCBmaWxlLiIgPiBzcmNfZGlyL3Rlc3QudHh0CisgICAuL21rZnMv
bWtmcy5lcm9mcyB0ZXN0LmltZyBzcmNfZGlyLworICAgYGBgCisKKzQuIFZlcmlmeSBpbnRlZ3Jp
dHk6CisgICBgYGBiYXNoCisgICAuL2ZzY2svZnNjay5lcm9mcyB0ZXN0LmltZworICAgIyBFeHBl
Y3RlZCBvdXRwdXQ6ICJObyBlcnJvcnMgZm91bmQiIG9yIGZpbGVzeXN0ZW0gc3RhdGlzdGljcyAo
bm8gZXJyb3IgbWVzc2FnZXMpCisgICBgYGAKKworNS4gTW91bnQgYW5kIGV4cGxvcmUgKHVzaW5n
IEZVU0Ug4oCUIG5vIGtlcm5lbCBtb2R1bGUgcmVxdWlyZWQpOgorICAgYGBgYmFzaAorICAgbWtk
aXIgbW50CisgICAuL2Z1c2UvZXJvZnNmdXNlIHRlc3QuaW1nIG1udC8KKyAgIGxzIG1udC8gICAg
ICAgICAgICAgICAgIyBTaG91bGQgbGlzdCBoZWxsby50eHQgYW5kIHRlc3QudHh0CisgICBjYXQg
bW50L2hlbGxvLnR4dCAgICAgICMgSGVsbG8sIEVST0ZTIHdvcmxkIQorICAgZnVzZXJtb3VudCAt
dSBtbnQvICAgICAjIFVubW91bnQgd2hlbiBkb25lCisgICBgYGAKKworNi4gQ2xlYW4gdXA6Cisg
ICBgYGBiYXNoCisgICBybSAtcmYgc3JjX2RpciBtbnQgdGVzdC5pbWcKKyAgIGBgYAorCis3LiBD
b21wcmVzc2VkIGltYWdlczoKKyAgIGBgYGJhc2gKKyAgIC4vbWtmcy9ta2ZzLmVyb2ZzIC16bHo0
aGMgdGVzdC1jb21wcmVzc2VkLmltZyBzcmNfZGlyLworICAgYGBgCisgICBGb3IgY29tcHJlc3Nl
ZCBpbWFnZXMsIGFkZCBlLmcuIGAtemx6NGhjYCBvciBgLXp6c3RkYCAob3Igb3RoZXIgYWxnb3Jp
dGhtcykgdG8gYG1rZnMuZXJvZnNgLgorICAgU2VlIHRoZSBgbWtmcy5lcm9mc2Agc2VjdGlvbiBi
ZWxvdyBmb3IgYWR2YW5jZWQgb3B0aW9ucyAoYmlnIHBjbHVzdGVycywKKyAgIG11bHRpLWFsZ29y
aXRobXMsIHJlcHJvZHVjaWJsZSBidWlsZHMsIGV0Yy4pLgorCiAKIG1rZnMuZXJvZnMKIC0tLS0t
LS0tLS0KQEAgLTI4Myw2ICszNDIsMTQgQEAgZmVlbCBmcmVlIHRvIHNlbmQgZmVlZGJhY2sgYW5k
L29yIHBhdGNoZXMgdG86CiAgIGxpbnV4LWVyb2ZzIG1haWxpbmcgbGlzdCAgIDxsaW51eC1lcm9m
c0BsaXN0cy5vemxhYnMub3JnPgogCiAKK1Vwc3RyZWFtIGFuZCBDb21tdW5pdHkKKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KKworLSBDYW5vbmljYWwgdXBzdHJlYW06IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3hpYW5nL2Vyb2ZzLXV0aWxzLmdpdAorLSBE
aXNjdXNzaW9uIC8gcGF0Y2hlczogbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZyAoc3Vic2Ny
aWJlOiBodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXgtZXJvZnMpCistIEtl
cm5lbCBkb2NzOiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL25leHQvZmlsZXN5c3Rl
bXMvZXJvZnMuaHRtbAorCisKIENvbW1lbnRzCiAtLS0tLS0tLQogCi0tIAoyLjM5LjUKCg==
--0000000000003d0901064bdf17e9--

