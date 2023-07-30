Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBF76857F
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:18:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UM0Pqu8m;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDMQS0gL1z2yFC
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:18:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UM0Pqu8m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDMQN5pPfz2xgp
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:18:52 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D5BB560C1F;
	Sun, 30 Jul 2023 13:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3166DC433C7;
	Sun, 30 Jul 2023 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690723130;
	bh=EolCVs9yK9Olu1OznZUeVwGvAneS7WkebgXshtR4DnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UM0Pqu8mg4WoLpPIjgir3MwSrLgXJdBh8xWAgGAMEcBVtNwedVPaLA/vhkbx0UuKr
	 xXxgXxoQK3Se16BpkJRg8MSBwkvZ554hfcjKZxvFYt1jct5UckYbDGq7Tdi0vPfn3P
	 lL3hpDtD95fARwITL3wbyl/PWg97sYZ94FP03Zss8Id8T3zYheisAwEWPM833ezG65
	 HYiOd4u058ukNhpCzprWs7WKyP4HVJkSVD78RHeU4oSTnwNACGDx5iZYmrZglkpB9j
	 nkvAaSBTAxFA5xltBvpego7XL/50cR6VWDLJ/B7OtzAKHI98QfWzZp9ARR9//30CI1
	 NJgDXxUJKxABg==
Message-ID: <87361a9d-ab34-a66b-ba10-6746fa14bb03@kernel.org>
Date: Sun, 30 Jul 2023 21:18:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/2] erofs: update on-disk format for xattr name filter
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, hsiangkao@linux.alibaba.com,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230722094538.11754-1-jefflexu@linux.alibaba.com>
 <20230722094538.11754-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230722094538.11754-2-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/7/22 17:45, Jingbo Xu wrote:
> The xattr name bloom filter feature is going to be introduced to speed
> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> lookup when running "ls -lR" workload.
> 
> There are some commonly used extended attributes (n) and the total
> number of these is approximately 30.
> 
> 	trusted.overlay.opaque
> 	trusted.overlay.redirect
> 	trusted.overlay.origin
> 	trusted.overlay.impure
> 	trusted.overlay.nlink
> 	trusted.overlay.upper
> 	trusted.overlay.metacopy
> 	trusted.overlay.protattr
> 	user.overlay.opaque
> 	user.overlay.redirect
> 	user.overlay.origin
> 	user.overlay.impure
> 	user.overlay.nlink
> 	user.overlay.upper
> 	user.overlay.metacopy
> 	user.overlay.protattr
> 	security.evm
> 	security.ima
> 	security.selinux
> 	security.SMACK64
> 	security.SMACK64IPIN
> 	security.SMACK64IPOUT
> 	security.SMACK64EXEC
> 	security.SMACK64TRANSMUTE
> 	security.SMACK64MMAP
> 	security.apparmor
> 	security.capability
> 	system.posix_acl_access
> 	system.posix_acl_default
> 	user.mime_type
> 
> Given the number of bits of the bloom filter (m) is 32, the optimal
> value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).
> 
> The single hash function is implemented as:
> 
> 	xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
> 
> where `index` represents the index of corresponding predefined short name
> prefix, while `name` represents the name string after stripping the above
> predefined name prefix.
> 
> The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
> used to give a better spread when mapping these 30 extended attributes
> into 32-bit bloom filter as:
> 
> 	bit  0: security.ima
> 	bit  1:
> 	bit  2: trusted.overlay.nlink
> 	bit  3:
> 	bit  4: user.overlay.nlink
> 	bit  5: trusted.overlay.upper
> 	bit  6: user.overlay.origin
> 	bit  7: trusted.overlay.protattr
> 	bit  8: security.apparmor
> 	bit  9: user.overlay.protattr
> 	bit 10: user.overlay.opaque
> 	bit 11: security.selinux
> 	bit 12: security.SMACK64TRANSMUTE
> 	bit 13: security.SMACK64
> 	bit 14: security.SMACK64MMAP
> 	bit 15: user.overlay.impure
> 	bit 16: security.SMACK64IPIN
> 	bit 17: trusted.overlay.redirect
> 	bit 18: trusted.overlay.origin
> 	bit 19: security.SMACK64IPOUT
> 	bit 20: trusted.overlay.opaque
> 	bit 21: system.posix_acl_default
> 	bit 22:
> 	bit 23: user.mime_type
> 	bit 24: trusted.overlay.impure
> 	bit 25: security.SMACK64EXEC
> 	bit 26: user.overlay.redirect
> 	bit 27: user.overlay.upper
> 	bit 28: security.evm
> 	bit 29: security.capability
> 	bit 30: system.posix_acl_access
> 	bit 31: trusted.overlay.metacopy, user.overlay.metacopy
> 
> h_name_filter is introduced to the on-disk per-inode xattr header to
> place the corresponding xattr name filter, where bit value 1 indicates
> non-existence for compatibility.
> 
> This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> compatible feature bit.
> 
> Reserve one byte in on-disk superblock as the on-disk format for xattr
> name filter may change in the future.  With this flag we don't need
> bothering these compatible bits again at that time.
> 
> Suggested-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks
