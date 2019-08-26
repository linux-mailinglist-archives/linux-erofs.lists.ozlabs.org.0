Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7739D195
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 16:24:50 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HDmH1c3zzDqFh
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 00:24:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DJGGT7qL"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HD2C0jlbzDqcl
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2019 23:51:44 +1000 (AEST)
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4851F217F5;
 Mon, 26 Aug 2019 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566827501;
 bh=wDfyXIBnwA8sKvOUkduyKciiIMqNec9f7nzYXncOUMc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=DJGGT7qLzAsMVHincMsuYuzSugIWRNFgTdXCKVbUE/dY2fN5cOnVCEwS3orLYNGEC
 nNiGlrwQY9GsaWDqZy0cMZEH8H9Cyz/3quzgw7+qrLd0ACjLZYzCsaBBx2kUmeEL/H
 Jh5Ez4MiSnWq6+EJVXHlFucOeaeYohbr4xMhJd1E=
Subject: Re: [PATCH RESEND] erofs: fix compile warnings when moving out
 include/trace/events/erofs.h
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
 <20190826132653.100731-1-gaoxiang25@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
Date: Mon, 26 Aug 2019 21:51:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190826132653.100731-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019-8-26 21:26, Gao Xiang wrote:
> As Stephon reported [1], many compile warnings are raised when
> moving out include/trace/events/erofs.h:
> 
> In file included from include/trace/events/erofs.h:8,
>                  from <command-line>:
> include/trace/events/erofs.h:28:37: warning: 'struct dentry' declared inside parameter list will not be visible outside of this definition or declaration
>   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
>                                      ^~~~~~
> include/linux/tracepoint.h:233:34: note: in definition of macro '__DECLARE_TRACE'
>   static inline void trace_##name(proto)    \
>                                   ^~~~~
> include/linux/tracepoint.h:396:24: note: in expansion of macro 'PARAMS'
>   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
>                         ^~~~~~
> include/linux/tracepoint.h:532:2: note: in expansion of macro 'DECLARE_TRACE'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>   ^~~~~~~~~~~~~
> include/linux/tracepoint.h:532:22: note: in expansion of macro 'PARAMS'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>                       ^~~~~~
> include/trace/events/erofs.h:26:1: note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(erofs_lookup,
>  ^~~~~~~~~~~
> include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
>   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
>   ^~~~~~~~
> 
> That makes me very confused since most original EROFS tracepoint code
> was taken from f2fs, and finally I found
> 
> commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")
> 
> It seems these warnings are generated from KERNEL_HEADER_TEST feature and
> ext4/f2fs tracepoint files were in blacklist.

For f2fs.h, it will be only used by f2fs module, I guess it's okay to let it
stay in blacklist...

> 
> Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
> of adding to blacklist...
> 
> [1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
