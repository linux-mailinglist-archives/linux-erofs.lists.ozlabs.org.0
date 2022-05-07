Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E1C51E47C
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 07:42:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KwGYV0kXXz3bpy
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 15:42:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QAziMRhw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=QAziMRhw; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KwGYQ2sL7z2xBF
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 15:42:49 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id c9so8618805plh.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 06 May 2022 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=axGutF4EXG2joxqSIRJRWv9W9uFIDQlZyIhhoP3wHfI=;
 b=QAziMRhwsaLQWo1ymC0YlxrEcOJaap42j2MiqetYaNZHEZ+GDSbSYLdwriPafFxtZW
 S9uhAOupouNSohNtCKbz7oArvyjgsEwO8AjpyHBaQZLBng8/TlIdBWZ7Gj7CfVCY/Zb9
 0hTlcjWjepG5L0d5QCcYDRxp3jt6/8oVgrxy7n4v8hNRWDxM5E0t3XE5/13qva5KABth
 6niWq+BmUionAqzWhkd7167d0r//7krFGBZtr/gUyD358hNWM/Mbs+yj9prtoFAOOkdm
 t0rDhW3dlJ0w9MpHVO7agTXTY1KEzjl1T6j2CvEumDquzNELLksQ0KeXaqu40dMyi/qv
 inwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=axGutF4EXG2joxqSIRJRWv9W9uFIDQlZyIhhoP3wHfI=;
 b=Hf+abwLi/hZMF3jZxHorEAaeAKc5MbNDkfp9uny4Nn3SFwqQVYz2xzZKkNAGA8GzeD
 QcUPuEGwxYBVLqbEuRGKtiyzQ8NgMQM5Nd0Ih1GaOM5BoWEWUfwz6zIYp0EyuQ4qkKx3
 lXlKndDqIdvRhF5cnojqN1L/aDh5jM4ZRky1VxrYzhOhrIk98Bt+nyIflLUnfzmfh+xA
 AGiOBl6+EgGJ1AgZpz0JyQwBHwc84tRSIWCzEusyTORtcHQ0b1EHCVj0h4VtuJky3kH6
 7zFvRQmwFSbLl9ChltILSuaQDx6eb/hety/8LYpu0AhKenPwU39uVyllIuke/XUdSQFn
 kaOw==
X-Gm-Message-State: AOAM5318Y10AkETPVZ42eJbKu9SBHE7515XXIvahnyjnxWrxmfHbLCqA
 m3KzCa3ROi4JmgsozU3hrRI=
X-Google-Smtp-Source: ABdhPJxtGSWhZZP1tgaKGZ3USdjTfC9nC6Jx0S823PC12IGb1Cp/8S7easenBRdpNWIT38SmkUHvqg==
X-Received: by 2002:a17:903:189:b0:15e:9584:fbe7 with SMTP id
 z9-20020a170903018900b0015e9584fbe7mr7391369plg.65.1651902166855; 
 Fri, 06 May 2022 22:42:46 -0700 (PDT)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 w9-20020a170902a70900b0015e8d4eb2absm2660503plq.245.2022.05.06.22.42.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 May 2022 22:42:46 -0700 (PDT)
Date: Sat, 7 May 2022 13:42:47 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 3/3] erofs: refine on-disk definition comments
Message-ID: <20220507134247.00007786.zbestahu@gmail.com>
In-Reply-To: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  7 May 2022 03:46:12 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Fix some outdated comments and typos, hopefully helpful.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 1238ca104f09..000fa2738974 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -79,15 +79,15 @@ struct erofs_super_block {
>  
>  /*
>   * erofs inode datalayout (i_format in on-disk inode):
> - * 0 - inode plain without inline data A:
> + * 0 - uncompressed flat inode without tail-packing inline data:
>   * inode, [xattrs], ... | ... | no-holed data
> - * 1 - inode VLE compression B (legacy):
> - * inode, [xattrs], extents ... | ...
> - * 2 - inode plain with inline data C:
> - * inode, [xattrs], last_inline_data, ... | ... | no-holed data
> - * 3 - inode compression D:
> + * 1 - compressed inode with non-compact indexes:
> + * inode, [xattrs], [map_header], extents ... | ...
> + * 2 - uncompressed flat inode with tail-packing inline data:
> + * inode, [xattrs], tailpacking data, ... | ... | no-holed data
> + * 3 - compressed inode with compact indexes:
>   * inode, [xattrs], map_header, extents ... | ...
> - * 4 - inode chunk-based E:
> + * 4 - chunk-based inode with (optional) multi-device support:
>   * inode, [xattrs], chunk indexes ... | ...
>   * 5~7 - reserved
>   */
> @@ -106,7 +106,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
>  		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
>  }
>  
> -/* bit definitions of inode i_advise */
> +/* bit definitions of inode i_format */
>  #define EROFS_I_VERSION_BITS            1
>  #define EROFS_I_DATALAYOUT_BITS         3
>  
> @@ -140,8 +140,9 @@ struct erofs_inode_compact {
>  	__le32 i_size;
>  	__le32 i_reserved;
>  	union {
> -		/* file total compressed blocks for data mapping 1 */
> +		/* total compressed blocks for compressed inodes */
>  		__le32 compressed_blocks;
> +		/* block address for uncompressed flat inodes */
>  		__le32 raw_blkaddr;
>  
>  		/* for device files, used to indicate old/new device # */
> @@ -156,9 +157,9 @@ struct erofs_inode_compact {
>  	__le32 i_reserved2;
>  };
>  
> -/* 32 bytes on-disk inode */
> +/* 32-byte on-disk inode */
>  #define EROFS_INODE_LAYOUT_COMPACT	0
> -/* 64 bytes on-disk inode */
> +/* 64-byte on-disk inode */
>  #define EROFS_INODE_LAYOUT_EXTENDED	1
>  
>  /* 64-byte complete form of an ondisk inode */
> @@ -171,8 +172,9 @@ struct erofs_inode_extended {
>  	__le16 i_reserved;
>  	__le64 i_size;
>  	union {
> -		/* file total compressed blocks for data mapping 1 */
> +		/* total compressed blocks for compressed inodes */
>  		__le32 compressed_blocks;
> +		/* block address for uncompressed flat inodes */
>  		__le32 raw_blkaddr;
>  
>  		/* for device files, used to indicate old/new device # */
> @@ -365,17 +367,16 @@ enum {
>  
>  struct z_erofs_vle_decompressed_index {
>  	__le16 di_advise;
> -	/* where to decompress in the head cluster */
> +	/* where to decompress in the head lcluster */
>  	__le16 di_clusterofs;
>  
>  	union {
> -		/* for the head cluster */
> +		/* for the HEAD lclusters */
>  		__le32 blkaddr;
>  		/*
> -		 * for the rest clusters
> -		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
> -		 * [0] - pointing to the head cluster
> -		 * [1] - pointing to the tail cluster
> +		 * for the NONHEAD lclusters
> +		 * [0] - distance to its HEAD lcluster
> +		 * [1] - distance to the next HEAD lcluster
>  		 */
>  		__le16 delta[2];
>  	} di_u;

Reviewed-by: Yue Hu <huyue2@coolpad.com>
