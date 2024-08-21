Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BF959322
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209508;
	bh=wdTdtNWHp0IaBWLAgZDBVckE/pqzztRRY1bAzcXbEp0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=izpxoyo/mXXzVQFOEgAPYTEF3OH7QfxdP1zAssioWnbpgHPHygKEIjjJRPRklqe5p
	 z1i2Mq+neZBu1VQ9uxAl6GgUzPIBhdC+WpCZjIuzEYE1wZFMpq2V5dftuNPZGIJJUi
	 TKKMUZ/shviKfd1sQ54Gv6ToYEC84uKhoxvzHsfVwgJ6c7vQaMznUKDGkaosRPuunt
	 1v1nb1ycVEKHKfrAsOiMd1t/pgX9k7h/uAduYOTsAk4hbzQhP1hfzJiZMhA+5UxXvT
	 YEnWrsc0zPRlq8ygXVDD6AVxtC8LDxoeuH90LX3RMYcn1wKkH0fRAd5DAb0Hh6kAYD
	 0/1jeBSSWptjA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWR84QP7z2yFL
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:05:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWR61XCmz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:05:06 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WpW2K4xBHz13cQg;
	Wed, 21 Aug 2024 10:47:05 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3370D1800D4;
	Wed, 21 Aug 2024 10:47:44 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:43 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 5/8] cachefiles: Clean up in cachefiles_commit_tmpfile()
Date: Wed, 21 Aug 2024 10:42:58 +0800
Message-ID: <20240821024301.1058918-6-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, cachefiles_commit_tmpfile() will only be called if object->flags
is set to CACHEFILES_OBJECT_USING_TMPFILE. Only cachefiles_create_file()
and cachefiles_invalidate_cookie() set this flag. Both of these functions
replace object->file with the new tmpfile, and both are called by
fscache_cookie_state_machine(), so there are no concurrency issues.

So the equation "d_backing_inode(dentry) == file_inode(object->file)" in
cachefiles_commit_tmpfile() will never hold true according to the above
conditions. This patch removes this part of the redundant code and does not
involve any other logical changes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/namei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 70b0b3477085..ce9d558ae4fa 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -700,11 +700,6 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 	if (!d_is_negative(dentry)) {
-		if (d_backing_inode(dentry) == file_inode(object->file)) {
-			success = true;
-			goto out_dput;
-		}
-
 		ret = cachefiles_unlink(volume->cache, object, fan, dentry,
 					FSCACHE_OBJECT_IS_STALE);
 		if (ret < 0)
-- 
2.39.2

