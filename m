Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026A66956D
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 12:23:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NtfF71850z3fBB
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 22:23:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NtfF343pYz3c9G
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jan 2023 22:23:50 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NtfDp65qBz4f3nql
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jan 2023 19:23:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXwLM6P8Fj7hGXBg--.28092S4;
	Fri, 13 Jan 2023 19:23:40 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-cachefs@redhat.com
Subject: [PATCH v3 0/2] Fixes for fscache volume operations
Date: Fri, 13 Jan 2023 19:52:09 +0800
Message-Id: <20230113115211.2895845-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLM6P8Fj7hGXBg--.28092S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Xry7Zr1fWF1kJrWfur43Awb_yoW8Jr1kpr
	W3CrsxKFW8G3sxtws7Xw47Z3409FWkta9rWr15Aw1UAr45ZFWjqayUKw1Y9a42y395Aayx
	XF1Utw4fZryUAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, houtao1@huawei.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset includes two fixes for fscache volume operations: patch 1
fixes the hang problem during volume acquisition when the volume
acquisition process waits for the freeing of relinquished volume, patch
2 adds the missing memory barrier in fscache_create_volume_work() and it
is spotted through code review when checking whether or not these is
missing smp_mb() before invoking wake_up_bit().

Comments are always welcome.

Chang Log:
v3:
 * Use clear_and_wake_up_bit() helper (Suggested by Jingbo Xu)
 * Tidy up commit message and add Reviewed-by tag

v2: https://listman.redhat.com/archives/linux-cachefs/2022-December/007402.html
 * rebased on v6.1-rc1
 * Patch 1: use wait_on_bit() instead (Suggested by David)
 * Patch 2: add the missing smp_mb() in fscache_create_volume_work()

v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/007384.html


Hou Tao (2):
  fscache: Use wait_on_bit() to wait for the freeing of relinquished
    volume
  fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()

 fs/fscache/volume.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.29.2

