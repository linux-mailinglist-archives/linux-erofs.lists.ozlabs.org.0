Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921C8A4341
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Apr 2024 17:04:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BXYKgrJP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VHYVq3JZMz3dKG
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 01:04:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BXYKgrJP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VHYVf5CGCz30hY
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 01:04:25 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1e504f58230so18656105ad.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 14 Apr 2024 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713107061; x=1713711861; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ei4iDtfs2+46V/SfaK93I/3fA+TH2IC2IYfC2Hvk8U=;
        b=BXYKgrJPgFHwGJfKzY1Ony9erMt/SFYi7STkdoPNdowjgCRbjxdh7/d9Inas6oLbHE
         LFE9sAo5/v6OtDe9UHO071i8Tq5Oy5oabSMJt64UVRjvLiQ3v/t3ig9WnTFWuoIFurkN
         d3ikkLGai1Z3PxQA2VESBUkTWB7Qc9PbfT3klL+dz6ePym1/WJR8XPVsw++8WMTbOqbC
         iKaFivhm/OTHQul+XZApGpcy2BOTnQbyanGZQ7+rqyP7PeHvy2mCv8QFXz4XjRn5Wvc0
         5iosAV3X2a92UP8a7xJhnQ7hOTRyR2uyOVo5AO8c8uzBGzyMfrzMDF6Abqb9ohm0sOPw
         zO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713107061; x=1713711861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ei4iDtfs2+46V/SfaK93I/3fA+TH2IC2IYfC2Hvk8U=;
        b=Jlez2lOOuV7BUCaOBVLBZaquk0JTZvwh8zyFc6o1+uptgpit8CE5mqaARkfARBgFNh
         Bv9g9xGdN24DjfwaYFpmTggYRCT2VqS8YeN4LjxYYSYgD9mjvbGgSw3yST8ssLNLuvP2
         n/dSvePIaRi6NMRFNXqOJeH8N9WZEBFOE131b6e8vMIc/Zdrf63V40cT6i/6Mx8CLQ16
         y8DGzRavksyVviJX98Yts/J+d0CVP609HKECx1LuapVjWqMoLvTR8L0w7J3jTw1/rWWl
         ST+TreYzaL1gJaU4DzvRpjKB6yub/JMugxyL03FgpPwQ9aZyMrG9g4kFJd4WTGMkreCo
         RyEw==
X-Gm-Message-State: AOJu0YzgwOT8OUUxAuIKHL84LnNlNQU3s+CBSEmltAm9OcqHhTgZZwdm
	H86yvdnVeO3/GTD80MrwArYPjRGLIJGEzGpq+pIXIPPMMvXuubm1
X-Google-Smtp-Source: AGHT+IHOjM5907Qv5NFSUOo1Zunk+qQN1c9ZSdwaRambCzLaRTo7oTABJYtvP+586MGoO0pmcZsHng==
X-Received: by 2002:a17:902:eacd:b0:1e2:23b9:eb24 with SMTP id p13-20020a170902eacd00b001e223b9eb24mr6159226pld.33.1713107061157;
        Sun, 14 Apr 2024 08:04:21 -0700 (PDT)
Received: from server.. ([5.44.249.114])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902f29200b001e0da190a07sm6130612plc.167.2024.04.14.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 08:04:20 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fs/erofs: add DEFLATE algorithm support
Date: Sun, 14 Apr 2024 23:04:14 +0800
Message-Id: <20240414150414.231027-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds DEFLATE compression algorithm support. It's a good choice
to trade off between compression ratios and performance compared to LZ4.
Alternatively, DEFLATE could be used for some specific files since EROFS
supports multiple compression algorithms in one image.

Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/erofs/Kconfig      | 15 ++++++++
 fs/erofs/decompress.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h   |  1 +
 3 files changed, 99 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index ee4e777c5c..c8463357ca 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -19,3 +19,18 @@ config FS_EROFS_ZIP
 	help
 	  Enable fixed-sized output compression for EROFS.
 	  If you don't want to enable compression feature, say N.
+
+config FS_EROFS_ZIP_DEFLATE
+	bool "EROFS DEFLATE compressed data support"
+	depends on FS_EROFS_ZIP
+	select ZLIB
+	help
+	  Saying Y here includes support for reading EROFS file systems
+	  containing DEFLATE compressed data.  It gives better compression
+	  ratios than the default LZ4 format, while it costs more CPU
+	  overhead.
+
+	  DEFLATE support is an experimental feature for now and so most
+	  file systems will be readable without selecting this option.
+
+	  If unsure, say N.
diff --git a/fs/erofs/decompress.c b/fs/erofs/decompress.c
index e04e5c34a8..ec74816534 100644
--- a/fs/erofs/decompress.c
+++ b/fs/erofs/decompress.c
@@ -1,6 +1,85 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include "decompress.h"
 
+#if IS_ENABLED(CONFIG_ZLIB)
+#include <u-boot/zlib.h>
+
+/* report a zlib or i/o error */
+static int zerr(int ret)
+{
+	switch (ret) {
+	case Z_STREAM_ERROR:
+		return -EINVAL;
+	case Z_DATA_ERROR:
+		return -EIO;
+	case Z_MEM_ERROR:
+		return -ENOMEM;
+	case Z_ERRNO:
+	default:
+		return -EFAULT;
+	}
+}
+
+static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
+{
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin = 0;
+	z_stream strm;
+	int ret;
+
+	while (!src[inputmargin & (erofs_blksiz() - 1)])
+		if (!(++inputmargin & (erofs_blksiz() - 1)))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	/* allocate inflate state */
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	ret = inflateInit2(&strm, -15);
+	if (ret != Z_OK) {
+		free(buff);
+		return zerr(ret);
+	}
+
+	strm.next_in = src + inputmargin;
+	strm.avail_in = rq->inputsize - inputmargin;
+	strm.next_out = dest;
+	strm.avail_out = rq->decodedlength;
+
+	ret = inflate(&strm, rq->partial_decoding ? Z_SYNC_FLUSH : Z_FINISH);
+	if (ret != Z_STREAM_END || strm.total_out != rq->decodedlength) {
+		if (ret != Z_OK || !rq->partial_decoding) {
+			ret = zerr(ret);
+			goto out_inflate_end;
+		}
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out_inflate_end:
+	inflateEnd(&strm);
+	if (buff)
+		free(buff);
+	return ret;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_LZ4)
 #include <u-boot/lz4.h>
 static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
@@ -93,6 +172,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #if IS_ENABLED(CONFIG_LZ4)
 	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
 		return z_erofs_decompress_lz4(rq);
+#endif
+#if IS_ENABLED(CONFIG_ZLIB)
+	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
+		return z_erofs_decompress_deflate(rq);
 #endif
 	return -EOPNOTSUPP;
 }
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 158e2c68a1..5bac4fe1a1 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -304,6 +304,7 @@ enum {
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
+	Z_EROFS_COMPRESSION_DEFLATE	= 2,
 	Z_EROFS_COMPRESSION_MAX
 };
 
-- 
2.34.1

