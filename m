Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1284818F2
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 04:29:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JPYfy6j8rz3054
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 14:29:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=etRGCZLm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=etRGCZLm; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JPYfw4jHLz2xXX
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Dec 2021 14:29:44 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 67D09615B7;
 Thu, 30 Dec 2021 03:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7CC36AE7;
 Thu, 30 Dec 2021 03:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640834979;
 bh=/MHAZ0T++Ohsl1IAW4FV+tbuCr4SJG0o5acbueps7WY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=etRGCZLm1ht++MQrzF50w9Jkc5Tf5JXMNnfQgMoZl5OwkQOwObdAopRt1atPPUKMY
 Zm6JeguIxZ0zL8wKPee0GScIGqCxw10LsqOJkrcfQrBhxxMeRtWxD2uv40R5ITUm1G
 oXc8/rPkVxwMBbTw35V8+GRIvMDGdv3nh0O1YN9qbmItXf+AisdILAzg8MfpSwiKdr
 xzEkuL2CPQruU9ubCrS1myB9FaVM32MpjdmpNkFo3KtmcjBcvo41ed6dCYiwfcrpkr
 20mtE5yuXXU0ymGva5D9sNX03qG1tZVbu775vBS+p4RHFFsiOSrHW9tvTCbaS/EMr8
 L0mtBIoLvKdYg==
Message-ID: <04f184a7-3c34-0dd7-4bac-3815ebeaba10@kernel.org>
Date: Thu, 30 Dec 2021 11:29:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 4/5] erofs: support inline data decompression
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20211228054604.114518-5-hsiangkao@linux.alibaba.com>
 <20211228232919.21413-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211228232919.21413-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/12/29 7:29, Gao Xiang wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we have already support tail-packing inline for
> uncompressed file, let's also implement this for compressed
> files to save I/Os and storage space.
> 
> Different from normal pclusters, compressed data is available
> in advance because of other metadata I/Os. Therefore, they
> directly move into the bypass queue without extra I/O submission.
> 
> It's the last compression feature before folio/subpage support.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
