Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F25BB73F0BD
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 04:13:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QqpCd6gl2z30Px
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 12:13:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QqpCV2Kg0z2ym7
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 12:13:07 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vm3e3fb_1687831979;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm3e3fb_1687831979)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 10:13:00 +0800
Message-ID: <af85ff08-3cd6-03c1-a559-da5b167c1685@linux.alibaba.com>
Date: Tue, 27 Jun 2023 10:12:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC 1/2] erofs: update on-disk format for xattr bloom filter
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <20230621083209.116024-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230621083209.116024-2-jefflexu@linux.alibaba.com>
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



On 2023/6/21 16:32, Jingbo Xu wrote:
> The xattr bloom filter feature is going to be introduced to speed up the
> negative xattr lookup, e.g. system.posix_acl_[access|default] lookup
> when running "ls -lR" workload.
> 
> The number of common used xattr (n) is approximately 8, including
> system.[posix_acl_access|posix_acl_default], security.[capability|selinux]
> and security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].  Given the
> number of bits of the bloom filter (m) is 32, the optimal value for the
> number of the hash functions (k) is 2 (ln2 * m/n = 2.7).
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/erofs_fs.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 2c7b16e340fe..9daea86cdb52 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -13,6 +13,7 @@
>   
>   #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
>   #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
> +#define EROFS_FEATURE_COMPAT_XATTR_BLOOM	0x00000003

#define EROFS_FEATURE_COMPAT_XATTR_BLOOM 0x00000004

>   
>   /*
>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> @@ -200,7 +201,7 @@ struct erofs_inode_extended {
>    * for read-only fs, no need to introduce h_refcount
>    */
>   struct erofs_xattr_ibody_header {
> -	__le32 h_reserved;
> +	__le32 h_map;	/* bloom filter, bit value 1 indicates not-present */

`map` here is too ambiguous, could we rename it as "h_name_filter"?

>   	__u8   h_shared_count;
>   	__u8   h_reserved2[7];
>   	__le32 h_shared_xattrs[];       /* shared xattr id array */
> @@ -221,6 +222,11 @@ struct erofs_xattr_ibody_header {
>   #define EROFS_XATTR_LONG_PREFIX		0x80
>   #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
>   
> +#define EROFS_XATTR_BLOOM_BITS		32
> +#define EROFS_XATTR_BLOOM_MASK		(EROFS_XATTR_BLOOM_BITS - 1)
> +#define EROFS_XATTR_BLOOM_DEFAULT	UINT32_MAX
> +#define EROFS_XATTR_BLOOM_COUNTS	2

could we rename them as EROFS_XATTR_NAME_FILTER_xxx?

Thanks,
Gao Xiang
