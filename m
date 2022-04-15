Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D247502A89
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 14:52:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kfx6z4mM5z3bWt
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 22:52:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TNsLiXG/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TNsLiXG/; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kfx6w5Kwnz2xDY
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Apr 2022 22:52:08 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F283961E6E;
 Fri, 15 Apr 2022 12:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D88C385A5;
 Fri, 15 Apr 2022 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650027125;
 bh=DDiEazOjfivTGxnFqvTt/+OO73WuD4gdXgNtxDxFHHY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TNsLiXG/YjsRPY2ENFacbs3bqSTWx01n7LIWfpSud6PDvqeXIZPF1hBT3/wOgsuv5
 IXi379DyrBSNKeZflH6Sbgb26Htqh49Gq/CjgrsiemL/CX1CCSpho9TpYkOs6y9LkU
 eSjUgs4TRqo3qkFx3aYc7V+29HTtPWX58kabm85bXUklNdXYjI1il5hkqvaWnszwDC
 uiXQfNnJaz84j/5/uglKaWL8DCSIICHQqSjxP0Yy6PUzZiBdUDb1/TefgtbEO9qIXI
 EykxUn36YkIv05EpbBi3yKRkjm+RnuCTvFQSqoxY0M8/kG4ePoPdJBh3LpoK/qNMPk
 NM6w96ehdXu8w==
Message-ID: <f83fcb91-0cbb-073c-a4a0-8edabcaa6ca7@kernel.org>
Date: Fri, 15 Apr 2022 20:52:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] erofs: fix use-after-free of on-stack io[]
Content-Language: en-US
To: Hongyu Jin <hongyu.jin.cn@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20220401115527.4935-1-hongyu.jin.cn@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220401115527.4935-1-hongyu.jin.cn@gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/4/1 19:55, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The root cause is the race as follows:
> Thread #1                              Thread #2(irq ctx)
> 
> z_erofs_runqueue()
>    struct z_erofs_decompressqueue io_A[];
>    submit bio A
>    z_erofs_decompress_kickoff(,,1)
>                                         z_erofs_decompressqueue_endio(bio A)
>                                         z_erofs_decompress_kickoff(,,-1)
>                                         spin_lock_irqsave()
>                                         atomic_add_return()
>    io_wait_event()
>    [end of function]
> z_erofs_runqueue() // bio B
>                                         wake_up_locked(io_A[]) // crash
>    struct z_erofs_decompressqueue io_B[];
>    submit bio B
>    z_erofs_decompress_kickoff(,,1)
> 
> Backtrace in kernel5.4:
> [   10.129413] 8<--- cut here ---
> [   10.129422] Unable to handle kernel paging request at virtual address eb0454a4
> [   10.364157] CPU: 0 PID: 709 Comm: getprop Tainted: G        WC O      5.4.147-ab09225 #1
> [   11.556325] [<c01b33b8>] (__wake_up_common) from [<c01b3300>] (__wake_up_locked+0x40/0x48)
> [   11.565487] [<c01b3300>] (__wake_up_locked) from [<c044c8d0>] (z_erofs_vle_unzip_kickoff+0x6c/0xc0)
> [   11.575438] [<c044c8d0>] (z_erofs_vle_unzip_kickoff) from [<c044c854>] (z_erofs_vle_read_endio+0x16c/0x17c)
> [   11.586082] [<c044c854>] (z_erofs_vle_read_endio) from [<c06a80e8>] (clone_endio+0xb4/0x1d0)
> [   11.595428] [<c06a80e8>] (clone_endio) from [<c04a1280>] (blk_update_request+0x150/0x4dc)
> [   11.604516] [<c04a1280>] (blk_update_request) from [<c06dea28>] (mmc_blk_cqe_complete_rq+0x144/0x15c)
> [   11.614640] [<c06dea28>] (mmc_blk_cqe_complete_rq) from [<c04a5d90>] (blk_done_softirq+0xb0/0xcc)
> [   11.624419] [<c04a5d90>] (blk_done_softirq) from [<c010242c>] (__do_softirq+0x184/0x56c)
> [   11.633419] [<c010242c>] (__do_softirq) from [<c01051e8>] (irq_exit+0xd4/0x138)
> [   11.641640] [<c01051e8>] (irq_exit) from [<c010c314>] (__handle_domain_irq+0x94/0xd0)
> [   11.650381] [<c010c314>] (__handle_domain_irq) from [<c04fde70>] (gic_handle_irq+0x50/0xd4)
> [   11.659641] [<c04fde70>] (gic_handle_irq) from [<c0101b70>] (__irq_svc+0x70/0xb0)
> 
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
