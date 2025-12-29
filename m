Return-Path: <linux-erofs+bounces-1635-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA6CE6C99
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 13:58:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfx9C1692z2xdV;
	Mon, 29 Dec 2025 23:58:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767013103;
	cv=none; b=V5EkRIoQc4FJ1TXtA1vds4w4qDWXwvNFtp8sk4u8BM5KbHn5HwhM+wE5NQlZs+aW2sWygrRT5+m2dvtf5nLuUbVrP+ArjyTkC18IWsqk8SN9kVW1ci3qmxBn4SsrBE7+pTEyGyIQfzBQ+6oafK2fVa2GeXdsPUaKyMQ7Zkn+/hyEfTGXfm5zPZlFD2r+82kfRWKogZRI9JTLHbvyYq81cnEMnEcmjI415/5d/8oncVs1zTQIF90frKj+z0M2a7dplNsheUEiMSR6W951F/51O+xCvhu25SDxPeTPyJJ6cEXf9C57lOXV+E/eGo9gymswIYHFgVjfjaDZBQdspSZNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767013103; c=relaxed/relaxed;
	bh=jvILjNvoViwBcJ/+A6GyPHlJ7M18ybqAecYbLMZIN9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UeruFipHCNQjW3aDBvD1DFkl5anLr2AwF/0wHabtht7jvHlSlJ0h/k7oXRnHKm0WSKSKfEH1mTCUo//VAzkx6fISVPTFnkgQ31wNAOAhXdO+Auevcd8FtLSM35RW7iO2VxboHFGgrQ2f9QbJ1fqnsCUCgLD41gpoRbDiTfKmIgGL0W/zBOweE/zC2bdt/IMrN9qE5w/7awb3BsM/uDlXYkUJjIyNZbnefs3XJp6/PMnWrmz10Bq5JgWjqj/YXbYjNxaP+/JouXN6DUFIjEGgLJmNaylLJ/b8RFW8n8bTpC8PEpVLpBkhjgI874Isapebz3Fjc1scUWzDAuyUnZ6jhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rQlZEJW4; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rQlZEJW4; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rQlZEJW4;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rQlZEJW4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfx973pr8z2xFn
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 23:58:17 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jvILjNvoViwBcJ/+A6GyPHlJ7M18ybqAecYbLMZIN9k=;
	b=rQlZEJW4E8nVmPX+FVJSFOWHDvN+ud67J9VCOP9EiqSKVLCU5aoNJBx/99tmP5kA4e8qg84W8
	IleDgXcq0fR9DMxcQYFo1gz6O8Tr5uM3543lVkMytmgLRE75b5iHUxLArvboV5ds5d06vZOycRQ
	bxKqX7LJthREFE7HSkSWSss=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dfx7d3k7Hz1BGFb
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 20:57:01 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jvILjNvoViwBcJ/+A6GyPHlJ7M18ybqAecYbLMZIN9k=;
	b=rQlZEJW4E8nVmPX+FVJSFOWHDvN+ud67J9VCOP9EiqSKVLCU5aoNJBx/99tmP5kA4e8qg84W8
	IleDgXcq0fR9DMxcQYFo1gz6O8Tr5uM3543lVkMytmgLRE75b5iHUxLArvboV5ds5d06vZOycRQ
	bxKqX7LJthREFE7HSkSWSss=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dfwyr6W2vzcb0B;
	Mon, 29 Dec 2025 20:49:24 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 87C0A40539;
	Mon, 29 Dec 2025 20:52:40 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 20:52:40 +0800
Message-ID: <fe5fe3af-1177-42c0-af10-d3c106c58b9d@huawei.com>
Date: Mon, 29 Dec 2025 20:52:39 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs-utils: lib: introduce prefix-aware
 erofs_setxattr()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20251229074959.2147985-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229074959.2147985-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 15:49, Gao Xiang wrote:
> Allows users to specify a predefined prefix for xattr names.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   include/erofs/xattr.h |  5 +++--
>   lib/tar.c             |  2 +-
>   lib/xattr.c           | 45 +++++++++++++++++++++++++++++++++----------
>   3 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 83aca44f8e44..941bed778956 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -36,9 +36,10 @@ int erofs_xattr_insert_name_prefix(const char *prefix);
>   void erofs_xattr_cleanup_name_prefixes(void);
>   int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
>   int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
> -
> -int erofs_setxattr(struct erofs_inode *inode, char *key,
> +int erofs_setxattr(struct erofs_inode *inode, int index, const char *name,
>   		   const void *value, size_t size);
> +int erofs_vfs_setxattr(struct erofs_inode *inode, const char *name,
> +		       const void *value, size_t size);
>   int erofs_set_opaque_xattr(struct erofs_inode *inode);
>   void erofs_clear_opaque_xattr(struct erofs_inode *inode);
>   int erofs_set_origin_xattr(struct erofs_inode *inode);
> diff --git a/lib/tar.c b/lib/tar.c
> index 16da593c3df1..8aa90c7dc0d4 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -411,7 +411,7 @@ int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
>   		item->kv[item->namelen] = '\0';
>   		erofs_dbg("Recording xattr(%s)=\"%s\" (of %u bytes) to file %s",
>   			  item->kv, v, vsz, inode->i_srcpath);
> -		ret = erofs_setxattr(inode, item->kv, v, vsz);
> +		ret = erofs_vfs_setxattr(inode, item->kv, v, vsz);
>   		if (ret == -ENODATA)
>   			erofs_err("Failed to set xattr(%s)=%s to file %s",
>   				  item->kv, v, inode->i_srcpath);
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 96be0b1bede5..b6b1a5e600fb 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -179,7 +179,7 @@ static struct erofs_xattr_prefix {
>   	const char *prefix;
>   	unsigned int prefix_len;
>   } xattr_types[] = {
> -	[EROFS_XATTR_INDEX_USER] = {
> +	[0] = {""}, [EROFS_XATTR_INDEX_USER] = {
>   		XATTR_USER_PREFIX,
>   		XATTR_USER_PREFIX_LEN
>   	}, [EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = {
> @@ -501,22 +501,41 @@ err:
>   	return ret;
>   }
>   
> -int erofs_setxattr(struct erofs_inode *inode, char *key,
> -		   const void *value, size_t size)
> +int erofs_setxattr(struct erofs_inode *inode, int index,
> +		   const char *name, const void *value, size_t size)
>   {
>   	struct erofs_sb_info *sbi = inode->sbi;
> -	char *kvbuf;
> -	unsigned int len[2];
>   	struct erofs_xattritem *item;
> +	struct erofs_xattr_prefix *prefix = NULL;
> +	struct ea_type_node *tnode;
> +	unsigned int len[2];
> +	int prefix_len;
> +	char *kvbuf;
>   
> -	len[0] = strlen(key);
> +	if (index & EROFS_XATTR_LONG_PREFIX) {
> +		list_for_each_entry(tnode, &ea_name_prefixes, list) {
> +			if (index == tnode->index) {
> +				prefix = &tnode->type;
> +				break;
> +			}
> +		}
> +	} else if (index < ARRAY_SIZE(xattr_types)) {
> +		prefix = &xattr_types[index];
> +	}
> +
> +	if (!prefix)
> +		return -EINVAL;
> +
> +	prefix_len = prefix->prefix_len;
> +	len[0] = prefix_len + strlen(name);
>   	len[1] = size;
>   
>   	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
>   	if (!kvbuf)
>   		return -ENOMEM;
>   
> -	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
> +	memcpy(kvbuf, prefix->prefix, prefix_len);
> +	memcpy(kvbuf + prefix_len, name, EROFS_XATTR_KSIZE(len) - prefix_len);
>   	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
>   
>   	item = get_xattritem(sbi, kvbuf, len);
> @@ -528,6 +547,12 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
>   	return erofs_inode_xattr_add(&inode->i_xattrs, item);
>   }
>   
> +int erofs_vfs_setxattr(struct erofs_inode *inode, const char *name,
> +		       const void *value, size_t size)
> +{
> +	return erofs_setxattr(inode, 0, name, value, size);
> +}
> +
>   static void erofs_removexattr(struct erofs_inode *inode, const char *key)
>   {
>   	struct erofs_inode_xattr_node *node, *n;
> @@ -543,7 +568,7 @@ static void erofs_removexattr(struct erofs_inode *inode, const char *key)
>   
>   int erofs_set_opaque_xattr(struct erofs_inode *inode)
>   {
> -	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
> +	return erofs_vfs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
>   }
>   
>   void erofs_clear_opaque_xattr(struct erofs_inode *inode)
> @@ -553,7 +578,7 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode)
>   
>   int erofs_set_origin_xattr(struct erofs_inode *inode)
>   {
> -	return erofs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
> +	return erofs_vfs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
>   }
>   
>   #ifdef WITH_ANDROID
> @@ -671,7 +696,7 @@ int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
>   			continue;
>   		}
>   
> -		ret = erofs_setxattr(inode, key, value, size);
> +		ret = erofs_vfs_setxattr(inode, key, value, size);
>   		free(value);
>   		if (ret)
>   			break;

