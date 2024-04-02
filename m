Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26588949DB
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 05:10:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TFyS/G+u;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7tD44wZYz3dBn
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 14:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TFyS/G+u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7tCz3Rbdz3d2K
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 14:10:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712027401; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6PV4i+HVzU1AelO3O3DyBmAse0V91CXhjbBuIegz1IQ=;
	b=TFyS/G+uMGjeGSxDGAX7JUQzgTJLGhYZ9pXEDmiKOgG4/4mhLR7oqzNUHzGrTtNRs8fEGOsc89zu2sBdajLEbPApL6ahaCvJUbway10e7DZOvyK3K82sgZ4KOworpdTrS0ZnuOoAYBsuZffgRkUEFYuO8j4QxGYhBrbspifio3A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3mnL8e_1712027399;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3mnL8e_1712027399)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 11:10:00 +0800
Message-ID: <7412666b-a290-482e-b6aa-c3813ce59fa8@linux.alibaba.com>
Date: Tue, 2 Apr 2024 11:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: rename per CPU buffer to global buffer pool
 and make it configurable
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240401135645.2550203-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240401135645.2550203-1-guochunhai@vivo.com>
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



On 2024/4/1 21:56, Chunhai Guo wrote:
> It will cost more time if compressed buffers are allocated on demand for
> low-latency algorithms (like lz4) so EROFS uses per-CPU buffers to keep
> compressed data if in-place decompression is unfulfilled.  While it is kind
> of wasteful of memory for a device with hundreds of CPUs, and only a small
> number of CPUs concurrently decompress most of the time.
> 
> This patch renames it as 'global buffer pool' and makes it configurable.
> This allows two or more CPUs to share a common buffer to reduce memory
> occupation.
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I've applied these two patches to -dev-test for the next cycle.

Thanks,
Gao Xiang
