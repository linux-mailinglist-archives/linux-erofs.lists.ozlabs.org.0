Return-Path: <linux-erofs+bounces-2522-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCivKZjEqWm2EQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2522-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 18:59:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F96216B3D
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 18:59:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRckV5pHDz3c5y;
	Fri, 06 Mar 2026 04:59:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772733586;
	cv=none; b=ZCFEU7VKlhXyjIBITNix9colnCbQj1l7aJP+aHaEDwFaW+eigpc/DrituLeUiCANxS3hSpbMUWJe/cYOXsyGriTH0xy5vyayuU8GLFn2V8TFYSkKFMGQHCr30sR8tGTE1ASH5rcelhxuh3cG34S1fPdV3x69Gm2qnLGbz1ec9+a+uDrEmQV16UeHtWcIEw1//tSf7qo2PqN2b7S0weoFi3AiqR8JlzIJP3xnGvOEcGP2TtskpWg6gtlXazUMvcTWly7F3aNb6zFp/xHznC+6YfERxb12bPkXhJ3eJ5ultOhCLGsppIDjHYbiWuqjoXZNRnc6ElugOGVlPFhhyv7rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772733586; c=relaxed/relaxed;
	bh=Xo640XpBPc5zs58zEEsRmvpQZK+1zi5rV/WeyoOPWtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9SMXkB9F9oSStd8XqB4EnR+oWy5HOgclMKTKd1sYuberO16BRjvksblDE4yTfzV+0ROn1/i75Ndjv+tVH8cXsSg09rry9NI2habZyKu1+YyrWb/6BW+0MK9SlV7e/xWq3VtpVIKgXttANrOyUhNQBSJnPEtBUVJGNGUNf+tHxOHDq3Sftp3yJz0cOk1xwyYJ+zAXGYDWEUYOnvzIeiLwDkAKktMxLYvSZnHch+Ke8OmS1/jNNcDPQ8iq7op76AANbNNTBXtI/YVj6MB/QbvzgPSfw5Zsd2L0wtioi2poZC9OI4xoXOHnqcTh8zuiSp9YDAPf3KHT5j3Q5BSNvvU2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TGhaLCxQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TGhaLCxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRckS47NXz3bhG
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 04:59:43 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c738585c636so100257a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772733581; x=1773338381; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo640XpBPc5zs58zEEsRmvpQZK+1zi5rV/WeyoOPWtg=;
        b=TGhaLCxQ65pSa+6eFLxKTJS1tYQkhKmRML8xL+YYmZhu+y2QEaamtd5qv0dg+hmbin
         rKhekyr07pxLpgb2XO99tUAMdnRSsXcZlMsjjt0ffF/DbYUitlIqEMZO04ZwssJpIgjQ
         E6tHG47sG1Um+4B15rHQ0rjhR1QhrCGDMSQoL1+C5hUZGJA6Y7C7PXzMMPYxECZc40Wi
         Z2Zf0JvA2hzuTqOMCgXg/JPa6+VHVAHCcyRIKvHElktiuKt02wnQzoTxNgA9HYdLs/WE
         lQpuJRPIKvJrJt27UTGgucK0rWlNiIer67i8K8vXrWaWwqThnYZsIHSp+Pz4dAesQ0gc
         FhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772733581; x=1773338381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo640XpBPc5zs58zEEsRmvpQZK+1zi5rV/WeyoOPWtg=;
        b=nJBoqjJrO/p7L9CeojgXJN0Uhff9CTM6y+Wk3/HVfLh3+9G2S6aw45Rau58yPAQtdH
         C1OJduAYlRoF+A5D6M0vMf9RSAcMWpUHbs88N35kJfdwT+ktr3bkmAMYeTK5zaiXl8yA
         IZHSGZTnlb+aiqEuU8FzOVP4d+E5vk0RlLSkg5LqS2lH9ecuNxodi45MAwMQCoiXxt4b
         tvyH4M42jpSlD8rBXdP2Y5dJ88C5/I+OhZRuECuo46fcxFfBS5YO/mWbnvgDqmJEJFp3
         99fqou9jgAlwk9KTrZ9icczBMU/wle6iFQhw2RyfrjX3jrNeZ7YuxdXKUhzMS++tAnwv
         6EfA==
X-Gm-Message-State: AOJu0Yy1Ymb7gEGLuochg4hDvZx7FWixCR4AEwrttoajDMRuCUuhMm6m
	6WhxBGz56EPw68m22Z9Dd6wSGKJtZM7YmcONfczbWJfCa+gX17Z0E3PbOO74FJ/1
X-Gm-Gg: ATEYQzzPAhOOrsaj+vfk3+F+CbhYRRSsjHKAsG212X0AbmIBc3+oTkD3R4fEzw5zzKV
	50B8EH8KtEGuul3d6V+L+sRfI/0YBgY3Na1U+qOn4T1jskBRxg+PTvc4LHHCBClsjVO5K0GKpNK
	sAxJybHdGpVHo7txZyAQlQzK6VlrrTf/nLNS067Lbcad8XyylwjzIF2tOw0uFSmqAs1YCKqK8u1
	BBOinuS4aktnEkIpOMZfxIsQQk5DJAw9wNv3oWuiQ75ffxaBUlep5hrXz9UFoXPaJfBgzf2Ulp4
	ODnC1BsjQ2HA8dQ3mkl57fHvmjVajAJym/qz3SrAhQwgfeCF/ez1lAf9q27AACVdWxSzLlVImnN
	38E/GctSEBrJXCMRpuTL22n9/23+c+UKxJnONJj0ossV9MSuzFDupqtjsqXeBt6mQPZnfUah+r5
	O25CPJPuiOS/ZPvF1cBnCwILSc2vc6wXLKAqyQrm9DQhLD1bWjkAo9a0CUA7EyIwmOYT4zg4+ns
	e0Y2jcW6TDutvkU8gf56p5Ruo3zdqcGUMuhDoZssZ8mXjA=
X-Received: by 2002:a05:6a00:12d7:b0:824:91f5:aa2d with SMTP id d2e1a72fcca58-82972ca0678mr3825074b3a.5.1772733580995;
        Thu, 05 Mar 2026 09:59:40 -0800 (PST)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8299a6938a7sm419786b3a.7.2026.03.05.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:59:40 -0800 (PST)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] fsck.erofs: fix directory loop detection by tracking current nid
Date: Thu,  5 Mar 2026 17:59:34 +0000
Message-ID: <20260305175934.23921-1-singhutkal015@gmail.com>
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
X-Rspamd-Queue-Id: 18F96216B3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2522-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The directory cycle detection in erofsfsck_check_inode() pushes the
parent nid (pnid) onto the dirstack, but checks the current inode's
nid against the stack entries. This means a self-referencing directory
(a directory containing an entry whose nid points back to itself) is
never detected, because the directory's own nid is never recorded in
the ancestor stack.

Fix this by pushing the current directory's nid instead of pnid. This
ensures that any descendant entry pointing back to any ancestor
directory in the traversal path will be correctly identified as a loop
and reported as -ELOOP.

This is critical for processing untrusted EROFS images from container
registries, where a crafted image with directory cycles would cause
fsck.erofs to recurse infinitely until stack overflow.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index cf07829..cd2cb3b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -1021,7 +1021,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 		for (i = 0; i < fsckcfg.dirstack.top; ++i)
 			if (inode.nid == fsckcfg.dirstack.dirs[i])
 				return -ELOOP;
-		fsckcfg.dirstack.dirs[fsckcfg.dirstack.top++] = pnid;
+		fsckcfg.dirstack.dirs[fsckcfg.dirstack.top++] = nid;
 		ret = erofs_iterate_dir(&ctx, true);
 		--fsckcfg.dirstack.top;
 	}
-- 
2.43.0


