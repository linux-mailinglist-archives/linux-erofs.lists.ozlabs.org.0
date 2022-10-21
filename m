Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EB6072CC
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:48:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtym45gbTz2xG7
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:48:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtym06BwZz2xG7
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:47:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VSijGYI_1666342072;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSijGYI_1666342072)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:47:54 +0800
Date: Fri, 21 Oct 2022 16:47:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fix general protection fault when reading fragment
Message-ID: <Y1Jct+8SnhawtIqJ@B-P7TQMD6M-0146.local>
References: <20221021083116.20048-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021083116.20048-1-zbestahu@gmail.com>
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
Cc: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 21, 2022 at 04:31:16PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> As syzbot reported [1], the fragment feature sb flag is not set, so
> packed_inode != NULL needs to be checked in z_erofs_read_fragment().
> 
> [1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/
> 
> Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/erofs/zdata.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index cce56dde135c..310f6916787a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
>  	u8 *src, *dst;
>  	unsigned int i, cnt;
>  
> +	if (!packed_inode)
> +		return -EFAULT;

You should use -EFSCURRUPTED; here.

Thanks,
Gao Xiang

> +
>  	pos += EROFS_I(inode)->z_fragmentoff;
>  	for (i = 0; i < len; i += cnt) {
>  		cnt = min_t(unsigned int, len - i,
> -- 
> 2.17.1
