Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948E4E27E3
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 14:41:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMbP23Nbmz30M3
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 00:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gDa4hOdW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=gDa4hOdW; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMbNq25hMz2x9R
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 00:40:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=A5pIWGpAlCpmoXO/m/tQzGXHU5kEsQj3f9sYGkjo+tw=; b=gDa4hOdWqKAvf/Z2G+BXMo9fDJ
 awDh71+oGBKuK2GtiNS0Bm6vNc3vODkCarJJOJNd0U+6kPxpFSLz/TNPERV3p6KDWys1hUBuyP111
 jaOqD+rF8Oh8tEErWlBCoqf8nu8kjqkedeovDbL25fIpUO0nzHM8D3uR3rBTfK/WzSNl4K8JZ1XDO
 Sdoqfbe3jUnOjltxe81qwd9VhUmcXzXcLHdkmtygg+uZo4IIYk/xFP0o6hhT0oOry28KA0oy97UFy
 HjQKcsVb/XGN7TP6uN1yi5rZMEjSpN2RlO99fUy4cIjmnfuUk2vVtaSsPAg9BQm1bDlpPhchFiacF
 UCa7zrKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nWIGz-00Aba8-IG; Mon, 21 Mar 2022 13:40:37 +0000
Date: Mon, 21 Mar 2022 13:40:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiAVezd5B9auhcP@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 16, 2022 at 09:17:04PM +0800, Jeffle Xu wrote:
> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
> +	rwlock_t			reqs_lock;	/* Lock for reqs xarray */

Why do you have a separate rwlock when the xarray already has its own
spinlock?  This is usually a really bad idea.
