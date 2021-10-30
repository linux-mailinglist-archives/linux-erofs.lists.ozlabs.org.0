Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6F4406DB
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 04:01:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hh2bR2YJmz3bXR
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 13:01:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fWTjHQB6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fWTjHQB6; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hh2bL6140z2yph
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 13:01:34 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8941861154;
 Sat, 30 Oct 2021 02:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635559293;
 bh=VTYet+JgSu3K6cbR7VXYZUo6cT2IdEaosJaSr213IZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fWTjHQB65Px/UFGEdfh813y6P5hwrn0If8Tt1NbSv8q9D5tl5y8t0Sz29yBCtr4C8
 87gu/zCSu4JCR6h/w82JrwQkhgMJoI4t8ujviKTlyoiFLX2Jel0f+VTDUd7KE14XO3
 mKyJvuzblYdfvgEldCTcN2X9dnZfzuXBq7jyOYW8CY9FOUAUqWEt0EmI0Oyxc2uOoC
 T8DYm3MRH60R8Va24lSFaRoa9ZQcrDWbzu6JkEOUjK2vnIKNzcQCoJMt0jAXNNnhzb
 a6ok8aPNpAb7NhmYIulNOSXgN4OR3/9pgBbGXexHtbdzgXRuFPQHr8XO+9Kve8cJxU
 pcmBkgr+s+o/w==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: fuse: add LZMA algorithm support
Date: Sat, 30 Oct 2021 10:01:17 +0800
Message-Id: <20211030020118.13898-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211030020118.13898-1-xiang@kernel.org>
References: <20211030020118.13898-1-xiang@kernel.org>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds LZMA compression algorithm support to erofsfuse
to test if LZMA fixed-sized output compression works as expected.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs_fs.h |  5 +++-
 lib/data.c         |  7 ++---
 lib/decompress.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 66a68e3b2065..86ad6f5fd86c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -248,7 +248,8 @@ struct erofs_inode_chunk_index {
 
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
-	Z_EROFS_COMPRESSION_LZ4	= 0,
+	Z_EROFS_COMPRESSION_LZ4		= 0,
+	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
@@ -260,6 +261,8 @@ struct z_erofs_lz4_cfgs {
 	u8 reserved[10];
 } __packed;
 
+#define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/lib/data.c b/lib/data.c
index 641d8408b54f..82bf6ba85592 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -244,9 +244,10 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 
-		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
-						Z_EROFS_COMPRESSION_LZ4 :
-						Z_EROFS_COMPRESSION_SHIFTED;
+		if (map.m_flags & EROFS_MAP_ZIPPED)
+			algorithmformat = inode->z_algorithmtype[0];
+		else
+			algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
diff --git a/lib/decompress.c b/lib/decompress.c
index 2ee1439d9bfa..f313e41d780b 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -7,6 +7,68 @@
 
 #include "erofs/decompress.h"
 #include "erofs/err.h"
+#include "erofs/print.h"
+
+#ifdef HAVE_LIBLZMA
+#include <lzma.h>
+
+static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin = 0;
+	lzma_stream strm;
+	lzma_ret ret2;
+
+	while (!src[inputmargin & ~PAGE_MASK])
+		if (!(++inputmargin & ~PAGE_MASK))
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
+	strm = (lzma_stream)LZMA_STREAM_INIT;
+	strm.next_in = src + inputmargin;
+	strm.avail_in = rq->inputsize - inputmargin;
+	strm.next_out = dest;
+	strm.avail_out = rq->decodedlength;
+
+	ret2 = lzma_microlzma_decoder(&strm, strm.avail_in, rq->decodedlength,
+				      !rq->partial_decoding,
+				      Z_EROFS_LZMA_MAX_DICT_SIZE);
+	if (ret2 != LZMA_OK) {
+		erofs_err("fail to initialize lzma decoder %u", ret2 | 0U);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret2 = lzma_code(&strm, LZMA_FINISH);
+	if (ret2 != LZMA_STREAM_END) {
+		ret = -EFSCORRUPTED;
+		goto out_lzma_end;
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out_lzma_end:
+	lzma_end(&strm);
+out:
+	if (buff)
+		free(buff);
+	return ret;
+}
+#endif
 
 #ifdef LZ4_ENABLED
 #include <lz4.h>
@@ -81,6 +143,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #ifdef LZ4_ENABLED
 	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
 		return z_erofs_decompress_lz4(rq);
+#endif
+#ifdef HAVE_LIBLZMA
+	if (rq->alg == Z_EROFS_COMPRESSION_LZMA)
+		return z_erofs_decompress_lzma(rq);
 #endif
 	return -EOPNOTSUPP;
 }
-- 
2.20.1

