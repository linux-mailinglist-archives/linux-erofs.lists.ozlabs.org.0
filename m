Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77C4D5C70
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 08:37:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFHnm3gh6z2yxW
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 18:37:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Weu8ocNd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Weu8ocNd; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFHnh6NYGz2xBV
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 18:37:12 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 08E65B82AE0;
 Fri, 11 Mar 2022 07:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F3C340EC;
 Fri, 11 Mar 2022 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646984227;
 bh=GQ4RaP2ez2tkLbCqL2jRU2LQnBbaB4HlcNPpvWVk95c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Weu8ocNdi/tIQd7tZzhM1nZuurzzjPE9n3PsbmoL0tLFZN/jGfCYkmXk32SMnDLCW
 RxmdHu2gIEXiewMZXl5kOVGfUpjOVeJ9vOulcQDX37O3ajY3TjZSqJOFZJ8b7noRIg
 NUxIzUTfkGuytF576LsAp4JvFrIq2sQgUPuESuqxPYQGXHzIImk0bzkI1pHY00PwuS
 9RdOJIBtEBf17Zsv1YV8IsyePAv6cC2QsYIUtwss4Mpae7HbEue8wFjidvmWzqM/Z/
 uJrDZWtQBWMpa/zWAOcCIm6vfgq7TInRQqiovEQbBtPIDoOEdw3xyQ0dYGggZaExn0
 9HY2WjvkyykxA==
Message-ID: <13f33ba9-cbfb-6ffb-a19a-a87127c80804@kernel.org>
Date: Fri, 11 Mar 2022 15:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 07/21] erofs: use meta buffers for
 erofs_read_superblock()
Content-Language: en-US
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
 <20220307123305.79520-8-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220307123305.79520-8-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/7 20:32, Jeffle Xu wrote:
> The only change is that, meta buffers read cache page without __GFP_FS
> flag, which shall not matter.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
