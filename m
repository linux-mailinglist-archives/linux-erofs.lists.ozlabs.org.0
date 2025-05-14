Return-Path: <linux-erofs+bounces-317-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF87AB6A87
	for <lists+linux-erofs@lfdr.de>; Wed, 14 May 2025 13:52:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyBXV5gGhz2yqW;
	Wed, 14 May 2025 21:52:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747223530;
	cv=none; b=QZjCkHozm+hGdT66hDGyGhJbE8WaLzbDbWGSWBdsatLnMpJSnUqTGerk5YmOkOwNp8Xn0tZA3p5EHBvrzhgAjep3dLxpxyfjFFkjKqK+muYZz3/ZcScFUUcDAEY/pdvrGH6GzUN/hwRTkdg8uS7T1Ss19BNCjPs5i5pRdsUZYE7e2a9PM43VGjgk9++THblOk/f5STCYYHjy1ebWKXjuWsRKfXZn/AeIIU1Xx4juqpEQk3JoGxWiomj1q7DGKASNQ+BUMWMtbu0E+y5T6y9cbycrMWtnoiYPoNefkP7bJHsIgafJ+z0TWkwx7hGOEbDwZO8QQ++4AvL1xLASpQEbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747223530; c=relaxed/relaxed;
	bh=/QDkqHbGcD+TMq3shCe5JVRzKlFBnQK6t8dDql3URHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWWuK7hJiI7rxZ/sYnSl8d11jAFQ45sw7+Ye+KTi89hsFYv7iv53Y1BsRFFiinMHGKZ4s8L2SDte1hE3QoRrjzy5cK5JXI9cqQUV+/wM5CEVXp0E02+dgtv6PDFXFLsYi8JSzmDhYgRE/jDtZR1w3cAWsQ5SiczKXwEXCAktdtXN2KCbPhZknKSeq8vEJfKIwXsHT8fYdNnqo3XBZxnWiKs7Qmh6ssMkngtAQfk5c5DN02msskmHQRbMYxlHbPObllAJdRDFLszNIVf/kzaVgN4TW9FP5OhFwirtOpKb81YTMfgBTO8h8gdAt/lONvD2XpwKmAsUkWZzgRktf7y++w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x5mDTxr5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x5mDTxr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyBXS4m01z2yTK
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 21:52:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747223523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/QDkqHbGcD+TMq3shCe5JVRzKlFBnQK6t8dDql3URHk=;
	b=x5mDTxr53E4DEJkYGH6sy1ELRxzmLyOR203rk9llTsnLEXm9Pj3xFnCaH7HRTg84DjNg1RINEG8m7Cw9E6krXjW+V48Phk1MLQbpT0PghGxl2KfxOtu2MA/oddS65eaEKksRKRpO03fdq2KHfs2AIg102UEk0Gs9WfZfESxW31o=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WalxjuG_1747223520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 May 2025 19:52:01 +0800
Message-ID: <a18463df-a63b-4bdd-af85-bd8435cb23e7@linux.alibaba.com>
Date: Wed, 14 May 2025 19:51:59 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: avoid using multiple devices with different
 type
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, lihongbo22@huawei.com,
 dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
 <20250513113418.249798-2-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250513113418.249798-2-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong,

On 2025/5/13 19:34, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> For multiple devices, both primary and extra devices should be the
> same type. `erofs_init_device` has already guaranteed that if the
> primary is a file-backed device, extra devices should also be
> regular files.
> 
> However, if the primary is a block device while the extra device
> is a file-backed device, `erofs_init_device` will get an ENOTBLK,
> which is not treated as an error in `erofs_fc_get_tree`, and that
> leads to an UAF:
> 
>    erofs_fc_get_tree
>      get_tree_bdev_flags(erofs_fc_fill_super)
>        erofs_read_superblock
>          erofs_init_device  // sbi->dif0 is not inited yet,
>                             // return -ENOTBLK
>        deactivate_locked_super
>          free(sbi)
>      if (err is -ENOTBLK)
>        sbi->dif0.file = filp_open()  // sbi UAF
> 
> So if -ENOTBLK is hitted in `erofs_init_device`, it means the
> primary device must be a block device, and the extra device
> is not a block device. The error can be converted to -EINVAL.

Yeah, nice catch.

As Hongbo said, it'd be better to add "Fixes:" tag
in the next version.

> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> ---
>   fs/erofs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 512877d7d855..16b5b1f66584 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
>   				bdev_file_open_by_path(dif->path,
>   						BLK_OPEN_READ, sb->s_type, NULL);
> -		if (IS_ERR(file))
> +		if (IS_ERR(file)) {
> +			if (PTR_ERR(file) == -ENOTBLK)

It's preferred to use:
			if (file == ERR_PTR(-ENOTBLK))
				return -EINVAL;

Otherwise it looks good to me.

Could you submit it as a seperate patch so I
could apply directly?

Thanks,
Gao Xiang


