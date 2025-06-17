Return-Path: <linux-erofs+bounces-435-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99CADC1DF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 07:41:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLwhk1c0Xz30MY;
	Tue, 17 Jun 2025 15:41:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750138870;
	cv=none; b=OnuXNXVZv2mzNJ/o+C80qGeEKMdPFm9+yuA9rpUfUeb9lqW8q2vt7Ic++M0kfdwoBLHMSjZ//NYVZQiIR1f+qt9qvTHVApCW9pBDRu4CQklgWi6MjsEWd1+CNmVF+37lbYEKgMmtJtxiTDlS7ExHTGL1Y4Ya0hoP4DZ+eNtwxREZgl6U/6Wz41LOsmVo8wFWxt3mNesNtFeem62dSc0wFvyqzXt62d5iaXKqC1Pm1S1oyC/4mT7unT3C64b6P7ed9N1V5GRHgN9vzmBPLTxmpYwnMK0ny/ngyd7G9J95jWwnx8fkVFFp6R81jN+dIjGgHjdgKOAaowM9hg5GMsC49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750138870; c=relaxed/relaxed;
	bh=nk7HqULbpBMmwe47ngETLVBM1WQjusixsRNJ+uUQpcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mi8WrQ2It0Og6vDAqZBqhgNiexR+JrcvznAMFkBYwuwq57oKvpmFzsap5xYPJuOCG/Wwt0us3M+FlW/PtxCwW1pNR6rJx5Qq9uMlZhC60OjOcUOmrfmZ0UnPQnPnfPH8H7n1ysYs7rS1dEQVV1DlPmPkoLqxHXn6eoVhrXmMC5xigshMvS91otbNQdvad1fnKPkMZhv21uIyUvX86KnKoCsGGykT7dgJlrgCsJV9XnePxPOXVzoLMXtbHiYLB4TF8gZ1qkwE0ymnlhE/W/9Mil9zh6E1MZdRDKGg4PFzbtF9bcR2YQKQiRxFV5KdNBC6wKCK20YMCoYhT4YFbUVdhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UGqUoDcX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UGqUoDcX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLwhg3pLbz30Lt
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 15:41:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750138862; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nk7HqULbpBMmwe47ngETLVBM1WQjusixsRNJ+uUQpcc=;
	b=UGqUoDcXc/B/OnU3UvUIswt/CNRrUyeH2FkXqW5bUIV+uEtQ6yRKVGdOFbp3FOOjOhzU+nfSbkPuRm5Bkt48jeflQcD2FnPZIc1X7AGEaIIjbBiGKhDAlUUQkBx4RdUds668PQIHIL0oaxI7hcQXLbO/BVyZmlJUorUeSkYiepY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0We7iSMz_1750138856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Jun 2025 13:41:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	stable@vger.kernel.org
Subject: [PATCH] erofs: remove unused trace event erofs_destroy_inode
Date: Tue, 17 Jun 2025 13:40:56 +0800
Message-ID: <20250617054056.3232365-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

The trace event `erofs_destroy_inode` was added but remains unused. This
unused event contributes approximately 5KB to the kernel module size.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/r/20250612224906.15000244@batman.local.home
Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
Cc: stable@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/trace/events/erofs.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index a5f4b9234f46..dad7360f42f9 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -211,24 +211,6 @@ TRACE_EVENT(erofs_map_blocks_exit,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-TRACE_EVENT(erofs_destroy_inode,
-	TP_PROTO(struct inode *inode),
-
-	TP_ARGS(inode),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	erofs_nid_t,	nid		)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_I(inode)->nid;
-	),
-
-	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-);
-
 #endif /* _TRACE_EROFS_H */
 
  /* This part must be outside protection */
-- 
2.43.5


