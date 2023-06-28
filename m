Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D18741698
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 18:41:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPuEVqd2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPuEVqd2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrnRJ2VBTz30Pc
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jun 2023 02:41:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPuEVqd2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPuEVqd2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=billodo@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrnR84BD6z30K1
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jun 2023 02:41:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687970494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnVyCujzdEZQCQhWIXvD4KgctZ350N170aw6MNVL7b8=;
	b=MPuEVqd25gvtHieFODS13sRdV0G4bZVH+PMmgUWa5IAjHsGPG/AG8tCDWpHCVuepvybE8F
	DGzFv1LdfZZaBDuyr2k2PnlhgCgosNLhkT1RDKnWOXvj/KZZJgXvVF+ZLuKLU4L4Uwi4l6
	nWgxoclMrgjWRbV+jOS+GhRR7P45hVs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687970494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnVyCujzdEZQCQhWIXvD4KgctZ350N170aw6MNVL7b8=;
	b=MPuEVqd25gvtHieFODS13sRdV0G4bZVH+PMmgUWa5IAjHsGPG/AG8tCDWpHCVuepvybE8F
	DGzFv1LdfZZaBDuyr2k2PnlhgCgosNLhkT1RDKnWOXvj/KZZJgXvVF+ZLuKLU4L4Uwi4l6
	nWgxoclMrgjWRbV+jOS+GhRR7P45hVs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-mvbvvUpqO5KW0JldaqOrMA-1; Wed, 28 Jun 2023 12:41:31 -0400
X-MC-Unique: mvbvvUpqO5KW0JldaqOrMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC46E3C108CB;
	Wed, 28 Jun 2023 16:41:29 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 02AF1F5CD9;
	Wed, 28 Jun 2023 16:41:28 +0000 (UTC)
Date: Wed, 28 Jun 2023 11:41:27 -0500
From: Bill O'Donnell <billodo@redhat.com>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 6/7] xfs: Convert to bdev_logical_block_mask()
Message-ID: <ZJxit/naWMq3v6OU@redhat.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
 <20230628093500.68779-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-6-frank.li@vivo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org, linux-raid@vger.kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, song@kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 28, 2023 at 05:34:59PM +0800, Yangtao Li wrote:
> Use bdev_logical_block_mask() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  fs/xfs/xfs_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15d1e5a7c2d3..f784daa21219 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1968,7 +1968,7 @@ xfs_setsize_buftarg(
>  
>  	/* Set up device logical sector size mask */
>  	btp->bt_logical_sectorsize = bdev_logical_block_size(btp->bt_bdev);
> -	btp->bt_logical_sectormask = bdev_logical_block_size(btp->bt_bdev) - 1;
> +	btp->bt_logical_sectormask = bdev_logical_block_mask(btp->bt_bdev);
>  
>  	return 0;
>  }
> -- 
> 2.39.0
> 

