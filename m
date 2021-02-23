Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D022322692
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 08:45:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DlB0V0x4Nz3cGJ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 18:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+v0Wcbp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+v0Wcbp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=d+v0Wcbp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+v0Wcbp; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DlB0S2S8jz30Qv
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 18:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614066291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSL7R8N6aFwp9SJMIxBXlxzl46HE12DDQh37CYhkuaQ=;
 b=d+v0WcbpdbNxjRJHMvs1LkQaQjkAO5r5aQFbCHup5xPEwuPwk95GFfICCI2ZWQRmHoH4qU
 YDc3uRUcu8ogjY1mECuTC46Jhvn2cYHNE0uEXbvI+oob8uSFnEZntrXHmViQB7V+xt5UCg
 LFA2RCVa5VaxOkLRX4jYosGzHfiKqgk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614066291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSL7R8N6aFwp9SJMIxBXlxzl46HE12DDQh37CYhkuaQ=;
 b=d+v0WcbpdbNxjRJHMvs1LkQaQjkAO5r5aQFbCHup5xPEwuPwk95GFfICCI2ZWQRmHoH4qU
 YDc3uRUcu8ogjY1mECuTC46Jhvn2cYHNE0uEXbvI+oob8uSFnEZntrXHmViQB7V+xt5UCg
 LFA2RCVa5VaxOkLRX4jYosGzHfiKqgk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-cmWhbO-VPD2sgHONAzlHxQ-1; Tue, 23 Feb 2021 02:44:30 -0500
X-MC-Unique: cmWhbO-VPD2sgHONAzlHxQ-1
Received: by mail-pl1-f198.google.com with SMTP id k16so9546013plk.20
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Feb 2021 23:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CSL7R8N6aFwp9SJMIxBXlxzl46HE12DDQh37CYhkuaQ=;
 b=oPl1Jt5xlM3UgffaEsM4oVB6p4TSSUK9o/1cbk4lmdipnVLZlnvlvw7Qlcu0eenOO/
 Anu04ppd559+vOjgU+tMRFkESt4zqmkhuotlo9f3xlMCrE3vmoCW/bd4U8XpRAMVC1VF
 tvp4OBFJRGFmyk0G8o09ds3QCss/lxbCsmeUvCHazWhurZN7trqSCgtM+b4Fve3x4tln
 Y5wq0T4dDfwSlcugLdGTiHDcwf371eLSpzQ+5SP6IL/mJDqNKeWdNOTMa4G1aW//rEkG
 dLb/bmA7j6910L0ctgVQtqkpLX843V+0k/2JgWVpFixCdrDZu4HbwSj+UIkyq+TGsdrY
 qtNg==
X-Gm-Message-State: AOAM532g3Xft+J3MyPFjD1cFOHkuoeaZ71Bwb1Ts7QOY5fXf+wpcwGqb
 VOrLBrLgCHjGIQ9Wcj10fAqG1NVxWoNfwtd3S3xIzJK4cn8wQw0DsQWUa+3kgVKyN6B+Tbw3Ni1
 WyZE/IrtSFBhcWigGV/qH952b
X-Received: by 2002:a17:90a:4e0b:: with SMTP id
 n11mr28454043pjh.145.1614066269795; 
 Mon, 22 Feb 2021 23:44:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza7ENGaVXTDs4pzYM7+xeO9o3YBuiJvpHYifqtjV2ZtXxHInra/9gMuV+LEzN6dGZpKHYzdw==
X-Received: by 2002:a17:90a:4e0b:: with SMTP id
 n11mr28454027pjh.145.1614066269540; 
 Mon, 22 Feb 2021 23:44:29 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s62sm14021560pfb.148.2021.02.22.23.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 23:44:29 -0800 (PST)
Date: Tue, 23 Feb 2021 15:44:18 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v3] erofs: support adjust lz4 history window size
Message-ID: <20210223074418.GA1269766@xiangao.remote.csb>
References: <20210223073119.69232-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210223073119.69232-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 23, 2021 at 03:31:19PM +0800, Huang Jianan via Linux-erofs wrote:
> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> using rolling decompression, a block with a higher compression
> ratio will cause a larger memory allocation (up to 64k). It may
> cause a large resource burden in extreme cases on devices with
> small memory and a large number of concurrent IOs. So appropriately
> reducing this value can improve performance.
> 
> Decreasing this value will reduce the compression ratio (except
> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> currently only supports 4k output, reducing this value will not
> significantly reduce the compression benefits.
> 
> The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
> we can only reduce this value. For the old kernel, it just can't
> reduce the memory allocation during rolling decompression without
> affecting the decompression result.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
> 
> change since v2:
> - use z_erofs_load_lz4_config to calculate lz4_distance_pages
> - add description about the compatibility of the old kernel version
> - drop useless comment
> 
>  fs/erofs/decompressor.c | 22 ++++++++++++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  7 +++++++
>  fs/erofs/super.c        |  2 ++
>  4 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..0bb7903e3f9b 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -28,6 +28,18 @@ struct z_erofs_decompressor {
>  	char *name;
>  };
>  
> +int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
> +			    struct erofs_super_block *dsb)
> +{
> +	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
> +
> +	sbi->lz4_max_distance_pages = distance ?
> +					(DIV_ROUND_UP(distance, PAGE_SIZE) + 1) :

Unneeded parentheses here (I'll update it when applying).
Otherwise it looks good to me.

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

