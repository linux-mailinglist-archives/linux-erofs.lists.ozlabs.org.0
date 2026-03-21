Return-Path: <linux-erofs+bounces-2913-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMHTGUm5vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2913-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75412E6184
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdH5jnQz2yfl;
	Sun, 22 Mar 2026 02:29:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106947;
	cv=none; b=AFulEC+sufWxk/dyI7DI8hoadMGYUunD35LaXmKuOHb0oF84nByhg/E65LJcNoYG4YFXmiQd1/4zcJI9ixstP6pQfmN1IEhzTeVv0THOqOjlt9guVCRZk5KyMDG6bXnv+H1z2EhuFu8bE+nQG7iw6gr/VJVeuyDX7laLzGCx/Vz4g/9Eyc4Sx4RSEzlCW7zSTx/NM/AekUH32tfqKS+L2CNRVwM/+4QkWCppHKUaOYdEJWcGwiLhNsGMVVamBqQDvadaGE2oZSYd1MxCTa9yxvh2dDTF2LTZx2dg11Fx5Drs7V5SWGdbGd/eFMqPXbKosEoNBFRxuDEseLyVItxs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106947; c=relaxed/relaxed;
	bh=xWb4I0YlJsUrHG0P4vNCyOF34NGHrKavZn7D44+OI+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYI5lLV2S44q7IonJ9CiiogZRlxKA2o0RlM90H09xW3qsShN8rRUtBPrWYsFrAXL7E5xmiVdg4r7C9K+myfoGAI7d4o3I7YbfhkAJfR7EkIc2xzNR+rw6XWKgTBmO0d8euECXD9bhGT8XbiCD5ZDxZPKBqVKXNooQ0oGp1aYTH/1K8VX+zQUC1oD2MnYYqxVl31tIv3r9SM1a7TxeVpQc2ZXMT/69WsxzXshxsd44yV6OpxPVHne1AjcrNUXL9HsONpqdmVxOV+y75LrmBIbVPkU1LDW2//9Q+isbt12X35Udl74q+RsumNU70YacGiWq/yJMAPUXF1CPEeXxm/VIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EXOiB2RH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EXOiB2RH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdG5wNRz2yC9
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:06 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso1899879a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106944; x=1774711744; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWb4I0YlJsUrHG0P4vNCyOF34NGHrKavZn7D44+OI+w=;
        b=EXOiB2RH6qPFwSdOQ/Vc8fyCbUamOxkBiWD/Jbab/yWs0kCF5z4NzNLtsA6JxSqqUR
         db9F+V6D6TEGte8GikAXTTWp3UscClQJ3qI/1ycvxX/j53sfIAHkehkZbFjwrRuSMo+g
         FIcp/BE8c7uahsR4U9c+2gmYKCovHGOIZ0KPEKfHYZkXHr15kA+Apj6r2IIDTm1kx4gQ
         vvp5F7OcWKownqCzZPOdM4Pi6nBZbeUqtK0CRwFMlcOnM2kRSlUMN5FSR1Elfb6ICuaO
         TMufEF98PyRRmdWasMRIO20TH8OAsPD5j5r1vd3q4bJmecKaKF1vCQIC4QtLbShFiEeR
         sFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106944; x=1774711744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWb4I0YlJsUrHG0P4vNCyOF34NGHrKavZn7D44+OI+w=;
        b=lpHYhsSGo0htF/8Hs0MrQdCj84SnkleZdsqLWeqlk9ExRb8k0RO/3T7OumntkIvXzv
         Wk4HAvYpxn4rEr60iTLmxrMrYRqTwBkqo0LTJwJ0kiv4kgRKCUKyHxuS+cqkAeD8HHMu
         vjuooHtyfw81ijXky17Tw8+7wnTfhGUIzNWOqhENesQHuJPKzA9UPZ/K0sAyBgDQFYln
         uoM34CaQ0x4Z0QDMEL6gugkU4uZWWJ0eA94Z5nVb7UuXcZs+Gx1VG8QRdsO/GgqHjBSG
         pun4iwXF7OMWB4M5PgWNh32iaNxJEcuyzJtgt/PRQ9RTDCE2MrSJ7tykhMd2HVdVhjp+
         OdUw==
X-Gm-Message-State: AOJu0Yyah+z8oaeEjSMo2xkaqQknLgLJ0VOTh+ebUI4GHUZ8LQbhhUqX
	Ajkwc4Xf6B24rUIl2M59NRayZNnNM4N2kYII9NRE2FpNQGgSY3Gf7ZanotJF78C2DMo=
X-Gm-Gg: ATEYQzwzwVuAZzPrQ+wkHJFw5rMma3p4XlR1Zv1grheo0FKRbPj+Ubi9iA4skiJcl5g
	QPdMlbzB+j8AzJoluoPkmyLfLiZouiy8BHt8AWQQrdpsmSDwLx2XNJWz+qgfk/DqOCwRmOyJHty
	KAT/3U9UiouISjLj8SbLm0lX/YnAEgVdDsFUjklvj+mNLnwFq5LnxLUJc+Mr0xy5OFf0liXdVjf
	taVzAwatZIoQJipKpqFWwH5TehePPIvO7puKKSiT358Vjte6sMI5267HxV3D0VJ/VX+0FMNi8hj
	xEAA3n80SOn5HY/JP+bziBiTMgAFmTjlalXk5CbBWn79Q4FLQPD+1Z2JxbQcI3xUakfznd6+CbI
	Hy72zQMWJH1VSP6hvrzddmGrMBbUbV3JCTq1osCX4ik1okQYHbVA7dyJZNjt6Xdax7s8JildyXm
	7aOktl8us0LdjuSjYpr1AfxAISZIe1S3jk14SuRqis5h66DKOhCRObYLEwppE97mEbo6M9cdd3N
	XlLv826p7a6ep0nl3MqQ8vx
X-Received: by 2002:a17:90b:3d4b:b0:354:a09a:1016 with SMTP id 98e67ed59e1d1-35bd2d2cd85mr4848837a91.30.1774106943565;
        Sat, 21 Mar 2026 08:29:03 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.29.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:29:03 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 2/5] erofs-utils: lib: add manifest loader interface
Date: Sat, 21 Mar 2026 20:58:29 +0530
Message-ID: <20260321152832.29735-3-adityakammati.workspace@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
References: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2913-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[adityakammatiworkspace@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C75412E6184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 include/erofs/manifest.h | 26 ++++++++++++++++++++++++++
 lib/Makefile.am          |  3 ++-
 lib/manifest.c           | 16 ++++++++++++++++
 mkfs/main.c              | 17 +++++++----------
 4 files changed, 51 insertions(+), 11 deletions(-)
 create mode 100644 include/erofs/manifest.h
 create mode 100644 lib/manifest.c

diff --git a/include/erofs/manifest.h b/include/erofs/manifest.h
new file mode 100644
index 0000000..c8a04ec
--- /dev/null
+++ b/include/erofs/manifest.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_MANIFEST_H
+#define __EROFS_MANIFEST_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "importer.h"
+
+enum erofs_manifest_format {
+	EROFS_MANIFEST_FORMAT_AUTO,
+	EROFS_MANIFEST_FORMAT_COMPOSEFS,
+	EROFS_MANIFEST_FORMAT_PROTO,
+};
+
+int erofs_manifest_load(struct erofs_importer *im,
+			enum erofs_manifest_format format,
+			const char *source);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 77f6fd8..42c56dc 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -16,6 +16,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/internal.h \
       $(top_srcdir)/include/erofs/io.h \
       $(top_srcdir)/include/erofs/list.h \
+      $(top_srcdir)/include/erofs/manifest.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/bitops.h \
       $(top_srcdir)/include/erofs/tar.h \
@@ -40,7 +41,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
+		      block_list.c rebuild.c diskbuf.c manifest.c bitops.c dedupe_ext.c \
 		      vmdk.c metabox.c global.c importer.c base64.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
diff --git a/lib/manifest.c b/lib/manifest.c
new file mode 100644
index 0000000..d7bbd5d
--- /dev/null
+++ b/lib/manifest.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include <errno.h>
+#include "erofs/manifest.h"
+#include "erofs/print.h"
+
+int erofs_manifest_load(struct erofs_importer *im,
+			enum erofs_manifest_format format,
+			const char *source)
+{
+	if (!im || !im->root || !source)
+		return -EINVAL;
+
+	(void)format;
+	erofs_err("manifest input support is not implemented yet");
+	return -EOPNOTSUPP;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 9641f2f..cb2cdca 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -16,6 +16,7 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/importer.h"
+#include "erofs/manifest.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/tar.h"
@@ -326,11 +327,7 @@ static enum {
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
-static enum {
-	EROFS_MKFS_MANIFEST_AUTO,
-	EROFS_MKFS_MANIFEST_COMPOSEFS,
-	EROFS_MKFS_MANIFEST_PROTO,
-} manifest_format;
+static enum erofs_manifest_format manifest_format;
 
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
@@ -349,18 +346,18 @@ static int mkfs_parse_manifest_cfg(const char *arg)
 	}
 
 	source_mode = EROFS_MKFS_SOURCE_MANIFEST;
-	manifest_format = EROFS_MKFS_MANIFEST_AUTO;
+	manifest_format = EROFS_MANIFEST_FORMAT_AUTO;
 
 	if (!arg || !*arg)
 		return 0;
 	if (!strcmp(arg, "auto"))
 		return 0;
 	if (!strcmp(arg, "composefs")) {
-		manifest_format = EROFS_MKFS_MANIFEST_COMPOSEFS;
+		manifest_format = EROFS_MANIFEST_FORMAT_COMPOSEFS;
 		return 0;
 	}
 	if (!strcmp(arg, "proto")) {
-		manifest_format = EROFS_MKFS_MANIFEST_PROTO;
+		manifest_format = EROFS_MANIFEST_FORMAT_PROTO;
 		return 0;
 	}
 
@@ -2089,8 +2086,8 @@ int main(int argc, char **argv)
 		while (!(err = tarerofs_parse_tar(&importer, &erofstar)))
 			;
 	} else if (source_mode == EROFS_MKFS_SOURCE_MANIFEST) {
-		erofs_err("manifest input support is not implemented yet");
-		err = -EOPNOTSUPP;
+		err = erofs_manifest_load(&importer, manifest_format,
+					  cfg.c_src_path);
 	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		err = erofs_mkfs_rebuild_load_trees(root);
 #ifdef S3EROFS_ENABLED
-- 
2.51.0


