Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487198E1F3
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 19:55:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJjC84TZHz2yWr
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Oct 2024 03:55:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.120.2.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727891729;
	cv=none; b=AwKVq746Wd0l8Oat/cTJ3NzQ4wEYGpb7s3kU1nu/PtgU38nicxLq0+XWRq9+4FS+4b6DHtPa/fftP/R2XFXpVD6faU8INJrHzZW+J7BGl/tebRqYK/ez8JtvN1bdXS75lrBipCQVg5sXLRWsE3d5IraqCydWY/lkQvIdTYtGpXWqSy6pnLTm3pwEGITi1GDEvGjXE3WGxAhjFTgmb7aKxBJPmuHHnx+elknjOheVEBEGO6oyoVH1bNBImiaoZQKMJn/aCxSWV5KIRu9QXbCUIjQ0D7NWoFD9K6H4X41se+gYZL1JqQtrJWrEuH69PAlS/VjQtDclRO9cIxro3GT4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727891729; c=relaxed/relaxed;
	bh=jWSkRHRNOBKe4Zgzq8lh38BmdvSAdmwIKu5bJmqACmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeNLYV5tvsRbzl6/B3axKG6jto1EO3JolI4cugQj3e0vzBm74XhdyXhidRo4XpTliIfJkL03ZsYDOWCdRLqBbtbe9uExWlXOZ4lKwkWkUGZRpe4dSfV4S0BYPc7RLW/ggW38+/7DtPQsUd0wr8iRa6fPRSalq3mA2lOjeQsnBfz2fQsVoqVDHKPbG8Ztp7kBDMUeQLUe72LohDeAj5gYRPbmOB/82rduZ/QXMPh9WFRJ3psiMzVBkMSIYuqcD6ESMQadwQ9jukKn07HufvahFvlaSj7aOIXMpNRO5JBYxc/E64wnH0kVqWjt2MQ0U9TLVnRoYi4aN9vARnUJ69/zgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=sjtu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 365 seconds by postgrey-1.37 at boromir; Thu, 03 Oct 2024 03:55:29 AEST
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJjC547jcz2yQL
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Oct 2024 03:55:27 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 0312A1008AED4
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Oct 2024 01:49:18 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 7D70E37C967;
	Thu,  3 Oct 2024 01:49:15 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: use pthread_kill instead of pthread_cancel
Date: Thu,  3 Oct 2024 01:49:12 +0800
Message-ID: <20241002174912.42486-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Bionic (Android's libc) does not have pthread_cancel. Let's use
pthread_kill instead to gracefully terminate the worker threads.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/workqueue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 47cec9b..f6d1a7f 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include <pthread.h>
+#include <signal.h>
 #include <stdlib.h>
 #include "erofs/workqueue.h"
 
@@ -40,6 +41,11 @@ static void *worker_thread(void *arg)
 	return NULL;
 }
 
+void worker_exit_handler(int sig)
+{
+	pthread_exit(NULL);
+}
+
 int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 			  unsigned int max_jobs, erofs_wq_func_t on_start,
 			  erofs_wq_func_t on_exit)
@@ -50,6 +56,8 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 	if (!wq || nworker <= 0 || max_jobs <= 0)
 		return -EINVAL;
 
+	signal(SIGUSR1, worker_exit_handler);
+
 	wq->head = wq->tail = NULL;
 	wq->nworker = nworker;
 	wq->max_jobs = max_jobs;
@@ -69,7 +77,7 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 		ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
 		if (ret) {
 			while (i)
-				pthread_cancel(wq->workers[--i]);
+				pthread_kill(wq->workers[--i], SIGUSR1);
 			free(wq->workers);
 			return ret;
 		}
-- 
2.46.2

