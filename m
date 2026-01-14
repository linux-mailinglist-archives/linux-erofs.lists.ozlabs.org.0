Return-Path: <linux-erofs+bounces-1852-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A186CD1CEC2
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 08:44:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drdRQ1qh8z2xlP;
	Wed, 14 Jan 2026 18:44:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768376658;
	cv=none; b=iki0MrI2k4PG9Klh0VcS3WbD/PJSmGn1YkXeIdA9uLQYo85NGPBmfHxYcL8lMMrcQGr6W8b+pcoivFU4OFeXagsUfpketzsqzBes1shaOLd4XTsAPM8+UP2aJJVNltUbY4buIuaj+XuZAwu7V8VnE1KqSi+sfBX93QEF9hIbeW6S5SeMfGTb5iw4HAEqfK4mnV2Le4w05fVCNSgCYgUtttgrNmfCRLrWl3/xY14uEhKfkKQ8ksbBcuWOcIZuKxunl2Bk5asuEORLp6ZtlMhytXrZ8gHQlfqxRO/t254Makr/EEKKsftQdJBldTX3Y4I8ZQR8XCjS6xjHh/mfAG9T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768376658; c=relaxed/relaxed;
	bh=TvtI70ryHcICP0QWMTEGNkZXIPG/HOIJQ82bqJh6C8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCuWF8TwZe8j3ax94Kz72Nl8ILETwKt/leobqVSODPkRI+xy1s+2vzrhQ1qJMnq11MOJ2St0i6gLbLTL6XbYeTbtmHqYkNVj0jxDJ9aaVkLClBgZGcJRCLKF6PZ0F5jDmy9lDXigoeEJ9AxaNNmAqT0hnlWtW6HLBCU7UVH8FksZVZwwfdJNbx4pmKg+/eSEdMibA0Lh9Xo6Zda626ALFrf2+zmseYfokU5MGVqLUy6s73PrdZVIsCueBRYe7r4Fk/qhNe8HFq5RepVLBIMJAvP2loMzS0GnSdY66tDQLHtWFb/e+g5mqmOjrGnNtG4LRojaDYX69KCJFkE/4Jflmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gYS1CRjU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gYS1CRjU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drdRM5FGGz2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 18:44:12 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768376647; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TvtI70ryHcICP0QWMTEGNkZXIPG/HOIJQ82bqJh6C8s=;
	b=gYS1CRjUEj1c8/j0VUhTEeOHrQORtWwpg+CPhjMeG3jFxocDCvW2Hb2opz2aVu2wjjaYBfOn+c2ggZNC0JYMLDvjJT6V+nlRWDA1AovnTSUYQIEg3MZFJSwC779p7tBnjbrMlmUSLlFwETD41cOGuqzkoPlquG1jyO5BNKKoXck=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx1ZL9V_1768376644 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 15:44:05 +0800
Message-ID: <1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com>
Date: Wed, 14 Jan 2026 15:44:04 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: correctly set {u,g}id in
 erofs_rebuild_make_root()
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
 <20260114073806.3640681-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260114073806.3640681-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/14 15:38, Yifan Zhao wrote:
> In rebuild mode, the {u,g}id of the root inode is currently defaulted
> to 0 and is not controlled by --force_{u,g}id. This behavior also
> causes the {u,g}id of intermediate directories created by
> `erofs_rebuild_mkdir()` to be set to 0.
> 
> This patch fixes the behavior by explicitly setting permissions for the
> root inode:
> 
> - If --force-{u,g}id is not specified, it now defaults to the current
>     user's {u,g}id.
> - If --force-{u,g}id is specified, it correctly updates the ownership
>     for all files and directories.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   include/erofs/inode.h | 3 ++-
>   lib/inode.c           | 5 ++++-
>   mkfs/main.c           | 2 +-
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index 8b91771..2a7af31 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -48,7 +48,8 @@ int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
>   struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
>   						     int fd, const char *name);
>   int erofs_fixup_root_inode(struct erofs_inode *root);
> -struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi);
> +struct erofs_inode *erofs_rebuild_make_root(struct erofs_importer *im,
> +					    struct erofs_sb_info *sbi);
>   
>   #ifdef __cplusplus
>   }
> diff --git a/lib/inode.c b/lib/inode.c
> index 26fefa2..4f87757 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -2375,7 +2375,8 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
>   	return err;
>   }
>   
> -struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
> +struct erofs_inode *erofs_rebuild_make_root(struct erofs_importer *im,
> +					    struct erofs_sb_info *sbi)
>   {

we could support !im, I mean

	struct erofs_importer_params *params = im ? im->params : NULL;

>   	struct erofs_inode *root;
>   
> @@ -2384,6 +2385,8 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
>   		return root;
>   	root->i_srcpath = strdup("/");
>   	root->i_mode = S_IFDIR | 0777;
> +	root->i_uid = im->params->fixed_uid == -1 ? getuid() : im->params->fixed_uid;
> +	root->i_gid = im->params->fixed_gid == -1 ? getgid() : im->params->fixed_gid;



	root->i_uid = params && params->fixed_uid < 0 ? getuid() :
			params->fixed_uid;
...

Thanks,
Gao Xiang

