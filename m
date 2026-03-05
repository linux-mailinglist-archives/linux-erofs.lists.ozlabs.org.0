Return-Path: <linux-erofs+bounces-2521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGkuFOi4qWlEDAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 18:10:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0F215E57
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 18:09:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRbd04b43z3c5y;
	Fri, 06 Mar 2026 04:09:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772730596;
	cv=none; b=X0fpij3ZCIROOyWLxsGPbdCgbBAGpON6Wle62Pn1Bk2lcAFtzsq91MLZBf18MIPXPB9PhGzxvtNeoClnC1TRLWf8ucmrh4FVZJLrB9vzaiAWP0XVHbrCZRXjUJpg9drKKfvApeGmt+9QAQM6o4Hp6cf4m7prNjgKKTYyMsDJvZ1CA+V+at465n57pXJUiPdk6hTIID0aoAfp8kMKSfLQfOV4YOd/oTN8kYDJdUIUBL+zF/b1RKd7jEnIPOexsqdCwQ8ptKPtJODrsXcAoXoiQTFdj+epguOaDCPV/8We+MHzhiMQBvkKK32o0sJ22pXOvI4AtykxhIxxtLcMWp+WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772730596; c=relaxed/relaxed;
	bh=A0OckjHxS+Qnid2eCJbM6hqodDd13/GL1e/CUc38Av4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHUMsVTSMDc6bpKo83tvYy82/1RLANp2IV5oevl1/fukPKQvQO6w3SeQSvrdL5YU3roj75dnGu9K8Fn/OZ/Ogtwy7wgQxT0cIBaE8cpWrFdoTpNNQNJ+Sm4EU8qukiqlizn+gQPi76/UuYGIH5tI0/9JCi6JlrSS+FxKjc9otx5AbtEZcBJpd4pb4OKPaumChJPQfLgs7Ghgok3Qw6f9J66ROobE4qPHAOxWMpekRYfIT2qQWtkn+JfIsYHAIUkYZxBYFaN3eQUcK+vAvG+KxEgfJ3wgMdaKXJ1/4F//VL8ObHESDJbkfDVUa76vDqMrdZ0Q/oo7Fp582tG19iloOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mC8X682j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mC8X682j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRbcz5m82z3c5f
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 04:09:55 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c46d4a02ff5so329884a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730593; x=1773335393; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0OckjHxS+Qnid2eCJbM6hqodDd13/GL1e/CUc38Av4=;
        b=mC8X682jZEoZqpYdKoP9GX0hwoIFA4BwOYf9y28SwxDric0JXZ8YT9cRvC6KBCIZVi
         Eu6soYpn6sRZsekv99o8kr9D9PSZ8auQGMMUlCXsJU09C2w74rTl/A83y5Trc6ATYNV7
         5kpBykrG1w3T0lUJsN7upUt165bj3Ijy2yZDOxXFs0LlwZzA9zDw8EP60WDsOw/rQztU
         tjC/65cFxXusQrss/VfvHlc/NqhK50xEx7tJUweYs2B1uVqQGCOa6irN71O2HfCXocS0
         fc/oLi+AmAf/1Lrkg+97apBxuuKUJp+Theckl7Nx+bYJsqGhT9EUF4SiUV2rkXlCqhK2
         RHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730593; x=1773335393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0OckjHxS+Qnid2eCJbM6hqodDd13/GL1e/CUc38Av4=;
        b=Ro8OC8StP7iaBkv1QrbtAxDe544onKKVj6fvaj9fnemdurmSa0YCiJWY1wVZbDEbtl
         2fZvVI4DlOFXvMQ84fOVaKGES4SQJFuZ41/mj2qkO8Pc/qVwjHRZx6QJ/dsuEGgLbLhH
         bIpGLL7b64crMBmbugHoPfaCDTWAB/8xdS/2GazhPDfxuOrVAKrag2ybdZJdeimdPELf
         SAjDDdhvEJ1qZK5yJQIiTHuQ8cgyQQvhuFnPpFYOKOrM1ellbQok9b2k0pgdG6Y9Pni1
         SZK8iwWrvHwVbUW20JQBZUYVSw/MF9T3uL1yFCWZuO3m8bvgogv0PAKEeGxJj5yh+RXR
         7V8g==
X-Gm-Message-State: AOJu0YxAoODWvG/O3uX0NvxHF0QDYbLNilQWuG1GzF7sLfSr1+k82w8b
	ykHu82DHr4z9ZGM/YcilnP21fkzlBxUMPZYT9fXM6aHuySUgtS04Ib8F6gxYpFYAoP0=
X-Gm-Gg: ATEYQzxr1FK0diUwg2rY6sti+BenQVVg9S/sncOuJz5TbMf0YsueMWsKiWJ4XUsT6yp
	7xFaUNG08dRWd+8Fl018aHSOhZe/7Rc0qExvz3k+pQibc1uIx+udRYOCE4dq2+p16dYAEH+4wcn
	JCLLX3J0zNSnVn1kHwa17067ZEKOEJftXwU/6P9vA96eIH4aAWD+xGFIpLBrbHzwmzUPM4uf682
	QhFMxU2vv/6pFijS5TYgBYnn9cjDkC2ZMZrsNh/VAUrctDfMDK0XQOvB7deI7ywEQ6v/qxvKpqO
	236jPjaC3EVJltfgvG2vhpdxu0RcENsg77MTVnXkemRz9lpZqAMavkovU2J92SIGlIt7bBUAqmA
	CjGpwDM2nB8mztOJdaooN2qgcCWlmCvjqySVlBT0e+bgtDofMVa1r9jlKmdzVR3+fB0HwBDt4z0
	ne/nBplxkyJHHKFnECkai/z9EAw8HQr5N4lB0CETgoKJj330q8NE8ciicyd9tOW9KadDNeqV2ml
	M8EpB/yRPF7RbW9oj5imipgHw0QoppTr72x
X-Received: by 2002:a05:6a20:244e:b0:35d:fce2:cb28 with SMTP id adf61e73a8af0-3982e2ba049mr4392424637.8.1772730592871;
        Thu, 05 Mar 2026 09:09:52 -0800 (PST)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a99esm27216370b3a.47.2026.03.05.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:09:52 -0800 (PST)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: dump: add directory loop detection to prevent infinite recursion
Date: Thu,  5 Mar 2026 17:09:47 +0000
Message-ID: <20260305170947.13184-1-singhutkal015@gmail.com>
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
X-Rspamd-Queue-Id: 4FD0F215E57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2521-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

A crafted EROFS image with circular directory references can cause
dump.erofs to enter infinite recursion during statistics gathering,
leading to a stack overflow.

Add a dirstack similar to fsck.erofs to track visited directory nids
during traversal. Before entering a subdirectory, check that the
maximum depth has not been exceeded and that the directory nid has
not already been visited. This addresses the XXXX comment that was
already present in the code.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 dump/main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 567cff6..83b2809 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -72,6 +72,11 @@ struct erofs_statistics {
 };
 static struct erofs_statistics stats;
 
+static struct {
+	erofs_nid_t dirs[PATH_MAX];
+	int top;
+} dump_dirstack;
+
 static struct option long_options[] = {
 	{"version", no_argument, NULL, 'V'},
 	{"help", no_argument, NULL, 'h'},
@@ -359,7 +364,6 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 		update_file_size_statistics(occupied_size, false);
 	}
 
-	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(vi.i_mode)) {
 		struct erofs_dir_context nctx = {
 			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
@@ -367,8 +371,17 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 			.dir = &vi,
 			.cb = erofsdump_dirent_iter,
 		};
-
-		return erofs_iterate_dir(&nctx, false);
+		int i;
+
+		if (dump_dirstack.top >= ARRAY_SIZE(dump_dirstack.dirs))
+			return -ENAMETOOLONG;
+		for (i = 0; i < dump_dirstack.top; ++i)
+			if (vi.nid == dump_dirstack.dirs[i])
+				return -ELOOP;
+		dump_dirstack.dirs[dump_dirstack.top++] = vi.nid;
+		err = erofs_iterate_dir(&nctx, false);
+		--dump_dirstack.top;
+		return err;
 	}
 	return 0;
 }
-- 
2.43.0


