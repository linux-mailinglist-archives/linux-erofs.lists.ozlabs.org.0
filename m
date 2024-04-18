Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B248A943B
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 09:37:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ERTTNeae;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKqP61mPpz3cVq
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 17:37:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ERTTNeae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKqNy5RB8z3cR9
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 17:37:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9B51A61771;
	Thu, 18 Apr 2024 07:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394FBC113CC;
	Thu, 18 Apr 2024 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713425840;
	bh=GO+KQ4267WrQM2kTxVBum1PoXA+w1WbxKusH6YJPuj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERTTNeaeF25Ab7t6xtS0YopYEq45E8+FxJedRn59aOPeCC1VuXHd21P+DROueOV2/
	 R79GEaCPsMbHSzWC+1ahWhXMEnVhRaWZNxLI+UFTOV4e3SFxJr6jMbZAX0uMihLUKg
	 dgo8iE1GVhQasUj8hxYy93NO2/yxzRMSBnEiMCC6KEpon/NqQAV9+a+dMbNHZdz3gJ
	 afCdTncByTm9aanpAgkHpgBJ2ghB0yK4tjWxacBlyoPk7yq3nPB8ej7ZVGLuN55SJB
	 1Q2+87tHNhnuyCJWp87brQhyOrCLUCeWustu15GL9YYbWeDA3oqiAes1uOn21lVwaj
	 AYLFXl+D9FrDw==
Date: Thu, 18 Apr 2024 15:37:18 +0800
From: Gao Xiang <xiang@kernel.org>
To: Noboru Asai <asai@sijam.com>
Subject: Re: [PATCH 1/3] erofs-utils: determine the [un]compressed data block
 is inline or not early
Message-ID: <ZiDNrgdW5nJcJs2H@debian>
Mail-Followup-To: Noboru Asai <asai@sijam.com>, hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn, linux-erofs@lists.ozlabs.org
References: <20240418055231.146591-1-asai@sijam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240418055231.146591-1-asai@sijam.com>
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
Cc: hsiangkao@linux.alibaba.com, zhaoyifan@sjtu.edu.cn, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Noboru,

On Thu, Apr 18, 2024 at 02:52:29PM +0900, Noboru Asai wrote:
> Introducing erofs_get_inodesize function and erofs_get_lowest_offset function,
> we can determine the [un]compressed data block is inline or not before
> executing z_erofs_merge_segment function. It enable the following,
> 
> * skip the redundant write for ztailpacking block.
> * simplify erofs_prepare_inode_buffer function. (remove handling ENOSPC error)
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

I appreciate and thanks for your effort and time.

Yet I tend to avoid assuming if the inline is ok or not before
prepare_inode_buffer() since it will be free for space allocator
to decide inline or not at that time.

So personally I still would like to write a final compressed
index for inline fallback.

I will fix this issue myself later (it should be just a small
patch to fix this). 

Thanks for your effort on this issue again!

Thanks,
Gao Xiang

