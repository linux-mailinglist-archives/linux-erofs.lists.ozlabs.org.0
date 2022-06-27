Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAD55B81C
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 09:12:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LWf7Q3wqqz305M
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 17:12:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=meizu.com (client-ip=112.91.151.210; helo=mail.meizu.com; envelope-from=chenyuwen1@meizu.com; receiver=<UNKNOWN>)
X-Greylist: delayed 67 seconds by postgrey-1.36 at boromir; Mon, 27 Jun 2022 17:12:30 AEST
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LWf7L0n7gz2xKj
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jun 2022 17:12:29 +1000 (AEST)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 27 Jun
 2022 15:11:05 +0800
Received: from [172.16.32.26] (172.16.32.26) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 27 Jun
 2022 15:11:04 +0800
Message-ID: <eef55261-753a-ac49-b237-eaea15e7c1d6@meizu.com>
Date: Mon, 27 Jun 2022 15:11:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: wake up all waiters after z_erofs_lzma_head ready
Content-Language: en-US
To: <hsiangkao@linux.alibaba.com>
References: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
 <20220626224041.4288-1-chenyuwen1@meizu.com>
From: Yuwen Chen <chenyuwen1@meizu.com>
In-Reply-To: <20220626224041.4288-1-chenyuwen1@meizu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.32.26]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The new patch has been upload. The modification points are as follower:

1. delete the period.

2. change 'W' to lowercase.

3. add a Reviewed-by tag.

On 6/27/22 06:40, Yuwen Chen wrote:
> When the user mounts the erofs second times, the decompression thread
> may hung. The problem happens due to a sequence of steps like the
> following:
>
> 1) Task A called z_erofs_load_lzma_config which obtain all of the node
>     from the z_erofs_lzma_head.
>
> 2) At this time, task B called the z_erofs_lzma_decompress and wanted to
>     get a node. But the z_erofs_lzma_head was empty, the Task B had to
>     sleep.
>
> 3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
>     task B was still sleeping.
>
> One example report when the hung happens:
> task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>   <TASK>
>   __schedule+0x281/0x760
>   schedule+0x49/0xb0
>   z_erofs_lzma_decompress+0x4bc/0x580
>   ? cpu_core_flags+0x10/0x10
>   z_erofs_decompress_pcluster+0x49b/0xba0
>   ? __update_load_avg_se+0x2b0/0x330
>   ? __update_load_avg_se+0x2b0/0x330
>   ? update_load_avg+0x5f/0x690
>   ? update_load_avg+0x5f/0x690
>   ? set_next_entity+0xbd/0x110
>   ? _raw_spin_unlock+0xd/0x20
>   z_erofs_decompress_queue.isra.0+0x2e/0x50
>   z_erofs_decompressqueue_work+0x30/0x60
>   process_one_work+0x1d3/0x3a0
>   worker_thread+0x45/0x3a0
>   ? process_one_work+0x3a0/0x3a0
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
>
> Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/decompressor_lzma.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 05a3063cf2bc..5e59b3f523eb 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
>   	DBG_BUGON(z_erofs_lzma_head);
>   	z_erofs_lzma_head = head;
>   	spin_unlock(&z_erofs_lzma_lock);
> +	wake_up_all(&z_erofs_lzma_wq);
>   
>   	z_erofs_lzma_max_dictsize = dict_size;
>   	mutex_unlock(&lzma_resize_mutex);
