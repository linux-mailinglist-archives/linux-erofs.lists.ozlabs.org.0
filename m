Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF444EB14
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 17:10:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrNpM0K6cz2ywb
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Nov 2021 03:10:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bS15VsQ+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=bS15VsQ+; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrNpD12zsz2yb6
 for <linux-erofs@lists.ozlabs.org>; Sat, 13 Nov 2021 03:09:54 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so6468317pjj.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Z2b+p+zrYV8oSAddOk13Fbfa5dVMbaO2tm9glOHnpQ=;
 b=bS15VsQ+CRU3cV8uZW6tk8yK8NK5sSs9lDjFT5CPXNwjXfDNxY2IobjS0ZBykVPPWu
 AbSu6oEyrWFrx9pgJlTWoF3wPR7ooE7U/SsWTZHR27Zf4faARxIgoUguxhe/RoxBqDU3
 e0JeS7QDkC+NN9px0MX3CnrMzN8zwe/mhJBKYE1DambXmXlS+Dx+SUWgui3ysazkFNrd
 KrtUtjrqRE+gRtjMeafdnUuyEqLXPhD9ZL7Yn8Ghfro64nHGvszKBvUjMm10jGT7CS5b
 7Y4y10VpALctdag8XO+i5/HaEcdP4YHaj9C2LWy2rYTyH5t7W7GpM3qTLd7Y867cV1/f
 Q5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Z2b+p+zrYV8oSAddOk13Fbfa5dVMbaO2tm9glOHnpQ=;
 b=G5PbFQp9ikrOTLykDL0HC7jruOYEkXgfI0ScKXZbMYcW0mkr2L6jU5Qkr+WmYKgBQ8
 CWz5gzUo3+VaLtsirhcM+ukc82PQx0Hs1eftBCFQ0bLwhGa2ZIWFvQuf1ObwoET4qp9j
 WEQgq/t58fHWMl1Bf+3O+vXdnTA2bWs9DaHL06g6NSNc/kwStm84E77NZRDfQWrWGufM
 E2TBAcTW5zMoePsc9S38PGe5Zbo3fXryYNZDm7xqdMyM4lIKBaTbeJsJWnlYhs/39+9b
 N+Ld0WBgEBGzYZ3jVGcL+1qKEN7i18TwW+lSthkCBWUgUX5futsHJsxNmiOs9g70+8bN
 TH1g==
X-Gm-Message-State: AOAM530abBJYYxlOSqBnlYMVcZ/mNg5gtP34nXsSAHl0BuJh/I/3Kbyw
 ofPnO/0WogjV+F+zCt2srsvSBz0tVY4=
X-Google-Smtp-Source: ABdhPJwHsP5YuxPeggZd8XTV/KViUk+mMwiR9lncT4ao0TKhbU12Ze2iHDv+10Z6gh+Du0ZcKpxXWQ==
X-Received: by 2002:a17:90b:314d:: with SMTP id
 ip13mr19398575pjb.228.1636733388759; 
 Fri, 12 Nov 2021 08:09:48 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id j17sm7490674pfj.55.2021.11.12.08.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 08:09:48 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v6 1/3] erofs: rename lz4_0pading to zero_padding
Date: Sat, 13 Nov 2021 00:09:33 +0800
Message-Id: <20211112160935.19394-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: zhangshiming@oppo.co, yh@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Renaming lz4_0padding to zero_padding globally since LZMA and later
algorithms also need that.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fs/erofs/decompressor.c | 18 +++++++++---------
 fs/erofs/erofs_fs.h     |  4 ++--
 fs/erofs/internal.h     |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index bf37fc76b182..3c848422a9ca 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -114,7 +114,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 
 static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool support_0padding)
+			bool support_zero_padding)
 {
 	unsigned int nrpages_in, nrpages_out;
 	unsigned int ofull, oend, inputsize, total, i, j;
@@ -128,7 +128,7 @@ static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	nrpages_out = ofull >> PAGE_SHIFT;
 
 	if (rq->inplace_io) {
-		if (rq->partial_decoding || !support_0padding ||
+		if (rq->partial_decoding || !support_zero_padding ||
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 
@@ -187,17 +187,17 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 {
 	unsigned int inputmargin;
 	u8 *headpage, *src;
-	bool support_0padding;
+	bool support_zero_padding;
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
 	headpage = kmap_atomic(*rq->in);
 	inputmargin = 0;
-	support_0padding = false;
+	support_zero_padding = false;
 
-	/* decompression inplace is only safe when 0padding is enabled */
-	if (erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
-		support_0padding = true;
+	/* decompression inplace is only safe when zero_padding is enabled */
+	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
+		support_zero_padding = true;
 
 		while (!headpage[inputmargin & ~PAGE_MASK])
 			if (!(++inputmargin & ~PAGE_MASK))
@@ -211,12 +211,12 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 
 	rq->inputsize -= inputmargin;
 	src = z_erofs_lz4_handle_inplace_io(rq, headpage, &inputmargin,
-					    &maptype, support_0padding);
+					    &maptype, support_zero_padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
 	/* legacy format could compress extra data in a pcluster. */
-	if (rq->partial_decoding || !support_0padding)
+	if (rq->partial_decoding || !support_zero_padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
 				rq->inputsize, rq->outputsize, rq->outputsize);
 	else
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 083997a034e5..f4506a642a12 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,14 +17,14 @@
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
  */
-#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_ZERO_PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9..273754e7b340 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -258,7 +258,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 	return sbi->feature_##compat & EROFS_FEATURE_##feature; \
 }
 
-EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(zero_padding, incompat, INCOMPAT_ZERO_PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
-- 
2.25.1

