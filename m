Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B84EFE0A
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Apr 2022 04:53:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KVhSb4lCxz3004
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Apr 2022 13:53:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KVhSW0cWnz2xTp
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Apr 2022 13:53:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V8xeXmT_1648868008; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V8xeXmT_1648868008) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 02 Apr 2022 10:53:29 +0800
Date: Sat, 2 Apr 2022 10:53:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Subject: Re: [PATCH v2] erofs: fix use-after-free of on-stack io[]
Message-ID: <Yke6p7EHG2NNETAA@B-P7TQMD6M-0146.local>
References: <20220401115527.4935-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401115527.4935-1-hongyu.jin.cn@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 01, 2022 at 07:55:27PM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The root cause is the race as follows:
> Thread #1                              Thread #2(irq ctx)
> 
> z_erofs_runqueue()
>   struct z_erofs_decompressqueue io_A[];
>   submit bio A
>   z_erofs_decompress_kickoff(,,1)
>                                        z_erofs_decompressqueue_endio(bio A)
>                                        z_erofs_decompress_kickoff(,,-1)
>                                        spin_lock_irqsave()
>                                        atomic_add_return()
>   io_wait_event()   -> pending_bios is already 0
>   [end of function]
>                                        wake_up_locked(io_A[]) // crash

Actually I think it can be written like this to simplify the case a
bit.

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

Looks good to me!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Let me test it this weekend and upstream it this cycle.

Thanks,
Gao Xiang
