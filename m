Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4D959326
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209581;
	bh=aL1dROMTpGVBsvL1gz2cYJ8AMMW+Biqu4NInJ2vcCLY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=R6ywVGjBxeaonsmjDQ30nqPigsScrCHaemHYk9smqW9yeNPoXYGgQyX9tAHw9GiSS
	 jfoVx1fz3hMI/sXJSKXVF3qbIjq5QwEvOYfshUSSRoxYhwSnpsjIREYPdjT+rK69pG
	 Bn2vVDCJqdD6wMmVHtmQzixA2EEi5iemc4xP6EXUH46WCyL1Lurjwl/rR5FChS9+g8
	 cIFeie2abpl8J+owZOFC74kxlxJnE8DovfhIRDPlyCO2z1KxRmjT/y3M0+flsjCG1k
	 PP9q8VNEe564RFlrFYd0/fKhjAB9WIedO88gmkwF4uWve0dpSD/xrI142Gt3s68VrV
	 01AKui+nNEP3A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWSY5SFLz2yGX
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:06:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWSW20sQz2xKd
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:06:19 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WpW2J2y81zyQDd;
	Wed, 21 Aug 2024 10:47:04 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 375D01401F4;
	Wed, 21 Aug 2024 10:47:43 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:42 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 4/8] cachefiles: Clear invalid cache data in advance
Date: Wed, 21 Aug 2024 10:42:57 +0800
Message-ID: <20240821024301.1058918-5-wozizhi@huawei.com>
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

In the current on-demand loading scenario, when umount is called, the
cachefiles_commit_tmpfile() is invoked. When checking the inode
corresponding to object->file is inconsistent with the dentry,
cachefiles_unlink() is called to perform cleanup to prevent invalid data
from occupying space.

The above operation does not apply to the first mount, because the cache
dentry generated by the first mount must be negative. Moreover, there is no
need to clear it during the first umount because this part of the data may
be reusable in the future. But the problem is that, the clean operation can
currently only be called through cachefiles_withdraw_cookie(), in other
words the redundant data does not cleaned until the second umount. This
means that during the second mount, the old cache data generated from the
first mount still occupies space. So if the user does not manually clean up
the previous cache before the next mount, it may return insufficient space
during the second mount phase.

This patch adds an additional cleanup process in the cachefiles_open_file()
function. When the auxdata check fails, the remaining old cache data is no
longer needed, the file and dentry corresponding to the object are also
put. As there is no need to clear it until umount, we can directly clear it
during the mount process.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/namei.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..70b0b3477085 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -542,7 +542,7 @@ static bool cachefiles_create_file(struct cachefiles_object *object)
  * stale.
  */
 static bool cachefiles_open_file(struct cachefiles_object *object,
-				 struct dentry *dentry)
+				 struct dentry *dir, struct dentry *dentry)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file;
@@ -601,10 +601,18 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
-	fput(file);
-	dput(dentry);
-	if (ret == -ESTALE)
+	__fput_sync(file);
+	if (ret == -ESTALE) {
+		/* When the auxdata check fails, the remaining old cache data
+		 * is no longer needed, and we will clear it here first.
+		 */
+		inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+		cachefiles_unlink(cache, object, dir, dentry, FSCACHE_OBJECT_IS_STALE);
+		inode_unlock(d_inode(dir));
+		dput(dentry);
 		return cachefiles_create_file(object);
+	}
+	dput(dentry);
 	return false;
 
 error_fput:
@@ -654,7 +662,7 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 		goto new_file;
 	}
 
-	if (!cachefiles_open_file(object, dentry))
+	if (!cachefiles_open_file(object, fan, dentry))
 		return false;
 
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
-- 
2.39.2

