Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4759A4336A0
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 15:03:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYYpc5HkLz305T
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Oct 2021 00:03:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PypRr6vT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PypRr6vT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYYpZ2MFqz2yp2
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Oct 2021 00:03:50 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA1061360;
 Tue, 19 Oct 2021 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634648627;
 bh=I7JwFHSmv1BT930lTSC6hdElWCbCHQMERETOEA78i0k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PypRr6vTgk9g7BuW7HmQemLz1Sf8vLq9WneM3HZL0HS4l5YHlXjNOcmo3bvd4Rxxm
 sJymSzuPjxmz3AZ2SKr7IrWHJ0SkLy/CuCbcGxYDCcrN0aBLcx7YKqpqh/f8/22SQ0
 kgAr/TIEYmLHLU3dNxhC9EQZeUINGLdhIMEzF43lkvsrVJHzInLHB5SkDUlo1+ghjm
 Taf/y1i/iR0FdkpYI4krHFAMWpl72LEBHVnre0nWa2UIXzQoh3rk+f1K7frfRtSoPO
 AXIJohp0sXPvDur0u24O2Sg6xPbJWwygnw4wHU1LPPSsnnIrkgPo3xMvT96++JE5qG
 x1hXCRI1hdcbQ==
Message-ID: <88cc9caf-1d50-2d0f-de0e-09456339b996@kernel.org>
Date: Tue, 19 Oct 2021 21:03:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/7] erofs: rename some generic methods in decompressor
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
 <20211010213145.17462-7-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211010213145.17462-7-xiang@kernel.org>
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
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Lasse Collin <lasse.collin@tukaani.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/11 5:31, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, some LZ4 methods were named with `generic'. However, while
> evaluating the effective LZMA approach, it seems they aren't quite
> generic at all (e.g. no need preparing dstpages for most LZMA cases.)
> 
> Avoid such naming instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
