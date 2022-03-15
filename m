Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AEE4D972E
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 10:08:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHndd0zd3z30Jm
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 20:08:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M6bubW+a;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M6bubW+a; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHndW0pZWz2yjS
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 20:08:46 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D029A61582;
 Tue, 15 Mar 2022 09:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7377DC340E8;
 Tue, 15 Mar 2022 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647335322;
 bh=00Z/aPEqMpUYQEYLBU8TquCbkMu9mw2X8SAwjRv70x4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M6bubW+a6KhUJ/8q1M+IqR9GQQPp9ygnCSmcg1k7QRJskisgwGk7BdLojd/CKBsN6
 SWVQH2nEXSgBI8oVCHdpXR/nxHGHzmHQz2fY5BwogZqtPeZgjtKhTS2IcVOPEMMdHd
 cUl50/L8xVDYSLU4bXkJ4JxyG+DAmZvjXPHF+3/zd0/8M0H3OuR+k3ZzvVnhjgY90l
 YuZgx+hpEkUuFeJexQb87DlZwuCqzPNBB+odhoI79ZVxmAcjqo1jbqbb3isBYFg/sn
 RydA/c56HoKY6Db5JSDIfbnyoLPuT4i1fRZTpqBvn+ZRH1WcO6jlCqOSkGyJajQ3cp
 73wy7RVALBNsQ==
Message-ID: <37668a23-5b56-015b-fb9b-fd8acb0fd9b7@kernel.org>
Date: Tue, 15 Mar 2022 17:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
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

On 2022/3/11 2:27, Gao Xiang wrote:
> Avoid the unnecessary tail recursion since it can be converted into
> a loop directly in order to prevent potential stack overflow.
> 
> It's a pretty straightforward conversion.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
