Return-Path: <linux-erofs+bounces-3090-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G7YKWYIymk64gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3090-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20E355758
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfk824scz2yfl;
	Mon, 30 Mar 2026 16:21:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848096;
	cv=none; b=U1zgvy6LH5EmSnRO1eF1260W7C2bgpjSEPo06vapjy2M1VVMQF8GjSaiJ0rjbkfkdltJZ/Pvt0nLhcQYWZufODyZHZO3VmvDoLuGSowG5jlMPpuPKzI3+Q7E9AKwrptDzbZR8d4IJYEDoX/a2dHO9rHzwOArttkSAmVibEeQPJccpnr3xU4nxfuZb2sxO/3MEwkrVcMOhedK+zYghRIzGWsKuSpzyOEiEFxNu7XgrKH+rUB6xpErDcJu76PS3W2y09pbIY/zbBAwxV+P9/o9CNhhrElf0w04se8QPzM1MG21wLvrz+nnP5tdHS1BLxwnnat7zXkTaNS+MtTC0QBmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848096; c=relaxed/relaxed;
	bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RYrrXppSpR6xwCNi/xLbSoXSMLYZFrZAdgiq//74ddxH7rcib97AjsK7q7DLHwkZCcID1t0zWU6mQrDZt50H/DVmi8hZVahSTO3Nt4pi/8kX7OnmAfB2dFQsX1iGvN6xp/Ij62Cg7DPTGIJRB90wrzav1cOTD91y9ht17mD29vqmD5RAhrx7fU/D9cTVgSDVUKC4D5HuQyOuyecMD+oOiqEuyLXx5uNEMUp0aHXBwmKL/b/EZOZJ/SR8f25yzIrewbAwLPVaSAlu4Mke9vHEuig7VJW1s/HBe9YcIt/j/BLfnJ/ySUnENxIQ9Fou6bd6pRA7mxgFuzSt6QEdEnqjzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6kV1Hki; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6kV1Hki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfk70RP6z2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:21:34 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1644531a12.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848091; x=1775452891; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=r6kV1HkiTHO7elFKZDD1jUNCCY4ckZrG/ljYZ6rESsmmA5TJp2fBx2O5ZqN5a0wKAT
         x2jkW+ucE9CPbAzpXDHiYpwVuldKsiq6/kAbdd+qkHSqYsMVU8U9Vvz7ZnZdn5/HgvGL
         S/6tjvMCh4JyFuhKO4nEt1XvScVnVEqvx37vcfNmIBfZ22i/GxntgJnExrdT1srlNAAO
         grA5Zt8O6witaFbieDFEkrA5S7uzLNvbD7z43QZH+loAtsrh1+4bRheDat2uPs6JfCNn
         IMpSlwq7pxmHvRy0X0KoFAJyoz88y8WmBY69aUI6oPb/IT2NjxKdbOAt/nVBZuefF0Vo
         HRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848091; x=1775452891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=W3rLvisBW5GUiN8p7CHcz+4PAjvH09ZZ6HqIJs6Nwe4xsognO0mT+8L+mnqjv1Wlh2
         VkButgOeh8PXIdbh5rb/cCOTjcFGw7rOG+HDWcKsQRyQSC0q82n9DSEb11cjvZ/jQQ/J
         NHhzwHYCCIoTxTp1GrvHVLKWHlkX2AmJyqy9w2V53GHJu1ME0xB7VsF05qQH9Wys6/7M
         6GTBzjLUgR868S2Su6+7w5XzsCQlgCB0Nd8jeRYxX8Pf08t7wDZ2iU/mQtP1CnrQXdtv
         KStDL++eobt8wj6cbkEiWD7doN1EsxcglvNpCeoiHvHhB0mHNlgOxsE0h8azRCA+QcDl
         iWyw==
X-Gm-Message-State: AOJu0Yzg1fA63ovzgANMPxvfuYb76CSmbm0yVBxc1+WZGgjGa8ErY51K
	fD/qQ/noBYD8E8KMqrHTdknsQUNNDWRHPwn4HIg6pIbyA94WM0U1Y4b13l5om321
X-Gm-Gg: ATEYQzy+egUY6kAo9fKeLeiPq3DIMiVw70pAqQW/X/urPhut/ntcNZd0/6B2OlPbaYl
	Bndo1ycOGf/et9itSJ36Gcyz2DRUb+MjYSBApijd0JAuqO2RrllOe3fWfv0sZDOj6sRCLt2QMWs
	eUfr0slEXY8VBFEz1C0YeiqYViRYS1z+a5ZYhXMOnf9f1DlI4dO80R2EHZ3jsklbngjZy/QObCl
	e5CnYW8tujPpG2sATGiwGI+VJc5XG+P1r0Ds12bhKGd99fAAgUdF9zgQA6Zs2ylQw/yzYS14I32
	3T8wv3Pa7JE8LvMTQxyb+tmjKlTKI185yCIkGnc/KcN5OFabngdnEtaDtRAqdY/XQ2Fs8/fKnyn
	+FqLyKYZQmX3CYv1URrn5L8cO7ldBWYprtFbhGyLrKIiIMYt2mfk7ysAKN0eC/7j4VeOO6TAQVl
	RTQGzsx+WLfaw2LqGS1jjc/YJ7CotDVvzFty+K3d1dssxF
X-Received: by 2002:a05:6a20:a123:b0:398:9fc9:e073 with SMTP id adf61e73a8af0-39c87958b56mr12535403637.25.1774848091283;
        Sun, 29 Mar 2026 22:21:31 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769160b165sm5042722a12.0.2026.03.29.22.21.30
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:21:31 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: fix error-path resource leaks in stream setup
Date: Mon, 30 Mar 2026 10:51:25 +0530
Message-ID: <20260330052127.9173-1-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3090-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3F20E355758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, erofs_iostream_open() in lib/tar.c has several resource leaks
in its error paths. Specifically:

1. In the LZMA decoder path, if lzma_auto_decoder() fails, the allocated
   ios->lzma structure is leaked. Furthermore, the file descriptor 'fd'
   passed to the function is not closed, despite ownership being
   conceptually transferred to the stream.

2. In the GZRAN decoder path, if erofs_gzran_builder_init() fails, the
   file descriptor 'fd' is leaked.

3. In the final buffer allocation loop, if malloc() fails for all
   attempted buffer sizes, the function returns -ENOMEM without
   cleaning up the already initialized decoder state (e.g., gzdopen'ed
   handler, lzma state, or gzran builder). This also leaks the file
   descriptor.

This patch refactors erofs_iostream_open() to use a unified error
cleanup path. A new 'err_close' label is introduced to handle failures
that occur before the high-level stream is fully established, ensuring
that the file descriptor is closed. For failures that occur after
the stream is partially or fully initialized (like the buffer allocation
failure), erofs_iostream_close() is called to perform a complete cleanup.

Additionally, erofs_iostream_close() is updated to ensure that the
underlying file descriptor is closed in the EROFS_IOS_DECODER_GZRAN
case, which was previously overlooked.

Furthermore, this patch fixes related resource leaks in lib/gzran.c,
ensuring that erofs_gzran_builder_init() frees its state on failure,
and erofs_gzran_builder_final() always frees its state regardless of
inflateEnd()'s return value.

These changes ensure clear resource ownership and robust error handling
during stream setup, reducing the risk of file descriptor and memory
leaks in long-running or resource-constrained environments.

Signed-off-by: Saksham <aghi.saksham5@gmail.com>
---
 lib/gzran.c |  9 +++----
 lib/tar.c   | 72 ++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index dffb20a..e64b5b0 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -50,8 +50,10 @@ struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
 	strm->avail_in = 0;
 	strm->next_in = Z_NULL;
 	ret = inflateInit2(strm, 47);	/* automatic zlib or gzip decoding */
-	if (ret != Z_OK)
+	if (ret != Z_OK) {
+		free(gb);
 		return ERR_PTR(-EFAULT);
+	}
 	gb->vf = vf;
 	gb->span_size = span_size;
 	gb->totout = gb->totin = 0;
@@ -187,11 +189,8 @@ int erofs_gzran_builder_export_zinfo(struct erofs_gzran_builder *gb,
 int erofs_gzran_builder_final(struct erofs_gzran_builder *gb)
 {
 	struct erofs_gzran_cutpoint_item *ci, *n;
-	int ret;
 
-	ret = inflateEnd(&gb->strm);
-	if (ret != Z_OK)
-		return -EFAULT;
+	(void)inflateEnd(&gb->strm);
 	list_for_each_entry_safe(ci, n, &gb->items, list) {
 		list_del(&ci->list);
 		free(ci);
diff --git a/lib/tar.c b/lib/tar.c
index eca29f5..dd8135b 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -53,80 +53,99 @@ struct erofs_iostream_liblzma {
 
 void erofs_iostream_close(struct erofs_iostream *ios)
 {
-	free(ios->buffer);
+	if (ios->buffer) {
+		free(ios->buffer);
+		ios->buffer = NULL;
+	}
 	if (ios->decoder == EROFS_IOS_DECODER_GZIP) {
 #if defined(HAVE_ZLIB)
 		gzclose(ios->handler);
 #endif
-		return;
 	} else if (ios->decoder == EROFS_IOS_DECODER_LIBLZMA) {
 #if defined(HAVE_LIBLZMA)
 		lzma_end(&ios->lzma->strm);
 		close(ios->lzma->fd);
 		free(ios->lzma);
 #endif
-		return;
-	} else if (ios->decoder == EROFS_IOS_DECODER_GZRAN) {
-		erofs_gzran_builder_final(ios->gb);
-		return;
+	} else {
+		if (ios->decoder == EROFS_IOS_DECODER_GZRAN)
+			erofs_gzran_builder_final(ios->gb);
+		erofs_io_close(&ios->vf);
 	}
-	erofs_io_close(&ios->vf);
 }
 
 int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 {
 	s64 fsz;
+	int ret;
 
 	ios->feof = false;
 	ios->tail = ios->head = 0;
 	ios->decoder = decoder;
 	ios->dumpfd = -1;
+	ios->buffer = NULL;
+
 	if (decoder == EROFS_IOS_DECODER_GZIP) {
 #if defined(HAVE_ZLIB)
 		ios->handler = gzdopen(fd, "r");
-		if (!ios->handler)
-			return -ENOMEM;
+		if (!ios->handler) {
+			ret = -ENOMEM;
+			goto err_close;
+		}
 		ios->sz = fsz = 0;
 		ios->bufsize = 32768;
 #else
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto err_close;
 #endif
 	} else if (decoder == EROFS_IOS_DECODER_LIBLZMA) {
 #ifdef HAVE_LIBLZMA
-		lzma_ret ret;
+		lzma_ret lret;
 
 		ios->lzma = malloc(sizeof(*ios->lzma));
-		if (!ios->lzma)
-			return -ENOMEM;
+		if (!ios->lzma) {
+			ret = -ENOMEM;
+			goto err_close;
+		}
 		ios->lzma->fd = fd;
 		ios->lzma->strm = (lzma_stream)LZMA_STREAM_INIT;
-		ret = lzma_auto_decoder(&ios->lzma->strm,
+		lret = lzma_auto_decoder(&ios->lzma->strm,
 					UINT64_MAX, LZMA_CONCATENATED);
-		if (ret != LZMA_OK)
-			return -EFAULT;
+		if (lret != LZMA_OK) {
+			free(ios->lzma);
+			ret = -EFAULT;
+			goto err_close;
+		}
 		ios->sz = fsz = 0;
 		ios->bufsize = 32768;
 #else
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto err_close;
 #endif
 	} else if (decoder == EROFS_IOS_DECODER_GZRAN) {
 		ios->vf.fd = fd;
+		ios->vf.ops = NULL;
 		ios->feof = false;
 		ios->sz = 0;
 		ios->bufsize = EROFS_GZRAN_WINSIZE * 2;
 		ios->gb = erofs_gzran_builder_init(&ios->vf, 4194304);
-		if (IS_ERR(ios->gb))
-			return PTR_ERR(ios->gb);
+		if (IS_ERR(ios->gb)) {
+			ret = PTR_ERR(ios->gb);
+			goto err_close;
+		}
 	} else {
 		ios->vf.fd = fd;
+		ios->vf.ops = NULL;
 		fsz = lseek(fd, 0, SEEK_END);
 		if (fsz <= 0) {
 			ios->feof = !fsz;
 			ios->sz = 0;
 		} else {
 			ios->sz = fsz;
-			if (lseek(fd, 0, SEEK_SET))
-				return -EIO;
+			if (lseek(fd, 0, SEEK_SET)) {
+				ret = -EIO;
+				goto err_close;
+			}
 #ifdef HAVE_POSIX_FADVISE
 			if (posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL))
 				erofs_warn("failed to fadvise: %s, ignored.",
@@ -143,9 +162,16 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 		ios->bufsize >>= 1;
 	} while (ios->bufsize >= 1024);
 
-	if (!ios->buffer)
-		return -ENOMEM;
+	if (!ios->buffer) {
+		ret = -ENOMEM;
+		erofs_iostream_close(ios);
+		return ret;
+	}
 	return 0;
+
+err_close:
+	close(fd);
+	return ret;
 }
 
 int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
-- 
2.53.0


