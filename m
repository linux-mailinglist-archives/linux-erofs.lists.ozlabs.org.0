Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEA9EC497
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 07:07:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7QB84DfRz30Bt
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 17:07:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733897263;
	cv=none; b=POFIjZBv7RGkMwl/VfIzOXytcmkpsLy3IkDYfEhT92KKIJs/fWz+OF74qfZ8TGeo4maLcYstUfxQd9ENnuhVqUMXRRzs4op3KAqG65FZNqjO4exrL6cgK2lARk10G9LOjMRim3axMCfw+gbsORzcpOcXt1uLE+zMpk29yx6CbqRAWG/zhM47ecaYkNc1eyW+Of4CTqU45fpJUO9gQdvq7sehkNhnoytMAHyArkKDUil+L0JpYsomBxUNfjQNOd/zrWpqeG1AkdGOqyEKfAAEo1CZ32OrxHB2n7+UFr7zQsT6WmqECH6v6M0QfsurKbYk1DAITr2FRZMsZXRP1fcgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733897263; c=relaxed/relaxed;
	bh=xPs1yOVnoyosmn7cJYk2sayyDdGWgy+fjMKV3BzJLwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmU7R7mOuM0ddp96J6s2LxRHKyoM2jcPV8nXeAhs6wu84Uu96JVTpMqWdkO6awEjmIOlHEiJXLa7bMA+KYH/YVvcMJJ9sT9xd6YpG7P/N0FudcIB4ysuoQXGhCusK/vhyuJD53mpdA3w56uVWW+UwLwKSf6NRXDT16Tf8x9hHIK88fVAZF5lI+hcAUnlYP8Lvu4bU8SLy3kF0sVyexFWTYIJwF+68YubZWT95c82pzK6bd3UyjqX8g4evMdsyuE6BxA/8Au1ITMsfl+SxnpJKtZPWcyMhke+SYm3z3eKH6ARcbGl5mTibgP8p0JH5Yc3Ge3GnFNRbid3IX4ElROpgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V5GPA7Rx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V5GPA7Rx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7QB35n79z2yn2
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 17:07:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733897251; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xPs1yOVnoyosmn7cJYk2sayyDdGWgy+fjMKV3BzJLwY=;
	b=V5GPA7RxSz/+ykECoAz5udk+NMGDRqSErFLqGPwLuu3UIDIJO9efBh6q2OuMrAUfBtZZAHlMJm3dQ+vBCox5YtzSo5vZPUeRi0AoQpMpQYVTJ2UvItDLOoTv1i81Xbvmg/tEFdSt7YwC4HZ8JK3Vj/Q5DMf94cQIUuHgiBVNG+Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLHDoZo_1733897242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 14:07:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: lib: get rid of pthread_cancel() for workqueue
Date: Wed, 11 Dec 2024 14:07:20 +0800
Message-ID: <20241211060720.3648866-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
References: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Applied with the following diff:

diff --git a/lib/compress.c b/lib/compress.c
index ce1056b..8446fe4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1790,7 +1790,9 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 					    cfg.c_mt_workers << 2,
 					    z_erofs_mt_wq_tls_alloc,
 					    z_erofs_mt_wq_tls_free);
-		z_erofs_mt_enabled = !ret;
+		if (ret)
+			return ret;
+		z_erofs_mt_enabled = true;
 	}
 	pthread_mutex_init(&g_ictx.mutex, NULL);
 	pthread_cond_init(&g_ictx.cond, NULL);
diff --git a/lib/workqueue.c b/lib/workqueue.c
index 840c204..2d4aa68 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -88,7 +88,7 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 		return -ENOMEM;
 
 	for (i = 0; i < nworker; i++) {
-		ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
+		ret = -pthread_create(&wq->workers[i], NULL, worker_thread, wq);
 		if (ret)
 			break;
 	}
