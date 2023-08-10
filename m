Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F05776DE9
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 04:10:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=JAfqWE3U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLr4J0TfRz3cGJ
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 12:10:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=JAfqWE3U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLr4835c6z2yw4
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 12:10:31 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so308825b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 09 Aug 2023 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691633429; x=1692238229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHnppH8OkHE3+a/XnL69tDk6mKlaaFEW6slsoeTV/t4=;
        b=JAfqWE3U8jNNlTcGM/mwc4vGcdo7iZq4rU6vElQtrpc7VfBiz+GxIa9t1PD10V5aJn
         IqfW5QNYs78BJ3Wpd1i+mnZIsGBiaEvuoEQvWNz9GvFAvTCEFCInvqu2MbXnRYBUMtvF
         FLcjHMl8FnuEP2K2/9zocgsKB1aY3E5RJf4mP5EW1kvChgc/0x9rgDwvnOZbGD1yKw1c
         XiE1LfvwZMi3LapcNLMqSlksTuV/1nrsYp/dQP6Gktln6wD5bkrHKoO0eyX4zYetoUFr
         hSKLe8QazoaEeMWcwJPN+r45SM6txTzNCUSgKI+ROEGjZeU+ysCUejrPoNbKZmpUuBzG
         Z81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691633429; x=1692238229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHnppH8OkHE3+a/XnL69tDk6mKlaaFEW6slsoeTV/t4=;
        b=V3xHIxswTXvvaAjVj7+eiMW2cIB83ppmjmSyluu8+cNHosHwEvh0rQFZWj7AVtunxt
         NLPpBsxBRiqM62/av3asZRASeYQS+842V+IQp30lSAo86YqaFulgPbuT7dcMmF2n4jaI
         Xr5JBxW7SrK56RnlGQoo15wZLp6m7TYmGB9QLhbCT0r+m27ZZwMXs/4BObMcymOjazTx
         cLDnP9misHzJRAMqT8LPasLTPuiWEQ+fkODkFPk+DNr69/xhAdnR9alN3tjYW9eyf7VJ
         92R3et5EuVsSTUeJ/62sjcyEV95DBs6ipGRAr4Lq3e2pw47aq9s+fX6ecbimtPMIrXoY
         3O8A==
X-Gm-Message-State: AOJu0YxFHEmwf4IUJObvsildb99MItJj0spqWeXeZ2xmBZ96ycYiLd5S
	hEA7RbQUpeo9NhFYHXNHc9Q=
X-Google-Smtp-Source: AGHT+IFqvlpc/IFhkjVNrtHO+AXON6RNj41vm63XDEqctsSKSr4BgGm2t15oZ9rm2Gk6eZLtco/okA==
X-Received: by 2002:a05:6a00:189c:b0:687:1300:22ff with SMTP id x28-20020a056a00189c00b00687130022ffmr1294241pfh.1.1691633429485;
        Wed, 09 Aug 2023 19:10:29 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id 24-20020aa79218000000b006827c26f148sm256157pfo.195.2023.08.09.19.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Aug 2023 19:10:29 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:20:01 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH] erofs: refine warning messages for data I/Os
Message-ID: <20230810102001.000035ca.zbestahu@gmail.com>
In-Reply-To: <20230809060637.21311-1-mengferry@linux.alibaba.com>
References: <20230809060637.21311-1-mengferry@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  9 Aug 2023 14:06:37 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

erofs: refine warning messages for zdata I/Os

> Don't warn users since -EINTR is returned due to user interruption.
> Also suppress warning messages of readmore.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index de4f12152b62..53820271e538 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1848,15 +1848,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>  
>  		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
>  		if (page) {
> -			if (PageUptodate(page)) {
> +			if (PageUptodate(page))
>  				unlock_page(page);
> -			} else {
> -				err = z_erofs_do_read_page(f, page);
> -				if (err)
> -					erofs_err(inode->i_sb,
> -						  "readmore error at page %lu @ nid %llu",
> -						  index, EROFS_I(inode)->nid);
> -			}
> +			else
> +				(void)z_erofs_do_read_page(f, page);
>  			put_page(page);
>  		}
>  
> @@ -1885,8 +1880,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>  	/* if some compressed cluster ready, need submit them anyway */
>  	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
>  
> -	if (err)
> -		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
> +	if (err && err != -EINTR)
> +		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
> +			  err, folio->index, EROFS_I(inode)->nid);
>  
>  	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&f.pagepool);
> @@ -1920,10 +1916,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  		head = (void *)page_private(page);
>  
>  		err = z_erofs_do_read_page(&f, page);
> -		if (err)
> -			erofs_err(inode->i_sb,
> -				  "readahead error at page %lu @ nid %llu",
> -				  page->index, EROFS_I(inode)->nid);
> +		if (err && err != -EINTR)
> +			erofs_err(inode->i_sb, "readahead error %d @ %lu of nid %llu",
> +				  err, page->index, EROFS_I(inode)->nid);
>  		put_page(page);
>  	}
>  	z_erofs_pcluster_readmore(&f, rac, false);

