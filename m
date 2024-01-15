Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029C82DAF1
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 15:07:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vATJg++B;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDDVB57H7z3bmq
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 01:07:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vATJg++B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDDV0525yz2yMJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 01:07:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k+DYOQ+yWRd2pgMIRz/5wGINWA2P7yC/o6J+Q7W5b70=; b=vATJg++BpawwIU6E3l3nCyM/fl
	CR1jGpmQB/8Vq7OxY1+wQ2R/Hf3ne8n0WN2AvXfif1DigL2m2rVPRPfBIGHsnUly6m2P18LQsHeeE
	pv+B6kcZ03YpFkpKUaN87vnGX7uiFbMHtRfudt/fZlAfUY3gjxMPFrspblYKei4oeLsyxJS6XNYy4
	LqB76AJULX5LYDl+H6w6rAl7am/wUSRx0JzXHryKNdYAP90XSPckLxOj9SUfy7eZIE7Kyi9Iei+Yr
	r2XvhpG935/rETqKfQZjY4lEZGAuxuj/0flXZIbbrxN+farXylvZfJ9RJiRByx9wkGofpA3ZAue1Z
	aDzeDz7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPNbh-009rfH-Cs; Mon, 15 Jan 2024 14:06:29 +0000
Date: Mon, 15 Jan 2024 14:06:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] erofs: Don't use certain internal folio_*()
 functions
Message-ID: <ZaU75cT0jx9Ya+6G@casper.infradead.org>
References: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 15, 2024 at 04:33:37PM +0800, Gao Xiang wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Filesystems should use folio->index and folio->mapping, instead of
> folio_index(folio), folio_mapping() and folio_file_mapping() since
> they know that it's in the pagecache.
> 
> Change this automagically with:
> 
> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Yue Hu <huyue2@coolpad.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: linux-erofs@lists.ozlabs.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi folks,
> 
> I tend to apply this patch upstream since compressed data fscache
> adaption touches this part too.  If there is no objection, I'm
> going to take this patch separately for -next shortly..

Could you change the subject?  It's not that the functions are
"internal", it's that filesystems don't need to use them because they're
guaranteed to not see swap pages.  Maybe just s/internal/unnecessary/

> Thanks,
> Gao Xiang
> 
> Change since v1:
>  - a better commit message pointed out by Jeff Layton.
> 
>  fs/erofs/fscache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 87ff35bff8d5..bc12030393b2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -165,10 +165,10 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>  static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>  {
>  	int ret;
> -	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
> +	struct erofs_fscache *ctx = folio->mapping->host->i_private;
>  	struct erofs_fscache_request *req;
>  
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>  				folio_pos(folio), folio_size(folio));
>  	if (IS_ERR(req)) {
>  		folio_unlock(folio);
> @@ -276,7 +276,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>  	struct erofs_fscache_request *req;
>  	int ret;
>  
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>  			folio_pos(folio), folio_size(folio));
>  	if (IS_ERR(req)) {
>  		folio_unlock(folio);
> -- 
> 2.39.3
> 
