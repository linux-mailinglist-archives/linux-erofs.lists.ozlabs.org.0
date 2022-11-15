Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BF6290C7
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 04:25:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBBPq0rjcz3cFP
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 14:25:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBBPj1BBnz2xf6
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Nov 2022 14:24:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUrQ.jq_1668482688;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUrQ.jq_1668482688)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 11:24:49 +0800
Date: Tue, 15 Nov 2022 11:24:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Siddh Raman Pant <code@siddh.me>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Message-ID: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs <linux-erofs@lists.ozlabs.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20221114120349.472418-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114120349.472418-1-code@siddh.me>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 14, 2022 at 05:33:49PM +0530, Siddh Raman Pant wrote:
> The following calculation of iomap->length on line 798 in
> z_erofs_iomap_begin_report() can yield 0:
> 	if (iomap->offset >= inode->i_size)
> 		iomap->length = length + map.m_la - offset;
> 
> This triggers a WARN_ON in iomap_iter_done() (see line 34 of
> fs/iomap/iter.c).
> 
> Hence, return error when this scenario is encountered.
> 
> ============================================================
> 
> This was reported as a crash by syzbot under an issue about
> warning encountered in iomap_iter_done(), but unrelated to
> erofs. Hence, not adding issue hash in Reported-by line.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  fs/erofs/zmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..bad852983eb9 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -796,6 +796,9 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
>  		 */
>  		if (iomap->offset >= inode->i_size)
>  			iomap->length = length + map.m_la - offset;
> +
> +		if (iomap->length == 0)

I just wonder if we should return -EINVAL for post-EOF cases or
IOMAP_HOLE with arbitrary length?

Thanks,
Gao Xiang

> +			return -EINVAL;
>  	}
>  	iomap->flags = 0;
>  	return 0;
> -- 
> 2.35.1
> 
