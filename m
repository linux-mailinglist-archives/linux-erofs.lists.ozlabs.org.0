Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9986F9CF
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 07:04:50 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TkihV7lp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tp7Sw1MqPz3cGW
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 17:04:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TkihV7lp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tp7Sm3Xsqz2xQ7
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Mar 2024 17:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709532273; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ADibi9+LqS/ZbdWl7A42/kCs0BgntDzko1HwYihHMqE=;
	b=TkihV7lp8TK8jkRv72nSMyOU63DIMx1U0BBGW7hNrwdu9WMFCuE2KxFxQyu9ztHcQIYH8u4pdhqzY744p+GfY6FapPpWjzPyba661DObgU+BfyHvCH3khVHDifnBTx6DzQCW/ChkhpeYAl2o6bcXN0gPhGQ6vd6NwsSoqpGFb/o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1jQ1i1_1709532271;
Received: from 30.97.48.196(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1jQ1i1_1709532271)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 14:04:32 +0800
Message-ID: <dfd05ad0-1dae-4121-abba-59b55ad22c99@linux.alibaba.com>
Date: Mon, 4 Mar 2024 14:04:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
To: linux-erofs@lists.ozlabs.org, syzkaller-bugs@googlegroups.com
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
 <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Roberto Sassu <roberto.sassu@huaweicloud.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

On 2024/3/4 11:53, Gao Xiang wrote:
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/decompressor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>   	u8 *kin;
>   
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize)
> +		return -EOPNOTSUPP;
>   	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>   		cur = bs - (rq->pageofs_out & (bs - 1));
>   		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
