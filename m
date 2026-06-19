Return-Path: <linux-erofs+bounces-3684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MxxqEA//NGpFlwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 10:34:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 646786A49E5
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 10:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=eQwK45ia;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3684-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3684-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghW956tLqz2ySW;
	Fri, 19 Jun 2026 18:34:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781858057;
	cv=none; b=aIwc2jRSxtXmeLnEEUN74zTQrgEgAwJ3Udt9ohMWc3CxTEtoRv1Nb+zUD26O2WATND/YgQI5eY0ItSvg8+gqmXZPOh1/lhf8GmXf4O8Ej4s8HDoXumZzU0o8goCxsAMWPO6FGM9vjzLZjvA35nSAROWqy8txu33rLfOwNKhHZ2FS3SGxD9OjYXIKiXlqKs85sLvXpdOHsKo8dyby+J+1mOrYmQUMTu6bDed+Qgx5kZwvUGTBUtBgXplmlpm5+tlnFnxF2M+RXOz3PEbIWqOzu3mVwptWRY7Z3OTRdo8DZIclan+7HwcUZMQn4f4ndQN/SAJCTAc3btSk7TcSi2esDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781858057; c=relaxed/relaxed;
	bh=JpqedkrDdgoz3/52vJ+BbHyq7NbFH+iEvNMFiuwcoTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTnhABVnWTKG6N6uuLDKTqOseK0aHMTbr/G/eDC6FtphA4/kGTa3mlbnjXgd59R1klPGMUqcsZ+R6XaO2kaaIACr+XSETMNlbjEWdqanUhO4UMsx51BQCaRngHK0wn6lSHiQ9/8HRnZ3btBQBjPsFvEAc/Xr7fQJ6vHOPyeq3RksBXATpRexx9Y1dnRQ7ovf4fD7FC2VPSY9cj4+VzMBo4g7t61RdUDbJ8ub+r6f4LlMMgNuIRJGxOXy79jqI9LXgWLTa0JPmpFRlTWA2q1iLEcmP7GfBmTcQojOl1g5CAzVTgdo44gglWnTD0xC6QlyPhIN7aNrnrceDjgPHL0NaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eQwK45ia; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghW934bPxz2y1Y
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 18:34:14 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781858050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JpqedkrDdgoz3/52vJ+BbHyq7NbFH+iEvNMFiuwcoTs=;
	b=eQwK45ia1/yNw8qlAwh6JD70fchHFKEBG1aHenmyIlxGllgZpjLVzIAtjzbZPTRYnFHkq+fwAnxNvK583pW0fAehbgFs4Z3ZTSWFlXEmtoLUMMoIQGmjWv7JEnqCN8dRypUYpntajT0I/IkOv2wcDJzHKHAvOZb4sV4Bg2v3yvc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X59MGOl_1781858044;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X59MGOl_1781858044 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 16:34:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: simplify RCU read critical sections
Date: Fri, 19 Jun 2026 16:34:03 +0800
Message-ID: <20260619083403.3993627-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3684-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 646786A49E5

 - use scoped_guard() for RCU read critical section in
   z_erofs_decompress_kickoff();

 - simplify the RCU critical section loop in
   z_erofs_pcluster_begin().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c6240dccbb0f..1c65b741b288 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -806,6 +806,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	struct super_block *sb = fe->inode->i_sb;
 	struct z_erofs_pcluster *pcl = NULL;
 	void *ptr = NULL;
+	bool needretry;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -825,19 +826,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		}
 		ptr = map->buf.page;
 	} else {
-		while (1) {
+		do {
 			rcu_read_lock();
 			pcl = xa_load(&EROFS_SB(sb)->managed_pslots, map->m_pa);
-			if (!pcl || z_erofs_get_pcluster(pcl)) {
-				DBG_BUGON(pcl && map->m_pa != pcl->pos);
-				rcu_read_unlock();
-				break;
-			}
+			needretry = pcl && !z_erofs_get_pcluster(pcl);
 			rcu_read_unlock();
-		}
+		} while (needretry);
 	}
 
 	if (pcl) {
+		DBG_BUGON(map->m_pa != pcl->pos);
 		fe->pcl = pcl;
 		ret = -EEXIST;
 	} else {
@@ -1459,21 +1457,19 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
-		struct kthread_worker *worker;
+		scoped_guard(rcu) {
+			struct kthread_worker *worker;
 
-		rcu_read_lock();
-		worker = rcu_dereference(
+			worker = rcu_dereference(
 				z_erofs_pcpu_workers[raw_smp_processor_id()]);
-		if (!worker) {
-			INIT_WORK(&io->u.work, z_erofs_decompressqueue_work);
-			queue_work(z_erofs_workqueue, &io->u.work);
-		} else {
-			kthread_queue_work(worker, &io->u.kthread_work);
+			if (worker) {
+				kthread_queue_work(worker, &io->u.kthread_work);
+				return;
+			}
 		}
-		rcu_read_unlock();
-#else
-		queue_work(z_erofs_workqueue, &io->u.work);
+		INIT_WORK(&io->u.work, z_erofs_decompressqueue_work);
 #endif
+		queue_work(z_erofs_workqueue, &io->u.work);
 		return;
 	}
 	gfp_flag = memalloc_noio_save();
-- 
2.43.5


