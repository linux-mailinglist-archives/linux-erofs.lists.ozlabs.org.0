Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4C70D259
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 05:26:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQKVW5yzRz3cPl
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 13:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CMyRmZAS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CMyRmZAS;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQKVP2n94z3bgX
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 13:26:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7431F60F8D;
	Tue, 23 May 2023 03:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF4C433D2;
	Tue, 23 May 2023 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684812393;
	bh=HT49vkUy5eZ0ZBZi3mTVCBueo3VRnPSV1wZa21TSs4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CMyRmZAS1lVU3R9ErqaPZpq2u6k0W7wQNqyU+h3GEEk6FutipdJ/F94mtYIwKoQU1
	 cjKJk4uR3sK/enYOfzrp484C0VC2tjLgkTpGS8k0r/BAauqc/mi0vhZfWuwz+RdSt4
	 g9X+tZNOBIgWq79wITr6j2xrqVLiKXuueKqo8vowy4AGyi47aUl9bsd3TboRBvpFT5
	 Ed6zKogR5xqOUtcBAuaoEksigXqKl/2u7sBJm/LlcqJc0DA+X7t09WO148Cs4lWNC1
	 oKk7muH+lQkZSH3rVJP8jwBbSAf76xQvX5a7BpXbSLJLpU7B9zyfRbttjO4U1Bamsv
	 oZbTCyqw87qFw==
Message-ID: <57c5f06c-ac41-d6c7-3a07-45d07f676577@kernel.org>
Date: Tue, 23 May 2023 11:26:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/5/22 17:21, Gao Xiang wrote:
> As Sandeep shown [1], high priority RT per-cpu kthreads are
> typically helpful for Android scenarios to minimize the scheduling
> latencies.
> 
> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> EROFS_FS_PCPU_KTHREAD.
> 
> Also clean up unneeded sched_set_normal().
> 
> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> Cc: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
