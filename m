Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3F47AD66
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 15:53:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHjJj6QzCz2ynY
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 01:53:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHjJb5lDyz2yY7
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 01:53:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V.Fbte-_1640011991; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.Fbte-_1640011991) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 20 Dec 2021 22:53:12 +0800
Date: Mon, 20 Dec 2021 22:53:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: Practical Limit on EROFS lcluster size
Message-ID: <YcCY1tmskGMy+QxV@B-P7TQMD6M-0146.local>
References: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Mon, Dec 20, 2021 at 08:45:42AM -0500, Kelvin Zhang wrote:
> Hi Gao,
>     I was playing with large pcluster sizes recently, I noticed a
> quirk about EROFS. In summary, logical cluster size has a practical
> limit of 8MB. Here's why:
> 
>    Looking at https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compress.c?h=experimental&id=564adb0a852b38a1790db20516862fc31bca314d#n92
> , line 92, we see the following code:
> 
> if (d0 == 1 && erofs_sb_has_big_pcluster()) {
>         type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
>         di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
>                 Z_EROFS_VLE_DI_D0_CBLKCNT); // This line
>         di.di_u.delta[1] = cpu_to_le16(d1);
> } else if (d0) {
>         type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> 
>         di.di_u.delta[0] = cpu_to_le16(d0);  // and this line
>         di.di_u.delta[1] = cpu_to_le16(d1);
> }
> 
> When a compressed index has type NOHEAD, delta[0] stores d0(distance
> to head block). But The 11th bit of d0 is also used as a flag bit to
> indicate that d0 stores the pcluster size. This means d0 cannot exceed
> Z_EROFS_VLE_DI_D0_CBLKCNT(2048), or else the parser will incorrectly
> interpret d0 as pcluster size, rather than distance to head block.
>     Is this an intentional design choice? It's not necessarily bad,
> but it's something I think is worth documenting in code.

Thanks for this great insight! Actually on-disk EROFS format doesn't
have such limitation by design, since if it looks back to the delta0
lcluster and it's still a NONHEAD lcluster, it will look back with
new delta0 again until finding the final HEAD lcluster.

But I'm not sure if mkfs code can handle > 8MiB lcluster properly yet,
without modification since lcluster size is strictly limited with
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/include/erofs/compress.h#n14
EROFS_CONFIG_COMPR_MAX_SZ * 2

Yeah, I have to admit the current document might not be so detailed,
partially due to my somewhat bad English written speed, and limited
time...

Thanks,
Gao Xiang

> 
> 
> -- 
> Sincerely,
> 
> Kelvin Zhang
