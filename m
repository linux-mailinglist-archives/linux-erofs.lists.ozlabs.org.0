Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158598B0044
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:56:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQCh5VKlz3ckg
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:56:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQCR3ctdz3bpd
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:56:34 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPPmR1wrTz4f3mHK
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7588A1A0C85
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5Nfihmarc3Kw--.25590S5;
	Wed, 24 Apr 2024 11:36:48 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 1/5] netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
Date: Wed, 24 Apr 2024 11:27:28 +0800
Message-Id: <20240424032732.2711487-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424032732.2711487-1-libaokun@huaweicloud.com>
References: <20240424032732.2711487-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ5Nfihmarc3Kw--.25590S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17ur1rJw1kWw1rCr1rWFg_yoW5Cr1Dp3
	srCrn7KF48Xw1xGw45Xw47Zrn3Z3yDKan7G348Gw15Cw4xtr15XF12yw15AF13A34UJrWI
	yF1Utryjgw1UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi9a97UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

Export fscache_put_volume() and add fscache_try_get_volume()
helper function to allow cachefiles to get/put fscache_volume
via linux/fscache-cache.h.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/netfs/fscache_volume.c     | 14 ++++++++++++++
 fs/netfs/internal.h           |  2 --
 include/linux/fscache-cache.h |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cdf991bdd9de..cb75c07b5281 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -27,6 +27,19 @@ struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 	return volume;
 }
 
+struct fscache_volume *fscache_try_get_volume(struct fscache_volume *volume,
+					      enum fscache_volume_trace where)
+{
+	int ref;
+
+	if (!__refcount_inc_not_zero(&volume->ref, &ref))
+		return NULL;
+
+	trace_fscache_volume(volume->debug_id, ref + 1, where);
+	return volume;
+}
+EXPORT_SYMBOL(fscache_try_get_volume);
+
 static void fscache_see_volume(struct fscache_volume *volume,
 			       enum fscache_volume_trace where)
 {
@@ -420,6 +433,7 @@ void fscache_put_volume(struct fscache_volume *volume,
 			fscache_free_volume(volume);
 	}
 }
+EXPORT_SYMBOL(fscache_put_volume);
 
 /*
  * Relinquish a volume representation cookie.
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ec7045d24400..edf9b2a180ca 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -326,8 +326,6 @@ extern const struct seq_operations fscache_volumes_seq_ops;
 
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
-void fscache_put_volume(struct fscache_volume *volume,
-			enum fscache_volume_trace where);
 bool fscache_begin_volume_access(struct fscache_volume *volume,
 				 struct fscache_cookie *cookie,
 				 enum fscache_access_trace why);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index bdf7f3eddf0a..4c91a019972b 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -19,6 +19,7 @@
 enum fscache_cache_trace;
 enum fscache_cookie_trace;
 enum fscache_access_trace;
+enum fscache_volume_trace;
 
 enum fscache_cache_state {
 	FSCACHE_CACHE_IS_NOT_PRESENT,	/* No cache is present for this name */
@@ -97,6 +98,11 @@ extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
+extern struct fscache_volume *
+fscache_try_get_volume(struct fscache_volume *volume,
+		       enum fscache_volume_trace where);
+extern void fscache_put_volume(struct fscache_volume *volume,
+			       enum fscache_volume_trace where);
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);
-- 
2.39.2

