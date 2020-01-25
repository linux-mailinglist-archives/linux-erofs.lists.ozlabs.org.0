Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC833149334
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 04:58:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484Mg02BlfzDqgN
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 14:58:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=iH3BlPfu; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484Mfn6W8DzDqgC
 for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2020 14:57:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lx0lKKnkqhl0zcGVWH7r4Ty17wTgyP7eWJIw8u2UES8=; b=iH3BlPfu1A1X7J+NKyJSKjuXD
 GWqzxemtGZlidnfLckCSUlh3uxKqlLMl5js8/AGNlozsz4suLtaPnBfhlU0ZoR+ZBeDsuH61dOSi9
 ZeCNNq2MEgScp7QeMzsvrUxdbQB0gMj4y9N2wWBUt05isit6e3rne6azh/ncYVIpgl4BC0/x/geV3
 MxZcb38PFW5p4FysEyJvIi7Y7pQaG+3E4cv/YbsbMWHUeep1VQx1+AgB/Uj2eAtxRH9cLv+G5hgRX
 V/9VG8Kw9BgHVjEoUccJi2nM2CqhQSk0BLKO4Rw8wV+GqKIjZvJ0JAa8O8aKC06qH7YJEoRiGaNeD
 QO9xevOAg==;
Received: from [2601:1c0:6280:3f0::ed68]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ivCZp-0007SX-Sz; Sat, 25 Jan 2020 03:57:41 +0000
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
To: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
Date: Fri, 24 Jan 2020 19:57:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200125013553.24899-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 1/24/20 5:35 PM, Matthew Wilcox wrote:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..bb06fb7b120b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,8 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		unsigned (*readahead)(struct file *filp, struct address_space *mapping,
> +				 pgoff_t start, unsigned nr_pages);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,6 +783,15 @@ cache in your filesystem.  The following members are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>  
> +``readahead``
> +	called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +        locked.  The implementation should decrement the page refcount after
> +        attempting I/O on each page.  Usually the page will be unlocked by
> +        the I/O completion handler.  If the function does not attempt I/O on
> +        some pages, return the number of pages which were not read so the
> +        common code can unlock the pages for you.
> +

Please use consistent indentation (tabs).

>  ``readpages``
>  	called by the VM to read pages associated with the address_space
>  	object.  This is essentially just a vector version of readpage.


cheers.
-- 
~Randy

