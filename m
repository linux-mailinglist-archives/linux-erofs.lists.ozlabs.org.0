Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C8575B72
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 08:21:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkh8H0Ptsz3c4c
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 16:21:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Yb65uxZ0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Yb65uxZ0;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkh8F2J0jz3bnH
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 16:21:33 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id o18so3564405pgu.9
        for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rq3ZLvSfaj/cFZPRn+lx4DRT0BE9U/2W83PKsNZWj1s=;
        b=Yb65uxZ0JwdEi2YnumbgLo4unXamYQjpmzYMAsIekvbPjByORenik6tJzperLMqC4M
         XNs0Mi85goSOF4c/K2dXyB58R1wU0DH3OBWg7rkHF6+63TWV5R67GJwyMSh273oDNzn1
         JbugledOwpO/yRszJx+qx+uivOk7wbKxjUN4joIeH/wAY5o7PJgarauZjc6TbOs4WI7k
         GLcBcaDZHgpkxlxkzrnhkfHg/HFyEYuZ0nU3SB0K9Z6CthoEpx+ao7FskwI29cllkBde
         XZc3BMIsyZz95M/uf3GJ+poXbnj71nSHIJbfGsEfdOYMV/LalNtTKV75jILl5OhPjZX7
         hoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rq3ZLvSfaj/cFZPRn+lx4DRT0BE9U/2W83PKsNZWj1s=;
        b=P3tjGhatIiq9dyt7N3ZgyyC83/DfnsLljjoY+sMMkP0hJWmxbMrUxbNaGQB92ApcqT
         +niX7kGAHwFlPozBWHjTI1rcfcucG9hRFp4E0Nl3mGeI7XSYdBWJR16cDml2ZRPSUh0A
         txRA5JhTBbTc+i/n4O1Mi0DgZDbUGXji2F6jKfM7luxUYdT7rXevd5xgC6QjCBD5guQ1
         DE61XpqFHEpA2IbHWhZDc0cENmagUBh6Kml7q6QuAA1ZgNfaNRaqf2KUfiZBVgOltnVT
         X84CSFJifTp6UBGduhjInkYKMW7+um58fYAPXtLvzvUUsFPGHLMta/YRBoXqSsnZ22dE
         KTgA==
X-Gm-Message-State: AJIora95xhtME/sGa0jNmcddzOLFJLjIzAvI0g9DCKyKeIqZx7UQxMIA
	KYxiaAdklqobrIB4zkyLe3Y=
X-Google-Smtp-Source: AGRyM1vbt2/3dZUin7L+IVctThOXGlOhmUoFD9CD7iB43RcnxOg0CbpC28VFfTm+XcUiSiAFfdvRDg==
X-Received: by 2002:a65:57c6:0:b0:415:c329:5d49 with SMTP id q6-20020a6557c6000000b00415c3295d49mr10514856pgr.581.1657866090932;
        Thu, 14 Jul 2022 23:21:30 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b00168f08d0d12sm2578421plf.89.2022.07.14.23.21.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:21:30 -0700 (PDT)
Date: Fri, 15 Jul 2022 14:22:53 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 03/16] erofs: introduce `z_erofs_parse_out_bvecs()'
Message-ID: <20220715142253.00005239.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-4-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-4-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 14 Jul 2022 21:20:38 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> `z_erofs_decompress_pcluster()' is too long therefore it'd be better
> to introduce another helper to parse decompressed pages (or laterly,
> decompressed bvecs.)
> 
> BTW, since `decompressed_bvecs' is too long as a part of the function
> name, `out_bvecs' is used instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 81 +++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index c7be447ac64d..c183cd0bc42b 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -778,18 +778,58 @@ static bool z_erofs_page_is_invalidated(struct page *page)
>  	return !page->mapping && !z_erofs_is_shortlived_page(page);
>  }
>  
> +static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
> +				   struct page **pages, struct page **pagepool)
> +{
> +	struct z_erofs_pagevec_ctor ctor;
> +	enum z_erofs_page_type page_type;
> +	int i, err = 0;
> +
> +	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
> +				  pcl->pagevec, 0);
> +	for (i = 0; i < pcl->vcnt; ++i) {
> +		struct page *page = z_erofs_pagevec_dequeue(&ctor, &page_type);
> +		unsigned int pagenr;
> +
> +		/* all pages in pagevec ought to be valid */
> +		DBG_BUGON(!page);
> +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> +
> +		if (z_erofs_put_shortlivedpage(pagepool, page))
> +			continue;
> +
> +		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> +			pagenr = 0;
> +		else
> +			pagenr = z_erofs_onlinepage_index(page);
> +
> +		DBG_BUGON(pagenr >= pcl->nr_pages);
> +		/*
> +		 * currently EROFS doesn't support multiref(dedup),
> +		 * so here erroring out one multiref page.
> +		 */
> +		if (pages[pagenr]) {
> +			DBG_BUGON(1);
> +			SetPageError(pages[pagenr]);
> +			z_erofs_onlinepage_endio(pages[pagenr]);
> +			err = -EFSCORRUPTED;
> +		}
> +		pages[pagenr] = page;
> +	}
> +	z_erofs_pagevec_ctor_exit(&ctor, true);
> +	return err;
> +}
> +
>  static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct z_erofs_pcluster *pcl,
>  				       struct page **pagepool)
>  {
>  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>  	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> -	struct z_erofs_pagevec_ctor ctor;
>  	unsigned int i, inputsize, outputsize, llen, nr_pages;
>  	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
>  	struct page **pages, **compressed_pages, *page;
>  
> -	enum z_erofs_page_type page_type;
>  	bool overlapped, partial;
>  	int err;
>  
> @@ -823,42 +863,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  	for (i = 0; i < nr_pages; ++i)
>  		pages[i] = NULL;
>  
> -	err = 0;
> -	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
> -				  pcl->pagevec, 0);
> -
> -	for (i = 0; i < pcl->vcnt; ++i) {
> -		unsigned int pagenr;
> -
> -		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
> -
> -		/* all pages in pagevec ought to be valid */
> -		DBG_BUGON(!page);
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (z_erofs_put_shortlivedpage(pagepool, page))
> -			continue;
> -
> -		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> -			pagenr = 0;
> -		else
> -			pagenr = z_erofs_onlinepage_index(page);
> -
> -		DBG_BUGON(pagenr >= nr_pages);
> -
> -		/*
> -		 * currently EROFS doesn't support multiref(dedup),
> -		 * so here erroring out one multiref page.
> -		 */
> -		if (pages[pagenr]) {
> -			DBG_BUGON(1);
> -			SetPageError(pages[pagenr]);
> -			z_erofs_onlinepage_endio(pages[pagenr]);
> -			err = -EFSCORRUPTED;
> -		}
> -		pages[pagenr] = page;
> -	}
> -	z_erofs_pagevec_ctor_exit(&ctor, true);
> +	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
>  
>  	overlapped = false;
>  	compressed_pages = pcl->compressed_pages;

Reviewed-by: Yue Hu <huyue2@coolpad.com>
