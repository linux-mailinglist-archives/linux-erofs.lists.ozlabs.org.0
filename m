Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CD7BFCE3
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Oct 2023 15:06:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S4bkr0L4jz3cG5
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Oct 2023 00:06:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S4bkg3KxVz3cBN
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Oct 2023 00:06:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vtsp-iy_1696943168;
Received: from 30.25.224.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vtsp-iy_1696943168)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 21:06:11 +0800
Message-ID: <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
Date: Tue, 10 Oct 2023 21:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231010113915.436591-1-tiwei.btw@antgroup.com>
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
Cc: linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tiwei,

On 2023/10/10 19:39, Tiwei Bie via Linux-erofs wrote:
> Xattrs, extents, data inline are _placed after_, not _followed by_ the
> corresponding inode. This patch fixes it

Thanks for the patch and sorry about my terrible English...

> 
> Fixes: fdb0536469cb ("staging: erofs: add document")

I'm not sure if it's necessary to tag document fixes anyway
since docs.kernel.org already uses the latest version and
`.rst` format is adapted much later..

I will drop this tag for the next merge window if not urgent.

> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   Documentation/filesystems/erofs.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index f200d7874495..57c6ae23b3fc 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
>                                           |                  |
>                                           |__________________| 64 bytes
>   
> -    Xattrs, extents, data inline are followed by the corresponding inode with
> +    Xattrs, extents, data inline are placed after the corresponding inode with
>       proper alignment, and they could be optional for different data mappings.
>       _currently_ total 5 data layouts are supported:
>   
