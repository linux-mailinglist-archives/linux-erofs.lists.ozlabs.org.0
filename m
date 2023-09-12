Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CF79CD27
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 12:06:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlK4Q55x0z3c7v
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 20:06:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlK4K0wYGz3by6
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 20:06:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrwXsFc_1694513190;
Received: from 30.97.48.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrwXsFc_1694513190)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 18:06:32 +0800
Message-ID: <dd4c81d3-3e70-6e30-75bb-afa941a07eb1@linux.alibaba.com>
Date: Tue, 12 Sep 2023 18:06:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] erofs-utils: lib: refactor extended attribute name
 prefixes
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230912080015.111464-1-jefflexu@linux.alibaba.com>
 <20230912080015.111464-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230912080015.111464-2-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/12 16:00, Jingbo Xu wrote:
> Previously, when an extended attribute (xattr) name matches a long name
> prefix, the attribute name after stripping the long name prefix is
> cached in xattr_item.  This is somewhat different with those that don't
> match any long name prefix or when long name prefixes feature is not
> enabled, in which case the attribute name after stripping the predefined
> short name prefix is cached in xattr_item.
> 
> The implementation described above makes it clumsy when stripping or
> deleting specific attribute from one file, if the attribute name is in
> the long name prefix format.
> 
> To fix this, for those attribute names that match the long name prefix,
> make the attribute name with the predefined short name prefix stripped
> cached in xattr_item just like normal attribute names.
> 
> To achieve this, add two new members `index` and `infix_len` to
> xattr_item.  The semantics of the original `prefix` member is unchanged,
> i.e. representing the index of the matched predefined short name prefix,
> while `index` member represents the index of the long name prefix if
> any, or it's the same as `prefix` otherwise.  The `infix_len` member
> represents the length of the infix of the long name preifx if any, or 0
> otherwise.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   lib/xattr.c | 253 +++++++++++++++++++---------------------------------
>   1 file changed, 94 insertions(+), 159 deletions(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 54a6ae2..cac8db8 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -75,9 +75,9 @@
>   struct xattr_item {
>   	struct xattr_item *next_shared_xattr;
>   	const char *kvbuf;
> -	unsigned int hash[2], len[2], count;
> +	unsigned int hash[2], len[2], count, infix_len;
>   	int shared_xattr_id;
> -	u8 prefix;
> +	u8 prefix, index;
>   	struct hlist_node node;
>   };
>   
> @@ -115,9 +115,11 @@ static struct xattr_prefix {
>   
>   struct ea_type_node {
>   	struct list_head list;
> -	struct xattr_prefix type;
> -	u8 index;
> +	u8 index, base_index;
> +	const char *infix;
> +	u8 infix_len;
>   };
> +
>   static LIST_HEAD(ea_name_prefixes);
>   static unsigned int ea_prefix_count;
>   
> @@ -154,7 +156,8 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
>   					unsigned int len[2])

As discussed offline, I tend to drop u8 prefix here, and move match_prefix() in.

Thanks,
Gao Xiang
