Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A7E6652A7
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 05:04:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsDZf2lV1z3cGh
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 15:04:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsDZY4vbSz3bYw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 15:04:03 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NsDZG3QNMz4f3s5y
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 12:03:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCHeugkNb5jzwboBQ--.7168S2;
	Wed, 11 Jan 2023 12:03:51 +0800 (CST)
Subject: Re: [PATCH v2 0/2] Fixes for fscache volume operations
To: linux-cachefs@redhat.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <57afbcf7-df1f-47b8-2b81-8fca87487f57@huaweicloud.com>
Date: Wed, 11 Jan 2023 12:03:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221226103309.953112-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgCHeugkNb5jzwboBQ--.7168S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr15Wr1xCFWktFyxXF18Zrb_yoWDKFg_u3
	4xKas8uw40qayDKayYkFnIqrs3uw4jga18JFyDtr17G34F9rn09F1kKrySyF1Igay7ZF45
	Cr1kKFZYqr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "houtao1@huawei.com" <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

ping ?

On 12/26/2022 6:33 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patchset includes two fixes for fscache volume operations: patch 1
> fixes the hang problem during volume acquisition when the volume
> acquisition process waits for the freeing of relinquished volume, patch
> 2 adds the missing memory barrier in fscache_create_volume_work() and it
> is spotted through code review when checking whether or not these is
> missing smp_mb() before invoking wake_up_bit().
>
> Comments are always welcome.
>
> Chang Log:
> v2:
>  * rebased on v6.1-rc1
>  * Patch 1: use wait_on_bit() instead (Suggested by David)
>  * Patch 2: add the missing smp_mb() in fscache_create_volume_work()
>
> v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/007384.html
>
> Hou Tao (2):
>   fscache: Use wait_on_bit() to wait for the freeing of relinquished
>     volume
>   fscache: Add the missing smp_mb__after_atomic() before wake_up_bit()
>
>  fs/fscache/volume.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>

