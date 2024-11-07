Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A4A9C0379
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 12:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730977839;
	bh=OPiBW7tsuV/HWsQckJMpfJU73ndvD2L1jlRNof7keEw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cYrjl2Mowjgxqc1gvtaUeFQ5M4e4i6JSO0bbw5OZxTex9FCuPoNIKQUqrmBxTtC5n
	 NzXCskTPRKRnpAYUTv/PLvBxwkbUO8BRL18QItL+rbsgar9vNB5Q0qW6/dtFqCNPLN
	 4lG4N6RWs4jnu7QJw6b4j9s/o33BDlVYmL68MmGcJ4Mzv+AcWM+wJxcFpoRr0bpmaX
	 OW0Eg7+zSSiMy71Cn3HGzPA7z4oeg7Riq5/gCqFpdojpC7xcID1ERres+3WByRZGgz
	 mYVSzXTX0Er4i9TyBvMPiQb8WyFZ99QytwCzit6kKK0hPAChHsuJi1RD/bp14LPi2p
	 xLoVJQknQCNoA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfWM1cmjz3btZ
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 22:10:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977836;
	cv=none; b=YNBTQ2g80FA6IYsuVwvC6Sy+5MQc4XU5oCFUhX02DGZC5inYQNF3MkNpTLxoMSvouGEG7bR4PAM/CHQQaiWpX7YMkITkzxhLZvUttNQnlSm0uY3WjJbpzPPMhGzoPZSwRLeJSkHZa1cI5YwN2B54SBo0SAdIBVyHWls4A5qvac0xikkeccgi8Ff273rO+43AEcTRu3S1/MrpqJDy4VlGxX+XVOzZp6hakcrWMHEohds+Zzj8Ylue5UCqMpgMlxKFkgtCLkFq5AsoRWCc5/RgIkGOvjkCLADtqad0BjKXSkKRj+niCdZiRhVdEujOZJbhSMVEriigiljkzyDPSLP17A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977836; c=relaxed/relaxed;
	bh=OPiBW7tsuV/HWsQckJMpfJU73ndvD2L1jlRNof7keEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcYBb94f8Dh57YDfbqvSY9msH95ikh0SpISHzXopEna76HDrJmFOWO8VJP2ct/1vKntmUjkCYuub+e+MzukG+vcj3cUa9JK/qqeXPtE9RtcnsbI298mXMiL/Jj1GqoezVwy57uRwXDGdepK+F7NTffSw6X1KgucvzK3VwtJYAV7zS+s/8iXqm1DBCM4OkxFQes7yCQBUdkdkld62Gd3V8K2Vy4c95XHytbU8DeM7OIARgiWPA/XVE6yfk0pe7Q7pr7Cph48XLtnSqwLy+++ND8MeZ3aw6if1eM6XX0JNdcJD4HXg3Gur0WpDuZsMfVL+jUwDXjR+G0YJNXkKLKmCnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfWF4Rhsz3bld
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 22:10:32 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XkfTm39pBzQsf2;
	Thu,  7 Nov 2024 19:09:16 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6D9180105;
	Thu,  7 Nov 2024 19:10:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:23 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v2 3/5] cachefiles: Clean up in cachefiles_commit_tmpfile()
Date: Thu, 7 Nov 2024 19:06:47 +0800
Message-ID: <20241107110649.3980193-4-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/namei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2b3f9935dbb4..7cf59713f0f7 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -691,11 +691,6 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
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

