Return-Path: <linux-erofs+bounces-2859-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCJYE4IdvGlEsQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2859-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:00:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521652CE2D7
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:00:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc9Pj42dZz2ypY;
	Fri, 20 Mar 2026 02:59:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773935993;
	cv=none; b=hWY9PWpLH9ED2BtPNvZWZRqvCsSzEDffkTcazcuKA0CqN/9sr+kaItjdyRaEqnGUIB0WTnrRDSpHKsgmLsF7L02k4B9iDTiqsGqbm7vLNcL9J4zJzjzM4GUTF2zBGf/EDW1ob0sQpDR8gPsPzMH6J2tlsebR6uwd/y2AHo7PP1Z8mCD7QyX/WjgCLaIXuivfkBPIjRQAVBaJvV+Kbp09LRi+6JEwjfz/MWcrQntx9ZU0yBoeKkenlU0qjhWjqd171yOb4QBoVL4qQ8uFaFnxAfFRlVRUoybURfXQ7a1V567vOQbLm+yWuSH0iME6ujeWw+1La4kj3UZhu/LoGad9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773935993; c=relaxed/relaxed;
	bh=HkjSP8N6dDQhbd5Xyi1DsPnPtJrqNtyOBGoVb9GuBUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDi8MCJXgGsG09TTjuP4sFuwfJmm/UAj0Rx1rPSn0Kuk1zi4SjzAtq+LJXCT5p/8CaLRfh0PoHkP1VS7rkLq+/LRY5ryOR0bBsxh2cC6aU1XjJP8kyP5P+bMkPRoctbJ/jJs3Serlh77G4GwIIlWqjL2Y2CYs5dxfVXQUzfuV3EczK4fNiFApSpokc0XcNnbIhoOChh+IBZpW7A6bx4AsaICDK4cItXNP2+S3WCl81OPyEzSwXMUwIc7gF8gApTDP2KaFfpA6cPAHXFL/4IyJZNGIIXvu05AzDCIlPdihQBRSi3mQz0nOkWVeznh5+JOqyJA3Jz2qK/E0dPp8JEa3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fzg+G2In; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fzg+G2In;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc9Ph23xpz2ykV
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 02:59:52 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so465090a12.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935990; x=1774540790; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkjSP8N6dDQhbd5Xyi1DsPnPtJrqNtyOBGoVb9GuBUk=;
        b=fzg+G2InX2S9DbV1FqKhpRSVTkpNy/7qo6kXobmhhLMfGT+gL8I0yb6Fm6P4j5530l
         SHjxgncNb277jDXzDxovDBOr+e3lhmO0Vaq/iWCnaC0Ja+9ASFJBIWK/lgnlT4xV3Pan
         alvGceJPw8K806KtbagLAtm5G7TaWOub+2zqIqgzpYobyZzpPlGTw7P/3Tv+dL12PpYK
         mNgjnyi3us6WrPLW35zdGChoB/89nFG4JyT7Nh+DZ2LFJsoiZL9aV68QIcETG9BLqOrE
         aJeOPkbyRgu3jfat/S3SGv8Uhy5d4Yx2w3Uq50UtFSuVUNTHjsfU5SwmgftqjdZoTPOG
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935990; x=1774540790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkjSP8N6dDQhbd5Xyi1DsPnPtJrqNtyOBGoVb9GuBUk=;
        b=i6DgCetryKmbfO24qLHERKhGQGMfO6WJDtZtfRg0HC8UrzQjuSis89SwXJyMSGCwmF
         NCiG70jH+bYFGv1u811bkMxSX7yU2hiPPxJbrBmPEObElpWtO7iHA0+hMR5scPkzlO2T
         d18HiKvGhv+tiMwdwCgeZjHyhsbD5A2zJezJ2t/GcNQX3DVGZ44SNNZ2BAy9pRMUGuax
         vF06vNz01ioh7XpWiZQYyhnDTNLGmbrFlL2ZxbsP6gha3LvMcWtxoauS5coXFffdcb2R
         7vepnw1OkrhRTrXE6PCyyYMIIIx+Cmyso3GQ8881ofKuvRgm3h7W+DYZoFT+oasJiZgX
         4Jqw==
X-Gm-Message-State: AOJu0YxGwMjOh8XK7LxIjkWvCBOtrJo2jCzubFs0bpOWe8GE1bnO9FAM
	9Q+2uqDL0fylJrfERzq+oRVBuEpINmFan0ENHsgrnVGYdco3BAgcMS4nTnZiHA==
X-Gm-Gg: ATEYQzzQo7do94cX/pEqR+YsARGQiflmwMQRz/iWbDr1s/UQj92Uu7JZChaY5Ruzu64
	See7SUvlei7cIZaxshLxrF5Yew5FeHMJoLBjFn/fiTFKSgsfmCRgTAZS6NBb4LdB1AGSAuFBY7o
	NDZx+kcDLhySbJ+Ayiobd2rLOcJi3yTWlXy3oYSlUjLxx6qs7nx1jleLP91EDCr56oD4MjkovRm
	HZ7P+UlGndV7/DqrSli1SdSwJ375rlcwjbxfoeXtFs+ApVBgYqVw0o9uqfVW+jOdLwfKXey6l7y
	q0iz4KQaBfh3M+ux/VU6jujHgbNLbv6SgUJ7+z5vahIOuj0pVXKCvQi7DjCad6h+L5MUHILzwMr
	Yk+ABjNGL03/NVK88gmzm6qMvTaXkF/YjpQsueyiL3LuwCOcqNFT8CUEXlkMTPAqWHHYSPVlF6D
	yavuTL/D3A70g5XEBacne/VlDQ7P2r7rGcqYc9Sy4=
X-Received: by 2002:a17:903:3510:b0:2ae:4cb8:484a with SMTP id d9443c01a7336-2b06e34e476mr73172905ad.17.1773935989548;
        Thu, 19 Mar 2026 08:59:49 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:9c10:629d:7171:156e:5fcc:56af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e445075sm74472555ad.31.2026.03.19.08.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:59:49 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v2 1/2] erofs-utils: lib: replace bool locked with erofs_mutex_t for MT safety
Date: Thu, 19 Mar 2026 21:27:53 +0530
Message-ID: <20260319155754.411-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260319133948.396-1-newajay.11r@gmail.com>
References: <20260319133948.396-1-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2859-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.992];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 521652CE2D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the bool locked field in erofs_diskbufstrm with
erofs_mutex_t lock to provide proper mutual exclusion
for multi-threaded disk buffer operations.

This addresses the TODO comment 'need a real lock for MT'
by using the erofs mutex API (erofs_mutex_lock/
erofs_mutex_unlock/erofs_mutex_init) instead of a simple
boolean flag that provided no actual synchronization.

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


