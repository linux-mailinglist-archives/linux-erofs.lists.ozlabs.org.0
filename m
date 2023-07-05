Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB583747E34
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:25:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwrmL5VNzz3bnr
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:25:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwrlZ63Fdz3bVp
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:24:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfqmhO_1688541892;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmfqmhO_1688541892)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:24:52 +0800
Message-ID: <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
Date: Wed, 5 Jul 2023 15:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] erofs: update on-disk format for xattr name filter
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230705070427.92579-2-jefflexu@linux.alibaba.com>
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



On 2023/7/5 15:04, Jingbo Xu wrote:
> The xattr name bloom filter feature is going to be introduced to speed
> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> lookup when running "ls -lR" workload.
> 
> The number of common used extended attributes (n) is approximately 30.

There are some commonly used extended attributes (n) and the total number
of these is 31:

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
> where index represents the index of corresponding predefined short name

where `index`...



> prefix, while name represents the name string after stripping the above
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
> The h_name_filter field is introduced to the on-disk per-inode xattr
> header to place the corresponding xattr name filter, where bit value 1
> indicates non-existence for compatibility.
> 
> This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> compatible feature bit.
> 
> Suggested-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/erofs_fs.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 2c7b16e340fe..b4b6235fd720 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -13,6 +13,7 @@
>   
>   #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
>   #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
> +#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004

I'd suggest that if we could leave one reserved byte in the
superblock for now (and checking if it's 0) since
   1) xattr filter feature is a compatible feature;
   2) I'm not sure if the implementation could be changed.

so that later implementation changes won't bother compat bits
again.

>   
>   /*
>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> @@ -200,7 +201,7 @@ struct erofs_inode_extended {
>    * for read-only fs, no need to introduce h_refcount
>    */
>   struct erofs_xattr_ibody_header {
> -	__le32 h_reserved;
> +	__le32 h_name_filter;		/* bit value 1 indicates not-present */
>   	__u8   h_shared_count;
>   	__u8   h_reserved2[7];
>   	__le32 h_shared_xattrs[];       /* shared xattr id array */
> @@ -221,6 +222,11 @@ struct erofs_xattr_ibody_header {
>   #define EROFS_XATTR_LONG_PREFIX		0x80
>   #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
>   
> +#define EROFS_XATTR_FILTER_BITS		32
> +#define EROFS_XATTR_FILTER_MASK		(EROFS_XATTR_FILTER_BITS - 1)

Is this useful, we could just replace it to
(EROFS_XATTR_FILTER_BITS - 1) directly.


Otherwise it looks good to me,

Thanks,
Gao Xiang
