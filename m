Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C1696537
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 14:44:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGMs12MScz3cGH
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 00:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mIcLLf4n;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mIcLLf4n;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGMrx5x96z3c6f
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 00:44:49 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 704F7B81D7C;
	Tue, 14 Feb 2023 13:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D901DC433D2;
	Tue, 14 Feb 2023 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676382287;
	bh=qCm9/g/4vkp0MxxyQCAuRl69DqJR1GLXomb5clqs5rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIcLLf4nnTv5Oe6RVsc8Mu9EOzLaaQ5AEzVodaR4J3Raj2EGphkpl+sfEh8geYgcJ
	 9u9Q3DZJ+lXMVXeXj7pBJ5jPsUfQQaDz02U/bkFsh5DI626kIv31D/jVEeqbmdE0SB
	 hkYp9/BSpq5R0aVPBTPs4R5HX4mkXrqcczvESUQJwxtc+0kr0Xs0FV6Ry9yjMuWY/C
	 Nrxj4fyMFJ/Mf/Rhc4+7ucCNFQI6D7yqTrmhn0xEr0DtPPX2BdxHK11bNSQmUBnx0e
	 ml4PyRIHXZxNja+rOlcQr6vGKg2/LFqKDX30QD9/S4eoW7RiMyvYZ43ws8JpSj2rN3
	 XInM/EKHUTVvA==
Message-ID: <575622cd-6b43-5155-b406-75a2ce634950@kernel.org>
Date: Tue, 14 Feb 2023 21:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] erofs: simplify iloc()
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20230114125746.399253-2-xiang@kernel.org>
 <20230114150823.432069-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230114150823.432069-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/14 23:08, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Actually we could pass in inodes directly to clean up all callers.
> Also rename iloc() as erofs_iloc().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
