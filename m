Return-Path: <linux-erofs+bounces-3093-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIFTImsIymk64gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3093-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5235576D
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfkJ4LJsz2ygT;
	Mon, 30 Mar 2026 16:21:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848104;
	cv=none; b=SXG+dTFkpGpeuovg7PuA2Z3kYwJhcugI4DmYFuXgQE7imfZ/fUUHVooZmCEyRf2o9cq6AaIRrApkRDtCwngar1X+9bEeWwAfITUZnwllXM8gISjPGzz0q/FImEqz372lF6vM2I/DbDMBnGzyNV1vPKryHHa2z/PaEBA6OE859PRtSPMKAmmbzG+PEt6oXypbFQzWs9J3XQRpsGHdWNb9Yk5ay3xxtbMWwJiGAlBedkahPBfzFzjbI3XKK+TA1QJKhNtFGoLAdKrOC+D6gypsoGYDl0JTXutjt+65GK1OkyONWff7aAqC41NSuBoQdhGGL7MOx2AksleNgvxP8V4bww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848104; c=relaxed/relaxed;
	bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=esdHwLg1GQmefFUcHqHBOPRNC4qU3vudm2jycsd3txzWZ7TteHRr5o22oL2WUVBAJH643ra5T/SZOmoSaSsgQ64ZDvVx3LVysHB48h5caVs4u5kHtOAz7XCcCW3PbZdjngUwEL8/9Wl+c3PiBalXV4JIXLlmQQP3EaZlL3aahpvQpL38tswcrYaCoYG0Hauimjqye0EhsSGsZUrItKHXrVqUzbV8TbbD2bcSWZe0FF/+t8rG65EpfudJdoAbYaKoEgQYL3ZYc/GEb77EfHYdi+H7bgCwTmqe7mYDxnTzifGmGwlvOfQJZmvlu+2XsKvA4XYeXB/l//WEXFhnZObz9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CA5lB7mB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CA5lB7mB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfkH6Gmnz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:21:43 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b24fede2acso4478195ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848102; x=1775452902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=CA5lB7mBc2ImUdF2Slu7hkwwK4r8DM8uoJ2W3Xu/+bLaMTyoOn/HOW/d3x6Ph7gGwy
         TlhkloYZrT3tLSjJ2P7AHmE2gcA3kgxnEQNbWHxngaraoyiKzvc50kRyThz+RHBdYHGL
         eaRY2/KOl5aYZyYQkBlMQaDtLf3oX1KTpjbL8uow9q1Np4vCy4kPlwPZZtfOOsjOgBrn
         aykVlohZCeiwNfdHkN64LSEyMNz0vvBzRgKIWktutX1key7QCIQuh3ANjlWezatBsY53
         Uakyr79fuFHNtvNXf0tNl884B0l/+1cnXHja6RBRWMZhvdvJawA8dovpY04L8fx94A2F
         8XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848102; x=1775452902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=QPGm5TY5qZvkuAroUxhcYYIiHaMfyWXZdaMh0rDqtuIub3mL7p9IibGRa8Y7h1Rozc
         1HRyezoOmWWolPGPw+mWoUAoVmlUrvTNKSZI9bIm/hGIlILQdJWC2PjffdevXaOSu1sY
         yvCTATTLoIQilD70LCMXpYKgstTkiENnVpk+9qcS1h6B83RV0P5jA9kUwvRzLXGvtfld
         2/YK1+thxXykAIkZc/InMw4HgUWQd8T9jlUlGnaOcID7UZRVi/M8UyWpkyQy8dwcupMA
         I4egQyD5yHck5dJPcsJwaCWGWVbSk1JRQ31dXJ1F5sZJ6ZFGp6ebw2p0cljzPN5kDM6J
         kSvA==
X-Gm-Message-State: AOJu0YzMNGGiNoMWGA4P7XxO7TcyoxOH7ysi03qdjnAK4PeelQwfblwz
	Zabm4kq3Ityxn7XAT4QXcWu0G4Zn4leeMJUm6ehUiKHRoiFwaTr+hxQ/jCCD5wpT
X-Gm-Gg: ATEYQzzQLhNBgRonA7K36YXjixS09WTT98Y6OG2KEt/SWUZXFG0dmKrt2TNmj4j3NCF
	rjSYQAg3m2O3HvTHwEtvEYzqfNv6ApMB93ApjSAIZZzPx1vylmmvOs/DnyBVKWITNVDGN+fmfo7
	3mWh5m58dprL4yq+m6XepgPhMMRoYZHhPmHCvnAXGkAd1XCXhcJGDpsqmbahozUo99o0eViaLNE
	ZuGxZ4QP8lj/AgfDvgpVw/1EGhtICf3vA/TslM3WgQI4WUfht+lepnLZsCLE2wVspqn3G9v/I2G
	F1t49A09S/aRHYphlte+mCHAgn/44obQUEJO5U1Mt82/6yit0cD/hMln0l8RX1XY3Yjdc0P8DRG
	mvsZeX0yZfwd3aVBVhDFUHfIQ/3o2LN7Qc6jKmg+ZhOveJgbqMc2ST/irQAQwNV5AE9euo8PsEg
	C5XWmS1fQgQtBO+Jw/eNzrEh1Jt4huTIPyag==
X-Received: by 2002:a17:903:292:b0:2b2:4e70:631c with SMTP id d9443c01a7336-2b24e706a7bmr34926425ad.28.1774848101466;
        Sun, 29 Mar 2026 22:21:41 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b15a2sm78624325ad.73.2026.03.29.22.21.40
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:21:41 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: fix error-path resource leaks in stream setup
Date: Mon, 30 Mar 2026 10:51:35 +0530
Message-ID: <20260330052137.9273-1-aghi.saksham5@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3093-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: DFE5235576D
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


