Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65B764B04
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690445612;
	bh=SQyM2U1mZ/Gwc1nAOvYev1L9XLZmdJlRT0RgZ5HuwGo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RC62W6I2rKytIWcXMTsF9XfqItxP2KZm/bo4sjYjWI9kcD4fuCzXXGATPiz4MECdv
	 QJG/o9Xtnp8fQEcPR15XD7o1WTZuauq+Bp2by7NV+CxunUDVjR0HtStLcc51GQ/Rfj
	 QgffIbrAeOYShAZnYFPqEPT9h62gSBC2lMJ383Tjt7uANJSS3Cuoh7vfYk/eteIBFz
	 qksEYJYvdFaILf/4E3y0ItCpq2RP12FMJ8cGcX1dzHheCqJVa1n5bGY94pyHqIdcgN
	 sLmL6D7CrcZmTyt70jPfnE6I+E7lUwfzADBR5OLcszAVKAUfANzfihaLaIG0ZgHL/o
	 0RQXBqsBWhZSg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNnS0T2Rz3cP7
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:13:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kd6rt5g6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNn22C7Jz3cT8
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:13:10 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f74a8992so78282b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 01:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445588; x=1691050388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQyM2U1mZ/Gwc1nAOvYev1L9XLZmdJlRT0RgZ5HuwGo=;
        b=AL+0+DSFTYPufjOOqeeHIzUIP52mNyU2KxoVyZ8Kab/AkO+fbunYCaoL4AxH7jilNM
         rK77g3lof+dZYGHdMvCpMnR9wx536nIi/eW/8G8dH2s+pN5dPBNx8rR2j5+IMY6VRlhS
         f9sElvUUqcl8/dvlDWzxftWfBE6nz8KknroTKjMqCy2QZ6OrYP+BIdWfsMzNCyMYyGd5
         sT9EeFVWYF2XRTtZYgcilNNx1BznlXIVJ4vJw+7VXrW9rarSw+bfye8NMEP7c7cQFMuE
         st6QqkMF+1RsB1cSq05gRgtGEsA/KEHb4uzZky69nY4uu+fThdZ1Qp5oYJSHunAsnU1u
         CKzQ==
X-Gm-Message-State: ABy/qLbgwjk9NcX4HYtdRfrVGl2sdZm8Bi2v6p7B/ZyFvLaUSWZfoOO8
	HIOf02spCBnNBqWLBNTZuYr5nA==
X-Google-Smtp-Source: APBJJlGx3t3etMepgJMVu+n+Us77oI88lCmbMpzaxwGd8c6y1MJ13X5vnrHVztpBTHVV1RS/gpzzOQ==
X-Received: by 2002:a05:6a21:3281:b0:137:514a:982d with SMTP id yt1-20020a056a21328100b00137514a982dmr6062167pzb.6.1690445588272;
        Thu, 27 Jul 2023 01:13:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:13:07 -0700 (PDT)
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev
Subject: [PATCH v3 36/49] nfsd: dynamically allocate the nfsd-client shrinker
Date: Thu, 27 Jul 2023 16:04:49 +0800
Message-Id: <20230727080502.77895-37-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-client shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h     |  2 +-
 fs/nfsd/nfs4state.c | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..f669444d5336 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,7 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
-	struct shrinker		nfsd_client_shrinker;
+	struct shrinker		*nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
 };
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ef7118ebee00..75334a43ded4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4388,8 +4388,7 @@ static unsigned long
 nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int count;
-	struct nfsd_net *nn = container_of(shrink,
-			struct nfsd_net, nfsd_client_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
@@ -8123,12 +8122,17 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
-	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
-	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-
-	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
+	nn->nfsd_client_shrinker = shrinker_alloc(0, "nfsd-client");
+	if (!nn->nfsd_client_shrinker)
 		goto err_shrinker;
+
+	nn->nfsd_client_shrinker->scan_objects = nfsd4_state_shrinker_scan;
+	nn->nfsd_client_shrinker->count_objects = nfsd4_state_shrinker_count;
+	nn->nfsd_client_shrinker->seeks = DEFAULT_SEEKS;
+	nn->nfsd_client_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_client_shrinker);
+
 	return 0;
 
 err_shrinker:
@@ -8226,7 +8230,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	unregister_shrinker(&nn->nfsd_client_shrinker);
+	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
-- 
2.30.2

