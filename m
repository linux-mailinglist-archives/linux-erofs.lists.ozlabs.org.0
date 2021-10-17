Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A64305CE
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 03:18:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HX2G32NRlz30Ph
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 12:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hUdK4oHA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hUdK4oHA; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HX2Fw1fwWz2yn4
 for <linux-erofs@lists.ozlabs.org>; Sun, 17 Oct 2021 12:18:44 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1405B61040;
 Sun, 17 Oct 2021 01:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634433513;
 bh=2pEJnugvv7r5TasV5ZvP9ZxHWn1aHcIZhOlEuKX4vNI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hUdK4oHAXEVI1OUUdA0gqGTQWCW1cB+WIXZSdNO67/FJ+ql97fsNqf0hhzlycGNs3
 ML6uywFaduVrl+fiz9RT78IkRLlEg5CPqLmoDbMGuTb8atqf6sn1gCbGLFudeoKSPO
 VoPFO2a9e4i6TwbtHspoHNco6ccBcURWZN//EBA9pUFndHCqybWvgzniZdJ81AR/VQ
 4R4/MJ/U0gLaX9HVxdgPrhNr+mIZhDKsSzw3RtC6po7Mw96uA5b2mbtBgYyG46fa3Y
 /Ns/L2bX/NNCwLIPUFLuHmc9hUu2Sac6yD7YU9fkHnnFihvWub/7UaJMdbmobfpQfb
 vDrOG9lmenpFw==
Message-ID: <428311ea-a1ed-599c-44b0-9558c61495eb@kernel.org>
Date: Sun, 17 Oct 2021 09:18:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 1/2] erofs: decouple basic mount options from fs_context
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20211007070224.12833-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211007070224.12833-1-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/7 15:02, Gao Xiang wrote:
> Previously, EROFS mount options are all in the basic types, so
> erofs_fs_context can be directly copied with assignment. However,
> when the multiple device feature is introduced, it's hard to handle
> multiple device information like the other basic mount options.
> 
> Let's separate basic mount option usage from fs_context, thus
> multiple device information can be handled gracefully then.
> 
> No logic changes.
> 
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
