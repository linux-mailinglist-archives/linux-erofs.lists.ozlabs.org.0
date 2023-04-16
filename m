Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A16E392F
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:24:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PzsrP6plhz3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:24:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6q1KM1w;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6q1KM1w;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PzsrL0Hjjz3c6t
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:24:17 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1999460CA0;
	Sun, 16 Apr 2023 14:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8173C433D2;
	Sun, 16 Apr 2023 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655055;
	bh=s6j+cFhC+fFisG2k+MvYEAPar5ATW7KdlOagLT/oLHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X6q1KM1wnWWVtUYy5Y6dH7XHBb2fpJSWWvAi48hJZQfdCeymHBRiMPwiH+ftQeub6
	 IyIR4D/xgkQMZ2FRCmjFtEIBc0ty9zCNU8dOa6LET5PLhxM80LdmBruMZNVAMJ9NhZ
	 radlqllVmdEMnVMA80qxJPFWtObsyGRs+HVKuBL7YM0rCWqHFqrMEjwTWh67r3sV6v
	 n9MNBF0KTtclamfuqGjfj3PM3hhnQdH8FPlrFVQ6bAA3er+NxxQq6mih9UXqtXOuj7
	 QEY4Ipfgy+5I8jE4NxqhYajRwAk9wbKUeOr7BwAdwsND7ITNVD3T+3JSR1/fbtWk+L
	 e1kdwwqVb2VIg==
Message-ID: <815ed5d3-efae-9d18-b2b5-e56bb196ffda@kernel.org>
Date: Sun, 16 Apr 2023 22:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/7] erofs: introduce long xattr name prefixes feature
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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

On 2023/4/7 22:17, Jingbo Xu wrote:
> Background
> =========
> overlayfs uses xattrs to keep its own metadata.  If such xattrs are
> heavily used, such as Composefs model [1], large amount of xattrs
> with diverse xattr values exist but only a few common xattr names
> are valid (trusted.overlay.redirect, trusted.overlay.digest, and
> maybe more in the future) . For example:
> 
> # file 1
> trusted.overlay.redirect="xxx"
> 
> # file 2
> trusted.overlay.redirect="yyy"
> 
> That makes the existing predefined prefixes ineffective in both image
> size and runtime performance.
> 
> Solution Proposed
> ====================
> Let's introduce long xattr name prefixes now to fix this.  They work
> similarly as the predefined name prefixes, except that long xattr name
> prefixes are user specified.
> 
> When a long xattr name prefix is used, the shared long xattr prefixes
> are stored in the packed or meta inode, while the remained trailing part
> of the xattr name apart from the long xattr name prefix will be stored
> in erofs_xattr_entry.e_name.  e_name is empty if the xattr name matches
> exactly as the long xattr name prefix.
> 
> Erofs image sizes will be smaller in the above described scenario where
> all files have diverse xattr values with the same set of xattr names[2],
> such as having following xattrs like:
> 
> trusted.overlay.metacopy=""
> trusted.overlay.redirect="xxx"
> 
> Here are the image sizes for comparison (32-byte inodes are used):
> 
> ```
> 7.4M  large.erofs.T0.xattr
> 6.4M  large.erofs.T0.xattr.share
> ```
> 
> - share: "--xattr-prefix=trusted.overlay.redirect" option of mkfs.erofs.
> w/ this option, the long xattr name prefixes feature is enabled.
> 
> It can be seen ~14% disk space is saved with this feature in this
> typical workload, therefore metadata I/Os could also be more effective
> then.
> 
> Test
> ====
> It passes erofs/019 of erofs-utils.
> 
> 
> [1] https://lore.kernel.org/all/CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com/
> [2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
> 
> 
> 
> Gao Xiang (1):
>    erofs: keep meta inode into erofs_buf
> 
> Jingbo Xu (6):
>    erofs: initialize packed inode after root inode is assigned
>    erofs: move packed inode out of the compression part
>    erofs: introduce on-disk format for long xattr name prefixes
>    erofs: add helpers to load long xattr name prefixes
>    erofs: handle long xattr name prefixes properly
>    erofs: enable long extended attribute name prefixes

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
