Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 467EB8CBA1F
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 05:56:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vkcl72HTcz3gFK
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 13:50:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkcky61svz3g0q
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 13:50:01 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vkckd6B08z4f3jXt
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C74D11A0906
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S4;
	Wed, 22 May 2024 11:49:52 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 22 May 2024 19:42:56 +0800
Message-Id: <20240522114308.2402121-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHGBFea01mxlBXNQ--.57627S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr18JFyUXF47JFy3uw4xCrg_yoW5tw4fpF
	WSk3Wakr18Wr48C3s7Ar4fJryrG3yxAF9FgrnFq34DZwn8Xr1FvrW0qr1Yqas8CrZ7Gw4a
	q3WUuas7tw1q93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuWlkUUUUU
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the third version of this patch series. The new version has no
functional changes compared to the previous one, so I've kept the previous
Acked-by and Reviewed-by, so please let me know if you have any objections.

Thank you, Jia Zhu and Jingbo Xu, Jeff Layton, Gao Xiang, for the feedback
in the previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch set fixes some of the issues related to ondemand requests.
The patches have passed internal testing without regression.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-5: Holding reference counts of reqs and objects on read requests
to avoid malicious restore leading to use-after-free.

Patch 6-10: Add some consistency checks to copen/cread/get_fd to avoid
malicious copen/cread/close fd injections causing use-after-free or hung.

Patch 11: When cache is marked as CACHEFILES_DEAD, flush all requests,
otherwise the kernel may be hung. since this state is irreversible, the
daemon can read open requests but cannot copen.

Patch 12: Allow interrupting a read request being processed by killing
the read process as a way of avoiding hung in some special cases.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v2:
  * Collect Acked-by from Jeff Layton.(Thanks for your ack!)
  * Collect RVB from Gao Xiang and Jingbo Xu.(Thanks for your review!)
  * Pathch 9: Rename anon_file to ondemand_anon_file to avoid possible
    conflicts with generic code.
  * Pathch 12: Add cachefiles_ondemand_finish_req() helper function to
    simplify the code.
  * Adjust the patch order as suggested to facilitate backporting to
    the STABLE version.
    * The current patch 1 is the previous patch 5;
    * The current patch 5 is the previous patch 2;

Changes since v1:
  * Collect RVB from Jia Zhu and Jingbo Xu.(Thanks for your review!)
  * Pathch 1: Add Fixes tag and enrich the commit message.
  * Pathch 7: Add function graph comments.
  * Pathch 8: Update commit message and comments.
  * Pathch 9: Enriched commit msg.

[V1]: https://lore.kernel.org/all/20240424033916.2748488-1-libaokun@huaweicloud.com
[V2]: https://lore.kernel.org/all/20240515084601.3240503-1-libaokun@huaweicloud.com


Baokun Li (11):
  cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
  cachefiles: remove requests from xarray during flushing requests
  cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
  cachefiles: fix slab-use-after-free in
    cachefiles_ondemand_daemon_read()
  cachefiles: remove err_put_fd label in
    cachefiles_ondemand_daemon_read()
  cachefiles: add consistency check for copen/cread
  cachefiles: add spin_lock for cachefiles_ondemand_info
  cachefiles: never get a new anonymous fd if ondemand_id is valid
  cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
  cachefiles: flush all requests after setting CACHEFILES_DEAD
  cachefiles: make on-demand read killable

Zizhi Wo (1):
  cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 217 ++++++++++++++++++++++--------
 include/trace/events/cachefiles.h |   8 +-
 4 files changed, 176 insertions(+), 57 deletions(-)

-- 
2.39.2

