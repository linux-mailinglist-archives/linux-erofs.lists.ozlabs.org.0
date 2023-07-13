Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04B7516CD
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 05:35:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1gHB6zssz3c1H
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 13:35:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1gH46KXPz3bb4
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 13:35:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnFF9iv_1689219321;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnFF9iv_1689219321)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 11:35:22 +0800
Message-ID: <440b56d9-eb9a-48a8-1042-b202c875dc02@linux.alibaba.com>
Date: Thu, 13 Jul 2023 11:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] erofs: update on-disk format for xattr name filter
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230712115123.33712-1-jefflexu@linux.alibaba.com>
 <20230712115123.33712-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230712115123.33712-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/12 19:51, Jingbo Xu wrote:
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

