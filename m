Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E0166088
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 16:11:01 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NdMQ2rBtzDqLS
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 02:10:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=rNJKV58k; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NdMG6PW2zDqFs
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 02:10:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=G2o7/2wQz4I2bSTa23Jz+2T7ehA7+Qh/DABLcJ7++Gg=; b=rNJKV58kH2Hi3xhQxkLMMzx8lV
 RipoN223ZmXSatYqltHsRF6idpZbBmyf0GL9X+CH+Ks6Wc6k43+EjLitqhF4xF2b133YQH9ZG5EHi
 9S2PEh7TBE1weivsELdxeyxuCZbNPOZ2MqqDqE2ZOhY+EIiIxbWx+hcdKp9lxQ0cgIgNcZkczih6K
 9FdryOmrnuCo9AOOf+joSEfiifv0Cop4iRUq+zKJAofsbwZLBBoyX6i8M/2kx+6/2vGI/vLfIxQw1
 2Ucmc3/Mow9vozyw390izexHNWNfoWyIucqRv+4NiQ+0nLq6AIcDZr0SBA/Y13JQUbUW+KN6Xz/8C
 FKW5FgEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4nTU-00007F-C8; Thu, 20 Feb 2020 15:10:48 +0000
Date: Thu, 20 Feb 2020 07:10:48 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v7 10/24] mm: Add readahead address space operation
Message-ID: <20200220151048.GW24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-11-willy@infradead.org>
 <5D7CE6BD-FABD-4901-AEF0-E0F10FC00EB1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D7CE6BD-FABD-4901-AEF0-E0F10FC00EB1@nvidia.com>
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
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 10:00:30AM -0500, Zi Yan wrote:
> > +/* The index of the first page in this readahead block */
> > +static inline unsigned int readahead_index(struct readahead_control *rac)
> > +{
> > +	return rac->_index;
> > +}
> 
> rac->_index is pgoff_t, so readahead_index() should return the same type, right?
> BTW, pgoff_t is unsigned long.

Oh my goodness!  Thank you for spotting that.  Fortunately, it's only
currently used by tracepoints, so it wasn't causing any trouble, but
that's a nasty landmine to leave lying around.  Fixed:

static inline pgoff_t readahead_index(struct readahead_control *rac)

