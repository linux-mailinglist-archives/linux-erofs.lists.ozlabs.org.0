Return-Path: <linux-erofs+bounces-3047-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COJBBnx3xWnw+QQAu9opvQ
	(envelope-from <linux-erofs+bounces-3047-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 19:14:20 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CAD339DAE
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 19:14:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhX3V2p93z2yZc;
	Fri, 27 Mar 2026 05:14:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774548854;
	cv=none; b=cvjoWq9ZNZXDacMQ3MW5B9YaEd6w4g23Fwijx99K52fQxBpyZa/Qe25Utsqht2AzyNQkLP6i7MQiV7Asoe+l++G2w54RaVJMt+XxmJU19LlJl8SgcgiLbLprn4f1fVutXhGNsP6i6gF0BvGXlMlA632xCw0EOtUJkvkFFU5zNJVAE6iDwQADS3uflTL6FC3055ySvFD+bIarhT8fGNU8vxFYBmQWpXn4w8ag7lNEDCNqBpdsjQEBObiEZ5gTFf2ovpgKz9cIpZBeclMiJ1RdjwOZ9B55AimCYj7ZODhqy1kfCdY2INsGUcJSAVTgH1ZoQ6662c3f7BiChwJc2C008g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774548854; c=relaxed/relaxed;
	bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGMPpeevLy1y3VEqMrD7mcGxpYvpcCEH/3itgOUEs3Y09OPTMDUBc/5ULppe2emhlhp5VbkEu82kgIGY/44Wnu6EsiT2mRbLcuh6886enKHe1eMtFYOlltVjdkrO+/hYqI7o9J6i1p5EvCBT8+h0S4mhiIwqhnUf1+z9udxAoVrn/69FxmOcqo+5Of02R0AjQ2rrhAUf9xAmdityACAxNGFSaXRF/9W0+P4U21IPfNii3y5XwGWMEs0rN7CMwG5RLC8q8WlP3fWmJS6Yv27xRLXZQPU5tCSVk95yt+xrEku22z9ZAqptXX0tobNfVMuWpixMZX41N0U4jshMvl79wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljaC0yNO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljaC0yNO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhX3S50mRz2xN8
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 05:14:11 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so1157276b3a.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548848; x=1775153648; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=ljaC0yNO9EPuTrJCEuMwnfl3bzkRZVOlYPGzXXOPVMHOnTOlpcx49i5H7h1+JVO32Z
         T05kf2ePiYBWDMlafOQpUTctswIrp2oQ3qxhEuqYBctw30q1bapBaObWYdl543msaraE
         TdBUuMg6mXw1ccaCAg7v3k2KJ4+RXGOJXG0cDxb37oM0F/dnSzlC8EXjLb6RYb5TfVPf
         9rMbOs9bJ6HnmSih/IV5iKdgRyLn3RVcOEnafyWcP9PKusrfO9oFyKEnQxL8aH50sZ11
         xKU5UKUxxXYHNgvpcbizUJcAa7eiA43OUA1aoQHkNKW5/tFbjJfhi7FpMPbtccuCVHOM
         lRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548848; x=1775153648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tze0wOTZorvP1ya6ZRuO2Q+rmvrJ9SIc25zX/+ZQgo0=;
        b=cVTshdgoVHdk+SFVMKTpA0Mkztfss4Cu1p+o8kdV9K7foA51eUld7jyT/v4DZBNQsS
         0qqPPNpEv0499oCxyfLEe+JxRW2IaeF6W0SfHUfY44vECnkGJ4j+WrMOtDSnOh4mo4r6
         7pSSWu2jR4hinD97eGikNc7dxZ4RcD4I+P7fuQkIvn9HLShjuLdOvKD84XwTmwbj2vVU
         u/ZkSmUmMPzcwG1D7TN3xtu6y0bhsaafZiQDh5KuLUVF0wAQC3PbyN42RQ0HBadpTyE2
         0roF6Qs9dTEYFfcO/9zTQfFkhF7RMnG56nVBPdVc/HAOCMA9INJHCkVJlvLsifvjCsqy
         eiKA==
X-Gm-Message-State: AOJu0YzQDUfyIOI+6yb1pwCGE51erWZcZ4GeVVDO6MfU8yLFKs1BY+V3
	4Hw0uV1OEp7dcXu2sdOyzN1YTlAnj0VZyok8YZc/m75MKy4wEe9k6EcAhdGpPRLk
X-Gm-Gg: ATEYQzzWylpCY6BB2LeH+QBPfDFgF/JMsTLdLPHULXjrvuqfd/53BlP86a/k8+F8qVn
	lNOAn5wYO1h4awE1wglzsT9OKRpJ2s9Q43DgkfnkRpWdhClf/o9pQzd18dWhOmce+g2/bC90eDn
	kNQGi9KFIqIJdeERloUFPihkZ4VDMty36Gc31qMK3GMVrCm0VA4a5RkCQixORMCW8813uGqAu43
	Dk1cPaT+HprEyG+hOGB+7dqB7O94IO0sWQiJyY4le1YlbLFHQqobWppVwt9M0JyClc93/D+qM1k
	+o1nmEQzj9OO7KlgemQ2yjHI3+7vfHgv/XatqIkfyOYSiFEX5556wbOegqZ9+XLUf3E3ACd+6An
	G3y8+apqtum+woUXZKNbNq6MwzCHUy8jXVh/YH6q405tUewvOXmWoh755P+CoS61wncOxJKF94Z
	gx1SEuyMqYn0VS9CHmWTBI41rKFQ++cZi7MA==
X-Received: by 2002:a05:6a00:428e:b0:82c:2480:4e8e with SMTP id d2e1a72fcca58-82c6e0eaeb2mr7569540b3a.59.1774548847940;
        Thu, 26 Mar 2026 11:14:07 -0700 (PDT)
Received: from kali ([103.212.138.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7cf78d9esm2937607b3a.0.2026.03.26.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:14:07 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Saksham <aghi.saksham5@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix error-path resource leaks in stream setup
Date: Thu, 26 Mar 2026 23:44:03 +0530
Message-ID: <20260326181403.28423-1-aghi.saksham5@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [103.212.138.228 listed in zen.spamhaus.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [aghi.saksham5(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [aghi.saksham5(at)gmail.com]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:431 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3047-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 23CAD339DAE
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


