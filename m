Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01652A57D
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 16:59:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2fQj06Pwz3bwH
	for <lists+linux-erofs@lfdr.de>; Wed, 18 May 2022 00:59:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HbJZ+/R8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HbJZ+/R8; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2fQf1yj4z2ypD
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 May 2022 00:59:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ED0006160B;
 Tue, 17 May 2022 14:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC26C385B8;
 Tue, 17 May 2022 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652799543;
 bh=p8VXyt5c/PXmes006c5s9QtDLiYpUTe0IUEvEX9H0Hg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HbJZ+/R81HedWh/aBwu9GpKip7UrN85t7CmpIwZNHyX7gHYFfpLfdF7jQU2/IfL1/
 UpxVHgCH2d8Zdab0aBZyiT5V2PFwfo0ep+JvqnTiXXqTfF/xQzojegcQz/av5jf4Hp
 Pq2VlHML5N91XNkLg0hMz4OrK9jPo7TYQXqeW/akKQrT0LCGw0UKPtP3jTLVBKeKYj
 U95o6+rGj+yRcwFHLc3Iib71amMzwAdg8XBIctKq9+lBvGromURT1o7aJpADp1gMGw
 4ZK/sA0ppkWRqW/rzJFHmvsdTk7oWxSE38Qhp42AOlKtTfDCHS8KyBn3f1dfXErQwI
 wBxubHSg4UKsg==
Message-ID: <c2e64d18-dfcc-c032-c39b-6059683a617f@kernel.org>
Date: Tue, 17 May 2022 22:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] erofs: refine on-disk definition comments
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/5/7 3:46, Gao Xiang wrote:
> Fix some outdated comments and typos, hopefully helpful.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
