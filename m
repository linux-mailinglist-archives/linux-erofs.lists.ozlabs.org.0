Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E3643CEB
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 06:59:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NR8rJ6xMgz3bWb
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 16:59:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BWRGlL6K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BWRGlL6K;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NR8rF2Lprz2yxQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 16:59:25 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 44A09614F4;
	Tue,  6 Dec 2022 05:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9BC433D6;
	Tue,  6 Dec 2022 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670306361;
	bh=TN8f1Zefq0DtbxLj2AZEFGY13EY8pSKcGZcIuQ2Vx4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWRGlL6KU4k+1ha+pkrhAIlpXw0bedaNWEPEgjq9RV2F+r+r0GR/WziPOJ7wj/5iL
	 +qfiPb4JP/9S2jx3C9UoRd5fIChvHjXRssdpRSVmCn7QdGf4Eed7v3OI0n1skWngJg
	 LeQhJMP7mrdRlvIlUJ++av0pvgfZzxCstMWvCDaJrU0L9uutwLh0Bye8uvPOwq7Xms
	 cqaDeZ/n67yMvU8aNcGp0rv5TQmRngywGWLTVa8OGek8zz8Fdw7BhxT9v2MU1PpFAV
	 gm97cpjl4uob8VbfS64KjwaX5YhjNBrNZ5fpjemJlhKdqBlc8J7gSg3T/uMxCqrhkS
	 98EOL0hksWqTw==
Date: Tue, 6 Dec 2022 13:59:15 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fix missing continue for !shouldalloc in
 z_erofs_bind_cache()
Message-ID: <Y47aMzzNHJAGZQmB@debian>
Mail-Followup-To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
	Yue Hu <huyue2@coolpad.com>
References: <20221206053633.4251-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206053633.4251-1-zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Tue, Dec 06, 2022 at 01:36:33PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Do cmpxchg_relaxed() is only for successful allocation if I/O is needed.
> 
> Fixes: 69b511baa0be ("erofs: clean up cached I/O strategies")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Thanks for the catch, it looks good to me.

Let's fold this into the original patch.

Thanks,
Gao Xiang
