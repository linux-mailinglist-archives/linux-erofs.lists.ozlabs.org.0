Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B86B26E3
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:28:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXWl93GPqz3cd9
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:28:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nX/ZyQ73;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nX/ZyQ73;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXWl30hTzz3c7l
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:28:47 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D465F618B6;
	Thu,  9 Mar 2023 14:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48E8C433EF;
	Thu,  9 Mar 2023 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678372123;
	bh=60Yf7G5xHK2RG+spG0/BSdW4iD21Ab+2egSl11944Fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nX/ZyQ73OyiDDKJUkdEz83IGJr1eBcTpyYRAPffY7e1Mv1sErbrGI9cI5aVGBj5bB
	 IzXBakAnH9KM9uHObPyOgHaZ0Jw/9UsuyHpn8tnsKqp2J8dNaMjcZzDwZjlEFc+ItJ
	 dPNEBSeyeRblX7RsflzsH0ySrhmuPWNq+ziIiO2Q7YCRl1J6CEIfZf3rEhFh1ZkiNJ
	 LCBa9pleX5WUSUc83lylFwPs3QChut6LiOpkEdSwSwUFOYcy4anyzkAgbc/Ljt5lQ0
	 jLnmz3Xs1GCNizg4Pri2GjPXacyTlaRtMOaAg5VsV64NuhnFYxF87NuWeYGIiuZ1Mt
	 vkPo5klVaD/vg==
Message-ID: <b9ddc3ff-ddfa-846b-61f8-cdcfcb71510e@kernel.org>
Date: Thu, 9 Mar 2023 22:28:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: fix wrong kunmap when using LZMA on HIGHMEM
 platforms
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230305134455.88236-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230305134455.88236-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/5 21:44, Gao Xiang wrote:
> As the call trace shown, the root cause is kunmap incorrect pages:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000
>   CPU: 1 PID: 40 Comm: kworker/u5:0 Not tainted 6.2.0-rc5 #4
>   Workqueue: erofs_worker z_erofs_decompressqueue_work
>   EIP: z_erofs_lzma_decompress+0x34b/0x8ac
>    z_erofs_decompress+0x12/0x14
>    z_erofs_decompress_queue+0x7e7/0xb1c
>    z_erofs_decompressqueue_work+0x32/0x60
>    process_one_work+0x24b/0x4d8
>    ? process_one_work+0x1a4/0x4d8
>    worker_thread+0x14c/0x3fc
>    kthread+0xe6/0x10c
>    ? rescuer_thread+0x358/0x358
>    ? kthread_complete_and_exit+0x18/0x18
>    ret_from_fork+0x1c/0x28
>   ---[ end trace 0000000000000000 ]---
> 
> The bug is trivial and should be fixed now.  It has no impact on
> !HIGHMEM platforms.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
