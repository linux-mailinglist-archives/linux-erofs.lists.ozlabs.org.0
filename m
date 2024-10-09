Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4C9960EB
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 09:31:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNl224Zp6z3bbR
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 18:31:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728459097;
	cv=none; b=Q0eMv7l3jFidGQmaL3qikFn2e9dCUJzxEFJ8VA8cM/+pU02KtlqJ9Wfqc/y+Du/H5jPzdqQIetcB0d3vz/Ef2yb1IK2K7fiCy0PtosAT+8nc/9RhNm8tKhhaxWmynKZKUpl+8MhVaJKdeu3F6aH6wPQ9RnTHns/nlhXBLASUUm+C5UEe11XEciDwRLlFPT+vX9DVHQUb635uQYBdNYWE77g4wHhyT3LE0esBb3fuStGROfBG+55BQUZ+ia7ZjrGgen38oQ5OtA60c+krOoIR+Kj6RYr7t2HkC2T3w+H2cTaDLoWMARSkU81jZIzF90MhKr9MvjHWAl4As7bMD7QdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728459097; c=relaxed/relaxed;
	bh=jZqLAC3MRdTsqXfdRTrZ8YpQt2c+tTA1yWYUJqu0P5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG8QkrcYD30TmrYtO0Vg7PYvect9JVW6ivRKE5V3EI8GRPEIKXBeZhqCtutlrvkudm0uPZiOdzKguMYOkJvP1tnfBX69nLoH/8cjtxcNH9UmiXZuT7lrUAa37+UXWkSN/IVSG9MnnUMiVIgHB/L/0O8yzZdXDiyKvkphc8jgLUgOe6GSKqYQ0Mb685yt8HDtcbQ3FbCZcaq3/VHDiaQYz3+2IEpmMEBs4DbZYetM8hNZoiVSehFQa8kiqE8qv4IdHo4bOAh7wIgviIQdHELAGA2/oxRTHDUo0HGCuHIcKKNBpiS055PwnvzexpSWuLISwp3Cl+HyrV3e7hRaivpOUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fe/tI5M+; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cb460f4b002c9a6a9c29+7717+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fe/tI5M+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cb460f4b002c9a6a9c29+7717+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNl205dBzz2xs0
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 18:31:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jZqLAC3MRdTsqXfdRTrZ8YpQt2c+tTA1yWYUJqu0P5c=; b=fe/tI5M+hy7HITYN8Vcm9vzsSn
	zSl69WsztIZ7NWUzZk/7J48NDLNXZnH16V3ol7noRDmSxfFz6Bs06085H02Z9Yp+8+T1yBJBKEi01
	Hiz4IM2bHULEUHQCzlL//1l6w/PDuxBjmppkcaikA2+Yh2EqnBSamZOrxsz9zliPZvyCUa+VIocKd
	NuxNLQLPs1N3GMmNU5kiJEnrOwXVItruDzxXospaupEfR5wosuG87xyB/G6FbRsaNp0I+fmgZzh8r
	0QLmmE7jenjDl2THrkCbZ3e2uf9YZaHxHdeldtQJE1/CiU5/0dHgq0QV0IZjYGq/Kv43tAEqHA71X
	Tvzgsf2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syRAT-00000008FFP-2t3k;
	Wed, 09 Oct 2024 07:31:33 +0000
Date: Wed, 9 Oct 2024 00:31:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
Message-ID: <ZwYxVcvyjJR_FM0U@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 09, 2024 at 11:31:51AM +0800, Gao Xiang wrote:
> Users can pass in an arbitrary source path for the proper type of
> a mount then without "Can't lookup blockdev" error message.
> 
> Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
> Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>  - use new get_tree_bdev_flags().
> 
>  fs/erofs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..b89836a8760d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
> -	ret = get_tree_bdev(fc, erofs_fc_fill_super);
> +	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> +		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> +			GET_TREE_BDEV_QUIET_LOOKUP : 0);

Why not pass it unconditionally and provide your own more useful
error message at the end of the function if you could not find any
source?

