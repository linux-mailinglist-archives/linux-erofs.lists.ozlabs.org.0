Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070A7514E8
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 02:01:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OTg/KzSH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1ZXJ1nzCz3bxr
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 10:01:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OTg/KzSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1ZXC4nd9z30XP
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 10:01:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KxXUCgJglmB5dbFFfEaMSuylDxhccdLxtBgB6REN/B4=; b=OTg/KzSH0/oOudFd276JdK54x/
	VZgOjVxeC5WtxoYfEjsEtHQ3sA93SkjC2rlVWoG82v/T8+Mbp+fN1eMP/PA8psq73Hlg89ULZLU5u
	gfelEk3Ct99LBW/Gj8N2qDBz+KhdKdbDZVk7q1U2St5KbV1vAtqqK9Cg2059dEh8Yftxu2IyWOD5d
	VaQpKWCEzJUH6hUelR7mY8MPITszMvFeqNOx5Nv398iQPTIrip8wFNOaPtOBo7IPYqd6ZJIFQq/bO
	jq8HoRqNjvL18YDhiNH7+xpg6Rnb9eUtpqYaKemeqEBLwzSjCXvaDNHdHLHVCPT5zUDHv7+P0iQje
	/awVgMKQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJjlx-001XO3-27;
	Thu, 13 Jul 2023 00:01:29 +0000
Message-ID: <a2900d12-d90a-b5d3-b158-c079911fdf03@infradead.org>
Date: Wed, 12 Jul 2023 17:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] erofs: DEFLATE compression support
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
 <20230712234611.4712-1-hsiangkao@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712234611.4712-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/12/23 16:46, Gao Xiang wrote:
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index f259d92c9720..d7b5327215f0 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
>  
>  	  If unsure, say N.
>  
> +config EROFS_FS_ZIP_DEFLATE
> +	bool "EROFS DEFLATE compressed data support"
> +	depends on EROFS_FS_ZIP
> +	select ZLIB_INFLATE
> +	help
> +	  Saying Y here includes support for reading EROFS file systems
> +	  containing DEFLATE compressed data.  It gives better compression
> +	  ratios than the default LZ4 format, whileas it costs more CPU

not a word:                                   whileas

> +	  overhead.
> +
> +	  DEFLATE support is an experimental feature for now and so most
> +	  file systems will be readable without selecting this option.
> +
> +	  If unsure, say N.

-- 
~Randy
