Return-Path: <linux-erofs+bounces-987-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F79B4A370
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 09:26:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLb3B6yTRz305n;
	Tue,  9 Sep 2025 17:26:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757402774;
	cv=none; b=lWsD7AcqCBVQiKJS77DJXWFSfJlu0LhlZn/+BnJykrMhRFfRvNE7FqUnkQRJTmuijfvop6C9rrooq0kt6S/T28uL4od2txZnouVRNpT4brtWhsQrfDSvm3aMurudk+IHgT0QLrc19aJcQmGe9uYhx4NKtnH6x6BF1H5SNAtE1rO3/62QgqSDDxKPzxTLbxMLDdb8XMJgJtNfTXrMnjh4jmlzrDTpAXnxWvdUxD1/ZGQ5iAHpRKVRberLpp54DuBFqx8VkS6aUKrv3Z3SeG+j0vbYFySfplkMCoG/5oi8DKDGp29gxBTIdYZns4KpjI+XWbbUr2HnG34Fjco3E6LBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757402774; c=relaxed/relaxed;
	bh=Uut4QBL7Xiq3YtWBD2ApLnDhl1sSd6NEPGGzLW9qKaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhPWWRlWuS7SKo+DW6GJ5Uq9UofFGvNNYXUUWnmYOAYBGNn4S4O7YZtjTm5qGVpd0OQYr1FTWrEzT53KjJ3/zMTGE9OehWLhg41ofWIMaOBs8H0jai1oAXtBs/Qe5LVdtC8aTxQZVHfc0jdjEkwhGmUrDbDMHkpqBS6/SfuY9LpmfHUg6ewfVyD/fmLbpggi6y+scP+utAdCy2JeamW/CARm3rvpaRj8dKDhCQ0VulRY+SksLmNFs8yBrsrDT5HxmZBy8AhvuGf6c45Fcr2o5PcxhTRIFUFepXdJOUA7HTaP72V3CJr4Sd0AqE8WFpW1i3Ue6Gim36yNWOlNkRYc/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JuH0mv1B; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JuH0mv1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLb381kC0z2yqh
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 17:26:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757402766; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Uut4QBL7Xiq3YtWBD2ApLnDhl1sSd6NEPGGzLW9qKaM=;
	b=JuH0mv1BXtAd1D0hInqAbGEf2YYXGu/rHJeRXd9Q+q0LHuwTg0duAkKad3LIpM70j7cZHSkE6IvoWEOzKwz4zoeRbDJDFw5ehUZaYwTipCNWk0j04UooQkcHU3b1essRib99Qpj7/PgHoWWjZLtARHxppi/CXxmc98JOOEa2CMA=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnctdRL_1757402764 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:26:05 +0800
Message-ID: <0f01805f-434c-4b7a-b6da-52efbbff2b87@linux.alibaba.com>
Date: Tue, 9 Sep 2025 15:26:04 +0800
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
Subject: Re: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yuezhang,

On 2025/9/9 10:52, Yuezhang Mo wrote:
> This patch addresses 4 memory leaks and 1 allocation issue to
> ensure proper cleanup and allocation:
> 
> 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().
> 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().
> 3. Fixed incorrect allocation of chunk index array in
>     erofs_rebuild_write_blob_index() to ensure correct array allocation
>     and avoid out-of-bounds access.
> 4. Fixed memory leak of struct erofs_blobchunk not being freed by
>     calling erofs_blob_exit() in rebuild mode.
> 5. Fix memory leak by calling erofs_put_super().
>     In main(), erofs_read_superblock() is called only to get the block
>     size. In erofs_mkfs_rebuild_load_trees(), erofs_read_superblock()
>     is called again, causing sbi->devs to be overwritten without being
>     released.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Thanks for your patch and sorry for a bit delay...

> ---
>   lib/compress.c | 2 ++
>   lib/inode.c    | 3 +++
>   lib/rebuild.c  | 2 +-
>   mkfs/main.c    | 3 ++-
>   4 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 622a205..dd537ec 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
>   		}
>   #endif
>   	}
> +
> +	free(sbi->zmgr);
>   	return 0;
>   }
> diff --git a/lib/inode.c b/lib/inode.c
> index 7ee6b3d..0882875 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>   	} else {
>   		free(inode->i_link);
>   	}
> +
> +	if (inode->chunkindexes)
> +		free(inode->chunkindexes);

For now, this needs a check

	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
		free(inode->chunkindexes);

I admit it's not very clean, but otherwise it doesn't work
since `chunkindexes` is in a union.

>   	free(inode);
>   	return 0;
>   }
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 0358567..18e5204 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
>   
>   	unit = sizeof(struct erofs_inode_chunk_index);
>   	inode->extent_isize = count * unit;
> -	idx = malloc(max(sizeof(*idx), sizeof(void *)));
> +	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
>   	if (!idx)
>   		return -ENOMEM;
>   	inode->chunkindexes = idx;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 28588db..bcde787 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1702,6 +1702,7 @@ int main(int argc, char **argv)
>   			goto exit;
>   		}
>   		mkfs_blkszbits = src->blkszbits;
> +		erofs_put_super(src);

Do you really need to fix this now (considering `mkfs.erofs`
will exit finally)?

In priciple, I think it should be fixed with a reference and
something similiar to the kernel fill_super.

I'm not sure if you have more time to improve this anyway,
but the current usage is not perfect on my side...


Thanks,
Gao Xiang

>   	}
>   
>   	if (!incremental_mode)
> @@ -1908,7 +1909,7 @@ exit:
>   	erofs_dev_close(&g_sbi);
>   	erofs_cleanup_compress_hints();
>   	erofs_cleanup_exclude_rules();
> -	if (cfg.c_chunkbits)
> +	if (cfg.c_chunkbits || source_mode == EROFS_MKFS_SOURCE_REBUILD)
>   		erofs_blob_exit();
>   	erofs_xattr_cleanup_name_prefixes();
>   	erofs_rebuild_cleanup();


