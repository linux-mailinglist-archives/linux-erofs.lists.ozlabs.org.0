Return-Path: <linux-erofs+bounces-2849-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC21Hbr8u2mzqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2849-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:40:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA32CC19F
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:40:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc6JP2VlZz2ynW;
	Fri, 20 Mar 2026 00:40:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773927605;
	cv=none; b=WOEJI81/SHwnD965syDUpttS2aiwglKeislh0+BwmVVOvpncKZmQP47ROU8HuJJUSF2q3rw6lWsmh5lxm4jMJhU1O9W/rsz8gLMVl0RbJE3+QCO2bTIqMwerCuWih97vhn+up708EZ12tEIDnFERR/VGbq/cFCufHsrBIKtEGaSbY16qipJHWo4Zx6Cz2U+7KeDoYOLAW1Ddu3b5AOw0Y93BVvtVeIKq+/gYAIJW5tx+Quorl0pZvTc2uIwE9t4x4F3I6LDkFZn02SWyOUND04Srgays/JJ5VcG7KCXN2SKgb/yG0HeCCfAiuP18cPmFbeSQ8M6CtB5BolxtXLA7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773927605; c=relaxed/relaxed;
	bh=VnWcR1p9aMycG3JaYqM8fLBpGkuES32GlT1fNN7yer4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDXF7/DZohVABsa7BIvQxeTdUF7d8k9HJheBD7aRZp3I/EvGOujMCXJFGRDw8RnldtW99R4Jz/+cjm4wsKAbPjEeJjnTL0PB0sfEgBB/wOQFZ+DHljPM2mFb4jY/hVC63CjDxXffrrsklkOsALwws3iaRXWWsTysO0rwLCoTkhM6cXMgbflwrnkTPxMjvA9vGH+1Rtn3egXeT+cLcUrYcB6r+9KXKzHEYb2okgH00U5GElp3nEn9fFBWthpMTRnxb1zbHIw79OJ3wOLCR9YH7wO4vSIn+TWH58e3rR6mHR3kkyWrCnUm/l8FcfT4oXnp8O80s1FWv1KwXWvlTR3VMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RA/XLwbW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RA/XLwbW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc6JM4wR6z2yLG
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 00:40:02 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so11434335ad.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927599; x=1774532399; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnWcR1p9aMycG3JaYqM8fLBpGkuES32GlT1fNN7yer4=;
        b=RA/XLwbWCR0Yeoqw7qjBk3E7Zhkm9Ll5kAIhszqE85L50VGnRM9rghvOnrsmdWA/kh
         cKO7RgeKZY3pFJ4ccU8OLglnadoHwfqMCZHsyZJG7aQgD3QOeTvJ4wv7iKyuWvQhnLnu
         bbH2EO5udsf7HScds7UajGRGyvEK4ZWFpW3oSwBrS2EU+Nxf5LaFEAbsCE66PNJamzW1
         JRjD7NBuwekv2jjC5CGbpm20rPTRNVFf59aP0hzzXXmGSI1DxlDb+CV7ua5XDDfT6/nT
         zlxw4JXg1Qtlmb3ZOGnbKJGQzkZTNFaaZ2zX2LCtchpdjGgNqPBigNiOJeuOVfwJvSws
         uqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927599; x=1774532399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnWcR1p9aMycG3JaYqM8fLBpGkuES32GlT1fNN7yer4=;
        b=ji0pdgEEn29hjHBnms6tCG1AUT5JfFJGEwGx34VcR92b3mchGRZ6V2IBXKeYxXM0Pl
         fN1N3LFxjN7N2YFPhZXlgjgcKVe2wGNem4eLgwHglmTrHg/x+tAnp0DLPaGG+FLx9xfX
         UTdhLruY7Ve46H3xBpWlRqG3UZSVOFPn1h10mvXGSkCFnDpknJgoBJaRUw8E+oQu3ZCk
         Kfnrzl3wqJIQST4faQw+JvQecIiIdA17hty6ZTiJw1BY4WG89hx1gjlT+xE+21GUPRWr
         W+9kpfm70xokIcIITlRc9gUqgDhXb1dcKFWnnrlZ6N8usbrjf1nAz5RDMQ55LyHjW8DU
         vu2A==
X-Gm-Message-State: AOJu0Yzvt4bjknK25UDs/Wfvce0naHorg5Q0qAF+P1vzXPgyesmh90/6
	EqO1IN7o+27bKmpKdMX60htOH0khzSCGbXS/aJCkHymLKPQqRg77JkQNqoLdCA==
X-Gm-Gg: ATEYQzzCJNwMxpEOaYSOvrE6GLPlcVrX/puJeX3wjjGZ1raKO/ozxWArbKqS51cCm9D
	TVyA3N9hjQHH4PstxbYDj20S3DdVYaKf+18wamSSAelncsp3OiqlmRgouGoNSgjtXZxMLE4JhQL
	u3epCqmnD9jY3GgcP8+0oBMMcWoayuDEPcXwgGHq3UYSSUSS8CeujQhOd37wRUfc6vWfvejI1k5
	TwNN46xpqQ5e6so/pXF1oVpY0esV9rKuEjB0QmgRCEDk1xAilkJ/aBiD4L5XKmL8lEuI2BH/g9J
	oUyL3ynl7Xa69yGIIlHBiw9dWo/UI/jZ2SUKuAfUVnloJp9WY08AwaEQol9eFCaDWTHqIbgjWjg
	LHS5M4s0wob1HofD+c+9W4r1c+fZFINTTfb6BjIf0YhXB7nvW64/xc0IAFEY6GrHjp0Gj18rNpo
	pdc1ske77/Ml3PPIDKqfA+exSuEtj1owJAxWPmK2anlknrukebYw==
X-Received: by 2002:a17:903:2f87:b0:2b0:51f6:d46e with SMTP id d9443c01a7336-2b06e34dfe9mr72356105ad.15.1773927598977;
        Thu, 19 Mar 2026 06:39:58 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:ad85:41d3:35ed:5117:45ed:d381])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e4316b5sm83638885ad.23.2026.03.19.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:39:58 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH 1/2] erofs-utils: lib: replace bool locked with erofs_mutex_t for MT safety
Date: Thu, 19 Mar 2026 19:09:47 +0530
Message-ID: <20260319133948.396-1-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2849-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.994];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 23FA32CC19F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the bool locked field in erofs_diskbufstrm with erofs_mutex_t lock to provide proper mutual exclusion for multi-threaded disk buffer operations. This addresses the TODO comment 'need a real lock for MT' by using the erofs mutex API (erofs_mutex_lock/erofs_mutex_unlock/erofs_mutex_init) instead of a simple boolean flag that provided no actual synchronization.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/diskbuf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index 0bf42da..4218df8 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -3,6 +3,7 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 #include <stdio.h>
+#include "erofs/lock.h"
 #include <errno.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -14,7 +15,7 @@ static struct erofs_diskbufstrm {
 	u64 tailoffset, devpos;
 	int fd;
 	unsigned int alignsize;
-	bool locked;
+	erofs_mutex_t lock;
 } *dbufstrm;
 
 int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
@@ -34,6 +35,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 {
 	struct erofs_diskbufstrm *strm = dbufstrm + sid;
 
+	erofs_mutex_lock(&strm->lock);
 	if (strm->tailoffset & (strm->alignsize - 1)) {
 		strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
 	}
@@ -42,7 +44,6 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 		*off = db->offset + strm->devpos;
 	db->sp = strm;
 	(void)erofs_atomic_inc_return(&strm->count);
-	strm->locked = true;	/* TODO: need a real lock for MT */
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
-- 
2.51.0.windows.1


