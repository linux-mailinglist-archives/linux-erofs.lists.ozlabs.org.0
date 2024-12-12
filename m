Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FFD9EE895
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 15:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1734013007;
	bh=9RXKWmDb0eOAmEWJ1jzUxpFxjeHIbus6hFcAmPU59sM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hrfUTQaUQtdR2v9wVHzDPVr+/eHMRmESIsv7MCzM5teAw88EyB9BO5KA5DhgkzlKe
	 nz8om4V1lF0JB4U/+XZzlzqfKmvQz1Kh6zoftNzrqepw+3hcfWPwNSHYY0iGMHItT/
	 XZan8YI7xaXyadZ7ASddzdh1DyKpCl9QjUKiUMAeQePF4l1g3c+OwTXMdPpugdvOWL
	 dymTZKDTZUqbl4XaUpK9lkR44EVYZ6wbddDqI8iJ8gyHF2hByNv2N5YghsAeJJPx4W
	 h8eiVX9jGrFSF6HKS8EijmM0/RHut1aQcs3LFHN+N4Pdarj64f29FopcklEgNw14lt
	 fAYp58dLuCcQQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8Dzz2Rsxz30YZ
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 01:16:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734013000;
	cv=none; b=eSnrJNlCI9mrvuSSiINqRomW5cPEFrdrComRpQ9ewtNvK9VF/eWmYyZg1R4D2qCUVJi3tmanR3OlF8q0QE6ZuS2fxiWswPEWU84/8cHUJPSdv043dZizI7NFWYAJ7R3St4S+PkJqTaX/3kD83bd9brl7+XRKwvhM/29eTLRzdMQ7rjqUI1KNR91gBSR2x0zX/tx/lwnPqh6Qa6VJQrONtXa0EbGQHT3Vy+xYEFZ7taA7BmBKDUNn5qbkC7QSLb8JAJPqlXhMU8Khrll/vZ/Fw/MF0D8ysmfaMfKTizbV681Wz3+x0d+g7Lh0W4tYSKY4ElSjPkvbW/miOd6s8nddbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734013000; c=relaxed/relaxed;
	bh=9RXKWmDb0eOAmEWJ1jzUxpFxjeHIbus6hFcAmPU59sM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bsKIVrrvDr8ZnFGl+JYLdsNtPILHaZLwDkxZbZX//eiv9nXjoUJUnKlygFk6VQ5oZRKq23vnSgFsozkTnhkMj/p4UfX53u6evGldsUYnbFKSnSz9AS8wwNjEMOj32A7ELGKK73/+xBQcXdBgkXBW/OutyNCz9rL5hN6jjU+OKvZ6MoA0WXMfuXAOvNXa29K25dBHoUsoMDpmtlTOJqPcqIOrLlNyCt9erNCF2yReYhizsPAlc/Wp0RqN6VHZpIrzwiLvTbYoF7kv9WoU60+mamFPvyLUpDaElMnDs/XiAquiuoPqba8SO7MJD++uzZPkPp4+pWUSsgzamFYwGPcnAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RJqzlOZi; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RJqzlOZi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8Dzp6qQwz30Vq
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 01:16:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 98253A42854;
	Thu, 12 Dec 2024 14:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC8C4CECE;
	Thu, 12 Dec 2024 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734012995;
	bh=45TZOcgzHOmBIRwi6FLlW8HAR5EeI3rFfCok//EusG4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RJqzlOZiX4A4XWASQhxGbSXC+5wIHPok7A/8IPeQ/zl8mDz3hEmpPhZOuT0gPVNYi
	 DAawO995TTkqp+bOtCYqNtQNbDh7cC0ReRTT+R4djXuR1OmALowK6z2zdn9ix2kMr0
	 1oVUUoUrRWJKPMMqg4zp9MQb+VhlhyrTJS51qX+ERfM+rePSKbT9XBH9ltzxgiMQws
	 9BxuX1qJZgllKqJ6WBF08wOvG6gbFIEmbEUhXCTKtSflh8SSkfgBadFp8G+XBdJ9+G
	 8CZd+ZK10lMjzDQm1Ymk8NbSX9g5DgJv6Ie3HSqfedMZrpr1d1M4hf6SJDy9U6As1R
	 5+qJtXt/ZYFjw==
Message-ID: <88a6844e-1294-4997-8ef3-a69ff6add34d@kernel.org>
Date: Thu, 12 Dec 2024 22:16:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix rare pcluster memory leak after unmounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <674c1235.050a0220.ad585.0032.GAE@google.com>
 <20241203072821.1885740-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20241203072821.1885740-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/12/3 15:28, Gao Xiang wrote:
> There may still exist some pcluster with valid reference counts
> during unmounting.  Instead of introducing another synchronization
> primitive, just try again as unmounting is relatively rare.  This
> approach is similar to z_erofs_cache_invalidate_folio().
> 
> It was also reported by syzbot as a UAF due to commit f5ad9f9a603f
> ("erofs: free pclusters if no cached folio is attached"):
> 
> BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
> ..
>   queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
>   do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
>   __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
>   _raw_spin_trylock+0x20/0x80 kernel/locking/spinlock.c:138
>   spin_trylock include/linux/spinlock.h:361 [inline]
>   z_erofs_put_pcluster fs/erofs/zdata.c:959 [inline]
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_queue+0x3798/0x3ef0 fs/erofs/zdata.c:1425
>   z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1437
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f2/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> However, it seems a long outstanding memory leak.  Fix it now.
> 
> Fixes: f5ad9f9a603f ("erofs: free pclusters if no cached folio is attached")
> Reported-by: syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/674c1235.050a0220.ad585.0032.GAE@google.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
