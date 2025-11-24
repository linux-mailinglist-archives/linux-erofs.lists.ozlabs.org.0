Return-Path: <linux-erofs+bounces-1428-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA09C7ECB4
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 03:03:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dF8J03lZ3z2yvN;
	Mon, 24 Nov 2025 13:03:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763949824;
	cv=none; b=OZDzwFT6o5OJz5megVWpZOTEVocP/++sCLgsUsc0yDusDoBeHH/VCdYUlFGR3UOASIhn1alW97gKeQr/ldxjG8PzzjNA9FRZ4q4oY+UURKGQOmy5sIARE1jsTDv4IFtlJJwhdwyVcTJnGqBTio93Ntb0uaABfF0oT9mk4AQv/oglLwdQzalxaDPNpHE4SfWBBCLndkynDzqmR7qiQza+JLeENo5zk19ap8roA/Doynkt19lGDo1kjwp5/SglwVgCcnrBO6I/SpeN/dHzHpN8BiML2HTxSsAvaR/mhch//469GjWfJaKJ/t/WdodIyyrU4pYKWUoxRC0WcMS0ESEeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763949824; c=relaxed/relaxed;
	bh=Gj9xEgD7hDR2RtpchBguB3GEdKBTmFBH1VAcFTtDlSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VGTyIzqtPJt8TUllVqZvTXm81zNdCg/w6QAOzvsBR0HjTrejsn2cqGJe+kfDEyoUL0TdkkzqZISdvbStgiqOm542cBo1p2Zaz+njRw7zhCKWnCwQxlkzmRQfj9t84n1lQCPvPmVyFryUryPvk/YTAQv78YQBbP8ZAUnvkMCw6AsYj9yGftsjvztAVijnUC7KGb1TlLM8M6h+laho4f1h77aCScAtk54cVch2IVi+yB9Y2YrumPoAdi//y1VMGz5zy5CbdvaqIH+xqAosdwkAqxpWpmSLdYKg7xnr2zZ7rPXVyWk+Gf7TtyKgubGzFVwe8z0n++qnKMEHBSpchdMKTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=02zFrAIY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=02zFrAIY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dF8Hw6G45z2yvB
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 13:03:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Gj9xEgD7hDR2RtpchBguB3GEdKBTmFBH1VAcFTtDlSc=;
	b=02zFrAIYlfdwlz+fJNxp9yowyhnkRjFZp2OFN2nDZzVp0qK8V4BOELFeVuKorEkG41a52qQ7Y
	9XcJ2zPrasKPv836bvXpekc/gM2gw5zA6AhpjEEO6BFN7nXUuQ4RMJJspVB+RysqvEM+9L5l7xo
	KNcHG9i92gBM4eOe9juRs2A=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dF8G75X9sznTWn
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 10:02:07 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A4F531A016C
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 10:03:32 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 10:03:32 +0800
Message-ID: <058b9c29-6e07-4661-8b83-b05d8762b524@huawei.com>
Date: Mon, 24 Nov 2025 10:03:31 +0800
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
Subject: Re: [PATCH v2] erofs: limit the level of fs stacking for file-backed
 mounts
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
 <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

On 2025/11/22 14:23, Gao Xiang wrote:
> Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
> mounting itself).
> 
> Reviewed-by: Sheng Yong <shengyong1@xiaomi.com>
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Change since v1:
>   - Return -ENOTBLK instead of -EINVAL since userspace tools like
>     util-linux will fall back to using loop to mount again.
> 
>     Don't use -ELOOP compared to other stacked fses, since -ENOTBLK is
>     more suitable: it means the kernel can't handle it anymore.
> 
>   fs/erofs/super.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index f3f8d8c066e4..2db534f76464 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -639,6 +639,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	sbi->blkszbits = PAGE_SHIFT;
>   	if (!sb->s_bdev) {
> +		/*
> +		 * (File-backed mounts) EROFS claims it's safe to nest other
> +		 * fs contexts (including its own) due to self-controlled RO
> +		 * accesses/contexts and no side-effect changes that need to
> +		 * context save & restore so it can reuse the current thread
> +		 * context.  However, it still needs to bump `s_stack_depth` to
> +		 * avoid kernel stack overflow from nested filesystems.
> +		 */
> +		if (erofs_is_fileio_mode(sbi)) {
> +			sb->s_stack_depth =
> +				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
> +			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +				erofs_err(sb, "maximum fs stacking depth exceeded");

Since it will success once the max stack depth is exceeded, a warning 
would be better? Otherwise it looks good me.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> +				return -ENOTBLK;
> +			}
> +		}
>   		sb->s_blocksize = PAGE_SIZE;
>   		sb->s_blocksize_bits = PAGE_SHIFT;
>   

