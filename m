Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B9561A38
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 14:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LYcrs0hz0z3ch9
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 22:21:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AwQWGTsm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=jnhuang95@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AwQWGTsm;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LYcrj1GMlz2ypH
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 22:21:38 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so2847319pjs.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=lbYoREvmzql9lYj8aM58YAT4aurGaSf+5cLoACdtQTo=;
        b=AwQWGTsm0Vh3YYS6d/tE0fktE8C+ieT3zwVRsV32gyT67P/2L1YHz0MqSFiyyXQtqv
         A6SWL+btCsqV/1cmgqY9cMX02Uy4eukN7ryVwQSuaIX3oZSBSvxTHpJ45uA3F+SaAaaL
         pxkOHFb1n/GcZ764bZpjYSRHoAfvicqCyM1cQwTwgef9m1EewGfv0UIY2tmnJZa7QRLG
         k1AlzaRd/yn1AV8SzgAIolxs4vpOVPhRn4kgCns0jdHyj2PK9ZK7JaQQT0lDHMfr54b+
         RPU0OtDEL/v4x+2kXHmfYWBgWMVA6nosuEkGDpW4/DUGyBwJrDpa/askj5p44DIx/NnJ
         LjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lbYoREvmzql9lYj8aM58YAT4aurGaSf+5cLoACdtQTo=;
        b=lvuoo4eD2TSZ40YwVDBRzp/oP6UCaOUzu5lyKubbhBIzEL4q4o2G/U26983wYd/H5y
         L3n5ovE0tqaJNpjvxqxUEU2oP9vVfXvy/HpAGqdUHupPmeUT8UqFreQQ1AvLfQp+FKV7
         /SJQc8KCYHyURqDWEI8uMy6wLruJ5G/34DaiVpYqgZh7cuqyJiC8P8u4ECKX8ULOVJ/z
         c8ieTDh5bXWDgvUn3/Xr21GjdbaB5IN+s0xZ9DN0w+h61yA/iDX3eFAJBqBKXT4kYtgg
         UcNv+vvvbRsIGcDu+hijBGcBsQCtOIDMVHbmlVOVImo238vbtgyw6ruJ3DTipw6TlSFS
         AHGA==
X-Gm-Message-State: AJIora+tpyr8KqTXt+77MSc//kPmbnkNR5DpWZENMpbgee6Y1VStWI0G
	htvgPU3SiH+zkTpizm5DHMM=
X-Google-Smtp-Source: AGRyM1teyPzDASWD2AOc8A5z5MCL2FmhumEw4bgn4mZq0g242lrPVc0u/uaIgEqI+fZpma4tgUrp7Q==
X-Received: by 2002:a17:90b:3b41:b0:1ed:25b1:e53a with SMTP id ot1-20020a17090b3b4100b001ed25b1e53amr12175390pjb.71.1656591695860;
        Thu, 30 Jun 2022 05:21:35 -0700 (PDT)
Received: from [192.168.50.25] ([150.107.0.182])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902b69600b0016b82943821sm7607851pls.73.2022.06.30.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:21:35 -0700 (PDT)
Message-ID: <fe4a2475-f8c3-8e66-82db-7ee20922713f@gmail.com>
Date: Thu, 30 Jun 2022 20:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] fs: erofs: add unaligned read range handling
To: Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
References: <cover.1656502685.git.wqu@suse.com>
 <f1f81773bf816717089d2ffde1ce673f5bb25e1e.1656502685.git.wqu@suse.com>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <f1f81773bf816717089d2ffde1ce673f5bb25e1e.1656502685.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/6/29 19:38, Qu Wenruo 写道:
> I'm not an expert on erofs, but my quick glance didn't expose any
> special handling on unaligned range, thus I think the U-boot erofs
> driver doesn't really support unaligned read range.
> 
> This patch will add erofs_get_blocksize() so erofs can benefit from the
> generic unaligned read support.
> 
> Cc: Huang Jianan <jnhuang95@gmail.com>
> Cc: linux-erofs@lists.ozlabs.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Looks good to me,

Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan
> ---
>   fs/erofs/internal.h | 1 +
>   fs/erofs/super.c    | 6 ++++++
>   fs/fs.c             | 2 +-
>   include/erofs.h     | 1 +
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4af7c91560cc..d368a6481bf1 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -83,6 +83,7 @@ struct erofs_sb_info {
>   	u16 available_compr_algs;
>   	u16 lz4_max_distance;
>   	u32 checksum;
> +	u32 blocksize;
>   	u16 extra_devices;
>   	union {
>   		u16 devt_slotoff;		/* used for mkfs */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4cca322b9ead..df01d2e719a7 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -99,7 +99,13 @@ int erofs_read_superblock(void)
>   
>   	sbi.build_time = le64_to_cpu(dsb->build_time);
>   	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> +	sbi.blocksize = 1 << blkszbits;
>   
>   	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
>   	return erofs_init_devices(&sbi, dsb);
>   }
> +
> +int erofs_get_blocksize(const char *filename)
> +{
> +	return sbi.blocksize;
> +}
> diff --git a/fs/fs.c b/fs/fs.c
> index 61bae1051406..e92174d89c28 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -375,7 +375,7 @@ static struct fstype_info fstypes[] = {
>   		.readdir = erofs_readdir,
>   		.ls = fs_ls_generic,
>   		.read = erofs_read,
> -		.get_blocksize = fs_get_blocksize_unsupported,
> +		.get_blocksize = erofs_get_blocksize,
>   		.size = erofs_size,
>   		.close = erofs_close,
>   		.closedir = erofs_closedir,
> diff --git a/include/erofs.h b/include/erofs.h
> index 1fbe82bf72cb..18bd6807c538 100644
> --- a/include/erofs.h
> +++ b/include/erofs.h
> @@ -10,6 +10,7 @@ int erofs_probe(struct blk_desc *fs_dev_desc,
>   		struct disk_partition *fs_partition);
>   int erofs_read(const char *filename, void *buf, loff_t offset,
>   	       loff_t len, loff_t *actread);
> +int erofs_get_blocksize(const char *filename);
>   int erofs_size(const char *filename, loff_t *size);
>   int erofs_exists(const char *filename);
>   void erofs_close(void);
