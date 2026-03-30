Return-Path: <linux-erofs+bounces-3096-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHRsMBMKymmL4gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3096-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F435585E
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkftS37sNz2xpt;
	Mon, 30 Mar 2026 16:28:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848528;
	cv=none; b=H8HRmIy9Gyq9K+KO6MJLKSZMlPioVTCfB1s2ITmQyuAQW4fr2gxDmlmO06iueobZDWv/4BMNLGj53RgrnDFxbiEZse8hkTKROAPbJFnMEqd/zcBPMRjCdBdxaNRdlnfsCJH+xczSd51VnhLKWSvyTT8Gni7AzvEddrsdCd6MkypXaoybzgxTda1dvrFno44duWYXbM5v/srvFyim1mjQ6hl/gek4HlPg2fYrKA2sP99+T8mKUqlqiOJX/2NrgX8fJjOj2GrDQ2/c5QOG/BYcExHv0aW5Nh54cEyDQqZgXMHA3EVZGuSKHP1QM2FIzrJIy3YMW5Wc/VtsVf7bZQNfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848528; c=relaxed/relaxed;
	bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PZ3VMcv75aDCVOwMILLLcbT9oHHwN9N7DZjgC3k60S8dLyHZY/KRGRPxTlPATuDfg7AwDZsDiIw6zRfvZrMCkoWQvuV2LccDlBLKB6CPoz9YPoUL7YxQyPDgtfuF9PQthLM0tpkgO17dx0hZN7zBO+ugZcYNuI2h30VPo2tIWY6ymv60o36ewdfhhdUy50H0hEhDoI+4NfF3+k+9frlUNFWM6Cb+NPsh1RupMET+xj51ShyGexpFPM8cbfqEBHLkmrNLRd6wdxIJGdN+I2DA/D0b4m7iK/xlaIS2zMFu+ANZhkaiW+xJW4Rz6KenTUMLBNYsjR8dknuPOuTgwUI38g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F//gEL6+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F//gEL6+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkftR0cBDz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:28:46 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82a07738118so2246293b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848525; x=1775453325; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=F//gEL6+yeBHbqfxLraVr6PtsNrMRjchKh4/6JmGol5TGXqbZQlUnWeenP5/66U3b6
         2McZYAhrtIuECwXvXXjz/EL7LiJABw7B+EvYcV0HaYfq57NyIDFFL3+nGrVpDfB2Ekmc
         3ktxuq8oyI+lbdcsJWt4Qpng1SvWjHFsqYgb92c/CChcA5L+e0oNnzj3kHYdGhEO2Jkz
         oHJHaoPHRD9atYvtDvmS2QwWFkQCrWxSRfcbwyuhbRNi0XfGwhHoqz3MBW+mQAL0yLGy
         c76pHo1I8RVE3aGztlTEjW9UVri/8+z9K46eg2Wj/JyGJtpWlz0Zkk2mB6DMyaL//gRR
         SNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848525; x=1775453325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=QstDzJlT2JKH4tIGNp4z4ovMHkQtZPZbQhShjG375Fz/JschfAFSpsrjtMTKAtfOLX
         1qT8elc275IHjQoyYpIMxwNYsQM+ZLPkjiHch6mFXNG2objeV593ZbmMCo988FI51cwr
         lEYUOmPTy7b1Zv5Pp9jDTz9qQr7R7vAAKovkYa3J/DgkYAcfhTk6dmWjOzhP+yeooo7U
         hheb3wWfF+s/XmmFrlrlXK3Acj0rIhr+mPaDnHoGD/L57Ad1I6BnNW78VDoGd6HqGMKK
         qAkBMzY7Oq5GiWApQQTs7pBaPg3O1v9pk0Si57/CkaV/yDs15Af+dZgY4q7mTHdwA2oq
         yLKA==
X-Gm-Message-State: AOJu0Yw7gTfFMDty/caqtJqCo92VtV7Hjix1OyasloqBUWOdNLvsWVXc
	Bx+WFnvy5I9QbthCyyPkPdY7GrQWVJ/3YDQSx4LlFWn3wL0JOUNkKcCXtQ6JdZy1
X-Gm-Gg: ATEYQzyAGRAj33MlewJrggC9ejtdW18KQ3xI/D6sSa8dHwou3JfUBYBLMgTYl/IlVqd
	JTHe+l7lxYhQ+V4FlLhG/U7c0YnrK2CI788haW0qvomxohz8VbsZF2pYt++2gaIwX35pX+Fnb0w
	EmwJIZdGOX7sMTYlT1YX7QCCC9L/lRxr1sEYZ/3ETb2jpvbI9yAlA3U3ZSzpmMZD/+EmCVa7pn/
	xrWmEA+AmGozbdmWeqk176kWrtJ3TYy7FQWjVod07+e6Ub/JnBhV20xtZsjMTpN1r5+ngpBa4z/
	W200hcvrZkZOKtbceTOqV6h1G1O+TyY5jj8pqSreEyiMrnw6vag72nTsxdUVN1O1jobAnZBxKwI
	EOtd5Crwu4GaGA54kjwddqvZvmvJ82wdZyT/w14q6kn/8+O+pJ5E7TNDGuXobQgL6HPbp1zcBo3
	tCL0ne4Pdiw2p56/Mlqs3Yql4GDHzQzSIj3A==
X-Received: by 2002:a05:6a00:1803:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-82c9605c95bmr10563983b3a.39.1774848524716;
        Sun, 29 Mar 2026 22:28:44 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm4851891b3a.1.2026.03.29.22.28.43
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:28:44 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: lib: fix error-path resource leaks in stream setup
Date: Mon, 30 Mar 2026 10:58:37 +0530
Message-ID: <20260330052840.12730-1-aghi.saksham5@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3096-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: DF4F435585E
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


