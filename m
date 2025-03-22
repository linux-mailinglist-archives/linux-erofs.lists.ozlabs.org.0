Return-Path: <linux-erofs+bounces-113-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44238A6CC72
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:44:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrrZ6JGcz2yTP;
	Sun, 23 Mar 2025 07:43:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742676238;
	cv=none; b=AlyGEM1LjyT04EDgVJOQgMzWPuOP+f8iwIQXMW28aTLblyzTV7kcHaVX7esdmvXsD+8lvScxXR++lriVa0E1R8tK5n1VFWpvxoYLgO8NYIBwcl8ne5ctWoovsQinFQSoId9lar+d1a6wEMD6UcsZjC7SHRwePrgv3rCQWxyzTNr2A5WBI5u2KPlInU2BfwNoR4hcjrsjkuTUaJzbvQTwJ8BYMhzUqbpkznhUfGdVkWDV+m61V6DYfRKlSRuoUWNgj3S8K6oR/bEDpXdMgugg+2N9CQ+/l7aVaBnYvwJwxxurdze6KwHbOU55E3E4Dlgj/KyKon2IBRHpU1cjir0csg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742676238; c=relaxed/relaxed;
	bh=5VyvbpqWFevMPoGk/oJe8KG+YRJjQWQ+kgj5mztbV4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msu7rNlp7Z3n2A3FI/CuwT/Sv5wpnTZjGj/nlr5OPznUVaeGLuX8xWMYqxJJrR78QQfaAiYbgRp6ywghOppXhI7KwtFbqgFtKtIzJz3MXrzLVFTuWkorhnffOrU1Ang/Nrd2Ykq4THGDGQbRs/IHsV4nbHeE5aS5HxtgkNqfegPWF7FSS7STtEqgKU6kMQoT6iQH7mzPOJANMglLm8NvkmIWC6P4Dm7htUWcn1cWplrK2VMG+SiKZOiN6tQtyylzkPeRbaegBplWI2RhFgszR25sJVvWgfhkAJa0uC8KGNzgHIOCTiMUrSZW0gDanbyBwlzZUc2zrqJSvn59UxHQVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KJJeHfYl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KJJeHfYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrrY0nCFz2ydW
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:43:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B72864403A;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1643C116C6;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=p8v3JQ4emsUMjjvSBjOOzwZTgB1SvlkW9F+SuuyZM1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KJJeHfYl3yzGUIwImmqR8xWDh/xoz41CsGa2N3ZvJ2+Uzr9yIFnrtV8JlkuUcu0YQ
	 Ouy2RN/TdTY0RARXo6QMN15NBmtZcraSr7+++reLI0GQatQ2TyP+c5ShKH7ZlhQLYQ
	 FGjHO4/bBEz4+ZPz1PClqYTh1gnR0t3CyDrJJF6o76jHw8qDRlrbPotMmzleV6W7po
	 rFBm5TmGLxlp3tpY6CgnOUWJAl84hVyGVBOhpURoeF55YpqwGaazTzEakbPTaho18u
	 OPt6mO/stFa+IIWM2wA+mfY/PmSmHIzKhBoWIWvx/pJfMWrCr7lz4PASfk8GEBS5bm
	 gddTVp2bOti0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E4C36008;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:21 +0100
Subject: [PATCH v2 9/9] fs: erofs: register an initrd fs detector
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-9-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
 Niklas Sturm <niklas.sturm@secunet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1748;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=3yTdTgTHrBXPDCzHQY85SoPI2ekHfJ9SwSVLMJjjpHc=;
 b=gbKgVEbkExOOnYyBMICxer+0rrpqPN7L6a11TGtSHg9nUJDPcH1Az1Dcltfti9MOJD2CWO7NM
 iXnPdA1cJA4Ct+v+ehZ5rvSbO6BmO84OPaQLlG31oC9XmPYYKZEvguk
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Allow erofs to be used as a filesystem for initrds. It offers similar
advantages as squashfs, but with higher performance and arguably nicer
tooling. If we support squashfs, there is no reason not to support
erofs as well.

Suggested-by: Niklas Sturm <niklas.sturm@secunet.com>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/erofs/Makefile |  5 +++++
 fs/erofs/initrd.c | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109550a0518f2ed8df456deecdd2f8c..cea46a51dea2b9e22e4ba1478dd30de3262fe6cb 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,3 +9,8 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+
+# If we are built-in, we provide support for erofs on initrds.
+ifeq ($(CONFIG_EROFS_FS),y)
+erofs-objs += initrd.o
+endif
diff --git a/fs/erofs/initrd.c b/fs/erofs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..e2bb313f55211a305e201f529d7da810898252ac
--- /dev/null
+++ b/fs/erofs/initrd.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/initrd.h>
+
+#include "internal.h"
+
+static size_t __init detect_erofs(void *block_data)
+{
+	struct erofs_super_block *erofsb = block_data;
+
+	BUILD_BUG_ON(sizeof(*erofsb) > BLOCK_SIZE);
+
+	if (le32_to_cpu(erofsb->magic) != EROFS_SUPER_MAGIC_V1)
+		return 0;
+
+	return le32_to_cpu(erofsb->blocks) << erofsb->blkszbits;
+}
+
+initrd_fs_detect(detect_erofs, EROFS_SUPER_OFFSET);

-- 
2.47.0



