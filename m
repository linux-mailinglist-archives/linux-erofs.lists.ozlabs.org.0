Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03555A890
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jun 2022 11:45:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LVTcN2bqLz3byP
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jun 2022 19:45:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LVTcD1X65z2yT0
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jun 2022 19:44:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHKrxCi_1656150289;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHKrxCi_1656150289)
          by smtp.aliyun-inc.com;
          Sat, 25 Jun 2022 17:44:50 +0800
Date: Sat, 25 Jun 2022 17:44:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Even <cheny_wen@126.com>
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
References: <20220625085738.12834-1-cheny_wen@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625085738.12834-1-cheny_wen@126.com>
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
Cc: Even <chenyuwen1@meizu.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Sat, Jun 25, 2022 at 04:57:38PM +0800, Even wrote:
> From: Even <chenyuwen1@meizu.com>
> 
> When the user mounts the erofs second times, the decompression thread
> may hung. The problem happens due to a sequence of steps like the
> following:
> 
> 1) Task A called z_erofs_load_lzma_config which obtain all of the node
>    from the z_erofs_lzma_head.
> 
> 2) At this time, task B called the z_erofs_lzma_decompress and wanted to
>    get a node. But the z_erofs_lzma_head was empty, the Task B had to
>    sleep.
> 
> 3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
>    task B was still sleeping.
> 
> One example report when the hung happens:
> task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>  <TASK>
>  __schedule+0x281/0x760
>  schedule+0x49/0xb0
>  z_erofs_lzma_decompress+0x4bc/0x580
>  ? cpu_core_flags+0x10/0x10
>  z_erofs_decompress_pcluster+0x49b/0xba0
>  ? __update_load_avg_se+0x2b0/0x330
>  ? __update_load_avg_se+0x2b0/0x330
>  ? update_load_avg+0x5f/0x690
>  ? update_load_avg+0x5f/0x690
>  ? set_next_entity+0xbd/0x110
>  ? _raw_spin_unlock+0xd/0x20
>  z_erofs_decompress_queue.isra.0+0x2e/0x50
>  z_erofs_decompressqueue_work+0x30/0x60
>  process_one_work+0x1d3/0x3a0
>  worker_thread+0x45/0x3a0
>  ? process_one_work+0x3a0/0x3a0
>  kthread+0xe2/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> Signed-off-by: Even <chenyuwen1@meizu.com>

Thanks a lot for catching this!

The patch itself looks good, but could you use your real name to sign
off the patch and resend a version? see,
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
