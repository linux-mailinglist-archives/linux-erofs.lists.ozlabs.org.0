Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 095096E394F
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:33:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzt3D6S9Hz3cMf
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:33:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QHh9ZH95;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QHh9ZH95;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzt383l44z3bbZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:33:40 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CCF8961083;
	Sun, 16 Apr 2023 14:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BB3C433EF;
	Sun, 16 Apr 2023 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655618;
	bh=7pAQdp9zOWqx4avhF2Eg2nBD/7QWu9T59ZFFoTswNMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QHh9ZH95o94PQUzy68vuDqHSGC22vg3Bwk+P2SC6x0wkqD/rwcwlr/l/bbv4SQVzd
	 fR2tDRhzTIAw3QHBOoRajU1jbxs6ZYXkTIUU7xMUZUz3R48vY1sCrDP1GkMZTickrk
	 hDTm5BOdocydSm8ZgRdz/unhNV/ncpWolWTFhbNMvMMOrn8mgWaOE6m5/G2bwWm6Gv
	 McDlV28jnKiMBDRxlTqJ+1Bui6ekq0VSBTMJCuL5eb16BmPYnS6Ay1ql/gUpyYNdyR
	 UtbUFw37rAz0YV/55Fdqwj8b2b/I3MPQq7XEud19i5qsY0Gl2KkRm1QPLnG1cNeBvR
	 pfJ1yoJIXEWBw==
Message-ID: <b7604342-1d56-1c15-1526-380a4fdbbb41@kernel.org>
Date: Sun, 16 Apr 2023 22:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: stop parsing non-compact HEAD index if clusterofs
 is invalid
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230410173714.104604-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230410173714.104604-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/4/11 1:37, Gao Xiang wrote:
> Syzbot generated a crafted image [1] with a non-compact HEAD index of
> clusterofs 33024 while valid numbers should be 0 ~ lclustersize-1,
> which causes the following unexpected behavior as below:
> 
>   BUG: unable to handle page fault for address: fffff52101a3fff9
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 23ffed067 P4D 23ffed067 PUD 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 1 PID: 4398 Comm: kworker/u5:1 Not tainted 6.3.0-rc6-syzkaller-g09a9639e56c0 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
>   Workqueue: erofs_worker z_erofs_decompressqueue_work
>   RIP: 0010:z_erofs_decompress_queue+0xb7e/0x2b40
>   ...
>   Call Trace:
>    <TASK>
>    z_erofs_decompressqueue_work+0x99/0xe0
>    process_one_work+0x8f6/0x1170
>    worker_thread+0xa63/0x1210
>    kthread+0x270/0x300
>    ret_from_fork+0x1f/0x30
> 
> Note that normal images or images using compact indexes are not
> impacted.  Let's fix this now.
> 
> [1] https://lore.kernel.org/r/000000000000ec75b005ee97fbaa@google.com
> 
> Reported-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
> Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
> Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
