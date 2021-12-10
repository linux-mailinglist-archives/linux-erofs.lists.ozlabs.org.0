Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1946FBF4
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:42:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NCB3cM3z3cJ9
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:41:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NC357kzz2yng
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-8PLOr_1639121783; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8PLOr_1639121783) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:24 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 03/19] cachefiles: refactor cachefiles_adjust_size()
Date: Fri, 10 Dec 2021 15:36:03 +0800
Message-Id: <20211210073619.21667-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In demand-read mode, fs using fscache for demand-read doesn't know the
exact file size of the data blob file, and the input @object_size
parameter of fscache_acquire_cookie() could be fake in this case.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 51c968cd00a6..b85051250cb7 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -110,6 +110,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 {
 	struct iattr newattrs;
 	struct file *file = object->file;
+	struct cachefiles_cache *cache = object->volume->cache;
 	uint64_t ni_size;
 	loff_t oi_size;
 	int ret;
@@ -123,6 +124,9 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 	if (!file)
 		return -ENOBUFS;
 
+	if (cache->mode == CACHEFILES_MODE_DEMAND)
+		return 0;
+
 	oi_size = i_size_read(file_inode(file));
 	if (oi_size == ni_size)
 		return 0;
-- 
2.27.0

