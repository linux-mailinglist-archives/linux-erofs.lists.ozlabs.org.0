Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DB86F7E5
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 00:54:06 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wlQeYgX+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TnzF70jnXz3c9r
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 10:54:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wlQeYgX+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TnzF15dCGz30hQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Mar 2024 10:53:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709510030; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Af5beNfEN0r7ORUFfnC+HrkG5+opfekQz/HhOQbFxAA=;
	b=wlQeYgX+BV0Gj5RoIRcqNTx+qLcyHCDHmTKz9aOqMnuA7l4FRrp1IenPKJCNp+eS3BmmKkyGcy/Jx4CkCOVJCiHcJVlYhD1crfctJrbHkEa9bQsfjXhHpR0fl8mEsdBFT/GEzGPVVZ2wA+qBKvg94lbJCWvZWzUQHmD4qAKFF5E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1haaCc_1709510028;
Received: from 192.168.71.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1haaCc_1709510028)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 07:53:49 +0800
Message-ID: <5ed37c5a-69ee-4b09-acd6-e39c3f0286d0@linux.alibaba.com>
Date: Mon, 4 Mar 2024 07:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <0000000000002be12a0611ca7ff8@google.com>
 <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
 <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/3 22:54, Tetsuo Handa wrote:
> On 2024/02/20 19:40, Roberto Sassu wrote:
>> On Mon, 2024-02-19 at 22:41 -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=135ba81c180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
>> I would add the VFS people in CC, in case they have some ideas.
> 
> This is an erofs bug. Since the filesystem image in the reproducer
> is crafted, decompression generates bogus result and
> z_erofs_transform_plain() misbehaves.

Yes, thanks for looking into this.  It seems it was introduced by
a new commit 1ca01520148a this cycle, let me find more clues and
make a fix for this.

Thanks,
Gao Xiang

> 
> You can obtain a single-threaded reproducer from
> https://syzkaller.appspot.com/x/repro.c?x=1256096a180000 with below diff.
> 
> ----------------------------------------
> --- old/1256096a180000.c
> +++ new/1256096a180000.c
> @@ -676,6 +676,6 @@
>     syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>             /*offset=*/0ul);
> -  loop();
> +  execute_one();
>     return 0;
>   }
> ----------------------------------------
> 
> With CONFIG_EROFS_FS_DEBUG=y, the reproducer hits DBG_BUGON().
> With debug printk() shown below, you can get output shown below.
> 
> ----------------------------------------
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..f221133a0731 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>   	u8 *kin;
>   
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize) {
> +		pr_err("rq->inputsize=%u rq->outputsize=%u\n", rq->inputsize, rq->outputsize);
> +		pr_err("rq->pageofs_in=%u rq->pageofs_out=%u\n", rq->pageofs_in, rq->pageofs_out);
> +		pr_err("nrpages_in=%u nrpages_out=%u\n", nrpages_in, nrpages_out);
> +	}
>   	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>   		cur = bs - (rq->pageofs_out & (bs - 1));
>   		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
> @@ -352,7 +356,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		do {
>   			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
>   			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
> -			DBG_BUGON(no >= nrpages_out);
> +			if (no >= nrpages_out)
> +				pr_err("no=%u nrpages_out=%u\n", no, nrpages_out);
>   			cnt = min(insz - pi, PAGE_SIZE - po);
>   			if (rq->out[no] == rq->in[ni]) {
>   				memmove(kin + po,
> @@ -366,7 +371,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		} while (pi < insz);
>   		kunmap_local(kin);
>   	}
> -	DBG_BUGON(ni > nrpages_in);
> +	if (ni > nrpages_in)
> +		pr_err("ni=%u nrpages_in=%u\n", ni, nrpages_in);
>   	return 0;
>   }
>   
> ----------------------------------------
> 
> ----------------------------------------
> [  138.991810][ T2983] loop0: detected capacity change from 0 to 16
> [  139.804002][ T2983] erofs: (device loop0): mounted with root inode @ nid 36.
> [  139.810464][   T87] erofs: rq->inputsize=4096 rq->outputsize=8194
> [  139.821540][   T87] erofs: rq->pageofs_in=0 rq->pageofs_out=0
> [  139.824347][   T87] erofs: nrpages_in=1 nrpages_out=3
> [  139.827008][   T87] erofs: ni=3 nrpages_in=1
> [  139.873777][ T2983] =====================================================
> [  139.881268][ T2983] BUG: KMSAN: uninit-value in ima_add_template_entry+0x626/0xa80
> ----------------------------------------
> 
> #syz set subsystems: erofs
