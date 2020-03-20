Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7618DBDA
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 00:24:37 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kfxZ2Zt5zDrgR
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 10:24:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::344;
 helo=mail-ot1-x344.google.com; envelope-from=linkinjeon@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vN1/Ute8; dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kfxR3Rm4zDrS7
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 10:24:22 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id a49so7701096otc.11
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2020 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=r1RjSBup4MWDnxcSCK94McxMdoDpG8eO0JDhY4wpKR0=;
 b=vN1/Ute8SimVqT3y3hab78UyOf4VVJ7VRiHOmD/0YEw4RVsLYf+I9I+znQgoZJ4gdB
 ictTZbD1FHachCP/sbEN+nf5NkPQ3zRL8Ac1BelFOIse/g9g6UpeoAfXXPC7J0vE8auY
 ePcveIYKTMSHJgWhosQIxl0CCrkGF9pmyNFPTwd0v+oVmX5riIDdzQ03F5K6zEp+Yorg
 xUhrv1K+sA6wqpG3J43WbuJGu1I6tO2+B7xlqRuhBhDVQUlM25cT94sYTuO+2rNTPHR+
 wUJD/jin1TicQd15MZDDptDmvyxFQ3GYs+b1BI3MQaatUfXjIV8IMG9GTl9ZI1NYxiQ/
 JVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=r1RjSBup4MWDnxcSCK94McxMdoDpG8eO0JDhY4wpKR0=;
 b=nL7+IvNvPKBVQFTkHTH2mhUbzqu0yS/UgplCphJXOKbFB7y0fmDQSFX9IOJkYM0W6r
 G/qiR1i7X9LNQMzt1EQABZAyqgIH1Rfjv7FVPJeRNCKzC8LtVL8HLqyQddwMK4kSfV6h
 3XhVIbG8QOLfBZLWfD4IbCWtTZS7d67VOBPHlpnZofSStWdDX1JQCDWm0owE6NzDzbMo
 5yrTUe28FxkTT7rwA6g4vRLgwnLZlV0eZkULez2xmGp9CsX/EYnhZz4yI0DqU0OXMLrn
 Zk4G+L+Qy59ga39Ruj6TndDcU2Q2V6kJw1DijDnRKOcKfIoC4JEdhGhkqDpa23pgdrIV
 8tzQ==
X-Gm-Message-State: ANhLgQ3SROF4HqlMHF8IiePdY7ZrBnV9uunJMb9urAOh5QF/DjtDoAT0
 DGnZdQLK6ogkUUO/pcLn7mIvyan5I0yjgLP8vhQ=
X-Google-Smtp-Source: ADFU+vvk42JpEDDDlDUp6QEGUIHSuidkoO4gJ/JVIxwHCPUSqqRu1OBVOgg9ZhRrthX3kgHdC2yuDHRY3AYH9iDgANA=
X-Received: by 2002:a05:6830:1608:: with SMTP id
 g8mr9414965otr.282.1584746659261; 
 Fri, 20 Mar 2020 16:24:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:8e:0:0:0:0:0 with HTTP;
 Fri, 20 Mar 2020 16:24:18 -0700 (PDT)
In-Reply-To: <20200320142231.2402-17-willy@infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-17-willy@infradead.org>
From: Namjae Jeon <linkinjeon@gmail.com>
Date: Sat, 21 Mar 2020 08:24:18 +0900
Message-ID: <CAKYAXd-NGQvMoYg=TV1T=8OZdQcYwcncK_Hix8OkF0GqmYr9Wg@mail.gmail.com>
Subject: Re: [PATCH v9 16/25] fs: Convert mpage_readpages to mpage_readahead
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-xfs@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
 William Kucharski <william.kucharski@oracle.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> diff --git a/drivers/staging/exfat/exfat_super.c
> b/drivers/staging/exfat/exfat_super.c
> index b81d2a87b82e..96aad9b16d31 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
Maybe, You should change fs/exfat instead of staging/exfat that is
gone from -next ?

> @@ -3002,10 +3002,9 @@ static int exfat_readpage(struct file *file, struct
> page *page)
>  	return  mpage_readpage(page, exfat_get_block);
>  }
>
> -static int exfat_readpages(struct file *file, struct address_space
> *mapping,
> -			   struct list_head *pages, unsigned int nr_pages)
> +static void exfat_readahead(struct readahead_control *rac)
>  {
> -	return  mpage_readpages(mapping, pages, nr_pages, exfat_get_block);
> +	mpage_readahead(rac, exfat_get_block);
>  }
>
>  static int exfat_writepage(struct page *page, struct writeback_control
> *wbc)
> @@ -3104,7 +3103,7 @@ static sector_t _exfat_bmap(struct address_space
> *mapping, sector_t block)
>
>  static const struct address_space_operations exfat_aops = {
>  	.readpage    = exfat_readpage,
> -	.readpages   = exfat_readpages,
> +	.readahead   = exfat_readahead,
>  	.writepage   = exfat_writepage,
>  	.writepages  = exfat_writepages,
>  	.write_begin = exfat_write_begin,
