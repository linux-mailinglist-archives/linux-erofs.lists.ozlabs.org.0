Return-Path: <linux-erofs+bounces-2883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN3PECJGvWlZ8gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 14:05:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C802DAA9D
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 14:05:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcjV22CSxz2yYY;
	Sat, 21 Mar 2026 00:05:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::641" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774011930;
	cv=pass; b=YS0F6WJHAEJWO5p4xV7nPyIJ6cmXEDA7cpVkP2vCVB6rdi0wR4leqtzb8QHUqSRMqR+SdfsH2JbjciwRDIo3Kt0HazIjop/oAiQqLfdVv3FA6LP/0se1VX1aSI2aUjruS6NknXZyGVnUJc2Se+wyoi2rk984+m7GqRdrpBx0ufLxrdXuDi6XVIFvkzh9pVnEhc/mu2Y8S/Dmkq6sV8hxSSp5CErH5DE4pRHOoHDhn1uidulIBnOm1avZSd0OQ4il1FCZ+pRQObi5jDXPfgFeNxryVBvOuQiDdJrUuePOLUs9wy2C8X5QQidcGrYQ+Jy1NCitG5TRFaq0MQlDLwnBpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774011930; c=relaxed/relaxed;
	bh=/uqy2wWhOMhXlmhaDt2XNsYZk4YJ7fQWU3RS6DQKaMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YaOQjHzN49+zguAopNavu6f8W/sBvet1/Q399h9virIKjp4ZaWCOgVVuPEcCsEVu9fWnorIX8cTGLx88uP5G1wQGGMu7zVLWR+OXFXKe4ZxZERAJ7r9bS7VbUZMGY4ECtn7sU0yi8+0eSczjbl5C8efb07Xsea4XzQz2iNAZ1acB6+pP+l2QGnuey4yqcclGnx+uxdscSsPpcui25sP0NDLayFBxo+/5ED5jiousvEHoRcS2IYb8putb6oQ/jQ2N1VtFNMnHOQmIAGESox92zj0/J8gttxwHP2U9c4rMOE+sih9JSMIayLnVW+gmECBWhp6VtN2WbIEnFhV0mmZajQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m1L4tNLv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m1L4tNLv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcjV00kcmz2yY1
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 00:05:27 +1100 (AEDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-b93698bb57aso398395466b.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 06:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774011923; cv=none;
        d=google.com; s=arc-20240605;
        b=Oyrf2r46+meKytrwNg31Lsaua0vB10dCTgXZzLNSLov9G7ti5z86ctHKWFdKNR62mh
         ybjXKQHMrD8GJa7XjVJRPwFuRJiClyowDaHTBE8rWIMsf714yKVY3Gjhmas+dR62EemF
         ZNn1Czb8Aw11KJSngK/vsggq7Kd4+02nMH/F1iJAZZJJbkYcRGGm5lrbVj5Udf+NIoxQ
         vMEMRCTzGL4LvriKNvPzPIjo7fLrfdwS+35Q5Z1b7MT1hVc4Sp0XjFuqQHyEKs2nJ2oT
         y7R6qSblpppoNWFnwNBYg9rRi/4MTycufTU5MHmVtlBugr5jkwnvHp8B8pI4rNkmMzU4
         lTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/uqy2wWhOMhXlmhaDt2XNsYZk4YJ7fQWU3RS6DQKaMU=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=F95YB5zUhi9F/O/p7hzuFsuCZEEjq2F8gF9VvnAGLcAzGD9XkR/9iJqN3jnTLU1gcB
         20NN7nAzwjD5ENpNRrmWZu3WYSYSa8n9Q124AU78OalPorXhtw61XSE3lZF6o1tWlb4v
         YPbb9JqJVcHO6PymEixRcfcn5NlMh86XWYQmpkt94nOVpaglWKUmzR71m1YH6CdKqQOi
         PtpAZ66Zzv//yppCoSzozamfmjooO3YgqYP+BbtOmXC5QMPOfPY/pdT1nsh7TdI8qBwj
         3p5bRUt/4APeNge0mEn2lztSL6G2i2irqOR5v/RgELRbWTTnb6GISKYLXYc2z7lHthlK
         ieKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774011923; x=1774616723; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/uqy2wWhOMhXlmhaDt2XNsYZk4YJ7fQWU3RS6DQKaMU=;
        b=m1L4tNLvPu49MydVSABr8Wx+ygFCDLmRxKtqOVivzzshZE47aWhMFmZ1OwqjzrUxIH
         CVnNiyhs0BXLGCISqABaogPlKKBbCPmDDzw6Q8EDy10WnnZnKDO6lup8bFrCX2Fy7Ekp
         fnMyajqI0Mq2lqUWMiKZeiO3hHYF/ifiF+kZm3wtA1Gw050BDXrSLKn55Dtt63JEdO7R
         jdWA631zaBGhrbqfSXl6miwE53HjT/46VsFnAigdk9N9uJvFwTKHra0/DGdRbvNizRIb
         7nbwxGMe5Qk8NiOgMSuF4fabfu4tNBCq7fk/16l7nI6koMBru0Lgx9cESteY1C/VGOKJ
         ye1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774011923; x=1774616723;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uqy2wWhOMhXlmhaDt2XNsYZk4YJ7fQWU3RS6DQKaMU=;
        b=GbJSPfTq3XLN2QLiVmRnadtfTLaBfsNmon4DhTMBaRdi3MFxCAyygouJwwgZC3GJH+
         fuBXPsWtYDSI4aZGs4g36EAejLji+XL3LoOfLUm7tA4h3VycI3DlXY+roT6J/LQpthI3
         Tb+ASCGdAkoF3S2z/o/qWn13Wcyv+PMW3o3ApIjKWOIxzh9R0oUFUKpfPWKBXZNC+Yuj
         4P+5RRmvqpEra1KBMDeZ8tkn6V2zVcsQKrPKkFJMUdiuLXilJ/+4NfkGuyDjgxamHKH1
         GjJQBlSSqy9Uo/1/ezVMWN71nWkwNFQzKN7HmmP7kiLwCi2/DS2Mn3CPWTjOsJ/MppuF
         9FmQ==
X-Gm-Message-State: AOJu0Yw9Hx/uFnCOKhV9fbCGHIIPnvjAa/CTwiev24ni/9UTpFB8AgI/
	P7gQ5zBMz3d4wN6WbIPvWK3xruDaG/RIf5yMLdhpShPv2USPHbmrSYYi4lZbj1HmHw5XcC2hDSc
	LsHvjXAgb1ggb+SOV9+Fa+KnvbEVHkTFPb7TTtqiYfA==
X-Gm-Gg: ATEYQzyBZfv3NrhIDbp9q13+CnTIN7IH249GJCzdNnkx0lY9CrW56QO7oExZzaq0RYt
	OdkUR71ptADw8jwZ6ifS2CQ2sfm94LPpSiyKHw1S7sHnc4TR6y5ZEdHgJ9AwK5XhK8Qd3DHLgv2
	MbnyuCuahOU9FWc/H/G/dxEPW5GUNKDwIEx6unQ5kSWjQM3kQBWFQ+9+TtnGryC7RKZFYiHwhaw
	ZaIWo8CuhvLpiAg39WBmueLiWrDJa6mIvbs5+kUg9sV5robchqKs9vvsJjkbwFjUVjKAryZA3EN
	QNONKj4YChW7
X-Received: by 2002:a17:906:80c2:b0:b97:ea19:341c with SMTP id
 a640c23a62f3a-b982f39a187mr156354666b.7.1774011923183; Fri, 20 Mar 2026
 06:05:23 -0700 (PDT)
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
From: Kamran Alam <kamranalam4555@gmail.com>
Date: Fri, 20 Mar 2026 18:05:11 +0500
X-Gm-Features: AaiRm5258ZHJQNUQ5VuHViyVCmRfUWv4Ob2V0k09APHHqF9GPqZIrypSWTIf04Q
Message-ID: <CAF7tac4iNk5msT0A6wOfuDHTSP1gcHx1xq20uiM9fy+A4GsdiA@mail.gmail.com>
Subject: [PATCH] ci: add workflow to mark tags as GitHub releases
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000823ab5064d745616"
X-Spam-Status: No, score=1.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2883-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamranalam4555@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C6C802DAA9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000823ab5064d745616
Content-Type: text/plain; charset="UTF-8"

From: Kamran Alam <kamrankhan0368@gmail.com>

This patch adds a GitHub Actions workflow that automatically creates
a GitHub Release whenever a new tag is pushed to the repository.

This addresses issue #22 - currently tags exist but are not marked
as GitHub Releases, making it harder for users to find and download
specific versions.

Signed-off-by: Kamran Alam <kamrankhan0368@gmail.com>
---
 .github/workflows/release.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.github/workflows/release.yml b/.github/workflows/release.yml
new file mode 100644
index 0000000..release
--- /dev/null
+++ b/.github/workflows/release.yml
@@ -0,0 +1,20 @@
+name: Create GitHub Release on Tag
+
+on:
+  push:
+    tags:
+      - 'v*'
+
+jobs:
+  release:
+    runs-on: ubuntu-latest
+    permissions:
+      contents: write
+    steps:
+      - name: Checkout code
+        uses: actions/checkout@v4
+
+      - name: Create GitHub Release
+        uses: softprops/action-gh-release@v2
+        with:
+          generate_release_notes: true

--000000000000823ab5064d745616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From: Kamran Alam &lt;<a href=3D"mailto:kamrankhan0368@gma=
il.com">kamrankhan0368@gmail.com</a>&gt;<br><br>This patch adds a GitHub Ac=
tions workflow that automatically creates<br>a GitHub Release whenever a ne=
w tag is pushed to the repository.<br><br>This addresses issue #22 - curren=
tly tags exist but are not marked<br>as GitHub Releases, making it harder f=
or users to find and download<br>specific versions.<br><br>Signed-off-by: K=
amran Alam &lt;<a href=3D"mailto:kamrankhan0368@gmail.com">kamrankhan0368@g=
mail.com</a>&gt;<br>---<br>=C2=A0.github/workflows/release.yml | 20 +++++++=
+++++++++++++<br>=C2=A01 file changed, 20 insertions(+)<br><br>diff --git a=
/.github/workflows/release.yml b/.github/workflows/release.yml<br>new file =
mode 100644<br>index 0000000..release<br>--- /dev/null<br>+++ b/.github/wor=
kflows/release.yml<br>@@ -0,0 +1,20 @@<br>+name: Create GitHub Release on T=
ag<br>+<br>+on:<br>+ =C2=A0push:<br>+ =C2=A0 =C2=A0tags:<br>+ =C2=A0 =C2=A0=
 =C2=A0- &#39;v*&#39;<br>+<br>+jobs:<br>+ =C2=A0release:<br>+ =C2=A0 =C2=A0=
runs-on: ubuntu-latest<br>+ =C2=A0 =C2=A0permissions:<br>+ =C2=A0 =C2=A0 =
=C2=A0contents: write<br>+ =C2=A0 =C2=A0steps:<br>+ =C2=A0 =C2=A0 =C2=A0- n=
ame: Checkout code<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/checkout@v=
4<br>+<br>+ =C2=A0 =C2=A0 =C2=A0- name: Create GitHub Release<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uses: softprops/action-gh-release@v2<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0with:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generate_release=
_notes: true</div>

--000000000000823ab5064d745616--

