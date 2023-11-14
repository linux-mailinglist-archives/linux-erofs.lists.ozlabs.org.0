Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A97EAAFD
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 08:41:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STysV4rnCz3c2H
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 18:41:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STysN04pTz2xdZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 18:41:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VwOoltt_1699947662;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwOoltt_1699947662)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 15:41:03 +0800
Message-ID: <d997f776-2b20-f38c-1347-c8734cc4e467@linux.alibaba.com>
Date: Tue, 14 Nov 2023 15:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/14 15:07, Jingbo Xu wrote:
> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:erofs_map_dev+0xbd/0x1c0
>   Call Trace:
>    <TASK>
>    erofs_fscache_data_read_slice+0xa7/0x340
>    erofs_fscache_data_read+0x11/0x30
>    erofs_fscache_readahead+0xd9/0x100
>    read_pages+0x47/0x1f0
>    page_cache_ra_order+0x1e5/0x270
>    filemap_get_pages+0xf2/0x5f0
>    filemap_read+0xb8/0x2e0
>    vfs_read+0x18d/0x2b0
>    ksys_read+0x53/0xd0
>    do_syscall_64+0x42/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
