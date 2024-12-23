Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37BE9FA98B
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 04:01:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YGjTM4SCbz3011
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 14:01:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=79.135.106.109
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734922869;
	cv=none; b=hAt7Sd3zY/0+UawJ5rydHpUpaJyTkAwx9pXvf+X79deE5wnJ1Mas1B+e31OWy0/pZNhdvq/kGqV8ZSpzUJwkV33FgxzRw458slkSZa3TM4jMDEa3v0KjOuV4sWKEuwvvcXwNiDkRzj1fd1kaHWoVCeOc5R9SJc1HYKNr5tCJptv3QcLZ8r5SwZjcv3/GKOwfl+OOVL+/K/YbQMj36iaXCmsut6taiBkIywd1mvfTxzo9qTYQdiLBUATdgUwvx9sS9PuqNEI+wOyZGtGg490sXmYol7NQorYzKn421V1S+iN0gvibkSmXWOJfh/Gr/9ADs3vQg76B10rqNHNr0uvE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734922869; c=relaxed/relaxed;
	bh=SHtY4cwbcwckhBhyL99rM8buRONT3zKCciVHn+TuBDA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G/ebfrXOOFHWWFXatveSKdgSWtdP0mVmD15divxcSjnmccxBNs1Jy+Zi6k/qYCHJO380S3/85xWFU/7EDVF0vp2Vtx+QxgCnVNggNVlVlskgnRR5eDAKwPtIACMUtT/8/og1+hT4fOWttbU/00QY41U7nfHxIYMNze0yNeypcCfPesW7BMpC05ZwzO4tiSK8/WGhaDW0Rh/jB+r6kboR5agnoYQePufeprmYVmUP/r+R6tYk2Bt8VXgo6eUY/T0sQ33vUhbPLwDtzKOoqVusiEDf2/bnX3xSd1Bqk8bQugEl/QBzCv2agboVruCGcyRph6AV0it0PFZGB+1sN1eDUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; dkim=pass (2048-bit key; unprotected) header.d=ethancedwards.com header.i=@ethancedwards.com header.a=rsa-sha256 header.s=protonmail3 header.b=ULCumkTg; dkim-atps=neutral; spf=pass (client-ip=79.135.106.109; helo=mail-106109.protonmail.ch; envelope-from=ethan@ethancedwards.com; receiver=lists.ozlabs.org) smtp.mailfrom=ethancedwards.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ethancedwards.com header.i=@ethancedwards.com header.a=rsa-sha256 header.s=protonmail3 header.b=ULCumkTg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ethancedwards.com (client-ip=79.135.106.109; helo=mail-106109.protonmail.ch; envelope-from=ethan@ethancedwards.com; receiver=lists.ozlabs.org)
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YGjTB5p84z2xfC
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Dec 2024 14:01:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=protonmail3; t=1734922844; x=1735182044;
	bh=SHtY4cwbcwckhBhyL99rM8buRONT3zKCciVHn+TuBDA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ULCumkTgw3EdKSatimehE+rQyizf684WrOZzaRAujJSfn65qVujeTBVInLdvvTl2n
	 13vZtb1qNaFBhQFK33zVrMsDNKtEwBmHjOjUYeqhWCQeNLLlYsw4CLYrntRd7VUuFy
	 MhNTS3ahVzt5kebJZHv1KGudiHmHur5aldUXgOepxDr18UgsRZ+mXYnoFd9yUH6ZxC
	 18nBxy4/ZvXogi3ndrRQD+rTS1aSTaLmAr27lNu9PeWiOyARFi3m3ihirUVzUxBwL3
	 nTETw8sFNw5ISmXvJenBZTULO4lA+ceMiSJEPvE3Kp9KK7OE0f3CceZCe9/lPI3dH0
	 potI/QeWuEoGQ==
Date: Mon, 23 Dec 2024 03:00:40 +0000
To: "xiang@kernel.org" <xiang@kernel.org>
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc
Message-ID: <i3CLJhMELKzBJr3DaRyv-hP_4m-3Twx0sgBWXW6naZlMtHrIeWr93xOFshX8qZHDrJeSjHMTiUOh8JmBZ9v0AB-S1lIYM_d-vasSRlsF_s4=@ethancedwards.com>
Feedback-ID: 28410670:user:proton
X-Pm-Message-ID: 95f523c5b9d491e553e56b41200f9f3466e6bd5b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From 272d7ef4611e64269fada0ea3021eece590118b9 Mon Sep 17 00:00:00 2001
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 22 Dec 2024 21:23:56 -0500
Subject: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc

Refactor xattr.c to use kcalloc instead of kzalloc when multiplying
allocation size by count. This refactor prevents unintentional
memory overflows. Discovered by checkpatch.pl.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/erofs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a90d7d649739..7940241d9355 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -478,7 +478,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 =09if (!sbi->xattr_prefix_count)
 =09=09return 0;
=20
-=09pfs =3D kzalloc(sbi->xattr_prefix_count * sizeof(*pfs), GFP_KERNEL);
+=09pfs =3D kcalloc(sbi->xattr_prefix_count, sizeof(*pfs), GFP_KERNEL);
 =09if (!pfs)
 =09=09return -ENOMEM;
=20
--=20
2.47.1
