Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550EE47CB3B
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 03:03:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJc6t0wfgz2ypV
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 13:03:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640138598;
	bh=+bIwUXtJ/NbQbwxV5VJGKd4AexQ7hWpQ/iIQQby82SQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=lXigwF3okAkgF+7NwGF4bzJGnu6f7YaI2XJQRwXq8cpVW+cMUOrFjq30jxz39KkvD
	 Lw09BhfJzWWobqbgLUDgRk7gQti3XvFOIueJdpcuGoun9Nm3XefjYvS58MlSqhIcy2
	 7Auu3sQuiztxSSdjYiksdCXgdi+tBWNrk6oO/0qVX15jruhpRuf6+157SU2zbjXdwk
	 oCUddCg/P+1+gE8KANRSWHclnRWhM/aIYdhJe5E2i28ehZ2CJaS8mEzf8KNFc7vXDS
	 XvoGU+GPBZMeFlBnKyXqWGBwfXN4ZhcwfNWtbPMTChXhbgp1fIOCa5MLszq9z81WDg
	 LNLaudQvh2Xog==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::949; helo=mail-ua1-x949.google.com;
 envelope-from=3xofcyqskc4sewp2vzt0ax2v33v0t.r310x29c-t63u70x787.3e0pq7.36v@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=imKnKIYs; dkim-atps=neutral
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com
 [IPv6:2607:f8b0:4864:20::949])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJc6p4xB6z2xs2
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 13:03:12 +1100 (AEDT)
Received: by mail-ua1-x949.google.com with SMTP id
 t10-20020ab04aca000000b002f6f910b48cso425351uae.20
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 18:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=+bIwUXtJ/NbQbwxV5VJGKd4AexQ7hWpQ/iIQQby82SQ=;
 b=IgABmImzxJBvBxVuaMIG0yrloRKg6piwqfnh00GMqlIQlAO8f3ltUrfPz90AVEzPdY
 x0CTcPmVNVSfrbKlWnivInHgz9ReISQDFdFVGFNDJNGCyFKkhnuR8ZmE/YLKZ+Dr+HeU
 AsHfb1csrgeDgRYHe1pPihkH0MtB70bEvlYFLOz4XqGMWDhUaClN5WWkufYmLcu/FSl9
 w3njrxMgazSF6qJyANIbt1No6p8Gj74XgHDWl26L197kinEtcVVC8uGtJV9l5k6YVraB
 Wz60V8xHbJvX6gj0WyDT8SGYzHkCb+WjyqTobh19cJNdVCPlv1rVzP20/rW29mrEAbz/
 3d7g==
X-Gm-Message-State: AOAM533LhQQL4Xw8Ys7liCDXNhcrAnVjt+/BPYsKK8JfXLDx9hDWZ/JD
 TisVBP+PtdNLnUHFBXt+vNwoRfYtXzpFyrEnKZ0oKbyCrRr3i0KZM+ps12Ovwla1lJrVDpuJYN4
 DwhnUf7OktG5vvUvUKPgnG0scMUKcsjOJYTCsk0rFVXnvXm211X0w8wBPj/+QADN/zz+2ULOcj/
 9dw1LsJG8=
X-Google-Smtp-Source: ABdhPJy88wOUwHbTCGrK17R16WxaBsLTnCWibjK8oj22NM197tnDtgmdLrLtBn0V9jetsBxp4pZvt8zCtrIXgMeYDg==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a1f:1609:: with SMTP id
 9mr337914vkw.18.1640138590554; Tue, 21 Dec 2021 18:03:10 -0800 (PST)
Date: Tue, 21 Dec 2021 18:03:07 -0800
Message-Id: <20211222020307.273150-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v1] erofs-utils: lib: Fix 8MB bug on uncompressed extent size
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, uncompressed extent can be at most 8MB before mkfs.erofs
crashes on some error condition. This is due to a minor bug in how
compressed indices are encoded. This patch fixes the issue.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs_fs.h |  2 +-
 lib/compress.c     | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..13eaf24 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -353,7 +353,7 @@ enum {
  * compressed block count of a compressed extent (in logical clusters, aka.
  * block count of a pcluster).
  */
-#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1U << 11)
 
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..23e571c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -97,7 +97,26 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		} else if (d0) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 
-			di.di_u.delta[0] = cpu_to_le16(d0);
+			/* If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
+			 * will interpret |delta[0]| as size of pcluster, rather
+			 * than distance to last head cluster. Normally this
+			 * isn't a problem, because uncompressed extent size are
+			 * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
+			 * But with large pcluster it's possible to go over this
+			 * number, resulting in corrupted compressed indices.
+			 * To solve this, we use Z_EROFS_VLE_DI_D0_CBLKCNT-1 if
+			 * the uncompressed extent size goes above 8MB. This is
+			 * OK because if kernel sees another non-head cluster
+			 * after going back by |delta[0]| blocks, kernel will
+			 * just keep looking back.
+			 */
+			if (d0 & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+				di.di_u.delta[0] = max(
+					d0 & (~Z_EROFS_VLE_DI_D0_CBLKCNT),
+					Z_EROFS_VLE_DI_D0_CBLKCNT-1);
+			} else {
+				di.di_u.delta[0] = cpu_to_le16(d0);
+			}
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
 			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-- 
2.34.1.448.ga2b2bfdf31-goog

