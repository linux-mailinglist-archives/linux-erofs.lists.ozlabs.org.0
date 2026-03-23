Return-Path: <linux-erofs+bounces-2943-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBRKGEHOwGm2LQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2943-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 06:23:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB732ECA2A
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 06:23:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffM591WR0z2ySb;
	Mon, 23 Mar 2026 16:23:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774243389;
	cv=none; b=hMm9b0Ud4iGw/Qt4M1alKjtnLPhObCUEkklY+lVQRVTYE5e3DIOeAz3w+FIVaxKHrXVg7EjK/RqI1KxS5KsGbrx8OJmf4loMOSHxxfzNdr+KaoHZx1kQQ4/KLRyvwYtKR3KaoEgrDpE9kwUkvOYH/1F7ydjsm80HkWvWCEZuAL79wXK72Nu7WIu35WHm7u0R5IqROLTITb3C/mBytymCbcSsxHLPFvsHTL2bStOpfR9S7J033WNvcOlW0wkCVZLgpQXCqlRJMdA0JQXGjDaU2hlR44+BIuLLUz46bUVdhsDa3vMkv/lAwB4WgXOSe6TGqN8TwREdkxyCDsAbfGnc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774243389; c=relaxed/relaxed;
	bh=KMcQE8uII1w49PUNlvQgA9UnuNHdF0LtPmvfXTNrLyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+aylkNlEZFb/HpQ8n/lbL9K9A4JBGpmy2+4UqcmSu7z6MKyokeFtH46fabenD5gsOS/eo7vsa4L18zCvUOSkslgRnZPZ6IixXAiENO5e3PP1ZGzA0Xxl331Ehw7eW0SBWoCEpQ3HhwSsDDsALuTT49WNhRBvTSx0tPJOsD0ct+BAGHNH6im3HilG1foPSXzLQDnYAiNLUrN8Y+81VVRzUplzAySJZZjlFJz1r9cWO7kBZmHuexEDlxbZSpOR5Fjr5fXMtOMNaAb0TXTwxykOJtEujcmSFlxWVXpvvDkVL+SEi02q6kGLzIxZf/lbsyVB820WBbOs+9Q572BPUkNSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EYHbIXLy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EYHbIXLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffM575XbKz2xly
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 16:23:06 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2aecf52fa69so7539915ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 22:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774243384; x=1774848184; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMcQE8uII1w49PUNlvQgA9UnuNHdF0LtPmvfXTNrLyc=;
        b=EYHbIXLyH5SHEzLx4cDJjawcx74b/rdH1e6t1rK1i7m1eBvZfjs2dyyyulQ34r7VTL
         oZjFNVPiNfZfLOT1MRqJOtPNVGPrs7Roy+LZSgxzd74+UQFqu9NXsZ5XAh0nGPxCiSo/
         ZR9KBWR0jseGg+WXTNbz4TcGtDCix83Rj0tJGoOnscWly3PrUlC7PaZiAWRyB5Yp5Lot
         wopS0ZkADIlg0/7NG4Qcimo5BanA1rgydyFeFM/kmuz1R6CL9KRXXWHmBADeaGaXI8bQ
         80VbuoZ1wk+y7jrELccBz5mDLwKeNFkRxmV+1oFwDs0wlP/sOKyXTEs58YBh13sX+dVI
         RjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774243384; x=1774848184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMcQE8uII1w49PUNlvQgA9UnuNHdF0LtPmvfXTNrLyc=;
        b=VW4q0fdaxUGM6ke4aCWWGk8iF5OwT7lDGTfG8VTZjZCRL6YvQA+vxkyOqC7cB3SnJU
         3CDvOVBKX4aAMW3YYvON1FD3aWIL0tkcdmH/qA56p1wE80nKcSJcIY2Hq+dxKooTlIny
         ftmnynGDX67UnOcRl2rFjmcLbaW83dJbmQIvFFYdYFpFDbdr8HEtXy3DuK1l+Z0jTAK1
         KBIQX4emtLktXQNf8jKX4Qw4KQrHnzVyHXXA4IqIU7WXAc7DWdc1GI868kWPtm0X2aZK
         KzshPJSxuIGhEDd9IRFW1xf5utIs3qFyfp1xN9v6D0WP6I/saLBoybDi71uWvw2GPRZL
         11Rg==
X-Gm-Message-State: AOJu0YwRhNOZ/olBVMFjouLrfD/eJqrYQoLpE2D6nVosE11lMG77L/b7
	YkhDIcmpmkebsis0eZslc3rt3q5SUR5TaGIKm/JnWG+N2WT9VUD2MJfp6uHXHw==
X-Gm-Gg: ATEYQzzPcW9zJPxi0jPSo4HfKxGdzOWJvaq+HkvLuM7BfVvagoXb9nCa/FrYw07otu2
	mZisJHd+GVE0OLj01L7j0I/YVvBrnuXId52W5U9lIq7KnFEeaA+TtY/bgwDG/XZWA3CtS7wlBOf
	QrOjqxSU4IKhaFsEScmipOxJw18KqkbpPyMEmSwKK8eFInyY2C73Z1LL0HMf5LBYzhGYSDG56wd
	4uqry8lcDzvKR7i/09Cq8dU71YF5Z3g/EIy2zgXCI1SjLYqB0uy7a+Kmk7Y6ossnoXW+Z7ri6ow
	DuZ9C58UjND8FZ30NO4QkbB5EAu0H8ZjVp9n2xwY8kda+r7/tR4v6eBKOGH3NXteS7ec+kal1tH
	p6ni2QajJXGfR+cu68t+mPwrzraXwoykQUIJ7na3unO2hnUci3bjMRw2Gi9wkCgLk7ilTCxnnBc
	SEYpZ3F8mjZOAS96AZz0BvRIGTUaYl3O7U/ny1cAs0Isfb2CZVN4SB7GreN8oVnMc9nRuk2ritA
	cEKJMtHQ0vxC0D4T8Xok7nc6K2K/++iOSFOCts=
X-Received: by 2002:a17:903:1a2e:b0:2ae:cacf:fc57 with SMTP id d9443c01a7336-2b08275dae1mr64805605ad.4.1774243383883;
        Sun, 22 Mar 2026 22:23:03 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([106.196.124.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08355f994sm97923605ad.36.2026.03.22.22.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:23:03 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: switch ZSTD decompression to streaming API
Date: Mon, 23 Mar 2026 05:22:57 +0000
Message-ID: <20260323052257.11377-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2943-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: EFB732ECA2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current ZSTD decompression path calls ZSTD_getFrameContentSize()
(or legacy ZSTD_getDecompressedSize()) to read the decompressed size
from the ZSTD frame header, then malloc()s a buffer of that size.

This is problematic because the frame content size field is untrusted
on-disk metadata; a crafted EROFS image can set it to an arbitrarily
large value, triggering a large allocation before any real validation
occurs.

The Linux kernel's erofs ZSTD decompressor does not use
ZSTD_getFrameContentSize() at all.  It uses ZSTD_decompressStream(),
which decompresses directly into a caller-supplied buffer whose size
is already known from the extent map.

Align erofs-utils with the kernel:

- Use rq->decodedlength (from the trusted extent map) to size the
  output buffer, removing the dependency on the on-disk frame header.
- Replace ZSTD_decompress() with ZSTD_createDStream(),
  ZSTD_initDStream(), and ZSTD_decompressStream().
- Remove the HAVE_ZSTD_GETFRAMECONTENTSIZE ifdef block entirely.
- For the decodedskip case, allocate a temporary buffer of exactly
  rq->decodedlength (not the untrusted frame size).

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 76 +++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index e66693c..19cde03 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -28,57 +28,73 @@ static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsi
 /* also a very preliminary userspace version */
 static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 {
-	int ret = 0;
+	ZSTD_DStream *dstream;
+	ZSTD_inBuffer in;
+	ZSTD_outBuffer out;
 	char *dest = rq->out;
 	char *src = rq->in;
 	char *buff = NULL;
-	unsigned int inputmargin = 0;
-	unsigned long long total;
+	unsigned int inputmargin;
+	size_t ret;
+	int err = 0;
 
 	inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
-#ifdef HAVE_ZSTD_GETFRAMECONTENTSIZE
-	total = ZSTD_getFrameContentSize(src + inputmargin,
-					 rq->inputsize - inputmargin);
-	if (total == ZSTD_CONTENTSIZE_UNKNOWN ||
-	    total == ZSTD_CONTENTSIZE_ERROR)
-		return -EFSCORRUPTED;
-#else
-	total = ZSTD_getDecompressedSize(src + inputmargin,
-					 rq->inputsize - inputmargin);
-#endif
-	if (rq->decodedskip || total != rq->decodedlength) {
-		buff = malloc(total);
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
 		if (!buff)
 			return -ENOMEM;
 		dest = buff;
 	}
 
-	ret = ZSTD_decompress(dest, total,
-			      src + inputmargin, rq->inputsize - inputmargin);
+	dstream = ZSTD_createDStream();
+	if (!dstream) {
+		err = -ENOMEM;
+		goto out_free_buff;
+	}
+
+	ZSTD_initDStream(dstream);
+
+	in.src  = src + inputmargin;
+	in.size = rq->inputsize - inputmargin;
+	in.pos  = 0;
+
+	out.dst  = dest;
+	out.size = rq->decodedlength;
+	out.pos  = 0;
+
+	ret = ZSTD_decompressStream(dstream, &out, &in);
 	if (ZSTD_isError(ret)) {
-		erofs_err("ZSTD decompress failed %d: %s", ZSTD_getErrorCode(ret),
-			  ZSTD_getErrorName(ret));
-		ret = -EIO;
-		goto out;
+		erofs_err("ZSTD decompress failed: %s", ZSTD_getErrorName(ret));
+		err = -EFSCORRUPTED;
+		goto out_free_dstream;
 	}
 
-	if (ret != (int)total) {
-		erofs_err("ZSTD decompress length mismatch %d, expected %d",
-			  ret, total);
-		ret = -EIO;
-		goto out;
+	if (ret != 0) {
+		erofs_err("ZSTD frame not fully decoded");
+		err = -EFSCORRUPTED;
+		goto out_free_dstream;
+	}
+
+	if (out.pos != rq->decodedlength) {
+		erofs_err("ZSTD decompress length mismatch: got %zu, expected %u",
+			  out.pos, rq->decodedlength);
+		err = -EFSCORRUPTED;
+		goto out_free_dstream;
 	}
-	if (rq->decodedskip || total != rq->decodedlength)
+
+	if (rq->decodedskip)
 		memcpy(rq->out, dest + rq->decodedskip,
 		       rq->decodedlength - rq->decodedskip);
-	ret = 0;
-out:
+
+out_free_dstream:
+	ZSTD_freeDStream(dstream);
+out_free_buff:
 	if (buff)
 		free(buff);
-	return ret;
+	return err;
 }
 #endif
 
-- 
2.43.0


