Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EC993E9C
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 08:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728367716;
	bh=LV5xESWwaS29cX148YJhC3gYVzjD5pmYuOe38IrKZ+8=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ooc4G4tlFe3NEQBZ0q50/jxusqTA1CMAUrwnhLX95Yk56UuOljMmuHj/Qg+g9Q0iy
	 3UV+qqYmZOQdkxF2mIj2OMyXoR3EKdAUcvAVJTOHS8VwM7kB/lKjSTEtezJqqgA1pp
	 gB57g2HFZcLVYD1Av6X+rkqaa2a5Y9x/mkqu3DKnx4+Cvj1z0lcwDWl9bzEBpP+6ti
	 L5Irf51OoVQG1KXJCBY9Vn3O8j9PBajFKg8qiPpV4zQwyHXOho5j7Pxm5ZtBav42D6
	 OlX1q/EchAUxus/QvuzU1uZEPJ1tRpwhg2pdB+Nn1uAcOwSf5DbyNBEh5hM7X3gRD4
	 2xwj06RZPna6g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN5Dh2B6dz3bcy
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 17:08:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1149"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728367714;
	cv=none; b=c+5lfIaOgEL4UCOyJDk8aLebVXDvKFlovAH8k7uUECu/rKUdru7NkiaWl2IbGfQ7RMSH+UL/CkOZaYjc+YHJY7EGCMUdbhggRTBsM6WGtD66WqvP6Vi4PXk8R1z5X95cN7aT7qRqmHmC1tqQC+jyrYg1uW6WRvGxPaZjBB7/69i9YnDwLfLkpRgNEEqVjDhTbJplVK0SBhgYz9dMgCbJDOV/sVwUkOw+8sGP4+TsRrlGfjJrPXfh89qUjN9J9gUxtgZmaJq9GeI7kkdbEY4qKkmfhfiHJrGm75sfi/jvaNqYkVIpn2yxNNGJkhEat3oRzwTttj886Qew4ysqgXJ8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728367714; c=relaxed/relaxed;
	bh=LV5xESWwaS29cX148YJhC3gYVzjD5pmYuOe38IrKZ+8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lqLJm/GisTIGjnJscLa8g9RMKhk9+ZTo0iQIQifMEsMIQwNQQYMv8yMT+W9wwdv/f5C2HCG047WJx/Xb5epDeW8tCq6chsVDQqKi4QuxZYTFmMikciFQoY2/D1GK7HeMR8U2ehcDh6CbsZoRv31cCN/1ISrLy4ddxOEnTtQlMmv4fjkGIuFzV0O9UMBZZh1lZ+riDPGHZ/qssKg4nFK+MpPzQtTcosEFchmuGm762AlzdZ104CKBQqxedvonaZ9bORjkYFgVfYbQpFCfawqggIERgVCd58v09SYnYon5Ku6bVop9N4G+KsidlXgayfFoyRuBAMpnHYscDa/nUsi+cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ic6ZiwdH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3wswezwqkc0uup3hnvvnsl.jvtspu14-lyvmzspz0z.v6shiz.vyn@flex--niwa.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--niwa.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ic6ZiwdH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--niwa.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3wswezwqkc0uup3hnvvnsl.jvtspu14-lyvmzspz0z.v6shiz.vyn@flex--niwa.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN5Dc4DFGz3bbR
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 17:08:30 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-6e2d1860a62so49745807b3.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Oct 2024 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728367706; x=1728972506; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LV5xESWwaS29cX148YJhC3gYVzjD5pmYuOe38IrKZ+8=;
        b=ic6ZiwdHIp0RH6tbv0CYmk5xnef6Sh0c8GNXDIAuwBfQ6EccP4BiTDmbjCuOFRShaB
         hcqTQ3qI1rf7bdFpDnzhkwvQAko3HVRTMOszvnguPiTf9w4vF4v80VFtgXPV535+Jtl8
         DggGeZEL9uWxr3WLoFYbn9+D7QhrjFOMly8eqnRFXwQQrceG4vluhBEIFDHnuFdt3zBE
         Kz1S+piktjc5xm1+hX9MQ1CK81q4Bob9PPYpim/m6MHVabx1SIYWoykt2RJg8/4ddFe5
         eKf0ANzaYp9W+MptSF1yn4GSNE+Fp0Ym/EwH2K+fzjnnQSakyDiJJaThJ73x5xz1GHz8
         MBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728367706; x=1728972506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LV5xESWwaS29cX148YJhC3gYVzjD5pmYuOe38IrKZ+8=;
        b=LQhi1d+Pot92TnY+1s+M4F3/sSy3jvDA7QDSvPQcgKSF4GyTR65BH4li8hUV0XDgvM
         Fpn2C0WuJ59YCfYRVgggzFiysS+rOcj3zOzNfGH8ZPdWFStMagEgP2CMAsW5TOwyu+rr
         eaCouqF15v4/TqE20a9arRrSo10UXnrnvr/vp4ruwTe/pb/3fSEEVyknjZQE9fCQhmON
         Is9rZuT/TLD9RnZ7zjdmh9WXlrSAdh3FNB25QCtk32jH46C8sdeFBXI/NWfsVk10vD35
         PMkzPBdjI6yrSQFdt40pULn49OUnXcXk2JgNrNaPdZwGxjZmjEAUoM71P4pauItl314k
         16sQ==
X-Gm-Message-State: AOJu0YyNbh/0TAJd6F5ujhlJWleHjFb30wfMEgu7sLL6KWWgCSb9Sswl
	5VRMxO9Ine1FHEYrVWMoXVKV4RW0JU8COyx2hPzSraIe2pvz+Z8zfIa5e55FA7jdDZR0Djvad5Q
	rMSwSmdBAPg2ftXOI6qcaMc/YNeHtj4XdSkQI/YDjpuj7iWbd95VyJH1l1i9lGraAZmUT01ek6f
	s+4RGCdOlQp/5HN/lXaI+58fkLKl+Smg==
X-Google-Smtp-Source: AGHT+IHkXZDW9DAcv46CSZDg5viiepuz5ZMQ/jwvesQ3alChMUCPcZ5qvbDG6QUBr1jkkHBcrTfq3j6A
X-Received: from acty2.tok.corp.google.com ([2401:fa00:8f:203:a631:efce:f21c:afbd])
 (user=niwa job=sendgmr) by 2002:a05:690c:2706:b0:6e3:1702:b3e6 with SMTP id
 00721157ae682-6e31702d2ccmr20117b3.4.1728367706458; Mon, 07 Oct 2024 23:08:26
 -0700 (PDT)
Date: Tue,  8 Oct 2024 15:08:19 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008060819.2442945-1-niwa@google.com>
Subject: [PATCH] erofs-utils: lib: Explicitly include <pthread.h> where used
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.0
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
From: Satoshi Niwa via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Satoshi Niwa <niwa@google.com>
Cc: Satoshi Niwa <niwa@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

compress.c and inode.c use pthread functions but do not explicitly include <pthread.h>.
This causes build failures with the Android build system,
which throws "error: implicit declaration of function pthread_*".

Signed-off-by: Satoshi Niwa <niwa@google.com>
---
 lib/compress.c | 3 +++
 lib/inode.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index 17e7112..5d6fb2a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -8,6 +8,9 @@
 #ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
 #endif
+#ifdef EROFS_MT_ENABLED
+#include <pthread.h>
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/lib/inode.c b/lib/inode.c
index 7958d43..48f46b1 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -6,6 +6,9 @@
  * with heavy changes by Gao Xiang <xiang@kernel.org>
  */
 #define _GNU_SOURCE
+#ifdef EROFS_MT_ENABLED
+#include <pthread.h>
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-- 
2.47.0.rc0.187.ge670bccf7e-goog

