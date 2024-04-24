Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEE8B0042
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:56:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQCZ3gH7z3cBx
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:56:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQCR3C7cz30gK
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:56:34 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPPmQ5ldLz4f3l1y
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 03B661A0C7E
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5Nfihmarc3Kw--.25590S4;
	Wed, 24 Apr 2024 11:36:47 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 0/5] cachefiles: some bugfixes for withdraw and xattr
Date: Wed, 24 Apr 2024 11:27:27 +0800
Message-Id: <20240424032732.2711487-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ5Nfihmarc3Kw--.25590S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18JFyfJFWDXrWkWFyfZwb_yoW8Gw45pF
	WayF43Jry8W3y7Gw1fAr15Jr1rA3s3JF1vg347Wr18Awn5Xr1jqF1Iyr15ZFW5ury7Jws2
	q3WUKFy7Ww1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUtrc3UUUUU==
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

Hello everyone!

Recently we found some bugs while doing tests on cachefiles ondemand mode,
and this patchset is a fix for some of those issues. The following is a
brief overview of the patches, see the patches for more details.

Patch 1-2: Add fscache_try_get_volume() helper function to avoid
fscache_volume use-after-free on cache withdrawal.

Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
concurrency causing cachefiles_volume use-after-free.

Patch 4-5: Propagate error codes returned by vfs_getxattr() to avoid
endless loops.

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (5):
  netfs, fscache: export fscache_put_volume() and add
    fscache_try_get_volume()
  cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
  cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
  cachefiles: correct the return value of
    cachefiles_check_volume_xattr()
  cachefiles: correct the return value of cachefiles_check_auxdata()

 fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++-
 fs/cachefiles/volume.c         |  1 -
 fs/cachefiles/xattr.c          |  5 +++-
 fs/netfs/fscache_volume.c      | 14 +++++++++++
 fs/netfs/internal.h            |  2 --
 include/linux/fscache-cache.h  |  6 +++++
 include/trace/events/fscache.h |  4 +++
 7 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.39.2

