Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B36561EB
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Dec 2022 11:33:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NgYzS5jpZz3bZJ
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Dec 2022 21:33:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NgYzD1tqfz307T
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Dec 2022 21:33:26 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NgYz030Smz4f3kJt
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Dec 2022 18:33:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBH_rFreKlj6SMxAg--.54373S6;
	Mon, 26 Dec 2022 18:33:19 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-cachefs@redhat.com
Subject: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic() before wake_up_bit()
Date: Mon, 26 Dec 2022 18:33:09 +0800
Message-Id: <20221226103309.953112-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221226103309.953112-1-houtao@huaweicloud.com>
References: <20221226103309.953112-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rFreKlj6SMxAg--.54373S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxXF18tr4DCF48ZF47Arb_yoW8Gr18pr
	Z5WFySqay8X39rt3yDJw17u34SgrWUKanrGr10y3WUZF4FqrWFv3WSkas8u3W7C398Xry3
	ZF15K3y3XF1UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2GYLDUUUU
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hou Tao <houtao1@huawei.com>

fscache_create_volume_work() uses wake_up_bit() to wake up the processes
which are waiting for the completion of volume creation. According to
comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
flag and waitqueue_active() before invoking wake_up_bit().

Considering clear_bit_unlock() before wake_up_bit() is an atomic
operation, use smp_mb__after_atomic() instead of smp_mb() to provide
such guarantee.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fscache/volume.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index fc3dd3bc851d..734d17f404e7 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -281,6 +281,11 @@ static void fscache_create_volume_work(struct work_struct *work)
 				 fscache_access_acquire_volume_end);
 
 	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
+	/*
+	 * Paired with barrier in wait_on_bit(). Check wake_up_bit() and
+	 * waitqueue_active() for details.
+	 */
+	smp_mb__after_atomic();
 	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
 	fscache_put_volume(volume, fscache_volume_put_create_work);
 }
-- 
2.29.2

