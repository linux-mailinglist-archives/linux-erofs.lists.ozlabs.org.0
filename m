Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F15820975
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 02:14:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T2h3L2MjNz3cLL
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 12:14:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T2h3F6q43z2y1Y
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Dec 2023 12:14:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzViQy2_1703985251;
Received: from 192.168.70.84(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzViQy2_1703985251)
          by smtp.aliyun-inc.com;
          Sun, 31 Dec 2023 09:14:12 +0800
Message-ID: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
Date: Sun, 31 Dec 2023 09:14:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
References: <000000000000321c24060d7cfa1c@google.com>
 <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
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
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/29 19:09, Edward Adam Davis wrote:
> When LZ4 decompression fails, the number of bytes read from out should be
> inputsize plus the returned overflow value ret.
> 
> Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/erofs/decompressor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 021be5feb1bc..8ac3f96676c4 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>   		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
>   			       16, 1, src + inputmargin, rq->inputsize, true);
>   		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
> -			       16, 1, out, rq->outputsize, true);
> +			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
> +			       (ret + rq->inputsize) : rq->outputsize, true);

It's incorrect since output decompressed buffer has no relationship
with `rq->inputsize` and `ret + rq->inputsize` is meaningless too.

Also, the issue was already fixed by avoiding debugging messages as
https://lore.kernel.org/r/20231227151903.2900413-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang
