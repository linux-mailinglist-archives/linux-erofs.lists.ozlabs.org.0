Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C37BFBAB
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Oct 2023 14:44:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S4bFg3HKBz3cDn
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Oct 2023 23:44:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S4bFW47gQz30MQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Oct 2023 23:44:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vtsrq3Q_1696941857;
Received: from 30.221.148.233(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vtsrq3Q_1696941857)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 20:44:18 +0800
Message-ID: <d32b6812-8b54-564b-17d0-5bc6d0661fe1@linux.alibaba.com>
Date: Tue, 10 Oct 2023 20:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
Content-Language: en-US
In-Reply-To: <20231010113915.436591-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 10/10/23 7:39 PM, Tiwei Bie wrote:
> Xattrs, extents, data inline are _placed after_, not _followed by_ the
> corresponding inode. This patch fixes it.
> 
> Fixes: fdb0536469cb ("staging: erofs: add document")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>  Documentation/filesystems/erofs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index f200d7874495..57c6ae23b3fc 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
>                                          |                  |
>                                          |__________________| 64 bytes
>  
> -    Xattrs, extents, data inline are followed by the corresponding inode with
> +    Xattrs, extents, data inline are placed after the corresponding inode with
>      proper alignment, and they could be optional for different data mappings.
>      _currently_ total 5 data layouts are supported:
>  

Thanks for catching it!

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
