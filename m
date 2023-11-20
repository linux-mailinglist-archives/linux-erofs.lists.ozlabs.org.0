Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D507F0ADC
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 04:18:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oIfeAgWR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYXlN6wS9z3cPS
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 14:18:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oIfeAgWR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYXlG0Z5Nz3c76
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 14:18:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 565D260B73;
	Mon, 20 Nov 2023 03:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1A8C433C7;
	Mon, 20 Nov 2023 03:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700450291;
	bh=8XwKCm9UP/VzeRcoLOhdlRbg4sYFffZ3ibiushCy1yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oIfeAgWRpDjBoZG4r2u9wsAYFfU9/c29QTbXUwJF2NGYf/ONgIKzAohe3SMVfxa8n
	 ivf5xgbudyhDqAbBblF4Shw+IX86bjwj8tZ+2DIfpU7Lv5ZAnw4Yg5JT3W/F4GYLlm
	 bt3bQm4yF5EAKMWTr5q9VEjyKKu1IfbZXwyxUlLVX6GUBAg/DgrYyngTiHauaDXv32
	 oTXDEzyavSMu04YPp2NrVuVZBCpTl+6p2jty6Q/WpmtU3OsJDNSMiArKSVxAZgrSE7
	 hCRfA3iIVc9C16pdqyWNNVcB1ezreJ2zNdlikEN4NAr9N0tKo2gczyBji7J1eeESCK
	 k0bxyQRe0W2JA==
Message-ID: <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
Date: Mon, 20 Nov 2023 11:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add EROFS webpage
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/11/17 16:53, Gao Xiang wrote:
> Add a new `W:` field of the EROFS entry points to the documentation
> site at <https://erofs.docs.kernel.org>.
> 
> In addition, update the in-tree documentation and Kconfig too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Nice work!

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   Documentation/filesystems/erofs.rst | 4 ++++
>   MAINTAINERS                         | 1 +
>   fs/erofs/Kconfig                    | 2 +-
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 57c6ae23b3fc..cc4626d6ee4f 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -91,6 +91,10 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
>   
>   - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>   
> +For more information, please also refer to the documentation site:
> +
> +- https://erofs.docs.kernel.org
> +
>   Bugs and patches are welcome, please kindly help us and send to the following
>   linux-erofs mailing list:
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..cf39d16ad22a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7855,6 +7855,7 @@ R:	Yue Hu <huyue2@coolpad.com>
>   R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
> +W:	https://erofs.docs.kernel.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>   F:	Documentation/ABI/testing/sysfs-fs-erofs
>   F:	Documentation/filesystems/erofs.rst
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index e540648dedc2..1d318f85232d 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -21,7 +21,7 @@ config EROFS_FS
>   	  performance under extremely memory pressure without extra cost.
>   
>   	  See the documentation at <file:Documentation/filesystems/erofs.rst>
> -	  for more details.
> +	  and the web pages at <https://erofs.docs.kernel.org> for more details.
>   
>   	  If unsure, say N.
>   
