Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983372C868
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 16:27:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfvCx1Wmcz30Jl
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 00:27:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfvCq0kcjz2yLY
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 00:27:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl-RFdP_1686580046;
Received: from 192.168.1.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vl-RFdP_1686580046)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 22:27:27 +0800
Message-ID: <76ecba87-256c-2537-cbee-9cef6c0ce714@linux.alibaba.com>
Date: Mon, 12 Jun 2023 22:27:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 5/5] erofs: use separate xattr parsers for
 listxattr/getxattr
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230612123745.36323-1-jefflexu@linux.alibaba.com>
 <20230612123745.36323-6-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230612123745.36323-6-jefflexu@linux.alibaba.com>
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



On 2023/6/12 20:37, Jingbo Xu wrote:
> There's a callback styled xattr parser, i.e. xattr_foreach(), which is
> shared among listxattr and getxattr.  Convert it to two separate xattr
> parsers for listxattr and getxattr.
Convert it to two separate xattr parsers to serve listxattr and getxattr
for better readability.

> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---

...

> +
> +static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
>   {
> -	unsigned int base_index = entry->e_name_index;
> -	unsigned int prefix_len, infix_len = 0;
> +	struct erofs_xattr_entry entry;
> +	unsigned int base_index, prefix_len, infix_len = 0;
>   	const char *prefix, *infix = NULL;
> +	int err;
>   
> -	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> +	/* 1. handle xattr entry */
> +	entry = *(struct erofs_xattr_entry *)
> +			(it->kaddr + erofs_blkoff(it->sb, it->pos));
> +	it->pos += sizeof(struct erofs_xattr_entry);
> +
> +	base_index = entry.e_name_index;
> +	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
>   		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> -			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
>   		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> -			return 1;
> +			return 0;
>   		infix = pf->prefix->infix;
>   		infix_len = pf->infix_len;
>   		base_index = pf->prefix->base_index;
> @@ -385,53 +225,103 @@ static int xattr_entrylist(struct erofs_xattr_iter *it,
>   
>   	prefix = erofs_xattr_prefix(base_index, it->dentry);
>   	if (!prefix)
> -		return 1;
> +		return 0;
>   	prefix_len = strlen(prefix);
>   
>   	if (!it->buffer) {
> -		it->buffer_ofs += prefix_len + infix_len +
> -					entry->e_name_len + 1;
> -		return 1;
> +		it->buffer_ofs += prefix_len + infix_len + entry.e_name_len + 1;

Overly 80 chars?

> +		return 0;
>   	}
>   
>   	if (it->buffer_ofs + prefix_len + infix_len +
> -		+ entry->e_name_len + 1 > it->buffer_size)
> +		entry.e_name_len + 1 > it->buffer_size)
>   		return -ERANGE;
>   
>   	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
>   	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
>   	it->buffer_ofs += prefix_len + infix_len;
> -	return 0;
> -}
>   
> -static int xattr_namelist(struct erofs_xattr_iter *it,
> -			  unsigned int processed, char *buf, unsigned int len)
> -{
> -	memcpy(it->buffer + it->buffer_ofs, buf, len);
> -	it->buffer_ofs += len;
> +	/* 2. handle xattr name */
> +	err = erofs_xattr_copy_to_buffer(it, entry.e_name_len);
> +	if (err)
> +		return err;
> +
> +	it->buffer[it->buffer_ofs++] = '\0';
>   	return 0;
>   }
>   
> -static int xattr_skipvalue(struct erofs_xattr_iter *it,
> -			   unsigned int value_sz)
> +static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
>   {
> -	it->buffer[it->buffer_ofs++] = '\0';
> -	return 1;
> -}
> +	struct super_block *sb = it->sb;
> +	struct erofs_xattr_entry entry;
> +	unsigned int slice, processed, value_sz;
> +	void *src;
>   
> -static const struct xattr_iter_handlers list_xattr_handlers = {
> -	.entry = xattr_entrylist,
> -	.name = xattr_namelist,
> -	.alloc_buffer = xattr_skipvalue,
> -	.value = NULL
> -};
> +	/* 1. handle xattr entry */
> +	entry = *(struct erofs_xattr_entry *)
> +			(it->kaddr + erofs_blkoff(sb, it->pos));
> +	it->pos += sizeof(struct erofs_xattr_entry);
> +	value_sz = le16_to_cpu(entry.e_value_size);
> +
> +	/* should also match the infix for long name prefixes */
> +	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
> +		struct erofs_sb_info *sbi = EROFS_SB(sb);
> +		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> +			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +
> +		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> +			return -ENOATTR;
> +
> +		if (it->index != pf->prefix->base_index ||
> +		    it->name.len != entry.e_name_len + pf->infix_len)
> +			return -ENOATTR;
> +
> +		if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
> +			return -ENOATTR;
> +
> +		it->infix_len = pf->infix_len;
> +	} else {
> +		if (it->index != entry.e_name_index ||
> +		    it->name.len != entry.e_name_len)
> +			return -ENOATTR;
> +
> +		it->infix_len = 0;
> +	}
> +
> +	/* 2. handle xattr name */
> +	for (processed = 0; processed < entry.e_name_len; processed += slice) {
> +		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> +					EROFS_KMAP);
> +		if (IS_ERR(it->kaddr))
> +			return PTR_ERR(it->kaddr);
> +
> +		src = it->kaddr + erofs_blkoff(sb, it->pos);
> +		slice = min_t(unsigned int,
> +				sb->s_blocksize - erofs_blkoff(sb, it->pos),
> +				entry.e_name_len - processed);
> +		if (memcmp(it->name.name + it->infix_len + processed, src, slice))

Overly 80 chars?

Thanks,
Gao Xiang
