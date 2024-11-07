Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C839C037A
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 12:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730977840;
	bh=cfFUhCU6iT3cgZsc06sT4HLAEKB/2LFKVMj0Gx6+Byg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fXy5QlM/aHVrq4aO93CVAc0gUYLcnUxF1amirp8ntpPVc90/VbAJo6dEV7jZ/OBIa
	 fHR4TWAqZOirzhIWg0RMpLqmxRubCizqkss4vEn/8/cojbYo7C2WYlw2i3351IEK1C
	 esWN/dHcDVbC8KngcycDkuF2ZuAcObUm2Kprv7PCpkJFmL3AAb6lq5ylcDmK464hBG
	 2fkLlQaAyyufI2ALO+PpVMi6vTE3VhQfqJoItbrXWi2PEO5LtK03KJJ9liX82Ix8Kd
	 4RmWhAY6DZTWv3KZfrIAc1U8A6k1ApqOmCHNMpY30IcvBOPJUtPUxhzMzDKY2qN4MX
	 +9r+Irt6YJ6gQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfWN0wpRz3c2P
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 22:10:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977836;
	cv=none; b=GjNv/TR9yrn/0yFMD7RYiTCmRAYrAR6CsG/F8iaMjVzlGH2y5qh9RMDhl3yJLM8brNbmZ1vJeJ6Z7DEdotNPyyNnQ7xOq27I2UmujW/YeRzgB1TrIL4HxXn3DJ+GKmsQksoOwWkWWdQHWLzo0gZEVrbWibQ8sbSN1oxioXjf/GwcUdu8vfbm5mkCOu3XhtvUM53N318VPpJ+xAAyHMJLURUaybxmUrOVuqP3yXbnOFa9HRFATvcv9qQS9T0XB40E7isVsQ8OskuDKLgpU8eJsmJpm0TcOZsQzlgpIcunkhWIiSz0Mz6bMQ9Eqw+ikUqUK7A29fdGRa/k9k8Q3graaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977836; c=relaxed/relaxed;
	bh=cfFUhCU6iT3cgZsc06sT4HLAEKB/2LFKVMj0Gx6+Byg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+bP11ZvDWbaf0gXG3kD6fy2ERl28vPwdWLWAM4O+kcxThSfBo9tyTuulCZ7b8DFghWkWVcv7BfoHLAirbcVmfhf4uymTne3thhwy/bRqjKD3MiJhuUH69NSbaJx9wVt4/9qejUHxsy/JjsHLo8BmxSHdo1YE6aFK7FxVZbyM83p7+ttI720xf55z2tmqalhk0CAQRu6jMCjFPoZl9kWDrZMlzTvjebFmBCbRTiSDCK0wehILukfb/ubKU0BG0aYNnn5JoStLErF+ytYBUb6N620igO6ZGX1jwwxksPVZwAMFgBEp/FoScklFgjVjWFpZQMRnGtDwgBkc+x7+Gh6+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfWG0m0lz3blk
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 22:10:33 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XkfWD6Ng5z2gL16;
	Thu,  7 Nov 2024 19:10:32 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E6621A016C;
	Thu,  7 Nov 2024 19:10:22 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:21 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v2 1/5] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
Date: Thu, 7 Nov 2024 19:06:45 +0800
Message-ID: <20241107110649.3980193-2-wozizhi@huawei.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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

cachefiles_ondemand_fd_write_iter() function first aligns "pos" and "len"
to block boundaries. When calling __cachefiles_write(), the aligned "pos"
is passed in, but "len" is the original unaligned value(iter->count).
Additionally, the returned length of the write operation is the modified
"len" aligned by block size, which is unreasonable.

The alignment of "pos" and "len" is intended only to check whether the
cache has enough space. But the modified len should not be used as the
return value of cachefiles_ondemand_fd_write_iter() because the length we
passed to __cachefiles_write() is the previous "len". Doing so would result
in a mismatch in the data written on-demand. For example, if the length of
the user state passed in is not aligned to the block size (the preread
scene/DIO writes only need 512 alignment/Fault injection), the length of
the write will differ from the actual length of the return.

To solve this issue, since the __cachefiles_prepare_write() modifies the
size of "len", we pass "aligned_len" to __cachefiles_prepare_write() to
calculate the free blocks and use the original "len" as the return value of
cachefiles_ondemand_fd_write_iter().

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 470c96658385..bdd321017f1c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,7 +61,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file = object->file;
-	size_t len = iter->count;
+	size_t len = iter->count, aligned_len = len;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
@@ -70,7 +70,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		return -ENOBUFS;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, file, &pos, &len, len, true);
+	ret = __cachefiles_prepare_write(object, file, &pos, &aligned_len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
 		return ret;
-- 
2.39.2

