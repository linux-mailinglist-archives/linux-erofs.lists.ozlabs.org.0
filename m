Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7B7416AA
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 18:45:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bmzj/2/U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c9af/QTJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrnWw6ZcJz30Pc
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jun 2023 02:45:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bmzj/2/U;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c9af/QTJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=billodo@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrnWs18Twz30K1
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jun 2023 02:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687970741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vOBIaytrYiPkaqMIJvuxkcnZSEVMg/kCzHHy7/59jY=;
	b=bmzj/2/UZZ2c8nvyrz7S4VuoBdHaYtTfy33LdXXc+3gSzSLEAtsHGhiQKvtrwI08P9GKnq
	ix6ugD3SFkdnj7FblnqucdPmeg8/0KxsUVtT+0XqK+WhJNwwyxH0WXLz+BY9algC8I/8SS
	55KLGdFeenThVh00l71cIfwPMAeQM+Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687970742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vOBIaytrYiPkaqMIJvuxkcnZSEVMg/kCzHHy7/59jY=;
	b=c9af/QTJGtNG01FO5AVoW+sdqUsCQeKUq5nzPP+7k7tYYHusGGPIjtYX2K3sncxtulRAMK
	A76LkD4WxhbOqGmPIBdBTPJ9XZZpSvgBoQE387oVaxMWOlooiTGmceain/UoRXqb44RqQF
	9vTwV5T7nnUNDnBpu8K2DsRVIp5zjRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-NikTkMo9Ncix8VYrrcJkow-1; Wed, 28 Jun 2023 12:45:37 -0400
X-MC-Unique: NikTkMo9Ncix8VYrrcJkow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1A20185A7A5;
	Wed, 28 Jun 2023 16:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 126A4F5CD4;
	Wed, 28 Jun 2023 16:45:36 +0000 (UTC)
Date: Wed, 28 Jun 2023 11:45:34 -0500
From: Bill O'Donnell <billodo@redhat.com>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZJxjrpbaKyX14yPq@redhat.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
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

On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> to simplify code, which replace (queue_logical_block_size(q) - 1)
> and (bdev_logical_block_size(bdev) - 1).
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Looks fine.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ed44a997f629..0cc0d1694ef6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1150,11 +1150,21 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
>  	return retval;
>  }
>  
> +static inline unsigned int queue_logical_block_mask(const struct request_queue *q)
> +{
> +	return queue_logical_block_size(q) - 1;
> +}
> +
>  static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
>  {
>  	return queue_logical_block_size(bdev_get_queue(bdev));
>  }
>  
> +static inline unsigned int bdev_logical_block_mask(struct block_device *bdev)
> +{
> +	return bdev_logical_block_size(bdev) - 1;
> +}
> +
>  static inline unsigned int queue_physical_block_size(const struct request_queue *q)
>  {
>  	return q->limits.physical_block_size;
> -- 
> 2.39.0
> 

