Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 502178B000C
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:48:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ2Y010Lz3cZs
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:48:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ2D5DMvz3btk
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:48:34 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPQ1y2Gylz4f3kFJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D3A311A0175
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S4;
	Wed, 24 Apr 2024 11:48:29 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 24 Apr 2024 11:39:04 +0800
Message-Id: <20240424033916.2748488-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXaBELgShmKXE4Kw--.6143S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18JFyfJFWDXrWDtFW8JFb_yoW8ZFyfpF
	WSya4akry8Wr42g3s7Ar4rJryrA3yfAF9Fgr12g34UA3s8Xr1YvryIyr15XFy5CrZrGr42
	qw18uF92q34qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU7uc_UUUUU=
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

Hello everyone!

Recently we found some bugs while doing tests on cachefiles ondemand mode,
and this patchset is a fix for some of those issues. The following is a
brief overview of the patches, see the patches for more details.

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

Thanks,
Baokun

Baokun Li (11):
  cachefiles: remove request from xarry during flush requests
  cachefiles: remove err_put_fd tag in cachefiles_ondemand_daemon_read()
  cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
  cachefiles: fix slab-use-after-free in
    cachefiles_ondemand_daemon_read()
  cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
  cachefiles: add consistency check for copen/cread
  cachefiles: add spin_lock for cachefiles_ondemand_info
  cachefiles: never get a new anon fd if ondemand_id is valid
  cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
  cachefiles: flush all requests after setting CACHEFILES_DEAD
  cachefiles: make on-demand read killable

Zizhi Wo (1):
  cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 199 +++++++++++++++++++++---------
 include/trace/events/cachefiles.h |   8 +-
 4 files changed, 158 insertions(+), 57 deletions(-)

-- 
2.39.2

