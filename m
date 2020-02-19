Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 119E716384D
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 01:13:11 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MdTw2JdzzDqdt
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 11:13:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64;
 helo=hqnvemgate25.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=LZUXi8JQ; dkim-atps=neutral
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MdTq1wgjzDqWn
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 11:13:02 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c7d6b0000>; Tue, 18 Feb 2020 16:12:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 16:12:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 16:12:59 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 00:12:59 +0000
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <e6687fed-bbe9-005b-4fde-d888f3d9873f@nvidia.com>
Date: Tue, 18 Feb 2020 16:12:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-14-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582071148; bh=XYyqV3UUSvdocn4sI3PrA/ovYe/qDo2rL7zzBYFMHHQ=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=LZUXi8JQOUsxM4MhkbKZoN+us77X32agHHEERvyhJFQIOA1HQvZOoIGniinVZGnwn
 pZ2VcWEgxoh8iz45kjTzfdIeohxKJWjgA24H8/wDDP9a0/3dFwa4tJpxgpapBn1SP0
 6/Wfm0vT02ejD0TSvYWlZdshSpOysFqkccwchWZ9fxvkGg5guUZEdfBxSiI/mMsYEp
 FgymXJQ1zao4g21+WHoUfPhqNPoyrsbrhqpLdsNEHa/aoseWOTMxw940mhXVsqG1Ib
 OHqwlrvjGtIuPOEVEUVsVzgkbxTMVawyEuM/R5wrTMKOe7ZmOR2cspeFnXDRI9uYLT
 teYbgBQPqd3OA==
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This replaces ->readpages with a saner interface:
>  - Return void instead of an ignored error code.
>  - Pages are already in the page cache when ->readahead is called.
>  - Implementation looks up the pages in the page cache instead of
>    having them passed in a linked list.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  6 +++++-
>  Documentation/filesystems/vfs.rst     | 13 +++++++++++++
>  include/linux/fs.h                    |  2 ++
>  include/linux/pagemap.h               | 18 ++++++++++++++++++
>  mm/readahead.c                        |  8 +++++++-
>  5 files changed, 45 insertions(+), 2 deletions(-)
> 

Looks nice,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 5057e4d9dcd1..0ebc4491025a 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -239,6 +239,7 @@ prototypes::
>  	int (*readpage)(struct file *, struct page *);
>  	int (*writepages)(struct address_space *, struct writeback_control *);
>  	int (*set_page_dirty)(struct page *page);
> +	void (*readahead)(struct readahead_control *);
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
>  	int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -271,7 +272,8 @@ writepage:		yes, unlocks (see below)
>  readpage:		yes, unlocks
>  writepages:
>  set_page_dirty		no
> -readpages:
> +readahead:		yes, unlocks
> +readpages:		no
>  write_begin:		locks the page		 exclusive
>  write_end:		yes, unlocks		 exclusive
>  bmap:
> @@ -295,6 +297,8 @@ the request handler (/dev/loop).
>  ->readpage() unlocks the page, either synchronously or via I/O
>  completion.
>  
> +->readahead() unlocks the pages like ->readpage().
> +
>  ->readpages() populates the pagecache with the passed pages and starts
>  I/O against them.  They come unlocked upon I/O completion.
>  
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..81ab30fbe45c 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,7 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		void (*readahead)(struct readahead_control *);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,12 +782,24 @@ cache in your filesystem.  The following members are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>  
> +``readahead``
> +	Called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +	locked.  The implementation should decrement the page refcount
> +	after starting I/O on each page.  Usually the page will be
> +	unlocked by the I/O completion handler.  If the function does
> +	not attempt I/O on some pages, the caller will decrement the page
> +	refcount and unlock the pages for you.	Set PageUptodate if the
> +	I/O completes successfully.  Setting PageError on any page will
> +	be ignored; simply unlock the page if an I/O error occurs.
> +
>  ``readpages``
>  	called by the VM to read pages associated with the address_space
>  	object.  This is essentially just a vector version of readpage.
>  	Instead of just one page, several pages are requested.
>  	readpages is only used for read-ahead, so read errors are
>  	ignored.  If anything goes wrong, feel free to give up.
> +	This interface is deprecated; implement readahead instead.
>  
>  ``write_begin``
>  	Called by the generic buffered write code to ask the filesystem
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..d4e2d2964346 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -292,6 +292,7 @@ enum positive_aop_returns {
>  struct page;
>  struct address_space;
>  struct writeback_control;
> +struct readahead_control;
>  
>  /*
>   * Write life time hint values.
> @@ -375,6 +376,7 @@ struct address_space_operations {
>  	 */
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
> +	void (*readahead)(struct readahead_control *);
>  
>  	int (*write_begin)(struct file *, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned flags,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3613154e79e4..bd4291f78f41 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -665,6 +665,24 @@ static inline void readahead_next(struct readahead_control *rac)
>  #define readahead_for_each(rac, page)					\
>  	for (; (page = readahead_page(rac)); readahead_next(rac))
>  
> +/* The byte offset into the file of this readahead block */
> +static inline loff_t readahead_offset(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_start * PAGE_SIZE;
> +}
> +
> +/* The number of bytes in this readahead block */
> +static inline loff_t readahead_length(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_nr_pages * PAGE_SIZE;
> +}
> +
> +/* The index of the first page in this readahead block */
> +static inline unsigned int readahead_index(struct readahead_control *rac)
> +{
> +	return rac->_start;
> +}
> +
>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *rac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 9e430daae42f..975ff5e387be 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -121,7 +121,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  
>  	blk_start_plug(&plug);
>  
> -	if (aops->readpages) {
> +	if (aops->readahead) {
> +		aops->readahead(rac);
> +		readahead_for_each(rac, page) {
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +	} else if (aops->readpages) {
>  		aops->readpages(rac->file, rac->mapping, pages,
>  				readahead_count(rac));
>  		/* Clean up the remaining pages */
> 
