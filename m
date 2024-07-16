Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2952393202D
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 07:50:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZFjS+6vF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNSpS56Stz3cYk
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 15:50:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZFjS+6vF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNSpM1D1Kz2xQB
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 15:50:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721109013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H8zq9naPob4y2i4lL8vhQLgKLKRADgCO3+XOJHZaf6Y=;
	b=ZFjS+6vFkldUkA8j3nlSwbGOYOQR51jQddm3qxHv1BwmERSuanmOo8hyc6JzZ1HHu5Y4eu23BIMHRRF14eFeLXUNb9++YmFM9dBEER2i6a89i/A1WVtX5eR5zlefWLvoxSI1OFZIFErYNy7Jbx1OL9ukNeajtBEcXUb2uA7UcoQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAgKAfp_1721109010;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAgKAfp_1721109010)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 13:50:11 +0800
Message-ID: <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
Date: Tue, 16 Jul 2024 13:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of
 erofs_allocpage
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/16 13:44, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> scheduling while atomic was reported as below where the schedule_timeout
> comes from too_many_isolated when doing direct_reclaim. Fix this by
> masking GFP_DIRECT_RECLAIM from gfp.
> 
> [  175.610416][  T618] BUG: scheduling while atomic: kworker/u16:6/618/0x00000000
> [  175.643480][  T618] CPU: 2 PID: 618 Comm: kworker/u16:6 Tainted: G
> [  175.645791][  T618] Workqueue: loop20 loop_workfn
> [  175.646394][  T618] Call trace:
> [  175.646785][  T618]  dump_backtrace+0xf4/0x140
> [  175.647345][  T618]  show_stack+0x20/0x2c
> [  175.647846][  T618]  dump_stack_lvl+0x60/0x84
> [  175.648394][  T618]  dump_stack+0x18/0x24
> [  175.648895][  T618]  __schedule_bug+0x64/0x90
> [  175.649445][  T618]  __schedule+0x680/0x9b8
> [  175.649970][  T618]  schedule+0x130/0x1b0
> [  175.650470][  T618]  schedule_timeout+0xac/0x1d0
> [  175.651050][  T618]  schedule_timeout_uninterruptible+0x24/0x34
> [  175.651789][  T618]  __alloc_pages_slowpath+0x8dc/0x121c
> [  175.652455][  T618]  __alloc_pages+0x294/0x2fc
> [  175.653011][  T618]  erofs_allocpage+0x48/0x58
> [  175.653572][  T618]  z_erofs_runqueue+0x314/0x8a4
> [  175.654161][  T618]  z_erofs_readahead+0x258/0x318
> [  175.654761][  T618]  read_pages+0x88/0x394
> [  175.655275][  T618]  page_cache_ra_unbounded+0x1cc/0x23c
> [  175.655939][  T618]  page_cache_ra_order+0x27c/0x33c
> [  175.656559][  T618]  ondemand_readahead+0x224/0x334
> [  175.657169][  T618]  page_cache_async_ra+0x60/0x9c
> [  175.657767][  T618]  filemap_get_pages+0x19c/0x7cc
> [  175.658367][  T618]  filemap_read+0xf0/0x484
> [  175.658901][  T618]  generic_file_read_iter+0x4c/0x15c
> [  175.659543][  T618]  do_iter_read+0x224/0x348
> [  175.660100][  T618]  vfs_iter_read+0x24/0x38
> [  175.660635][  T618]  loop_process_work+0x408/0xa68
> [  175.661236][  T618]  loop_workfn+0x28/0x34
> [  175.661751][  T618]  process_scheduled_works+0x254/0x4e8
> [  175.662417][  T618]  worker_thread+0x24c/0x33c
> [  175.662974][  T618]  kthread+0x110/0x1b8
> [  175.663465][  T618]  ret_from_fork+0x10/0x20
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

I don't see why it's an atomic context,
so this patch is incorrect.

Thanks,
Gao Xiang
