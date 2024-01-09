Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6B8286CD
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 14:08:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8WTB4lfnz30hG
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 00:08:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8WT51HBPz30Qk
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 00:08:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W-IdcIZ_1704805700;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-IdcIZ_1704805700)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 21:08:21 +0800
Message-ID: <d8a104d4-1a58-423a-ba12-ea82d622de48@linux.alibaba.com>
Date: Tue, 9 Jan 2024 21:08:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: add a global page pool for lz4 decompression
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240109074143.4138783-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240109074143.4138783-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2024/1/9 15:41, Chunhai Guo wrote:
> Using a global page pool for LZ4 decompression significantly reduces the
> time spent on page allocation in low memory scenarios.
> 
> The table below shows the reduction in time spent on page allocation for
> LZ4 decompression when using a global page pool.  The results were
> obtained from multi-app launch benchmarks on ARM64 Android devices
> running the 5.15 kernel with an 8-core CPU and 8GB of memory.  In the
> benchmark, we launched 16 frequently-used apps, and the camera app was
> the last one in each round. The data in the table is the average time of
> camera app for each round.
> After using the page pool, there was an average improvement of 150ms in
> the launch time of the camera app, which was obtained from systrace log.
> +--------------+---------------+--------------+---------+
> |              | w/o page pool | w/ page pool |  diff   |
> +--------------+---------------+--------------+---------+
> | Average (ms) |     3434      |      21      | -99.38% |
> +--------------+---------------+--------------+---------+
> 
> Based on the benchmark logs, 64 pages are sufficient for 95% of
> scenarios. This value can be adjusted from the module parameter. The
> default value is 0.
> 
> This patch currently only supports the LZ4 decompressor, other
> decompressors will be supported in the next step.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>


This patch looks good to me, yet we're in the merge window for v6.8.
I will address it after -rc1 is out since no stable tag these days.

Also it would be better to add some results of changing max_distance
if you have more time to test.

Thanks,
Gao Xiang
