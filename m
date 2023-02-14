Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54412696752
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 15:49:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGPHr12Jyz3cJ7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 01:49:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DZJxfqNQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DZJxfqNQ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGPHn27bSz30hl
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 01:49:41 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 66F36616CB;
	Tue, 14 Feb 2023 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29094C433EF;
	Tue, 14 Feb 2023 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676386178;
	bh=Hd39Bbt/oIFR+/8DTIbIyGdhtSgpK09BMQP2qSeF5wE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DZJxfqNQQ/OoeSuk1eQEEjyH6Cqo2MBxfq0SV17uW6JhwUAtpzEfvOY91jGm792u4
	 R14eKWCigrKsnflRNPtIRVaSTlw7zWLEcpI2A6Vu2dLfDp1FzvAVsJb3xYBjxvutFW
	 9OnWoOxvq5SLJRfpOJW+7fOsdzGw2N84kOo6mortxsX0H1ksDQAk4zYpGjFZ2GcqRd
	 WBnufsdYW1D6F321srKZcqRsMijQvQBYv7E1AKFvvawpFUj2x75FuGSs35lSfWLwFD
	 Nhn886+35P5n/w9knYpy7OEgETvC9EDG1CDd6V5pD8kI/bDciuzSrsN4z5GptUGI8i
	 mf9dtmLbhgDug==
Message-ID: <8d6471cf-75b1-14b2-7c4b-27c38dc0428b@kernel.org>
Date: Tue, 14 Feb 2023 22:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] erofs: update print symbols for various flags in
 trace
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/2/9 10:48, Jingbo Xu wrote:
> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
