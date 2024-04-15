Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC98A498D
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 09:58:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pIXRSX0+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJ00p4dmDz3dT4
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 17:58:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pIXRSX0+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJ00l3YLXz2xQL
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 17:58:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C6AB1CE098D;
	Mon, 15 Apr 2024 07:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D79C113CC;
	Mon, 15 Apr 2024 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713167908;
	bh=1yWYTIeT3SuBLjY4mcEEgkFO+HrksPtdCjRmaLqZXzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIXRSX0+3mvAJhMmwWaZOHpC9tHqaidcXHpWeGi51YbMN53RfJQHvsIAMbjt7t5U7
	 Tg6oWKiQkJ7J6j2fKHUcPGputkhKxbvrytmv4GPBY3qoVZLfyLap1batqqqbBgO39X
	 /aaC0/bD5UGX2GnGRADRUFAvcF5Wo0wExtUKSiZHPtvFgYFn0U+5UAf9bOI4ruNlWc
	 vo/EG77UDYQVWtObnWrPs/nZQfO+dxdaAMTXRdADS2VyhQSI4o39aD6+fQ+D657RzM
	 XM3RHpYj9A010Mfv4V9bz4ZpeH4+FNg+23IeAy2oHKFTXDwXcYwxL3uryk7cednOsL
	 +uezGmiylQTdA==
Date: Mon, 15 Apr 2024 15:58:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] erofs: Consider NUMA affinity when allocating memory for
 per-CPU pcpubuf
Message-ID: <ZhzeIgG6Xu46hrF/@debian>
Mail-Followup-To: Li RongQing <lirongqing@baidu.com>, xiang@kernel.org,
	chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org
References: <20240415061940.56864-1-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240415061940.56864-1-lirongqing@baidu.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi RongQing,

On Mon, Apr 15, 2024 at 02:19:40PM +0800, Li RongQing wrote:
> per-CPU pcpubufs are dominantly accessed from their own local CPUs,
> so allocate them node-local to improve performance.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Thanks for your patch!  Yeah, NUMA-aware is important to
NUMA bare metal server scenarios.

In the next cycle, we also reduce the total number of buffers
since we don't such many per-CPU buffers if there are too many
CPUs: we called "global buffers" and maintain CPU->global
buffer mappings.  Also erofs_allocpage() won't be used to
allocate too.

For more details, see my for-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/log/?h=dev

So could you make some difference to make the new global
buffers NUMA-aware? (both for allocation and mapping, maybe
the allocation is still a priority stuff if per-CPU is needed
anyway.)

Thanks,
Gao Xiang
