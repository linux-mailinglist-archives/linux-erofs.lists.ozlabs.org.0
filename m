Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1BD666841
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 02:07:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nsmcj1FSZz3cFP
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 12:07:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsmcY6JCCz3bT5
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 12:07:41 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NsmcN5Ks6z4f3jHy
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 09:07:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXP7NUXb9j77E5Bg--.63722S2;
	Thu, 12 Jan 2023 09:07:35 +0800 (CST)
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic()
 before wake_up_bit()
To: David Howells <dhowells@redhat.com>
References: <20221226103309.953112-3-houtao@huaweicloud.com>
 <20221226103309.953112-1-houtao@huaweicloud.com>
 <2431994.1673453386@warthog.procyon.org.uk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cd26e985-ce9a-6011-400a-9005376f47b5@huaweicloud.com>
Date: Thu, 12 Jan 2023 09:07:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2431994.1673453386@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDXP7NUXb9j77E5Bg--.63722S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4rAF15Zr1ftr1rCr1kuFg_yoW3KFb_CF
	ZYvFZYkw47W3WDK3WUtr1Sqa1xKr18C3Z3trZrJrZ7tr4xZ39IkFn7WryI9F1xG3s7KF43
	A34UWF4vyw13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 1/12/2023 12:09 AM, David Howells wrote:
> Hou Tao <houtao@huaweicloud.com> wrote:
>
>> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
>> which are waiting for the completion of volume creation. According to
>> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
>> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
>> flag and waitqueue_active() before invoking wake_up_bit().
> What two values are you ordering?
>
> If we're using this to create a critical section, then yes, we would need a
> barrier to order the changes inside the critical section before changing the
> memory location that forms the lock - but this is not a critical section.
It is similar with patch #1. The smp_mb() is used for order between
volume->flags and wq->head.
> David
>

