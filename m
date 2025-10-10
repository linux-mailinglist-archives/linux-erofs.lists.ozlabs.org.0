Return-Path: <linux-erofs+bounces-1166-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD9BCB945
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Oct 2025 05:49:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjXmv38Chz2xQ0;
	Fri, 10 Oct 2025 14:49:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760068175;
	cv=none; b=bUQJ0RH9r1U3wqYullYKX6ZSFzUgX615kgVayRB4NrC9lwbANti1kHjY8uRjZmFDtAcTUzu3Bo24J1tmymT4v8FvlTvMTaUnac8ii+n5krsN1WVtK9qTgR+alkhPTyXtlVK4Wm8vRbT+bFMeiglnkC/CGkURW2xGmMGZcb8bsf57+lrU/QYl3IEdf5ny+iMlQ6Ztdmp5zcG1VR5uroAvASuSfqJWCEvylarmfUcGMqsGFMX4EolF4MqFGXYY7urnj+fZG9JffbpdFkfwmT2i9r+waHusMIa1q6Yd5DX6lODPFINPF0DfpHy6B+Jy3csdStCp1G5jMg0pthkMa+WXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760068175; c=relaxed/relaxed;
	bh=uqy/lolARU51dQBWx2i60zOblzWRhHINKNoTP5nnSgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deiQBiIyyb0Dy39L4RP1RudrCBrksM9FcT7ftdqZxufVqHG8vCiQY0XNrFOCLMn4Ofx2qaeK507hlqnyQ/dIM3xTCWTAvhXYB2v60YlIEmwdWdmKt7mb87DDxD9k/uE12FB2P0gO/fe7c3gmDXTHSt8gmix82xzL/PskZ2O8k9Ws3xf+UbVq5EYxW/OpmNSUprUaD/YTZONJlL2EDH3+9vN00bFBJmHP9lhJcmsFEBQU6tZtYLPlyAjbl7qKirJHkldkWQyz+MFOXyZAtEvUl4R8l3eYO5kRfNSrsURvSk5LrigTlsauEjW3zKGlDZimdFxoCEwvwiiJhdrabpFdMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jfns9LpE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jfns9LpE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjXms5HQmz2xPy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 14:49:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760068169; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uqy/lolARU51dQBWx2i60zOblzWRhHINKNoTP5nnSgQ=;
	b=Jfns9LpErwjyq7SP63xvyvXQ4uz3BggBdGubN3JRdlFh7oFDgFeskLd4duQJ/5J3Dm7B/a6xqixfD4N3uFPALmvfc4+fmBlbWl7OXPKyzLL0AnWXLk8taLaW3Yv9C0EDSpboT5SBOwrBloDMGckky8OnnODVHhNAi/MDtSZ0Yr4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wprwznb_1760068167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 11:49:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 2/2] erofs-utils: get rid of `{erofsmount_tarindex,ocierofs_io}_sendfile()`
Date: Fri, 10 Oct 2025 11:49:22 +0800
Message-ID: <20251010034922.1534943-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251010034922.1534943-1-hsiangkao@linux.alibaba.com>
References: <20251010034922.1534943-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use the default fallback approach directly.

Cc: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c          |  9 +++++----
 lib/remotes/oci.c | 43 -------------------------------------------
 mount/main.c      | 37 -------------------------------------
 3 files changed, 5 insertions(+), 84 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index d4cfbef..2aa81de 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -583,12 +583,13 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 	ssize_t read, written;
 
 	if (vin->ops || vout->ops) {
-		if (vin->ops)
+		if (vin->ops && vin->ops->sendfile)
 			return vin->ops->sendfile(vout, vin, pos, count);
-		return vout->ops->sendfile(vout, vin, pos, count);
+		if (vout->ops && vout->ops->sendfile)
+			return vout->ops->sendfile(vout, vin, pos, count);
 	}
 #if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
-	do {
+	else do {
 		written = sendfile(vout->fd, vin->fd, pos, count);
 		if (written <= 0) {
 			if (written < 0) {
@@ -602,7 +603,7 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 	} while (written);
 #endif
 	while (count) {
-		char buf[EROFS_MAX_BLOCK_SIZE];
+		char buf[max(EROFS_MAX_BLOCK_SIZE, 32768)];
 
 		read = min_t(u64, count, sizeof(buf));
 		if (pos)
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 25f991d..1524251 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1458,48 +1458,6 @@ static ssize_t ocierofs_io_read(struct erofs_vfile *vf, void *buf, size_t len)
 	return ret;
 }
 
-static ssize_t ocierofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
-				    off_t *pos, size_t count)
-{
-	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vin->payload;
-	static char buf[OCIEROFS_IO_CHUNK_SIZE];
-	ssize_t total_written = 0;
-	ssize_t ret = 0;
-
-	while (count > 0) {
-		size_t to_read = min_t(size_t, count, OCIEROFS_IO_CHUNK_SIZE);
-		u64 read_offset = pos ? *pos : oci_iostream->offset;
-
-		ret = ocierofs_io_pread(vin, buf, to_read, read_offset);
-		if (ret <= 0) {
-			if (ret < 0 && total_written == 0)
-				return ret;
-			break;
-		}
-		ssize_t written = __erofs_io_write(vout->fd, buf, ret);
-
-		if (written < 0) {
-			erofs_err("OCI I/O sendfile: failed to write to output: %s",
-				  strerror(errno));
-			ret = -errno;
-			break;
-		}
-
-		if (written != ret) {
-			erofs_err("OCI I/O sendfile: partial write: %zd != %zd", written, ret);
-			ret = written;
-		}
-
-		total_written += ret;
-		count -= ret;
-		if (pos)
-			*pos += ret;
-		else
-			oci_iostream->offset += ret;
-	}
-	return count;
-}
-
 static void ocierofs_io_close(struct erofs_vfile *vfile)
 {
 	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vfile->payload;
@@ -1513,7 +1471,6 @@ static void ocierofs_io_close(struct erofs_vfile *vfile)
 static struct erofs_vfops ocierofs_io_vfops = {
 	.pread = ocierofs_io_pread,
 	.read = ocierofs_io_read,
-	.sendfile = ocierofs_io_sendfile,
 	.close = ocierofs_io_close,
 };
 
diff --git a/mount/main.c b/mount/main.c
index fa4c322..d98e1e9 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -409,45 +409,8 @@ static void erofsmount_tarindex_close(struct erofs_vfile *vf)
 	free(tp);
 }
 
-static ssize_t erofsmount_tarindex_sendfile(struct erofs_vfile *vout,
-					    struct erofs_vfile *vin,
-					    off_t *pos, size_t count)
-{
-	static char buf[32768];
-	ssize_t total_written = 0, ret = 0, written;
-	size_t to_read;
-	u64 read_offset;
-
-	while (count > 0) {
-		to_read = min_t(size_t, count, sizeof(buf));
-		read_offset = pos ? *pos : 0;
-
-		ret = erofsmount_tarindex_pread(vin, buf, to_read, read_offset);
-		if (ret <= 0) {
-			if (ret < 0 && total_written == 0)
-				return ret;
-			break;
-		}
-
-		written = __erofs_io_write(vout->fd, buf, ret);
-		if (written < 0) {
-			ret = -errno;
-			break;
-		}
-		if (written != ret)
-			ret = written;
-
-		total_written += ret;
-		count -= ret;
-		if (pos)
-			*pos += ret;
-	}
-	return count;
-}
-
 static struct erofs_vfops tarindex_vfile_ops = {
 	.pread = erofsmount_tarindex_pread,
-	.sendfile = erofsmount_tarindex_sendfile,
 	.close = erofsmount_tarindex_close,
 };
 
-- 
2.43.5


