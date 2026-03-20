Return-Path: <linux-erofs+bounces-2888-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K/NBUZ7vWmt9wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2888-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 17:52:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5842DE075
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 17:52:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcpWk392Vz2ybQ;
	Sat, 21 Mar 2026 03:52:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774025538;
	cv=none; b=SwdAavcbeoszJk0K1vUD6tFmVU5YtnL0DcJNSyoeHG3HArfKXIgtfmHJ+s0s8LsQBndhdM7L5VxlqA9CRnsbTlbD7Z+3ZKjnRqZdmLnrN9B3JKUB23a2niIn81EXD2Ihz92K2rDMLQ8kWuKmnjZ6VCv22DJh05qYuTDn9HxYp6/eM4glIGwQ30ZY0NfaV1gchwc4yoicbmrY9mQPGx7FYjlxQBuyKGVL2QmfZcVGLltvPXZnqTgQe/fZQJOmN49tMBUOpuW2U/dLkeVSpSyMBSM57ainoei+VzzGbmXCISxt/8MygVlLqZGA/IAxryj4UtozVfMAajhrELyk2DoZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774025538; c=relaxed/relaxed;
	bh=rKonzr9ejkQCUbE70I0uBpLVz2D6EHnLXKpMqw5g/LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0Ph5de2hjvvMa63orIkaDYeFJMsbm8nDVigIXT9OIzLUDO0hKpy2wXm4bPq17mHhEysOj59W9Pr0FXfxKwYR9ox+U2uVdZNJc00s3sprmcKT3CR0SQpvgia5MJheh2tvuFJVREMtb6XTQyUd//0tazl/QyRo9+7HRYoNktJ6YEUc6eZlZxwHz53Y7FdHdJXVr9ocxJuEx5EHRSzhFkQprojkistfJpzGOgTel3pmo2fCteSab/xmAoYlDTNYB/5kFJZD9HWjjOftt13JBK0nzx2iHZ1VYd5Mzc5JKtPf9MdkqwkGM/iT7tr5CHl5AAEOQWPQSSuyfx/4u6w3fqgZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CS2qXfDl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CS2qXfDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcpWh6BXKz2yZN
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 03:52:16 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b04d051664so17734485ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025533; x=1774630333; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKonzr9ejkQCUbE70I0uBpLVz2D6EHnLXKpMqw5g/LI=;
        b=CS2qXfDlOlpxgoM1qSbLRd2iLXtEfi8rkUemSTF+64scf336HifK2vjNnZVMHnDuty
         9ydFMG3+R1eKPg1B1DyzgrjbOkcFU1zOCrHytNgnlQtqBWz93e2xCC2bBTWbLaVloHKc
         lVenlUn/As1Zft6nSskQaCLRxny0Yu8xiuuPxEeYuSoRtRoD9qR6c5q83MGDHL/fbWIo
         lHzbbnpOgdjP5jmpt5hR8jNlOFtfaG0bLhH6TtMtsW3tUnd4ccl7hq1T0WMtOzN0kue/
         iwWr0LF2RZ/1wH3UJom16m7RRnPeRKT8ZjvcWqRiZfP4R4z4K3YvcQVwQ7iHB8oVIneS
         J5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025533; x=1774630333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKonzr9ejkQCUbE70I0uBpLVz2D6EHnLXKpMqw5g/LI=;
        b=q+7F1i1NtMImHOYyQhxksGP5aYlE0kzJNudMa2pE0QDpA2jQGqxcCohYRBAWHrdCLP
         JQGkH3gUfswdZTZR80B0oeSfE+kE57cb8uQAItbZQdk61RPtnE+6WQ9ktgq5V5eRM3PM
         Jw5ZnCiroa510zs7X3HEne3P7O55TXb2kX2MA5iiwyGK1JEoFeNuiQBmqudVS4GfgQt4
         ZHQWcmDkV3rxmFFxZw7HKhbXCvcLJ2Mxc2M/JWJCjYquzQ6vTQndquqEzVRRljAR2NbT
         QyHdPT0X5JQTyzGzjxD3tHikqCunjGNV4r/cIjootsnocoeYxdtzWVdhPcy0q2DPYt4Z
         KnNw==
X-Gm-Message-State: AOJu0YwGv5hXNc/im3U898T8ZMrpBGXRuLct/5oGddpzqa4y0CXYL8/6
	WkMJCdPdb0Zc29XujH7FoXzLDM8Q28ctWn+jwB17nweuqtYkffjrOJBM80UIMQ==
X-Gm-Gg: ATEYQzwoAYif/iLc1JIEvrjW0SOzQhn8sCoBqInatFVwh4aU+LopnznTfCV1Xii/lnA
	UoSFS4115odItrz4t5NAhQyr/jBtfN/YJHW1stx5d3p205Qx0WCWrA0YMvPbqQJty3kxaso+X4/
	yc/4WnmifJf7Mlh3wJlit+JVdiUl9uFPff1QCWPPqZHtW/QDmahUoSuFUuDdbIIMBfYru4BPgfL
	0984pYYaTG7Obd7wiCJ34lrxE8rbPlf1gdCHeLvw1ZxtfuGWFyiIEK671ylDBbku+rZO1rauou2
	m4S6iFU/+m0qac3524zeeKBqEpJcrArWGUR7h12UlUCoJAz7EK4zIpi4IJAjztOzkHiA8MdG2a7
	vDfyHfp4ecu3uGmFG/YRoP3NWmwdC9kpo0CBqP/FdFC8vukP7k9CpAV+N/ao82hWVzAbheMlpgL
	EWRHpDazlmJiWD9Ho592fPEgcdgVNWrEpztm4FzGitbTc0oEeYlQ==
X-Received: by 2002:a17:903:4b47:b0:2b0:5fa5:a68f with SMTP id d9443c01a7336-2b08271b5a0mr30051125ad.18.1774025533248;
        Fri, 20 Mar 2026 09:52:13 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:9b93:a46d:450e:74e7:9b3f:79a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm26423185ad.84.2026.03.20.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:52:12 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH] erofs-utils: fix resource leaks and missing returns on error paths
Date: Fri, 20 Mar 2026 22:22:00 +0530
Message-ID: <20260320165200.1862-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2888-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2B5842DE075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes two error-handling bugs in erofs-utils:

1. fuse: add missing return on getattr error
erofsfuse_getattr() calls fuse_reply_err() when erofs_read_inode_from_disk()
fails, but does not return afterwards. This causes the function to fall through
to erofsfuse_fill_stat() with uninitialized inode data and then call
fuse_reply_attr(), sending a second reply to the same FUSE request. This triggers
undefined behavior in libfuse and exposes garbage values.

2. lib: fix memory leak in erofs_gzran_builder_init error path
When inflateInit2() fails, erofs_gzran_builder_init() returns an ERR_PTR(-EFAULT)
but forgets to free the previously allocated erofs_gzran_builder struct (gb),
resulting in a memory leak.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 fuse/main.c | 4 +++-
 lib/gzran.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 82aca8c..b634782 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -265,8 +265,10 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	ret = erofs_read_inode_from_disk(&vi);
-	if (ret < 0)
+	if (ret < 0) {
 		fuse_reply_err(req, -ret);
+		return;
+	}
 
 	erofsfuse_fill_stat(&vi, &stbuf);
 	stbuf.st_ino = ino;
diff --git a/lib/gzran.c b/lib/gzran.c
index dffb20a..8a01825 100644
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
-- 
2.51.0.windows.1


