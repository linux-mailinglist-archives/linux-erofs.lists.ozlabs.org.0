Return-Path: <linux-erofs+bounces-3164-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNNaI5sGzmnpkQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3164-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:03:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54A38440B
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:03:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWVb3DFYz2ySk;
	Thu, 02 Apr 2026 17:03:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775109783;
	cv=none; b=Ho0o1Gknn5T6cp1lITRHc+InuKgm9O/d9JxqQ1NlYEPT86qpdPkGTvDVzaNT2lx0iZDjGZy49dThwje3mOJrDeHU2VhBsfnwbdiLtdYhVZ5Ke1TZADZv2XjdKRAPqdVtKEOBUcPwLNVyAZn/y8iBnJo1LZp8D1c0t2gbKbX4Z17ez2MQEDSHFr5atLJm5+ccDgi6kNmLVOxOyFqhC7vKD0fFtqOfruEi3Yj8pdPy/PfmAe6VffSUv0rha6baW5/FpY7aB/Ka0j3VlJaUkNKk4vPdzTGwz8f4DNeGLcLpQuWtlz9Z69ctMaeDGynt6TuxFSXSwGw8ntP45gFR2IUFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775109783; c=relaxed/relaxed;
	bh=V385BR5V7RACNs/G0W+7MZqk1hDYP9tm8ZKNvmIEMRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ch4jAU3tpB/UuOC7xZx+fQf45Qrm0pjYpqYMCp2OTsbgpNtQ9v7FDNWPJLZOA/aITR7+5emWnXb0+pscjJTXm0vQjITrTZb/dqhgcNjKhcdaJd5M1yzC/2auP2fk1lz45zeNNcHlE+SYT++wmhS3M6BaMVq5w4HZZ2kOdT2xWkxXH/Zis/9HDpl6nWbrrb+m82vm6x7w8D4I67euZcVQBqQjcOltDQTfPMYQRpdLKRcwlc9ULvEDaxo64ujVnPTPNml0ajEBA6/RlTgPdjk4UHHoqVwdSegeqlPfObBmhFQmMlhh6+0DhD/VztEgB1HBuiDQYKijDnvS+Nq/5wXJbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mcDzEykA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mcDzEykA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWVZ0PHMz2xm5
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:03:01 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b0baebcb55so1673525ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775109778; x=1775714578; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V385BR5V7RACNs/G0W+7MZqk1hDYP9tm8ZKNvmIEMRo=;
        b=mcDzEykAQeJgr1oHs1t40lMz9eg5+1EFu/McfXoR/v54uMtZ+rkYBJfWPqimZ11cXd
         a2/iwYb1VReU5Co1uEBETqlW+ISYKZy4Ua7menZMIN1sHWp+i3MO2FgbKB7b7agqrMdf
         khc0+FpfjV6xhrPniKf3w3KLs486EOHzOhKKpLowx7LAp3PX9EIp+PSFEkBCSIQUrmZz
         ntJprFmXvqq0pAZ/4pq820Yp7S+uRLLKv1BK5dl4LfGywTAVxN59H3rHUb7C5ivPFqyA
         TBOtLaA78zc7RiWlDTLONtmr+PY0kgHoDMOZE++yBRYDLgfWbArufNAn7e4b73SW4AIG
         KOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775109778; x=1775714578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V385BR5V7RACNs/G0W+7MZqk1hDYP9tm8ZKNvmIEMRo=;
        b=hJLIWisOOn6DEMxbGy6s7QJvV3wDpGeZ0L7Kc/0WReI2fjbe3pofmZ7nO1POmPgEHQ
         c1q/YR2jRllV5JGZ7h2eLeOQ0eVzAlcM9v43iZyHsi2wOUNlFssbPgVq7W9J4c7irLpb
         Sl5GLVQJbW3cEIU2g4e0JqmC0+kUgp6p+BS2Sy7lZIh4WydF/H43f8B5acQqK7GSIzRw
         pap5YtqEeerOE1WsoIzrIaIJV87f2iJsdcIgvhPtPvx1YHP+tRqONXxKLZ0Bqm3dhYGS
         ONI7yhPZfaff59SYgGVy0bBfqB73OiF/zNMgFqggEd+Vn6uLdOyRpYXCpCyvay03CAVU
         2lwQ==
X-Gm-Message-State: AOJu0YxW/unpgq7NKNWPDpI4W9xxs2/M/JGQkpt06gO4WILm2WueNtUF
	4AYlACOcH1N6cvrEzJYzGbyVachpEbz0xs/cldwg03XKxO0hQC34iP2eX+DTaznv
X-Gm-Gg: AeBDiesxLQC8MiJVWKk2PXhzZUTRLsfO+2P6dMbTXJAsdA+NFFoLxDbipe0OSXClG8h
	2+i7niuy4k71VP5LWJmj7H1p0RCRTO4bwvlFNQRt9Q+T5KSsp5/r6hv3baB3jioJodhXAM8h5Gb
	39Ay/M9Q/lijxtXiY+YHLtSAdBSVU4yFnKTyfJLXoYkQlQs+DqBWXvEMTB/kXfQCNqHG8ZLWY80
	f1rix0Kym4DdNnlkANtJroYKlINw841NHN6RPfVQjfqgt5oJj7a+cj7iDJNgWDB0/PVy3hmCaaq
	MKnB7njj+ZujFu10ITeIioA8UTK4NjoI5NwT4n3iGtn9BWRXCDwm4YUl1S4UpdifkpD74tgf+m8
	wuSDZRtBRNrthmzX8iN0dS/Yr/oCr1DT+l2FYN6KlxAStYXu+mNsILVMEK4WbqqJUF0qsONWksr
	dbpEcNzDzHf9m1kXal0KltTR/6Wyz6QqOop891O7KkBiL18jv/SLUTxZ6TE3LBiPbD9Q2zgnl6H
	IrTF1k8+8xa8SSNROrRgVR5uH6Z4WJeY4Nu
X-Received: by 2002:a17:90a:ec86:b0:35b:a241:ffb2 with SMTP id 98e67ed59e1d1-35dc703b635mr3673483a91.7.1775109778289;
        Wed, 01 Apr 2026 23:02:58 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e360bsm1524516a91.3.2026.04.01.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:02:57 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib/diskbuf: replace bool locked with a real mutex for MT
Date: Thu,  2 Apr 2026 06:02:50 +0000
Message-ID: <20260402060250.64080-1-singhutkal015@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3164-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0F54A38440B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_diskbufstrm used a plain boolean 'locked' to track stream
reservation state, with an explicit comment marking it as a
placeholder: 'need a real lock for MT'.  A boolean provides no
atomicity or memory-ordering guarantees under concurrent access.

Replace 'bool locked' with 'erofs_mutex_t lock' using the existing
portable wrapper in include/erofs/lock.h.  Acquire the mutex in
erofs_diskbuf_reserve() and release it in erofs_diskbuf_commit(),
serialising concurrent access to each stream's tailoffset field.
Initialisation and destruction are wired into erofs_diskbuf_init()
and erofs_diskbuf_exit() respectively.

Also add erofs_mutex_destroy() to include/erofs/lock.h, which was
missing despite erofs_mutex_init() being present.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 include/erofs/lock.h |  2 ++
 lib/diskbuf.c        | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/erofs/lock.h b/include/erofs/lock.h
index c6e3093..ef4210d 100644
--- a/include/erofs/lock.h
+++ b/include/erofs/lock.h
@@ -15,6 +15,7 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock)
 }
 #define erofs_mutex_lock	pthread_mutex_lock
 #define erofs_mutex_unlock	pthread_mutex_unlock
+#define erofs_mutex_destroy	pthread_mutex_destroy
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = PTHREAD_MUTEX_INITIALIZER
@@ -35,6 +36,7 @@ typedef struct {} erofs_mutex_t;
 static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
+static inline void erofs_mutex_destroy(erofs_mutex_t *lock) {}
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = {}
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index 0bf42da..7f4e6e1 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include "erofs/diskbuf.h"
 #include "erofs/internal.h"
+#include "erofs/lock.h"
 #include "erofs/print.h"
 #include <stdio.h>
 #include <errno.h>
@@ -14,7 +15,7 @@ static struct erofs_diskbufstrm {
 	u64 tailoffset, devpos;
 	int fd;
 	unsigned int alignsize;
-	bool locked;
+	erofs_mutex_t lock;
 } *dbufstrm;
 
 int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
@@ -42,7 +43,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 		*off = db->offset + strm->devpos;
 	db->sp = strm;
 	(void)erofs_atomic_inc_return(&strm->count);
-	strm->locked = true;	/* TODO: need a real lock for MT */
+	erofs_mutex_lock(&strm->lock);
 	return strm->fd;
 }
 
@@ -51,9 +52,9 @@ void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len)
 	struct erofs_diskbufstrm *strm = db->sp;
 
 	DBG_BUGON(!strm);
-	DBG_BUGON(!strm->locked);
 	DBG_BUGON(strm->tailoffset != db->offset);
 	strm->tailoffset += len;
+	erofs_mutex_unlock(&strm->lock);
 }
 
 void erofs_diskbuf_close(struct erofs_diskbuf *db)
@@ -115,6 +116,7 @@ int erofs_diskbuf_init(unsigned int nstrms)
 setupone:
 		strm->tailoffset = 0;
 		erofs_atomic_set(&strm->count, 1);
+		erofs_mutex_init(&strm->lock);
 		if (fstat(strm->fd, &st))
 			return -errno;
 		strm->alignsize = max_t(u32, st.st_blksize, getpagesize());
@@ -131,7 +133,7 @@ void erofs_diskbuf_exit(void)
 
 	for (strm = dbufstrm; strm->fd >= 0; ++strm) {
 		DBG_BUGON(erofs_atomic_read(&strm->count) != 1);
-
+		erofs_mutex_destroy(&strm->lock);
 		close(strm->fd);
 		strm->fd = -1;
 	}
-- 
2.43.0


