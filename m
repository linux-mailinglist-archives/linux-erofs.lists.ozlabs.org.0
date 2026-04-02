Return-Path: <linux-erofs+bounces-3162-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLdJF+n4zWmrjwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3162-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 07:04:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8C383D58
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 07:04:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmVC817sGz2xfX;
	Thu, 02 Apr 2026 16:04:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775106276;
	cv=none; b=nleM4GrmephUfxRJuh/Rd6eGAawaN/mZSQBM0oGmj0LMPa9flzDbpnf932X8ASUnidsyQZGbFRL0fb9oLH4opUn1jD5+q7D9FVnXwHIwfYjrQBwqKL2mJG413bCXqjMJqvuwj0u1vJilzj4I6sfR9YRxtM67+dZhnCVOMAP35GBsOCq+MbcPxs2B9ZbPrKR7Msf8QkuIbfPkfLtkonRKQOa3wnUhd9lZrm+U2J6OqCH7nQC63CDaqA7yAAzJLdHFw7nU90rn6a3Sb2vVn6bjCgBhjRHrH+rbFNATnz7PbTpG0vaecuiDKuD2J8fyo7m8mXT/xKw06q39pLkOAGl5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775106276; c=relaxed/relaxed;
	bh=EfQixkB6oRHyOestxcR0VU0VaALJF0KV4P/6wp8bfPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW8IQMdxOqHLg896esrKrTSWYhbq3CpXOroU4KuqmioPqh21RG0ckEankSoko0pAiwB/K8Zp0ZdZPNcv3yczTW8fnmtPtu/CxFY23l/EISO+FDaXj/yhHheFesjR8g11Ng+Iwn621Moebi/049Y9KsPmlw9ItHtDTqGfqz0AVOrFtF8496QCupHs4dOkb5yE0X69OW7P6Q7lrAdAU55nG6H6954hrMbIzG8euUr7OMVK7bFXXbaREXNiSr2gMOKAHOQpaMXGcLeTZ++bNVlZM2yy5RFZmOamXnxkUXIHR/En2yNgEc2MCfIhWVde2YneRFlgAyuw/2fL94ezQ0PcNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bjETG3qe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bjETG3qe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmVC702Drz2xTh
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 16:04:34 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2b2454fbfccso340355ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775106272; x=1775711072; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfQixkB6oRHyOestxcR0VU0VaALJF0KV4P/6wp8bfPg=;
        b=bjETG3qeiikeCNJ5NKy5MaqebbPhWdhoBN4yk69OhD8NAOs0HATGVzZECYZ3kNxvjc
         0DGkvDTBFtDUiV6sTqnbuBiAv7dvcTdZrQS6TIyeTHlduEA9qbhlH9FxrFBCQ2cY6M5H
         qH+GqyXQWzjERnnuKFThU5/g3yle5abarZH+SJ50u5OmBEX/VILjRLroqr7CCXBkgx2W
         I9gU0ELjNXe9mmr7/ZTfEeJY3VD3FbbTm8TOdBaqk+o3P0rccv3IpZETFGyvjLZZlCSb
         a/JkYU/YqUEJIpN4GBXa520KelMpBfp/axNnmev4IINBdS/ToB0JSDjaGta2LtDR930o
         mAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106272; x=1775711072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfQixkB6oRHyOestxcR0VU0VaALJF0KV4P/6wp8bfPg=;
        b=GPdLyhV9n1LYTTLxlw7MqT9sTv4Gn9D0ms1gWSYZfRY5xm72zlznnWnsEs0HRFjmPs
         cWk5UX7tuxjSR2aIHFc7cBa+UKjRwjAnBARbZJ7O4S5mGz9+bxnwzV8i9uaO97ch7V6g
         f5ICjEQq9u325yUOveq/nJAo5vQACsRFSkEyvS0yddlo7IYbxQpQc+xhAg7qZ57E+2Hz
         Zf+22QErs4t3Olcn1FibzCsRgSqF2XpSFYrvizb5P7074AOWKK2TgEvnfOxcoO5FX0DF
         xZs4UzHbUh92B2L7PyofOf5psbLFO3Tlx2sJss4EnFjDARno5yU5UEVbRBBbMU14utmq
         i+yA==
X-Gm-Message-State: AOJu0Yx6R29Uk+/ne8qlfu+Ed9waxsaFvtMCn3aymRth+fC/0+MpxMrm
	bubV62ICRMEMneZYunuI2rNPJ+0+agqV7iFyjdSoMtLNWyh5vsG5iYX9OheNr6uz
X-Gm-Gg: AeBDiesS6QKKaQL1XSQk8DTLzutnqPSy4/k6dZFu5R1pcTIBXRqhoAIvoDkMGXAob55
	09BXKPBJzTriAw0eI/1MgCuma6bN96jpdx0LZR9T31k/OL0EQ5qIzDl3lkrDvBV61gs2y3m9fpl
	j4JYTjMdsP0JLjXRzAZ4HVf7oCjKuweYL5CrUptR7rBftljttAbfLUxJgW5ZtfU2MTvy7dBCLpi
	/51/MSeGXkITOjBNt+40BQCC3J2gLf5aH8ydoMVeFyZi8IypjFlAe0/FxmxiWoVJjnLNyiwSY+c
	CSNqRPzYFTxmeegPS0I0nhCUnlHpw05V+zKw9RCao1//4DbcqgRFll/mzKq7pbagI+e7PxO8FIk
	L8HbEklpCj+TA7+V41p8hkbrlpKhhHykPPxgMeEgj/N+l5kjK4dOBYVT1MwtBg6ReFLLXMsG0oG
	gmNhXpEhwwDBcSoFX8J0k+HhxZBUX2OSQJytC7xFZmuR7Zo0DwLNAJDle+/T99+rTnOdL+IROEy
	SU0BYlpwksWoT3g5fXMXwFIlISDqO1UxsvM5w==
X-Received: by 2002:a17:903:32cd:b0:2ae:7edc:9234 with SMTP id d9443c01a7336-2b269a92af2mr37884095ad.1.1775106272197;
        Wed, 01 Apr 2026 22:04:32 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af31sm13403945ad.52.2026.04.01.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:04:31 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib/diskbuf: fix MT data race in erofs_diskbuf_reserve()
Date: Thu,  2 Apr 2026 05:04:24 +0000
Message-ID: <20260402050424.24308-1-singhutkal015@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3162-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C7F8C383D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two threads calling erofs_diskbuf_reserve() concurrently can both
observe strm->locked == false and both advance tailoffset, silently
producing an incorrect offset in the output image. Add a
pthread_mutex_t to serialize access.

The commit path also gains the missing strm->locked = false reset;
without it, locked was set once and never cleared, making the flag
a latch rather than a guard.

libpthread is already a build requirement (-lpthread in
lib/Makefile.am) and pthread_mutex_t is used identically in
lib/workqueue.c and lib/compress.c, so no build system changes
are required.

Fixes: 13f7268 ("erofs-utils: lib: introduce multi-threaded I/O framework")
Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/diskbuf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index 0bf42da..ccfeaa4 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -2,6 +2,7 @@
 #include "erofs/diskbuf.h"
 #include "erofs/internal.h"
 #include "erofs/print.h"
+#include <pthread.h>
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
@@ -15,6 +16,7 @@ static struct erofs_diskbufstrm {
 	int fd;
 	unsigned int alignsize;
 	bool locked;
+	pthread_mutex_t lock;
 } *dbufstrm;
 
 int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
@@ -34,15 +36,20 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 {
 	struct erofs_diskbufstrm *strm = dbufstrm + sid;
 
-	if (strm->tailoffset & (strm->alignsize - 1)) {
-		strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
+	pthread_mutex_lock(&strm->lock);
+	if (strm->locked) {
+		pthread_mutex_unlock(&strm->lock);
+		return -EBUSY;
 	}
+	if (strm->tailoffset & (strm->alignsize - 1))
+		strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
 	db->offset = strm->tailoffset;
 	if (off)
 		*off = db->offset + strm->devpos;
 	db->sp = strm;
 	(void)erofs_atomic_inc_return(&strm->count);
-	strm->locked = true;	/* TODO: need a real lock for MT */
+	strm->locked = true;
+	pthread_mutex_unlock(&strm->lock);
 	return strm->fd;
 }
 
@@ -51,9 +58,12 @@ void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len)
 	struct erofs_diskbufstrm *strm = db->sp;
 
 	DBG_BUGON(!strm);
+	pthread_mutex_lock(&strm->lock);
 	DBG_BUGON(!strm->locked);
 	DBG_BUGON(strm->tailoffset != db->offset);
 	strm->tailoffset += len;
+	strm->locked = false;
+	pthread_mutex_unlock(&strm->lock);
 }
 
 void erofs_diskbuf_close(struct erofs_diskbuf *db)
@@ -115,6 +125,7 @@ int erofs_diskbuf_init(unsigned int nstrms)
 setupone:
 		strm->tailoffset = 0;
 		erofs_atomic_set(&strm->count, 1);
+		pthread_mutex_init(&strm->lock, NULL);
 		if (fstat(strm->fd, &st))
 			return -errno;
 		strm->alignsize = max_t(u32, st.st_blksize, getpagesize());
@@ -132,6 +143,7 @@ void erofs_diskbuf_exit(void)
 	for (strm = dbufstrm; strm->fd >= 0; ++strm) {
 		DBG_BUGON(erofs_atomic_read(&strm->count) != 1);
 
+		pthread_mutex_destroy(&strm->lock);
 		close(strm->fd);
 		strm->fd = -1;
 	}
-- 
2.43.0


