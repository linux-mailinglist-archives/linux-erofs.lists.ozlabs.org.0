Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599AC91B711
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 08:31:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9QZ26wRbz3cZK
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 16:31:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9QYk3KrQz3cSX
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 16:31:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W9QYN6xMNz4f3jR5
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:30:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DE46F1A058E
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:30:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S4;
	Fri, 28 Jun 2024 14:30:57 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 0/9] cachefiles: random bugfixes
Date: Fri, 28 Jun 2024 14:29:21 +0800
Message-Id: <20240628062930.2467993-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXwIWfWH5mZZVAAg--.52859S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15CF1DXrW3GFy5ZFy5Arb_yoWrAr17pF
	Waka13JrykWry7C393Zw13tFyrA3yfXFn2gr17Xw15A3s8XF15ZrWI9r1YvFyUCrZ7Jw42
	vr1jkFn7Gr1jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYWrWUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-YcwABs3
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the third version of this patch series, in which another patch set
is subsumed into this one to avoid confusing the two patch sets.
(https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)

Thank you, Jia Zhu, Gao Xiang, Jeff Layton, for the feedback in the
previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch series fixes some of the issues. The patches have passed internal
testing without regression.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-2: Add fscache_try_get_volume() helper function to avoid
fscache_volume use-after-free on cache withdrawal.

Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
concurrency causing cachefiles_volume use-after-free.

Patch 4: Propagate error codes returned by vfs_getxattr() to avoid
endless loops.

Patch 5-7: A read request waiting for reopen could be closed maliciously
before the reopen worker is executing or waiting to be scheduled. So
ondemand_object_worker() may be called after the info and object and even
the cache have been freed and trigger use-after-free. So use
cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
reopen worker or wait for it to finish. Since it makes no sense to wait
for the daemon to complete the reopen request, to avoid this pointless
operation blocking cancel_work_sync(), Patch 1 avoids request generation
by the DROPPING state when the request has not been sent, and Patch 2
flushes the requests of the current object before cancel_work_sync().

Patch 8: Cyclic allocation of msg_id to avoid msg_id reuse misleading
the daemon to cause hung.

Patch 9: Hold xas_lock during polling to avoid dereferencing reqs causing
use-after-free. This issue was triggered frequently in our tests, and we
found that anolis 5.10 had fixed it. So to avoid failing the test, this
patch is pushed upstream as well.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v2:
  * Collect Acked-by from Jeff Layton.(Thanks for your ack!)
  * Collect RVB from Gao Xiang.(Thanks for your review!)
  * Patch 1-4 from another patch set.
  * Pathch 4,6,7: Optimise commit messages and subjects.

Changes since v1:
  * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
  * Pathch 1,2：Add more commit messages.
  * Pathch 3：Add Fixes tag as suggested by Jia Zhu.
  * Pathch 4：No longer changing "do...while" to "retry" to focus changes
    and optimise commit messages.
  * Pathch 5: Drop the internal RVB tag.

v1: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huaweicloud.com
v2: https://lore.kernel.org/all/20240515125136.3714580-1-libaokun@huaweicloud.com

Baokun Li (7):
  netfs, fscache: export fscache_put_volume() and add
    fscache_try_get_volume()
  cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
  cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
  cachefiles: propagate errors from vfs_getxattr() to avoid infinite
    loop
  cachefiles: stop sending new request when dropping object
  cachefiles: cancel all requests for the object that is being dropped
  cachefiles: cyclic allocation of msg_id to avoid reuse

Hou Tao (1):
  cachefiles: wait for ondemand_object_worker to finish when dropping
    object

Jingbo Xu (1):
  cachefiles: add missing lock protection when polling

 fs/cachefiles/cache.c          | 45 ++++++++++++++++++++++++++++-
 fs/cachefiles/daemon.c         |  4 +--
 fs/cachefiles/internal.h       |  3 ++
 fs/cachefiles/ondemand.c       | 52 ++++++++++++++++++++++++++++++----
 fs/cachefiles/volume.c         |  1 -
 fs/cachefiles/xattr.c          |  5 +++-
 fs/netfs/fscache_volume.c      | 14 +++++++++
 fs/netfs/internal.h            |  2 --
 include/linux/fscache-cache.h  |  6 ++++
 include/trace/events/fscache.h |  4 +++
 10 files changed, 123 insertions(+), 13 deletions(-)

-- 
2.39.2

